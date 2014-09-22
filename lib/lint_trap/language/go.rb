require_relative 'base'
require_relative '../linter/golint'

module LintTrap
  module Language
    # Go
    module Go
      extend Base

      def self.linters
        [Linter::GoLint]
      end
    end
  end
end
