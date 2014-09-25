require_relative 'base'
require_relative '../linter/scsslint'

module LintTrap
  module Language
    # SCSS
    module SCSS
      extend Base

      def self.linters
        [Linter::SCSSLint]
      end
    end
  end
end
