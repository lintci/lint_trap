require 'spec_helper'

describe LintTrap::Linter::CPPCheck do
  let(:container){LintTrap::Container::Docker.new(linter.image_version, fixture_path, remove_container: ENV['CI'].nil?)}
  let(:options){{}}
  subject(:linter){described_class.new}

  describe '#version' do
    subject(:dockerfile){Dockerfile.new(linter.name)}

    it 'matches the linters version' do
      expect(dockerfile.include_env?('CPPCHECK_VERSION', linter.version)).to be_truthy
    end
  end

  describe '#lint' do
    context 'when linting a bad file' do
      let(:file){fixture_path('bad.cpp')}

      it 'generates lint' do
        expect{|b| linter.lint([file], container, options, &b)}.to yield_successive_args(
          {
            file: file,
            line: '3',
            column: nil,
            length: nil,
            rule: 'unassignedVariable',
            severity: 'style',
            message: start_with("Variable 'p' is not assigned a value.") # Other text sometimes gets added
          }, {
            file: file,
            line: '4',
            column: nil,
            length: nil,
            rule: 'uninitvar',
            severity: 'error',
            message: start_with('Uninitialized variable: p')
          }, {
            file: file,
            line: '1',
            column: nil,
            length: nil,
            rule: 'unusedFunction',
            severity: 'style',
            message: start_with("The function 'f' is never used.")
          }
        )
      end
    end

    context 'when linting a good file' do
      let(:file){fixture_path('good.cpp')}

      it 'generates no lint' do
        expect{|b| linter.lint([file], container, options, &b)}.to_not yield_control
      end
    end
  end
end
