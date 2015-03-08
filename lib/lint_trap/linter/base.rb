require_relative '../parser/standard'
require_relative '../command'

module LintTrap
  module Linter
    # The base class for all linters. Provides a template for linter execution.
    class Base
      CONFIG_PATH = File.expand_path('../../../../config', __FILE__)

      def lint(files, container, options)
        return unless known?

        @container, @options = container, options

        command(files).run(container) do |stdout|
          parser(stdout).parse do |violation|
            yield violation
          end
        end
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

      def flags(options)
        raise NotImplementedError, 'Method flags must be implemented.'
      end

      def command_name
        name.downcase
      end
    end
  end
end
