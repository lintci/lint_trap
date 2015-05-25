require 'spec_helper'

describe LintTrap::Registry do
  let(:a) do
    Class.new do
      def name
        'a'
      end
    end
  end
  let(:b) do
    Class.new do
      def name
        'b'
      end
    end
  end

  subject(:registry){described_class.new}

  before(:each) do
    registry.register(a)
    registry.register(b)
    registry.default(b)
  end

  describe '#all' do
    subject(:all){registry.all}

    it{is_expected.to match([be_a(a), be_a(b)])}
  end

  describe '#find' do
    context 'when searching for a' do
      it 'finds an a' do
        expect(registry.find('a')).to be_a(a)
      end
    end

    context 'when searching for b' do
      it 'finds a b' do
        expect(registry.find('b')).to be_a(b)
      end
    end

    context 'when searching for an unregistered value' do
      it 'finds the default' do
        expect(registry.find('c')).to be_a(b)
      end
    end
  end
end
