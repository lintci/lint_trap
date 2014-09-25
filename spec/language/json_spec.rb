require 'spec_helper'

describe LintTrap::Language::JSON do
  subject(:language){described_class}

  its(:name){is_expected.to eq('JSON')}
  its(:linters){is_expected.to eq([LintTrap::Linter::JSONLint])}
end
