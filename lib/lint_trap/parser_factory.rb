require_relative 'parsers/null_parser'
require_relative 'parsers/standard_parser'

module LintTrap
  # Determines the appropriate parser for the given linter
  module ParserFactory
    class << self
      def register(linter, parser)
        @parsers ||= Hash.new{Parsers::NullParser}
        @parsers[linter] = parser
      end

      def parser_for(linter)
        @parsers[linter]
      end
    end

    register 'standard', Parsers::StandardParser
    register 'vim_quickfix', Parser::VimQuickfixParser

    register 'checkstyle', Parsers::StandardParser
    register 'coffeelint', Parsers::StandardParser
    #register 'csslint', Parsers::CSSLintParser
    #register 'golint', Parser::VimQuickfixParser
    register 'jshint', Parsers::StandardParser
    register 'jsonlint', Parsers::StandardParser
    register 'rubocop', Parsers::StandardParser
    register 'scsslint', Parsers::StandardParser
  end
end
