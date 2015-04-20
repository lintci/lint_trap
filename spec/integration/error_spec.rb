require 'spec_helper'

describe LintTrap::Linter::Base do
  let(:container){LintTrap::Container::Docker.new('lintci/spin_cycle:latest', fixture_path)}
  let(:options){{}}
  subject(:linter) do
    ErrorLinter = Class.new(described_class) do
      def command_name
        'ls'
      end

      def flags
        []
      end
    end.new
  end

  describe '#lint' do
    context 'when linting fails' do
      let(:file){fixture_path('this-does-not-exist.rb')}

      it 'raises an error with console output' do
        expect{|b| linter.lint([file], container, options, &b)}.to raise_error(
          LintTrap::Linter::LintError,
          start_with(
            "Encountered error when running linter:\n"\
            "ls: cannot access /home/spin_cycle/this-does-not-exist.rb: No such file or directory\n"
          )
        )
      end
    end
  end
end
