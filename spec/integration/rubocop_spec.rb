require 'spec_helper'

describe LintTrap::Linter::RuboCop do
  let(:container){LintTrap::Container::Fake.new}
  subject(:linter){described_class.new(container: container)}

  shared_examples '#lint' do
    context 'when linting a bad file' do
      let(:file){fixture_path('bad.rb')}

      it 'generates lint' do
        expect{|b| linter.lint([file], &b)}.to yield_successive_args(
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
            message: 'Use snake_case for methods.'
          }
        )
      end
    end

    context 'when linting a good file' do
      let(:file){fixture_path('good.rb')}

      it 'generates no lint' do
        expect{|b| linter.lint([file], &b)}.to_not yield_control
      end
    end
  end

  context 'with docker container', if: !ENV['SKIP_DOCKER'] do
    let(:container){LintTrap::Container::Docker.new('lintci/spin_cycle:latest', fixture_path)}

    it_behaves_like '#lint'
  end

  context 'without a docker container', if: ENV['SKIP_DOCKER'] do
    it_behaves_like '#lint'
  end
end
