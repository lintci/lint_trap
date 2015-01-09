require 'spec_helper'

describe LintTrap::Linter::CoffeeLint do
  let(:container){LintTrap::Container::Docker.new('lintci/spin_cycle:latest', fixture_path)}
  let(:options){{}}
  subject(:linter){described_class.new}

  describe '#lint' do
    context 'when linting a bad file' do
      let(:file){fixture_path('bad.coffee')}

      it 'generates lint' do
        expect{|b| linter.lint([file], container, options, &b)}.to yield_successive_args(
          {
            file: file,
            line: '1',
            column: nil,
            length: nil,
            rule: 'camel_case_classes',
            severity: 'error',
            message: 'Class names should be camel cased'
          }
        )
      end
    end

    context 'when linting a good file' do
      let(:file){fixture_path('good.coffee')}

      it 'generates no lint' do
        expect{|b| linter.lint([file], container, options, &b)}.to_not yield_control
      end
    end
  end
end
