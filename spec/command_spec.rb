require 'spec_helper'

describe LintTrap::Command do
  let(:file){'fake file.txt'}
  let(:command){described_class.new('cat', %w(-b), [file])}
  let(:container){LintTrap::Container::Fake.new}

  describe '#run' do
    let(:file){File.expand_path('../fixtures/lint.txt', __FILE__)}

    it 'generates the expected output' do
      command.run(container) do |io|
        expect(io.read).to eq("     1\tlint\n")
      end
    end
  end

  describe '#command/#to_s' do
    context 'with fake container' do
      it 'generates a bare executable command' do
        expect(command.to_s).to eq('cat -b fake\ file.txt 2>&1')
      end
    end

    context 'with docker container' do
      let(:container){LintTrap::Container::Docker.new('lint/runner', '/local/code')}

      it 'generates a wrapped executable command' do
        expect(command.to_s(container)).to eq(
          "docker run --privileged=false -v #{LintTrap::Container::Base::LOCAL_CONFIG_PATH}:/opt/lint_trap/config "\
          '-v /local/code:/home/code --workdir=/home/code --user=linter lint/runner '\
          'cat -b fake\ file.txt 2>&1'
        )
      end
    end
  end
end
