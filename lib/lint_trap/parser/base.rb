module LintTrap
  module Parser
    # Interface for parsers
    class Base
      def parse(_io, _container)
        raise NotImplementedError, 'Must implement parse.'
      end

      def name
        self.class.name.split('::').last
      end
    end
  end
end
