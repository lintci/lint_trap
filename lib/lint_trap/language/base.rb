module LintTrap
  module Language
    # Interface for languages
    module Base
      def name
        super.split('::').last
      end

      def linters
        raise NotImplementedError, 'Must define what linters this language supports.'
      end
    end
  end
end
