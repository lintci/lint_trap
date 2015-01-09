require_relative 'base'
require_relative '../linter/cppcheck'

module LintTrap
  module Language
    # C++
    class CPP < Base
      def name
        'C++'
      end

      def linters
        super(Linter::CPPCheck)
      end
    end
  end
end
