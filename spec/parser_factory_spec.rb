require 'spec_helper'

describe LintTrap::ParserFactory do
  describe '.linter_for' do
    it 'returns a NullParser when no valid linter is given' do
      expect(described_class.parser_for('blah')).to eq(LintTrap::Parsers::NullParser)
    end

    it 'returns the StandardParser when a valid linter is given' do
      expect(described_class.parser_for('rubocop')).to eq(LintTrap::Parsers::StandardParser)
    end

    it 'returns the VimQuickfixParser when the parser itself is specified' do
      expect(described_class.parser_for('vim_quickfix')).to eq(LintTrap::Parsers::VimQuickfixParser)
    end
  end
end
