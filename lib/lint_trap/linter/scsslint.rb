require_relative 'base'

module LintTrap
  module Linter
    # Encapsulates logic specific to scsslint command line tool.
    class SCSSLint < Base
      COMMAND = 'scsslint/scsslint'

      def version
        '0.38.0'
      end

      def command_name(container)
        container.config_path(COMMAND)
      end

      def flags(_container, options)
        [
          '--format=LintTrap'
        ].tap do |flags|
          flags.concat(['--config', options[:config]]) if options[:config]
        end
      end
    end
  end
end
