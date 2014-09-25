require_relative 'base'
require_relative '../linter/checkstyle'

module LintTrap
  module Language
    # Java
    module Java
      extend Base

      def self.linters
        [Linter::CheckStyle]
      end
    end
  end
end
