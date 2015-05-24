require 'spec_helper'

describe LintTrap::Language::JSON do
  subject(:language){described_class.new}

  it_behaves_like 'language'

  its(:name){is_expected.to eq('JSON')}
  its(:linters){is_expected.to eq([LintTrap::Linter::JSONLint.new])}
  it{is_expected.to be_known}
end
