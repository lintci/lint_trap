require 'spec_helper'

describe LintTrap::Parser::Base do
  let(:image){LintTrap::Linter::RuboCop.new.image_version}
  let(:container){LintTrap::Container::Docker.new(image, fixture_path, remove_container: ENV['CI'].nil?)}
  let(:io){StringIO.new}
  subject(:parser){Class.new(described_class).new}

  describe '#parse' do
    it 'raises an error if not overriden' do
      expect{parser.parse(io, container)}.to raise_error(NotImplementedError, 'Must implement parse.')
    end
  end
end
