require 'spec_helper'

describe LintTrap::Linter do
  describe '.all' do
    subject(:all_linters){described_class.all}

    it do
      is_expected.to match([
        be_a(described_class::CheckStyle),
        be_a(described_class::CoffeeLint),
        be_a(described_class::CPPCheck),
        be_a(described_class::CSSLint),
        be_a(described_class::GoLint),
        be_a(described_class::JSHint),
        be_a(described_class::JSONLint),
        be_a(described_class::PyLint),
        be_a(described_class::RuboCop),
        be_a(described_class::SCSSLint)
      ])
    end
  end

  describe '.find' do
    subject(:linter){described_class.find(linter_name)}

    context 'when given CheckStyle' do
      let(:linter_name){'CheckStyle'}

      it{is_expected.to be_a(described_class::CheckStyle)}
    end

    context 'when given CoffeeLint' do
      let(:linter_name){'CoffeeLint'}

      it{is_expected.to be_a(described_class::CoffeeLint)}
    end

    context 'when given CPPCheck' do
      let(:linter_name){'CPPCheck'}

      it{is_expected.to be_a(described_class::CPPCheck)}
    end

    context 'when given CSSLint' do
      let(:linter_name){'CSSLint'}

      it{is_expected.to be_a(described_class::CSSLint)}
    end

    context 'when given GoLint' do
      let(:linter_name){'GoLint'}

      it{is_expected.to be_a(described_class::GoLint)}
    end

    context 'when given JSHint' do
      let(:linter_name){'JSHint'}

      it{is_expected.to be_a(described_class::JSHint)}
    end

    context 'when given JSONLint' do
      let(:linter_name){'JSONLint'}

      it{is_expected.to be_a(described_class::JSONLint)}
    end

    context 'when given PyLint' do
      let(:linter_name){'PyLint'}

      it{is_expected.to be_a(described_class::PyLint)}
    end

    context 'when given RuboCop' do
      let(:linter_name){'RuboCop'}

      it{is_expected.to be_a(described_class::RuboCop)}
    end

    context 'when given SCSSLint' do
      let(:linter_name){'SCSSLint'}

      it{is_expected.to be_a(described_class::SCSSLint)}
    end

    context 'when given an unknown linter' do
      let(:linter_name){'taco cheese'}

      it{is_expected.to eq(described_class::Unknown.new(linter_name))}
    end
  end
end
