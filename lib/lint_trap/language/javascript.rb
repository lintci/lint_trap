require_relative 'base'
require_relative '../linter/jshint'

module LintTrap
  module Language
    # JavaScript
    class JavaScript < Base
      def linters
        [Linter::JSHint]
      end
    end
  end
end
