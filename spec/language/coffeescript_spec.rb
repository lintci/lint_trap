require 'spec_helper'

describe LintTrap::Language::CoffeeScript do
  subject(:language){described_class}

  its(:name){is_expected.to eq('CoffeeScript')}
  its(:linters){is_expected.to eq([LintTrap::Linter::CoffeeLint])}
end