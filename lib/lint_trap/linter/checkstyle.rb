require_relative 'base'

module LintTrap
  module Linter
    # Encapsulates logic specific to checkstyle command line tool.
    class CheckStyle < Base
      CHECKS_XML = 'checkstyle/sun_checks.xml'

      def version
        '6.6'
      end

      def jar
        "checkstyle/checkstyle_logger-#{version}-all.jar"
      end

    private

      def command_name(_container)
        'java'
      end

      def flags(container, options)
        [
          '-jar', container.config_path(jar),
          '-c', options[:config] || container.config_path(CHECKS_XML)
        ]
      end
    end
  end
end
