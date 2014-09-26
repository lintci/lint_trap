require 'spec_helper'

describe LintTrap::Linter::GoLint do
  let(:container){LintTrap::Container::Fake.new}
  subject(:linter){described_class.new(container: container)}

  shared_examples '#lint' do
    context 'when linting a bad file' do
      let(:file){fixture_path('bad.go')}

      it 'generates lint' do
        expect{|b| linter.lint([file], &b)}.to yield_successive_args(
          {
            file: file,
            line: '5',
            column: '1',
            length: nil,
            rule: nil,
            severity: nil,
            message: 'exported function Main should have comment or be unexported'
          }
        )
      end
    end

    context 'when linting a good file' do
      let(:file){fixture_path('good.go')}

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
