require 'spec_helper'

describe LintTrap::Container::Base do
  subject(:container) do
    Class.new(described_class).new('lintci/rubocop', '/src')
  end

  describe '#pull' do
    it 'raises an error if not overriden' do
      expect{container.pull}.to raise_error(NotImplementedError, 'Must implement pull.')
    end
  end

  describe '#wrap' do
    it 'raises an error if not overriden' do
      expect{container.wrap('ls')}.to raise_error(NotImplementedError, 'Must implement wrap.')
    end
  end

  describe '#config_path' do
    it 'raises an error if not overriden' do
      expect{container.config_path('/config')}.to raise_error(NotImplementedError, 'Must implement config_path.')
    end
  end

  describe '#file_path' do
    it 'raises an error if not overriden' do
      expect{container.file_path('/src')}.to raise_error(NotImplementedError, 'Must implement file_path.')
    end
  end
end
