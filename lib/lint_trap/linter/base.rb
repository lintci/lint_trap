require_relative '../parser/standard'
require_relative '../command'

module LintTrap
  module Linter
    # The base class for all linters. Provides a template for linter execution.
    class Base
      CONFIG_PATH = File.expand_path('../../../../config', __FILE__)

      def initialize(container:, **options)
        @container = container
        @options = options
      end

      def lint(files)
        command(files).run(container) do |stdout|
          parser(stdout).parse do |violation|
            yield violation
          end
        end
      end

    protected

      attr_reader :container, :options

    private

      def command(files)
        Command.new(command_name, flags, files)
      end

      def parser(stdout)
        LintTrap::Parser::Standard.new(stdout)
      end

      def config_path(path)
        container.config_path(path)
      end

      def flags
        raise NotImplementedError, 'Method flags must be implemented.'
      end

      def command_name
        self.class.name.split('::').last.downcase
      end
    end
  end
end
