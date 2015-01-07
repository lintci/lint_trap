require_relative 'base'
require_relative '../linter/csslint'

module LintTrap
  module Language
    # CSS
    class CSS < Base
      def linters
        [Linter::CSSLint]
      end
    end
  end
end
