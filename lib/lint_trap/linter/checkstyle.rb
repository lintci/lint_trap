require_relative 'base'

module LintTrap
  module Linter
    # Encapsulates logic specific to checkstyle command line tool.
    class CheckStyle < Base
      JAR = 'checkstyle/checkstyle_logger-all.jar'
      CHECKS_XML = 'checkstyle/sun_checks.xml'

    private

      def command_name
        'java'
      end

      def flags
        [
          '-jar', config_path(JAR),
          '-c', options[:config] || config_path(CHECKS_XML)
        ]
      end
    end
  end
end
