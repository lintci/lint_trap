require_relative '../command'
require_relative '../execution_error'

module LintTrap
  module Linter
    # The base class for all linters. Provides a template for linter execution.
    class Base
      LintError = Class.new(ExecutionError)

      CONFIG_PATH = File.expand_path('../../../../config', __FILE__)

      attr_accessor :parser
      attr_reader :languages

      def initialize
        @languages = []
      end

      def lint(files, container, options)
        violations_found, remaining_output = false, ''

        success = command(files, container, options).run(container) do |stdout|
          remaining_output = parser.parse(stdout, container) do |violation|
            violations_found = true
            yield violation
          end
        end

        if violations_found
          false
        elsif success
          true
        else
          raise LintError.new(command(files, container, options).to_s(container), remaining_output)
        end
      end

      def add_language(language)
        @languages << language
        language.add_linter(self)
      end

      def name
        self.class.name.split('::').last
      end

      def version
        raise NotImplementedError, 'Must implement version.'
      end

      def image
        "lintci/#{name.downcase}"
      end

      def image_version
        "#{image}:#{version}"
      end

      def ==(other)
        return false unless other.respond_to?(:name, true)

        name == other.name
      end

      def inspect
        "<#{name}>"
      end

    private

      def command(files, container, options)
        Command.new(command_name(container), flags(container, options), files)
      end

      def flags(_container, _options)
        raise NotImplementedError, 'Must implement flags.'
      end

      def command_name(_container)
        name.downcase
      end
    end
  end
end
