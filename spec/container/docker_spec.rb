require 'spec_helper'

describe LintTrap::Container::Docker do
  let(:image){LintTrap::Linter::RuboCop.new.image_version}
  subject(:container){described_class.new(image, '/local/path')}

  describe '#pull' do
    context 'when image exists' do
      it 'completes successfully' do
        expect(container.pull).to be_truthy
      end
    end

    context 'when image does not exist' do
      subject(:container){described_class.new('lintci/missing', '/local/path')}

      it 'raises an error' do
        expect{container.pull}.to raise_error(
          LintTrap::Container::Base::ImagePullError,
          /An error occurred while running `docker pull lintci\/missing`. The output was:\n/
        )
      end
    end
  end

  describe '#wrap' do
    it 'wraps the command passed in with a call to docker' do
      expect(container.wrap('ls')).to eq(
        'docker run --net="none" --privileged=false '\
        "-v #{described_class::LOCAL_CONFIG_PATH}:/config "\
        '-v /local/path:/src '\
        "--workdir=/src --user=lint_trap #{image} ls"
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
      expect(container.container_path('/local/path/bad.file')).to eq('/src/bad.file')
    end
  end

  describe '#local_path' do
    it 'returns the absolute path of the file outside the container' do
      expect(container.local_path('/src/bad.file')).to eq('/local/path/bad.file')
    end
  end
end
