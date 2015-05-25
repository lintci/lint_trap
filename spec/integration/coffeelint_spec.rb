require 'spec_helper'

describe LintTrap::Linter::CoffeeLint do
  let(:container){LintTrap::Container::Docker.new(linter.image_version, fixture_path, remove_container: ENV['CI'].nil?)}
  let(:options){{}}
  subject(:linter){LintTrap::Linter.find('CoffeeLint')}

  describe '#version' do
    subject(:dockerfile){Dockerfile.new(linter.name)}

    it 'matches the linters version' do
      expect(dockerfile.include_env?('COFFEELINT_VERSION', linter.version)).to be_truthy
    end
  end

  describe '#lint' do
    context 'when linting a bad file' do
      let(:file){fixture_path('bad.coffee')}

      it 'generates lint' do
        expect{|b| linter.lint([file], container, options, &b)}.to yield_successive_args(
          file: file,
          line: '1',
          column: nil,
          length: nil,
          rule: 'camel_case_classes',
          severity: 'error',
          message: 'Class name should be UpperCamelCased'
        )
      end
    end

    context 'when linting a good file' do
      let(:file){fixture_path('good.coffee')}

      it 'generates no lint' do
        expect{|b| linter.lint([file], container, options, &b)}.to_not yield_control
      end
    end
  end
end
