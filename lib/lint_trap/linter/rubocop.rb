require_relative 'base'

module LintTrap
  module Linter
    # Encapsulates logic specific to rubocop command line tool.
    class RuboCop < Base
      FORMATTER = 'rubocop/formatter.rb'

      def version
        '0.31.0'
      end

    private

      def flags(container, options)
        [
          '--require', container.config_path(FORMATTER),
          '--format', 'LintTrap::Rubocop::Formatter',
          '--no-color'
        ].tap do |flags|
          flags.concat(['--config', options[:config]]) if options[:config]
        end
      end
    end
  end
end
