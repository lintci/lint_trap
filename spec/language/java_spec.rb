require 'spec_helper'

describe LintTrap::Language::Java do
  subject(:language){described_class.new}

  it_behaves_like 'language'

  its(:name){is_expected.to eq('Java')}
  its(:linters){is_expected.to eq([LintTrap::Linter::CheckStyle.new])}
  it{is_expected.to be_known}
end
