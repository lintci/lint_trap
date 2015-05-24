require 'spec_helper'

describe LintTrap::Linter::CSSLint do
  let(:container){LintTrap::Container::Docker.new(linter.image_version, fixture_path)}
  let(:options){{}}
  subject(:linter){described_class.new}

  describe '#version' do
    subject(:dockerfile){Dockerfile.new(linter.name)}

    it 'matches the linters version' do
      expect(dockerfile.include_env?('CSSLINT_VERSION', linter.version)).to be_truthy
    end
  end

  describe '#lint' do
    context 'when linting a bad file' do
      let(:file){fixture_path('bad.css')}

      it 'generates lint' do
        expect{|b| linter.lint([file], container, options, &b)}.to yield_successive_args(
          file: file,
          line: '2',
          column: '5',
          length: nil,
          rule: nil,
          severity: 'Warning',
          message: 'Using width with border can sometimes make elements larger than you expect.'
        )
      end
    end

    context 'when linting a good file' do
      let(:file){fixture_path('good.css')}

      it 'generates no lint' do
        expect{|b| linter.lint([file], container, options, &b)}.to_not yield_control
      end
    end
  end
end
