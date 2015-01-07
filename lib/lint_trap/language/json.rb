require_relative 'base'
require_relative '../linter/jsonlint'

module LintTrap
  module Language
    # JSON
    class JSON < Base
      def linters
        [Linter::JSONLint]
      end
    end
  end
end
