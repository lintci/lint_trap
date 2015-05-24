require 'spec_helper'

describe LintTrap::Parser::Line do
  let(:image){LintTrap::Linter::RuboCop.new.image_version}
  let(:container){LintTrap::Container::Docker.new(image, fixture_path, remove_container: ENV['CI'].nil?)}
  subject(:parser){Class.new(described_class).new(StringIO.new('violation'), container)}

  describe '#parse' do
    it 'raises an error if #violation_regex not overriden' do
      expect{parser.parse}.to raise_error(NotImplementedError, 'Must implement violation_regex.')
    end
  end
end
