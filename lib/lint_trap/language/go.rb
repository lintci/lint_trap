require_relative 'base'
require_relative '../linter/golint'

module LintTrap
  module Language
    # Go
    class Go < Base
      def linters
        [Linter::GoLint]
      end
    end
  end
end
