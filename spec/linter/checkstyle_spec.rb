require 'spec_helper'

describe LintTrap::Linter::CheckStyle do
  let(:container){LintTrap::Container::Fake.new}
  let(:options){{}}
  let(:files){%w(Good.java bad.java)}
  let(:command){instance_double(LintTrap::Command)}
  subject(:linter){described_class.new}

  it_behaves_like 'linter'

  its(:languages){is_expected.to eq([LintTrap::Language::Java.new])}
  its(:version){is_expected.to eq('6.6')}
  its(:image){is_expected.to eq('lintci/checkstyle')}
  its(:image_version){is_expected.to eq('lintci/checkstyle:6.6')}
  its(:jar){is_expected.to eq('checkstyle/checkstyle_logger-6.6-all.jar')}

  describe '#lint' do
    context 'when config is provided' do
      let(:options){{config: 'checks.xml'}}

      it 'runs the lint command with the correct arguments' do
        expect(LintTrap::Command).to receive(:new).with(
          'java',
          [
            '-jar', container.config_path(linter.jar),
            '-c', options[:config]
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
          'java',
          [
            '-jar', container.config_path(linter.jar),
            '-c', container.config_path(described_class::CHECKS_XML)
          ],
          files
        ).and_return(command)
        expect(command).to receive(:run).with(container).and_return(true)

        linter.lint(files, container, options)
      end
    end
  end
end
