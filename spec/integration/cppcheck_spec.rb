require 'spec_helper'

describe LintTrap::Linter::CPPCheck do
  let(:container){LintTrap::Container::Fake.new}
  subject(:linter){described_class.new(container: container)}

  describe '#lint', if: !ENV['CI'] do
    context 'when linting a bad file' do
      let(:file){fixture_path('bad.cpp')}

      it 'generates lint' do
        expect{|b| linter.lint([file], &b)}.to yield_successive_args(
          {
            file: file,
            line: '3',
            column: nil,
            length: nil,
            rule: 'unassignedVariable',
            severity: 'style',
            message: "Variable 'p' is not assigned a value."
          }, {
            file: file,
            line: '4',
            column: nil,
            length: nil,
            rule: 'uninitvar',
            severity: 'error',
            message: 'Uninitialized variable: p'
          }, {
            file: file,
            line: '1',
            column: nil,
            length: nil,
            rule: 'unusedFunction',
            severity: 'style',
            message: "The function 'f' is never used."
          }
        )
      end
    end

    context 'when linting a good file' do
      let(:file){fixture_path('good.cpp')}

      it 'generates no lint' do
        expect{|b| linter.lint([file], &b)}.to_not yield_control
      end
    end
  end
end
