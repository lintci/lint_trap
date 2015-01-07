require 'spec_helper'

describe LintTrap::Language::Java do
  subject(:language){described_class.new}

  its(:name){is_expected.to eq('Java')}
  its(:linters){is_expected.to eq([LintTrap::Linter::CheckStyle])}
end
