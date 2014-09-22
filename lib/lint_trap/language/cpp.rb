require_relative 'base'
require_relative '../linter/cppcheck'

module LintTrap
  module Language
    # C++
    module CPP
      extend Base

      def self.name
        'C++'
      end

      def self.linters
        [Linter::CPPCheck]
      end
    end
  end
end
