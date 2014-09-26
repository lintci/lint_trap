require 'spec_helper'

describe LintTrap::Linter::JSONLint do
  let(:container){LintTrap::Container::Fake.new}
  subject(:linter){described_class.new(container: container)}

  shared_examples '#lint' do
    context 'when linting a bad file' do
      let(:file){fixture_path('bad.json')}

      it 'generates lint' do
        expect{|b| linter.lint([file], &b)}.to yield_successive_args(
          {
            file: file,
            line: '2',
            column: '2',
            length: nil,
            rule: nil,
            severity: 'error',
            message: 'Json strings must use double quotes'
          }, {
            file: file,
            line: '3',
            column: '2',
            length: nil,
            rule: nil,
            severity: 'error',
            message: 'Keys must be double quoted in Json. Did you mean "not"?'
          }, {
            file: file,
            line: '3',
            column: '7',
            length: nil,
            rule: nil,
            severity: 'error',
            message: 'Invalid Json number'
          }
        )
      end
    end

    context 'when linting a good file' do
      let(:file){fixture_path('good.json')}

      it 'generates no lint' do
        expect{|b| linter.lint([file], &b)}.to_not yield_control
      end
    end
  end

  context 'with docker container', if: !ENV['CI'] do
    let(:container){LintTrap::Container::Docker.new('lintci/spin_cycle', fixture_path)}

    it_behaves_like '#lint'
  end

  context 'without a docker container' do
    it_behaves_like '#lint'
  end
end
