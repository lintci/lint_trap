require 'spec_helper'

describe LintTrap::Linter::JSHint do
  let(:container){LintTrap::Container::Fake.new}
  let(:options){{}}
  let(:files){%w(good.js bad.js)}
  subject(:linter){LintTrap::Linter.find('JSHint')}
  let(:command){instance_double(LintTrap::Command)}

  it_behaves_like 'linter'

  its(:languages){is_expected.to eq([LintTrap::Language::JavaScript.new])}
  its(:version){is_expected.to eq('2.5.11')}
  its(:image){is_expected.to eq('lintci/jshint')}
  its(:image_version){is_expected.to eq('lintci/jshint:2.5.11')}

  describe '#lint' do
    context 'when config is provided' do
      let(:options){{config: '.jshintrc'}}

      it 'runs the lint command with the correct arguments' do
        expect(LintTrap::Command).to receive(:new).with(
          'jshint',
          [
            '--reporter', container.config_path(described_class::FORMATTER),
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
          'jshint',
          [
            '--reporter', container.config_path(described_class::FORMATTER)
          ],
          files
        ).and_return(command)
        expect(command).to receive(:run).with(container).and_return(true)

        linter.lint(files, container, options)
      end
    end
  end
end
