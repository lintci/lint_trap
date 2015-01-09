require_relative 'base'
require_relative '../linter/golint'

module LintTrap
  module Language
    # Go
    class Go < Base
      def linters
        [Linter::GoLint].map(&:new)
      end
    end
  end
end
