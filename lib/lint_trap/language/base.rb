module LintTrap
  module Language
    # Interface for languages
    class Base
      def name
        self.class.name.split('::').last
      end

      def linters(*classes)
        classes.map(&:new)
      end

      def known?
        true
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
