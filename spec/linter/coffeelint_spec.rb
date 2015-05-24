require 'spec_helper'

describe LintTrap::Linter::CoffeeLint do
  let(:container){LintTrap::Container::Fake.new}
  let(:options){{}}
  let(:files){%w(good.coffee bad.coffee)}
  subject(:linter){described_class.new}
  let(:command){instance_double(LintTrap::Command)}

  it_behaves_like 'linter'

  its(:languages){is_expected.to eq([LintTrap::Language::CoffeeScript.new])}
  its(:version){is_expected.to eq('1.9.7')}
  its(:image){is_expected.to eq('lintci/coffeelint')}
  its(:image_version){is_expected.to eq('lintci/coffeelint:1.9.7')}

  describe '#lint' do
    context 'when config is provided' do
      let(:options){{config: 'coffeelint.json'}}

      it 'runs the lint command with the correct arguments' do
        expect(LintTrap::Command).to receive(:new).with(
          'coffeelint',
          [
            "--reporter=#{container.config_path(described_class::REPORTER)}",
            '--nocolor',
            '--file=coffeelint.json'
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
          'coffeelint',
          [
            "--reporter=#{container.config_path(described_class::REPORTER)}",
            '--nocolor'
          ],
          files
        ).and_return(command)
        expect(command).to receive(:run).with(container).and_return(true)

        linter.lint(files, container, options)
      end
    end
  end
end
