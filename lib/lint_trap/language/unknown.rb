require_relative 'base'
require_relative '../linter/unknown'

module LintTrap
  module Language
    # Interface for languages
    class Unknown < Base
      def linters
        [Linter::Unknown.new]
      end
    end
  end
end
