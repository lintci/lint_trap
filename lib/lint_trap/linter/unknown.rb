require_relative 'base'

module LintTrap
  module Linter
    # Encapsulates logic specific to scsslint command line tool.
    class Unknown < Base
      attr_reader :name

      def initialize(name = 'Unknown')
        @name = name
      end

      def languages
        super(Language::Unknown)
      end

      def version
        LintTrap::VERSION
      end

      def known?
        false
      end
    end
  end
end
