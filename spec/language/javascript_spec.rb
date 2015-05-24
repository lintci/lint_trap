require 'spec_helper'

describe LintTrap::Language::JavaScript do
  subject(:language){described_class.new}

  it_behaves_like 'language'

  its(:name){is_expected.to eq('JavaScript')}
  its(:linters){is_expected.to eq([LintTrap::Linter::JSHint.new])}
  it{is_expected.to be_known}
end
