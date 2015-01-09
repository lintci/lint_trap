require 'spec_helper'

describe LintTrap::Linter::PyLint do
  let(:container){LintTrap::Container::Fake.new}
  let(:options){{}}
  let(:files){%w(good.py bad.py)}
  subject(:linter){described_class.new}
  let(:command){instance_double(LintTrap::Command)}

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
        expect(command).to receive(:run).with(container)

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
        expect(command).to receive(:run).with(container)

        linter.lint(files, container, options)
      end
    end
  end
end
