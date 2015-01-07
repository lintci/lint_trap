require 'spec_helper'

describe LintTrap::Linter::CoffeeLint do
  let(:container){LintTrap::Container::Fake.new}
  subject(:linter){described_class.new(container: container)}

  shared_examples '#lint' do
    context 'when linting a bad file' do
      let(:file){fixture_path('bad.coffee')}

      it 'generates lint' do
        expect{|b| linter.lint([file], &b)}.to yield_successive_args(
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
