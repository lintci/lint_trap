require 'spec_helper'

describe LintTrap::Language::Python do
  subject(:language){described_class.new}

  its(:name){is_expected.to eq('Python')}
  its(:linters){is_expected.to eq([LintTrap::Linter::PyLint])}
end
