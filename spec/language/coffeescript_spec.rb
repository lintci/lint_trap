require 'spec_helper'

describe LintTrap::Language::CoffeeScript do
  subject(:language){LintTrap::Language.find('CoffeeScript')}

  it_behaves_like 'language'

  its(:name){is_expected.to eq('CoffeeScript')}
  its(:linters){is_expected.to eq([LintTrap::Linter::CoffeeLint.new])}
end
