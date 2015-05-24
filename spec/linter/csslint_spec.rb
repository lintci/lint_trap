require 'spec_helper'

describe LintTrap::Linter::CSSLint do
  let(:container){LintTrap::Container::Fake.new}
  let(:options){{}}
  let(:files){%w(good.css bad.css)}
  subject(:linter){described_class.new}
  let(:command){instance_double(LintTrap::Command)}

  it_behaves_like 'linter'

  its(:languages){is_expected.to eq([LintTrap::Language::CSS.new])}
  its(:version){is_expected.to eq('0.10.0')}
  its(:image){is_expected.to eq('lintci/csslint')}
  its(:image_version){is_expected.to eq('lintci/csslint:0.10.0')}

  describe '#lint' do
    context 'when config is provided' do
      let(:options){{config: '.csslintrc'}}

      it 'runs the lint command with the correct arguments' do
        expect(LintTrap::Command).to receive(:new).with(
          'csslint',
          [
            '--format=compact',
            '--config=.csslintrc'
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
          'csslint',
          [
            '--format=compact'
          ],
          files
        ).and_return(command)
        expect(command).to receive(:run).with(container).and_return(true)

        linter.lint(files, container, options)
      end
    end
  end
end
