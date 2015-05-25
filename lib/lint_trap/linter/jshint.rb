require_relative 'base'

module LintTrap
  module Linter
    # Encapsulates logic specific to jshint command line tool.
    class JSHint < Base
      FORMATTER = 'jshint/formatter.js'

      def version
        '2.5.11'
      end

    private

      def flags(container, options)
        [
          '--reporter', container.config_path(FORMATTER)
        ].tap do |flags|
          flags.concat(['--config', options[:config]]) if options[:config]
        end
      end
    end
  end
end
