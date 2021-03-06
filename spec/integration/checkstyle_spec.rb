require 'spec_helper'

describe LintTrap::Linter::CheckStyle do
  let(:container){LintTrap::Container::Docker.new(linter.image_version, fixture_path, remove_container: ENV['CI'].nil?)}
  let(:options){{}}
  subject(:linter){LintTrap::Linter.find('CheckStyle')}

  describe '#lint' do
    context 'when linting a bad file' do
      let(:file){fixture_path('bad.java')}

      it 'generates lint' do
        expect{|b| linter.lint([file], container, options, &b)}.to yield_successive_args(
          {
            file: file,
            line: '1',
            column: '0',
            length: nil,
            rule: 'com.puppycrawl.tools.checkstyle.checks.javadoc.JavadocTypeCheck',
            severity: 'error',
            message: 'Missing a Javadoc comment.'
          }, {
            file: file,
            line: '1',
            column: '14',
            length: nil,
            rule: 'com.puppycrawl.tools.checkstyle.checks.naming.TypeNameCheck',
            severity: 'error',
            message: "Name 'bad' must match pattern '^[A-Z][a-zA-Z0-9]*$'."
          }
        )
      end
    end

    context 'when linting a good file' do
      let(:file){fixture_path('Good.java')}

      it 'generates no lint' do
        expect{|b| linter.lint([file], container, options, &b)}.to_not yield_control
      end
    end
  end
end
