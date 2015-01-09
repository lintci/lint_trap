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
        [Linter::CPPCheck].map(&:new)
      end
    end
  end
end
