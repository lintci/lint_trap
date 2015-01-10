require_relative 'base'

module LintTrap
  module Linter
    # Encapsulates logic specific to scsslint command line tool.
    class SCSSLint < Base
      COMMAND = 'scsslint/scsslint'

      def languages
        super(Language::SCSS)
      end

      def command_name
        config_path(COMMAND)
      end

      def flags
        [
          '--format=LintTrap'
        ].tap do |flags|
          flags.concat(['--config', options[:config]]) if options[:config]
        end
      end
    end
  end
end
