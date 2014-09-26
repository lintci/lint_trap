module LintTrap
  module Parser
    class Base
      def initialize(io, container)
        @io = io
        @container = container
      end

      def parse
        raise NotImplementedError, "Subclass #{self.class.name} must implement parse."
      end

    protected

      attr_reader :container, :io
    end
  end
end
