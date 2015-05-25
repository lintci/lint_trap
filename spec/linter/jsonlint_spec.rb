require 'spec_helper'

describe LintTrap::Linter::JSONLint do
  let(:container){LintTrap::Container::Fake.new}
  let(:options){{}}
  let(:files){%w(good.go bad.go)}
  subject(:linter){LintTrap::Linter.find('JSONLint')}
  let(:command){instance_double(LintTrap::Command)}

  it_behaves_like 'linter'

  its(:languages){is_expected.to eq([LintTrap::Language::JSON.new])}
  its(:version){is_expected.to eq('0.0.4')}
  its(:image){is_expected.to eq('lintci/jsonlint')}
  its(:image_version){is_expected.to eq('lintci/jsonlint:0.0.4')}

  describe '#lint' do
    it 'runs the lint command with the correct arguments' do
      expect(LintTrap::Command).to receive(:new).with(
        'durable-json-lint',
        ['--format', '{{file}}:{{line}}:{{column}}:::error:{{{description}}}'],
        files
      ).and_return(command)
      expect(command).to receive(:run).with(container).and_return(true)

      linter.lint(files, container, options)
    end
  end
end
