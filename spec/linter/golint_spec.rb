require 'spec_helper'

describe LintTrap::Linter::GoLint do
  let(:container){LintTrap::Container::Fake.new}
  let(:options){{}}
  let(:files){%w(good.go bad.go)}
  subject(:linter){described_class.new}
  let(:command){instance_double(LintTrap::Command)}

  it_behaves_like 'linter'

  its(:languages){is_expected.to eq([LintTrap::Language::Go.new])}

  describe '#lint' do
    it 'runs the lint command with the correct arguments' do
      expect(LintTrap::Command).to receive(:new).with(
        'golint',
        [],
        files
      ).and_return(command)
      expect(command).to receive(:run).with(container)

      linter.lint(files, container, options)
    end
  end
end
