require 'spec_helper'

describe LintTrap::Linter::RuboCop do
  let(:container){LintTrap::Container::Fake.new}
  let(:config){nil}
  let(:files){%w(good.rb bad.rb)}
  subject(:linter){described_class.new(container: container, config: config)}
  let(:command){instance_double(LintTrap::Command)}

  describe '#lint' do
    context 'when config is provided' do
      let(:config){'.rubocop.yml'}

      it 'runs the lint command with the correct arguments' do
        expect(LintTrap::Command).to receive(:new).with(
          'rubocop',
          [
            '--require', container.config_path(described_class::FORMATTER),
            '--format', 'LintTrap::Rubocop::Formatter',
            '--no-color',
            '--config', config
          ],
          files
        ).and_return(command)
        expect(command).to receive(:run).with(container)

        linter.lint(files)
      end
    end

    context 'when config is not provided' do
      it 'runs the lint command with the correct arguments' do
        expect(LintTrap::Command).to receive(:new).with(
          'rubocop',
          [
            '--require', container.config_path(described_class::FORMATTER),
            '--format', 'LintTrap::Rubocop::Formatter',
            '--no-color'
          ],
          files
        ).and_return(command)
        expect(command).to receive(:run).with(container)

        linter.lint(files)
      end
    end
  end
end
