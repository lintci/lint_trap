require_relative 'line_parser'

module LintTrap
  module Parsers
    # Handles parsing LintCI standard format
    class VimQuickfixParser < LineParser

    private

      def violation_regex
        /
          (?<file>[^:]+):
          (?<line>[^:]*):
          (?<column>[^:]*):\s*
          (?<message>.+)
        /x
      end
    end
  end
end
