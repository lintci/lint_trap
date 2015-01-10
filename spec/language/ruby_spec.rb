require 'spec_helper'

describe LintTrap::Language::Ruby do
  subject(:language){described_class.new}

  it_behaves_like 'language'

  its(:name){is_expected.to eq('Ruby')}
  its(:linters){is_expected.to eq([LintTrap::Linter::RuboCop.new])}
end
