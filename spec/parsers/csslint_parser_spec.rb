require 'spec_helper'

describe LintTrap::Parsers::CSSLintParser do
  let(:parser_output) do
    "bad.css: line 2, col 5, Error - Using width with border can sometimes"\
    " make elements larger than you expect.\n\n"
  end
  let(:io){StringIO.new(parser_output)}
  subject(:parser){described_class}

  describe '.parse' do
    it 'parses violations from io' do
      expect{|b| parser.parse(io, &b)}.to yield_successive_args(
        {
          file: 'bad.css',
          line: '2',
          column: '5',
          length: nil,
          rule: nil,
          severity: 'Error',
          message: 'Using width with border can sometimes make elements larger than you expect.'
        }
      )
    end
  end
end
