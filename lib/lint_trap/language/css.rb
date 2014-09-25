require_relative 'base'
require_relative '../linter/csslint'

module LintTrap
  module Language
    # CSS
    module CSS
      extend Base

      def self.linters
        [Linter::CSSLint]
      end
    end
  end
end
