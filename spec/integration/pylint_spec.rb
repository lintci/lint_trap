require 'spec_helper'

describe LintTrap::Linter::PyLint do
  let(:container){LintTrap::Container::Fake.new}
  subject(:linter){described_class.new(container: container)}

  shared_examples '#lint' do
    context 'when linting a bad file' do
      let(:file){fixture_path('bad.py')}

      it 'generates lint' do
        expect{|b| linter.lint([file], &b)}.to yield_successive_args(
          {
            file: file,
            line: '1',
            column: '0',
            length: nil,
            rule: 'missing-docstring',
            severity: 'convention',
            message: 'Missing module docstring'
          }, {
            file: file,
            line: '1',
            column: '0',
            length: nil,
            rule: 'missing-docstring',
            severity: 'convention',
            message: 'Missing function docstring'}
        )
      end
    end

    context 'when linting a good file' do
      let(:file){fixture_path('good.py')}

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
