require_relative 'line'

module LintTrap
  module Parser
    # Handles parsing LintTrap standard format
    class Standard < Line
    private

      def violation_regex
        /
          (?<file>[^:]+):
          (?<line>[^:]*):
          (?<column>[^:]*):
          (?<length>[^:]*):
          (?<rule>[^:]*):
          (?<severity>[^:]*):
          (?<message>.+)
        /x
      end
    end
  end
end
