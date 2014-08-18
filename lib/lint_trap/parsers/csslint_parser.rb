require_relative 'line_parser'

module LintTrap
  module Parsers
    # Handles parsing LintCI standard format
    class CSSLintParser < LineParser

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
