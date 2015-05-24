require 'spec_helper'

describe LintTrap::Linter::Base do
  let(:image){LintTrap::Linter::RuboCop.new.image_version}
  let(:container){LintTrap::Container::Docker.new(image, fixture_path)}
  let(:options){{}}
  subject(:linter) do
    ErrorLinter = Class.new(described_class) do
      def command_name(_container)
        'ls'
      end

      def flags(_container, _options)
        []
      end
    end.new
  end

  describe '#lint' do
    context 'when linting fails' do
      let(:file){fixture_path('this-does-not-exist.rb')}

      it 'raises an error with console output' do
        expect{|b| linter.lint([file], container, options, &b)}.to raise_error(
          LintTrap::Linter::LintError,
          start_with(
            'An error occurred while running `docker run'
          )
        )
      end
    end
  end
end
