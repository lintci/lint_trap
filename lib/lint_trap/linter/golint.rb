require_relative 'base'
require_relative '../parser/vim_quickfix'

module LintTrap
  module Linter
    # Encapsulates logic specific to golint command line tool.
    class GoLint < Base
      def languages
        super(Language::Go)
      end

      def version
        LintTrap::VERSION
      end

    private

      def flags(_container, _options)
        []
      end

      def parser(stdout, container)
        LintTrap::Parser::VimQuickfix.new(stdout, container)
      end
    end
  end
end
