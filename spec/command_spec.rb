require 'spec_helper'

describe LintTrap::Command do
  let(:file){fixture_path('lint.txt')}
  let(:command){described_class.new('cat', %w(-b), [file])}
  let(:container){LintTrap::Container::Docker.new('lintci/spin_cycle', fixture_path)}

  describe '#run' do
    it 'generates the expected output' do
      command.run(container) do |io|
        expect(io.read).to eq("     1\tlint\n")
      end
    end
  end

  describe '#command/#to_s' do
    it 'generates a wrapped executable command' do
      expect(command.to_s(container)).to eq(
        "docker run --privileged=false -v #{LintTrap::Container::Base::LOCAL_CONFIG_PATH}:/opt/lint_trap/config "\
        "-v #{fixture_path}:/home/spin_cycle --workdir=/home/spin_cycle --user=spin_cycle lintci/spin_cycle "\
        'cat -b /home/spin_cycle/lint.txt'
      )
    end
  end
end
