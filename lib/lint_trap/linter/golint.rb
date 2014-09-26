require_relative 'base'
require_relative '../parser/vim_quickfix'

module LintTrap
  module Linter
    # Encapsulates logic specific to golint command line tool.
    class GoLint < Base
    private

      def flags
        []
      end

      def parser(stdout)
        LintTrap::Parser::VimQuickfix.new(stdout, container)
      end
    end
  end
end
