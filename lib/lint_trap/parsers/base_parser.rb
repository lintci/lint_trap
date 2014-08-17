module LintTrap
  module Parsers
    class BaseParser
      class << self
        def parse(io)
          new(io).parse(&Proc.new)
        end
      end

      def initialize(io)
        @io = io
      end

      def parse
        raise NotImplementedError, "Subclass #{self.class.name} must implement parse.'
      end
    end
  end
end
