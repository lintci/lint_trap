require_relative 'base'
require_relative '../linter/rubocop'

module LintTrap
  module Language
    # Ruby
    class Ruby < Base
      def linters
        [Linter::RuboCop]
      end
    end
  end
end
