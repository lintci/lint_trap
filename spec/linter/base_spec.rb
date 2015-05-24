require 'spec_helper'

describe LintTrap::Linter::Base do
  let(:container){LintTrap::Container::Docker.new('lintci/rubocop', '/src')}
  subject(:linter) do
    Class.new(described_class) do
      def name
        'ErrorLinter'
      end
    end.new
  end

  describe '#version' do
    it 'raises an error if not overriden' do
      expect{linter.version}.to raise_error(NotImplementedError, 'Must implement version.')
    end
  end

  describe '#lint' do
    it 'raises an error if #flags is not overriden' do
      expect{linter.lint([], container, {})}.to raise_error(NotImplementedError, 'Must implement flags.')
    end
  end
end
