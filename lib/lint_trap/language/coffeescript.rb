require_relative 'base'
require_relative '../linter/coffeelint'

module LintTrap
  module Language
    # CoffeeScript
    module CoffeeScript
      extend Base

      def self.linters
        [Linter::CoffeeLint]
      end
    end
  end
end
