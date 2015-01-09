module LintTrap
  module Language
    # Interface for languages
    class Base
      def name
        self.class.name.split('::').last
      end

      def linters
        raise NotImplementedError, 'Must define what linters this language supports.'
      end

      def ==(other)
        name == other.name
      end
    end
  end
end
