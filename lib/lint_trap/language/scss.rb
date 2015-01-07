require_relative 'base'
require_relative '../linter/scsslint'

module LintTrap
  module Language
    # SCSS
    class SCSS < Base
      def linters
        [Linter::SCSSLint]
      end
    end
  end
end
