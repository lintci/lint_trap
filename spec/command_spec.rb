require 'spec_helper'

describe LintTrap::Command do
  let(:file){fixture_path('lint.txt')}
  let(:command){described_class.new('cat', %w(-b), [file])}
  let(:container){LintTrap::Container::Docker.new('lintci/rubocop', fixture_path)}

  describe '#run' do
    let(:container){LintTrap::Container::Docker.new('lintci/rubocop', fixture_path, remove_container: ENV['CI'].nil?)}

    it 'generates the expected output' do
      success = command.run(container) do |io|
        expect(io.read).to eq("     1\tlint\n")
      end

      expect(success).to be_truthy
    end
  end

  describe '#command/#to_s' do
    it 'generates a wrapped executable command' do
      expect(command.to_s(container)).to eq(
        'docker run --rm --net="none" --privileged=false '\
        "-v #{LintTrap::Container::Base::LOCAL_CONFIG_PATH}:/config "\
        "-v #{fixture_path}:/src --workdir=/src --user=lint_trap lintci/rubocop "\
        'cat -b /src/lint.txt'
      )
    end
  end
end
