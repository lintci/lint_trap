require_relative 'base'
require_relative '../linter/pylint'

module LintTrap
  module Language
    # Python
    class Python < Base
      def linters
        [Linter::PyLint].map(&:new)
      end
    end
  end
end
