require 'spec_helper'

describe LintTrap::Linter::CoffeeLint do
  let(:container){LintTrap::Container::Fake.new}
  let(:config){nil}
  let(:files){%w(good.coffee bad.coffee)}
  subject(:linter){described_class.new(container: container, config: config)}
  let(:command){instance_double(LintTrap::Command)}

  describe '#lint' do
    context 'when config is provided' do
      let(:config){'coffeelint.json'}

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
        expect(command).to receive(:run).with(container)

        linter.lint(files)
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
        expect(command).to receive(:run).with(container)

        linter.lint(files)
      end
    end
  end
end
