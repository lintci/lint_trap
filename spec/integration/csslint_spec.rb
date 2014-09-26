require 'spec_helper'

describe LintTrap::Linter::CSSLint do
  let(:container){LintTrap::Container::Fake.new}
  subject(:linter){described_class.new(container: container)}

  shared_examples '#lint' do
    context 'when linting a bad file' do
      let(:file){fixture_path('bad.css')}

      it 'generates lint' do
        expect{|b| linter.lint([file], &b)}.to yield_successive_args(
          {
            file: file,
            line: '2',
            column: '5',
            length: nil,
            rule: nil,
            severity: 'Warning',
            message: 'Using width with border can sometimes make elements larger than you expect.'
          }
        )
      end
    end

    context 'when linting a good file' do
      let(:file){fixture_path('good.css')}

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
