require_relative 'line_parser'

module LintTrap
  module Parsers
    # Handles parsing LintCI standard format
    class PyLintParser < LineParser

    private

      def violation_regex
        /
          (?<file>[^:]+):
          (?<line>[^:]+):
          \s+\[
          (?<severity>[^\]]+)
          \]\s+
          (?<message>.+)
        /x
      end
    end
  end
end

#     "bad.py:3: [E] unexpected indent\n"
