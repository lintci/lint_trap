require 'spec_helper'

describe LintTrap::Linter::GoLint do
  let(:container){LintTrap::Container::Docker.new('lintci/spin_cycle:latest', fixture_path)}
  let(:options){{}}
  subject(:linter){described_class.new}

  describe '#lint' do
    context 'when linting a bad file' do
      let(:file){fixture_path('bad.go')}

      it 'generates lint' do
        expect{|b| linter.lint([file], container, options, &b)}.to yield_successive_args(
          file: file,
          line: '5',
          column: '1',
          length: nil,
          rule: nil,
          severity: nil,
          message: 'exported function Main should have comment or be unexported'
        )
      end
    end

    context 'when linting a good file' do
      let(:file){fixture_path('good.go')}

      it 'generates no lint' do
        expect{|b| linter.lint([file], container, options, &b)}.to_not yield_control
      end
    end
  end
end
