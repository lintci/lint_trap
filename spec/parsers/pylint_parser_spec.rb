require 'spec_helper'

describe LintTrap::Parsers::PyLintParser do
  let(:parser_output) do
    "No config file found, using default configuration\n"\
    "bad.py:3: [E] unexpected indent\n"
  end
  
  let(:io){StringIO.new(parser_output)}
  subject(:parser){described_class}

  describe '.parse' do
    it 'parses violations from io' do
      expect{|b| parser.parse(io, &b)}.to yield_successive_args(
        {
          file: 'bad.py',
          line: '3',
          column: nil,
          length: nil,
          rule: nil,
          severity: 'E',
          message: 'unexpected indent'
        }
      )
    end
  end
end
