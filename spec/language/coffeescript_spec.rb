require 'spec_helper'

describe LintTrap::Language::CoffeeScript do
  subject(:language){described_class.new}

  it_behaves_like 'language'

  its(:name){is_expected.to eq('CoffeeScript')}
  its(:linters){is_expected.to eq([LintTrap::Linter::CoffeeLint.new])}
  it{is_expected.to be_known}
end
