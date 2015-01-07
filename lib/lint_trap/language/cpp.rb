require_relative 'base'
require_relative '../linter/cppcheck'

module LintTrap
  module Language
    # C++
    class CPP < Base
      def self.canonical_name
        'C++'
      end

      def linters
        [Linter::CPPCheck]
      end
    end
  end
end
