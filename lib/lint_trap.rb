require 'lint_trap/version'
require 'lint_trap/parser_factory'

# Parses linter output from IO
module LintTrap
  class << self
    def parse(linter, io, parser_name = nil)
      parser = ParserFactory.parser(parser_name)
      parser ||= ParserFactory.parser(linter)

      parser.parse(io, &Proc.new)
    end
  end
end
