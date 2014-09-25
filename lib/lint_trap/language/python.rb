require_relative 'base'
require_relative '../linter/pylint'

module LintTrap
  module Language
    # Python
    module Python
      extend Base

      def self.linters
        [Linter::PyLint]
      end
    end
  end
end
