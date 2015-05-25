require 'spec_helper'

describe LintTrap::Language::Unknown do
  subject(:language){described_class.new}

  it_behaves_like 'language'

  its(:name){is_expected.to eq('Unknown')}
  its(:linters){is_expected.to eq([LintTrap::Linter::Unknown.new])}
end
