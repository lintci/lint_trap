require 'spec_helper'

describe LintTrap::Parser::VimQuickfix do
  let(:parser_output) do
    "bad.go:5:1: exported function Main should have comment or be unexported\n"
  end
  let(:io){StringIO.new(parser_output)}
  let(:container){LintTrap::Container::Fake.new}
  subject(:parser){described_class.new(io, container)}

  describe '#parse' do
    it 'parses violations from io' do
      expect{|b| @result = parser.parse(&b)}.to yield_successive_args(
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

      expect(@result).to eq('')
    end
  end
end
