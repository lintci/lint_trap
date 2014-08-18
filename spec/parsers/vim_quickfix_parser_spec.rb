require 'spec_helper'

describe LintTrap::Parsers::VimQuickfixParser do
  let(:parser_output) do
    "bad.go:5:1: exported function Main should have comment or be unexported\n"
  end
  let(:io){StringIO.new(parser_output)}
  subject(:parser){described_class}

  describe '#parse' do
    it 'parses violations from io' do
      expect{|b| parser.parse(io, &b)}.to yield_successive_args(
        {
          file: 'bad.go',
          line: '5',
          column: '1',
          length: nil,
          rule: nil,
          severity: nil,
          message: 'exported function Main should have comment or be unexported'
        }
      )
    end
  end
end
