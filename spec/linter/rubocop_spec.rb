require 'spec_helper'

describe LintTrap::Linter::RuboCop do
  let(:container){LintTrap::Container::Fake.new}
  let(:options){{}}
  let(:files){%w(good.rb bad.rb)}
  subject(:linter){LintTrap::Linter.find('RuboCop')}
  let(:command){instance_double(LintTrap::Command)}

  it_behaves_like 'linter'

  its(:languages){is_expected.to eq([LintTrap::Language::Ruby.new])}
  its(:version){is_expected.to eq('0.31.0')}
  its(:image){is_expected.to eq('lintci/rubocop')}
  its(:image_version){is_expected.to eq('lintci/rubocop:0.31.0')}

  describe '#lint' do
    context 'when config is provided' do
      let(:options){{config: '.rubocop.yml'}}

      it 'runs the lint command with the correct arguments' do
        expect(LintTrap::Command).to receive(:new).with(
          'rubocop',
          [
            '--require', container.config_path(described_class::FORMATTER),
            '--format', 'LintTrap::Rubocop::Formatter',
            '--no-color',
            '--config', options[:config]
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
          'rubocop',
          [
            '--require', container.config_path(described_class::FORMATTER),
            '--format', 'LintTrap::Rubocop::Formatter',
            '--no-color'
          ],
          files
        ).and_return(command)
        expect(command).to receive(:run).with(container).and_return(true)

        linter.lint(files, container, options)
      end
    end
  end
end
