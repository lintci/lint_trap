require 'spec_helper'

describe LintTrap::Linter::SCSSLint do
  let(:container){LintTrap::Container::Docker.new(linter.image_version, fixture_path)}
  let(:options){{}}
  subject(:linter){described_class.new}

  describe '#version' do
    subject(:dockerfile){Dockerfile.new(linter.name)}

    it 'matches the linters version' do
      expect(dockerfile.include_env?('SCSSLINT_VERSION', linter.version)).to be_truthy
    end
  end

  describe '#lint' do
    context 'when linting a bad file' do
      let(:file){fixture_path('bad.scss')}

      it 'generates lint' do
        expect{|b| linter.lint([file], container, options, &b)}.to yield_successive_args(
          file: file,
          line: '2',
          column: '3',
          length: '12',
          rule: 'BorderZero',
          severity: 'warning',
          message: '`border: 0 is preferred over `border: none`'
        )
      end
    end

    context 'when linting a good file' do
      let(:file){fixture_path('good.scss')}

      it 'generates no lint' do
        expect{|b| linter.lint([file], container, options, &b)}.to_not yield_control
      end
    end
  end
end
