require 'spec_helper'

describe LintTrap::Language do
  describe '.find' do
    subject(:language){described_class.find(language_name)}

    context 'when given CoffeeScript' do
      let(:language_name){'CoffeeScript'}

      it{is_expected.to eq(described_class::CoffeeScript)}
    end

    context 'when given C++' do
      let(:language_name){'C++'}

      it{is_expected.to eq(described_class::CPP)}
    end

    context 'when given CSS' do
      let(:language_name){'CSS'}

      it{is_expected.to eq(described_class::CSS)}
    end

    context 'when given Go' do
      let(:language_name){'Go'}

      it{is_expected.to eq(described_class::Go)}
    end

    context 'when given Java' do
      let(:language_name){'Java'}

      it{is_expected.to eq(described_class::Java)}
    end

    context 'when given JavaScript' do
      let(:language_name){'JavaScript'}

      it{is_expected.to eq(described_class::JavaScript)}
    end

    context 'when given JSON' do
      let(:language_name){'JSON'}

      it{is_expected.to eq(described_class::JSON)}
    end

    context 'when given Python' do
      let(:language_name){'Python'}

      it{is_expected.to eq(described_class::Python)}
    end

    context 'when given Ruby' do
      let(:language_name){'Ruby'}

      it{is_expected.to eq(described_class::Ruby)}
    end

    context 'when given SCSS' do
      let(:language_name){'SCSS'}

      it{is_expected.to eq(described_class::SCSS)}
    end

    context 'when given an invalid language' do
      let(:language_name){'invalid language'}

      it{is_expected.to eq(nil)}
    end
  end
end
