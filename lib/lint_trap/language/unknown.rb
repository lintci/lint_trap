require_relative 'base'
require_relative '../linter/unknown'

module LintTrap
  module Language
    # Interface for languages
    class Unknown < Base
      attr_reader :name

      def initialize(name = 'Unknown')
        @name = name
      end

      def linters
        super(Linter::Unknown)
      end

      def known?
        false
      end
    end
  end
end
