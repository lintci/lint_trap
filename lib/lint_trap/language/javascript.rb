require_relative 'base'
require_relative '../linter/jshint'

module LintTrap
  module Language
    # JavaScript
    module JavaScript
      extend Base

      def self.linters
        [Linter::JSHint]
      end
    end
  end
end
