require_relative '../parser/standard'
require_relative '../command'

module LintTrap
  module Linter
    class LintError < StandardError
      def initialize(error_output)
        super("Encountered error when running linter:\n#{error_output}")
      end
    end

    # The base class for all linters. Provides a template for linter execution.
    class Base
      CONFIG_PATH = File.expand_path('../../../../config', __FILE__)

      def lint(files, container, options)
        return unless known?

        @container, @options = container, options

        violations_found, remaining_output = false, ''
        success = command(files).run(container) do |stdout|
          remaining_output = parser(stdout).parse do |violation|
            violations_found = true
            yield violation
          end
        end

        raise LintError, remaining_output if !violations_found && !success
      end

      def name
        self.class.name.split('::').last
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

    protected

      attr_reader :container, :options

    private

      def command(files)
        Command.new(command_name, flags, files)
      end

      def parser(stdout)
        LintTrap::Parser::Standard.new(stdout, container)
      end

      def config_path(path)
        container.config_path(path)
      end

      def flags
        raise NotImplementedError, 'Method flags must be implemented.'
      end

      def command_name
        name.downcase
      end
    end
  end
end
