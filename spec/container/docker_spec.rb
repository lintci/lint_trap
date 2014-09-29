require 'spec_helper'

describe LintTrap::Container::Docker do
  subject(:container){described_class.new('lintci/spin_cycle:latest', '/local/path')}

  describe '#wrap' do
    it 'wraps the command passed in with a call to docker' do
      expect(container.wrap('ls')).to eq(
        'docker run --privileged=false '\
        "-v #{described_class::LOCAL_CONFIG_PATH}:/opt/lint_trap/config "\
        '-v /local/path:/home/spin_cycle '\
        '--workdir=/home/spin_cycle --user=spin_cycle lintci/spin_cycle:latest ls'
      )
    end
  end

  describe '#config_path' do
    it 'returns the docker config_path' do
      expect(container.config_path('')).to eq(described_class::CONFIG_PATH.to_s)
    end
  end

  describe '#container_path' do
    it 'returns the absolute path of the file in the container' do
      expect(container.container_path('/local/path/bad.file')).to eq('/home/spin_cycle/bad.file')
    end
  end

  describe '#local_path' do
    it 'returns the absolute path of the file outside the container' do
      expect(container.local_path('/home/spin_cycle/bad.file')).to eq('/local/path/bad.file')
    end
  end
end
