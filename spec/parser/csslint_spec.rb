require 'spec_helper'

describe LintTrap::Parser::CSSLint do
  let(:parser_output) do
    'bad.css: line 2, col 5, Error - Using width with border can sometimes'\
    " make elements larger than you expect.\n\n"
  end
  let(:io){StringIO.new(parser_output)}
  let(:container){LintTrap::Container::Fake.new}
  subject(:parser){described_class.new(io, container)}

  describe '.parse' do
    it 'parses violations from io' do
      expect{|b| parser.parse(&b)}.to yield_successive_args(
        file: 'bad.css',
        line: '2',
        column: '5',
        length: nil,
        rule: nil,
        severity: 'Error',
        message: 'Using width with border can sometimes make elements larger than you expect.'
      )
    end
  end
end
