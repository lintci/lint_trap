require 'spec_helper'

describe LintTrap::Linter::JSHint do
  let(:container){LintTrap::Container::Docker.new(linter.image_version, fixture_path, remove_container: ENV['CI'].nil?)}
  let(:options){{}}
  subject(:linter){LintTrap::Linter.find('JSHint')}

  describe '#version' do
    subject(:dockerfile){Dockerfile.new(linter.name)}

    it 'matches the linters version' do
      expect(dockerfile.include_env?('JSHINT_VERSION', linter.version)).to be_truthy
    end
  end

  describe '#lint' do
    context 'when linting a bad file' do
      let(:file){fixture_path('bad.js')}

      it 'generates lint' do
        expect{|b| linter.lint([file], container, options, &b)}.to yield_successive_args(
          {
            file: file,
            line: '2',
            column: '13',
            length: nil,
            rule: 'E031',
            severity: 'error',
            message: 'Bad assignment.'
          }, {
            file: file,
            line: '2',
            column: '13',
            length: nil,
            rule: 'W030',
            severity: 'warning',
            message:
             'Expected an assignment or function call and instead saw an expression.'
          }, {
            file: file,
            line: '2',
            column: '14',
            length: nil,
            rule: 'W033',
            severity: 'warning',
            message: 'Missing semicolon.'
          }, {
            file: file,
            line: '2',
            column: '15',
            length: nil,
            rule: 'W030',
            severity: 'warning',
            message:
             'Expected an assignment or function call and instead saw an expression.'
          }
        )
      end
    end

    context 'when linting a good file' do
      let(:file){fixture_path('good.js')}

      it 'generates no lint' do
        expect{|b| linter.lint([file], container, options, &b)}.to_not yield_control
      end
    end
  end
end
