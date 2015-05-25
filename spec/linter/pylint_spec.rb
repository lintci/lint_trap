require 'spec_helper'

describe LintTrap::Linter::PyLint do
  let(:container){LintTrap::Container::Fake.new}
  let(:options){{}}
  let(:files){%w(good.py bad.py)}
  subject(:linter){LintTrap::Linter.find('PyLint')}
  let(:command){instance_double(LintTrap::Command)}

  it_behaves_like 'linter'

  its(:languages){is_expected.to eq([LintTrap::Language::Python.new])}
  its(:version){is_expected.to eq('1.3.1-3')}
  its(:image){is_expected.to eq('lintci/pylint')}
  its(:image_version){is_expected.to eq('lintci/pylint:1.3.1-3')}

  describe '#lint' do
    context 'when config is provided' do
      let(:options){{config: '.pylintrc'}}

      it 'runs the lint command with the correct arguments' do
        expect(LintTrap::Command).to receive(:new).with(
          'pylint',
          [
            '-r', 'no',
            '--msg-template', '"{abspath}:{line}:{column}::{symbol}:{category}:{msg}"',
            '--rcfile', options[:config]
          ],
          files
        ).and_return(command)
        expect(command).to receive(:run).with(container).and_return(true)

        linter.lint(files, container, options)
      end
    end

    context 'when config is not provided' do
      it 'runs the lint command with the correct arguments' do
        expect(LintTrap::Command).to receive(:new).with(
          'pylint',
          [
            '-r', 'no',
            '--msg-template', '"{abspath}:{line}:{column}::{symbol}:{category}:{msg}"'
          ],
          files
        ).and_return(command)
        expect(command).to receive(:run).with(container).and_return(true)

        linter.lint(files, container, options)
      end
    end
  end
end
