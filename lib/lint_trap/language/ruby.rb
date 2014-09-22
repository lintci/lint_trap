require_relative 'base'
require_relative '../linter/rubocop'

module LintTrap
  module Language
    # Ruby
    module Ruby
      extend Base

      def self.linters
        [Linter::RuboCop]
      end
    end
  end
end
