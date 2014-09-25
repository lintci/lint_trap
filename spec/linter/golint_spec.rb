require 'spec_helper'

describe LintTrap::Linter::GoLint do
  let(:container){LintTrap::Container::Fake.new}
  let(:config){nil}
  let(:files){%w(good.go bad.go)}
  subject(:linter){described_class.new(container: container, config: config)}
  let(:command){instance_double(LintTrap::Command)}

  describe '#lint' do
    it 'runs the lint command with the correct arguments' do
      expect(LintTrap::Command).to receive(:new).with(
        'golint',
        [],
        files
      ).and_return(command)
      expect(command).to receive(:run).with(container)

      linter.lint(files)
    end
  end
end
