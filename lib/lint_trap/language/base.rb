module LintTrap
  module Language
    # Interface for languages
    class Base
      def self.canonical_name
        name.split('::').last
      end

      def name
        self.class.canonical_name
      end

      def linters
        raise NotImplementedError, 'Must define what linters this language supports.'
      end
    end
  end
end
