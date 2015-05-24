require 'spec_helper'

describe LintTrap::Language::Unknown do
  subject(:language){described_class.new}

  it_behaves_like 'language'

  context 'when no name is passed' do
    its(:name){is_expected.to eq('Unknown')}
  end

  context 'when a name is passed' do
    subject(:language){described_class.new('Huh')}

    its(:name){is_expected.to eq('Huh')}
  end

  its(:linters){is_expected.to eq([LintTrap::Linter::Unknown.new])}
  it{is_expected.to_not be_known}
end
