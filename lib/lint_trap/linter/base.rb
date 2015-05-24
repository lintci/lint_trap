require_relative '../parser/standard'
require_relative '../command'
require_relative '../execution_error'

module LintTrap
  module Linter
    LintError = Class.new(ExecutionError)

    # The base class for all linters. Provides a template for linter execution.
    class Base
      CONFIG_PATH = File.expand_path('../../../../config', __FILE__)

      def lint(files, container, options)
        return unless known?

        violations_found, remaining_output = false, ''
        success = command(files, container, options).run(container) do |stdout|
          remaining_output = parser(stdout, container).parse do |violation|
            violations_found = true
            yield violation
          end
        end

        if !violations_found && !success
          raise LintError.new(command(files, container, options).to_s(container), remaining_output)
        end
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

      def languages(*classes)
        classes.map(&:new)
      end

      def known?
        true
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

      def parser(stdout, container)
        LintTrap::Parser::Standard.new(stdout, container)
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
