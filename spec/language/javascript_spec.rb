require 'spec_helper'

describe LintTrap::Language::JavaScript do
  subject(:language){described_class.new}

  its(:name){is_expected.to eq('JavaScript')}
  its(:linters){is_expected.to eq([LintTrap::Linter::JSHint])}
end
