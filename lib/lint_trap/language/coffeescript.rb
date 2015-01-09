require_relative 'base'
require_relative '../linter/coffeelint'

module LintTrap
  module Language
    # CoffeeScript
    class CoffeeScript < Base
      def linters
        [Linter::CoffeeLint].map(&:new)
      end
    end
  end
end
