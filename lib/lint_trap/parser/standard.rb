require_relative 'line'

module LintTrap
  module Parser
    # Handles parsing LintTrap standard format
    class Standard < Line
    private

      def violation_regex
        /
          (?<file>[^:]+):
          (?<line>\d*):
          (?<column>\d*):
          (?<length>\d*):
          (?<rule>[^:]*):
          (?<severity>[^:]*):
          (?<message>.+)
        /x
      end
    end
  end
end
