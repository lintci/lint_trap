require_relative 'line'

module LintTrap
  module Parser
    # Handles parsing LintTrap standard format
    class VimQuickfix < Line
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
