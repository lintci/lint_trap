require 'spec_helper'

describe LintTrap::Language::Go do
  subject(:language){described_class.new}

  it_behaves_like 'language'

  its(:name){is_expected.to eq('Go')}
  its(:linters){is_expected.to eq([LintTrap::Linter::GoLint.new])}
end
