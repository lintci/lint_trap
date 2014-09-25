require_relative 'line'

module LintTrap
  module Parser
    # Handles parsing LintTrap standard format
    class CSSLint < Line
    private

      def violation_regex
        /
          (?<file>[^:]+):
          \sline\s(?<line>\d+),
          \scol\s(?<column>\d+),
          \s(?<severity>\w+)\s-\s
          (?<message>.+)
        /x
      end
    end
  end
end
