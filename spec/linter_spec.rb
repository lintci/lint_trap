require 'spec_helper'

describe LintTrap::Linter do
  describe '.find' do
    subject(:language){described_class.find(linter_name)}

    context 'when given CheckStyle' do
      let(:linter_name){'CheckStyle'}

      it{is_expected.to eq(described_class::CheckStyle)}
    end

    context 'when given CoffeeLint' do
      let(:linter_name){'CoffeeLint'}

      it{is_expected.to eq(described_class::CoffeeLint)}
    end

    context 'when given CPPCheck' do
      let(:linter_name){'CPPCheck'}

      it{is_expected.to eq(described_class::CPPCheck)}
    end

    context 'when given CSSLint' do
      let(:linter_name){'CSSLint'}

      it{is_expected.to eq(described_class::CSSLint)}
    end

    context 'when given GoLint' do
      let(:linter_name){'GoLint'}

      it{is_expected.to eq(described_class::GoLint)}
    end

    context 'when given JSHint' do
      let(:linter_name){'JSHint'}

      it{is_expected.to eq(described_class::JSHint)}
    end

    context 'when given JSONLint' do
      let(:linter_name){'JSONLint'}

      it{is_expected.to eq(described_class::JSONLint)}
    end

    context 'when given PyLint' do
      let(:linter_name){'PyLint'}

      it{is_expected.to eq(described_class::PyLint)}
    end

    context 'when given RuboCop' do
      let(:linter_name){'RuboCop'}

      it{is_expected.to eq(described_class::RuboCop)}
    end

    context 'when given SCSSLint' do
      let(:linter_name){'SCSSLint'}

      it{is_expected.to eq(described_class::SCSSLint)}
    end
  end
end
