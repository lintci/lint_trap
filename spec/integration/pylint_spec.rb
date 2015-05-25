require 'spec_helper'

describe LintTrap::Linter::PyLint do
  let(:container){LintTrap::Container::Docker.new(linter.image_version, fixture_path, remove_container: ENV['CI'].nil?)}
  let(:options){{}}
  subject(:linter){LintTrap::Linter.find('PyLint')}

  describe '#version' do
    subject(:dockerfile){Dockerfile.new(linter.name)}

    it 'matches the linters version' do
      expect(dockerfile.include_env?('PYLINT_VERSION', linter.version)).to be_truthy
    end
  end

  describe '#lint' do
    context 'when linting a bad file' do
      let(:file){fixture_path('bad.py')}

      it 'generates lint' do
        expect{|b| linter.lint([file], container, options, &b)}.to yield_successive_args(
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
        expect{|b| linter.lint([file], container, options, &b)}.to_not yield_control
      end
    end
  end
end
