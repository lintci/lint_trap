require 'spec_helper'

describe LintTrap::Container::Fake do
  subject(:container){described_class.new}

  describe '#wrap' do
    it 'returns the command passed in' do
      expect(container.wrap('ls')).to eq('ls')
    end
  end

  describe '#config_path' do
    it 'returns the gems config_path' do
      expect(container.config_path('')).to eq(described_class::LOCAL_CONFIG_PATH.to_s)
    end
  end

  describe '#container_path' do
    it 'returns the path passed in' do
      expect(container.container_path('bad.file')).to eq('bad.file')
    end
  end

  describe '#local_path' do
    it 'returns the path passed in' do
      expect(container.local_path('bad.file')).to eq('bad.file')
    end
  end
end
