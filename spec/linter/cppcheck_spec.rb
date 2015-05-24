require 'spec_helper'

describe LintTrap::Linter::CPPCheck do
  let(:container){LintTrap::Container::Fake.new}
  let(:options){{}}
  let(:files){%w(good.cpp bad.cpp)}
  subject(:linter){described_class.new}
  let(:command){instance_double(LintTrap::Command)}

  it_behaves_like 'linter'

  its(:languages){is_expected.to eq([LintTrap::Language::CPP.new])}
  its(:version){is_expected.to eq('1.67-1')}
  its(:image){is_expected.to eq('lintci/cppcheck')}
  its(:image_version){is_expected.to eq('lintci/cppcheck:1.67-1')}

  describe '#lint' do
    it 'runs the lint command with the correct arguments' do
      expect(LintTrap::Command).to receive(:new).with(
        'cppcheck',
        [
          '--enable=all',
          '--error-exitcode=1',
          '--template="{file}:{line}:::{id}:{severity}:{message}"'
        ],
        files
      ).and_return(command)
      expect(command).to receive(:run).with(container).and_return(true)

      linter.lint(files, container, options)
    end
  end
end
