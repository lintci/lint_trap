module LintTrap
  module Language
    # Interface for languages
    class Base
      attr_reader :linters

      def initialize
        @linters = []
      end

      def name
        self.class.name.split('::').last
      end

      def add_linter(linter)
        @linters << linter
      end

      def ==(other)
        return false unless other.respond_to?(:name, true)

        name == other.name
      end

      def inspect
        "<#{name}>"
      end
    end
  end
end
