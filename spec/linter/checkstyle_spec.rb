require 'spec_helper'

describe LintTrap::Linter::CheckStyle do
  let(:container){LintTrap::Container::Fake.new}
  let(:options){{}}
  let(:files){%w(Good.java bad.java)}
  let(:command){instance_double(LintTrap::Command)}
  subject(:linter){described_class.new}

  it_behaves_like 'linter'

  its(:languages){is_expected.to eq([LintTrap::Language::Java.new])}

  describe '#lint' do
    context 'when config is provided' do
      let(:options){{config: 'checks.xml'}}

      it 'runs the lint command with the correct arguments' do
        expect(LintTrap::Command).to receive(:new).with(
          'java',
          [
            '-jar', container.config_path(described_class::JAR),
            '-c', options[:config]
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
          'java',
          [
            '-jar', container.config_path(described_class::JAR),
            '-c', container.config_path(described_class::CHECKS_XML)
          ],
          files
        ).and_return(command)
        expect(command).to receive(:run).with(container)

        linter.lint(files, container, options)
      end
    end
  end
end
