require_relative 'base'
require_relative '../linter/checkstyle'

module LintTrap
  module Language
    # Java
    class Java < Base
      def linters
        [Linter::CheckStyle].map(&:new)
      end
    end
  end
end
