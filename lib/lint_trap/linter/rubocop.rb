require_relative 'base'

module LintTrap
  module Linter
    # Encapsulates logic specific to rubocop command line tool.
    class RuboCop < Base
      FORMATTER = 'rubocop/formatter.rb'

    private

      def flags
        [
          '--require', config_path(FORMATTER),
          '--format', 'LintTrap::Rubocop::Formatter',
          '--no-color'
        ].tap do |flags|
          flags.concat(['--config', options[:config]]) if options[:config]
        end
      end

      def parser(stdout)
        LintTrap::Parser::Standard.new(stdout)
      end
    end
  end
end
