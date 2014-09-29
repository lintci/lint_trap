require 'spec_helper'

describe LintTrap::Linter::CPPCheck do
  let(:container){LintTrap::Container::Fake.new}
  let(:config){nil}
  let(:files){%w(good.cpp bad.cpp)}
  subject(:linter){described_class.new(container: container, config: config)}
  let(:command){instance_double(LintTrap::Command)}

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
      expect(command).to receive(:run).with(container)

      linter.lint(files)
    end
  end
end