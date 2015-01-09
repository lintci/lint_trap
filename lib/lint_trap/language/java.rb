require_relative 'base'
require_relative '../linter/checkstyle'

module LintTrap
  module Language
    # Java
    class Java < Base
      def linters
        super(Linter::CheckStyle)
      end
    end
  end
end
