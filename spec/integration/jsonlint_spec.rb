require 'spec_helper'

describe LintTrap::Linter::JSONLint do
  let(:container){LintTrap::Container::Docker.new(linter.image_version, fixture_path, remove_container: ENV['CI'].nil?)}
  let(:options){{}}
  subject(:linter){described_class.new}

  describe '#version' do
    subject(:dockerfile){Dockerfile.new(linter.name)}

    it 'matches the linters version' do
      expect(dockerfile.include_env?('JSONLINT_VERSION', linter.version)).to be_truthy
    end
  end

  describe '#lint' do
    context 'when linting a bad file' do
      let(:file){fixture_path('bad.json')}

      it 'generates lint' do
        expect{|b| linter.lint([file], container, options, &b)}.to yield_successive_args(
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
        expect{|b| linter.lint([file], container, options, &b)}.to_not yield_control
      end
    end
  end
end
