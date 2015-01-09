require_relative 'base'

module LintTrap
  module Linter
    # Encapsulates logic specific to rubocop command line tool.
    class RuboCop < Base
      FORMATTER = 'rubocop/formatter.rb'

      def languages
        super(Language::Ruby)
      end

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
    end
  end
end
