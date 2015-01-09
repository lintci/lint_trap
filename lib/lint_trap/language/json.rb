require_relative 'base'
require_relative '../linter/jsonlint'

module LintTrap
  module Language
    # JSON
    class JSON < Base
      def linters
        [Linter::JSONLint].map(&:new)
      end
    end
  end
end
