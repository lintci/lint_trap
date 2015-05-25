require 'spec_helper'

describe LintTrap::Linter::GoLint do
  let(:container){LintTrap::Container::Fake.new}
  let(:options){{}}
  let(:files){%w(good.go bad.go)}
  subject(:linter){LintTrap::Linter.find('GoLint')}
  let(:command){instance_double(LintTrap::Command)}

  it_behaves_like 'linter'

  its(:languages){is_expected.to eq([LintTrap::Language::Go.new])}
  its(:version){is_expected.to eq(LintTrap::VERSION)}
  its(:image){is_expected.to eq('lintci/golint')}
  its(:image_version){is_expected.to eq('lintci/golint:' + LintTrap::VERSION)}

  describe '#lint' do
    it 'runs the lint command with the correct arguments' do
      expect(LintTrap::Command).to receive(:new).with(
        'golint',
        [],
        files
      ).and_return(command)
      expect(command).to receive(:run).with(container).and_return(true)

      linter.lint(files, container, options)
    end
  end
end
