require_relative 'base'
require_relative '../linter/scsslint'

module LintTrap
  module Language
    # SCSS
    class SCSS < Base
      def linters
        [Linter::SCSSLint].map(&:new)
      end
    end
  end
end
