require 'spec_helper'

describe LintTrap::Linter::RuboCop do
  let(:container){LintTrap::Container::Docker.new('lintci/spin_cycle:latest', fixture_path)}
  let(:options){{}}
  subject(:linter){described_class.new}

  describe '#lint' do
    context 'when linting a bad file' do
      let(:file){fixture_path('bad.rb')}

      it 'generates lint' do
        expect{|b| linter.lint([file], container, options, &b)}.to yield_successive_args(
          {
            file: file,
            line: '1',
            column: '1',
            length: '5',
            rule: 'Style/Documentation',
            severity: 'convention',
            message: 'Missing top-level class documentation comment.'
          }, {
            file: file,
            line: '2',
            column: '7',
            length: '4',
            rule: 'Style/MethodName',
            severity: 'convention',
            message: 'Use snake_case for method names.'
          }
        )
      end
    end

    context 'when linting a good file' do
      let(:file){fixture_path('good.rb')}

      it 'generates no lint' do
        expect{|b| linter.lint([file], container, options, &b)}.to_not yield_control
      end
    end
  end
end
