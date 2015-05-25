require 'spec_helper'

describe LintTrap::Language::CPP do
  subject(:language){LintTrap::Language.find('C++')}

  it_behaves_like 'language'

  its(:name){is_expected.to eq('C++')}
  its(:linters){is_expected.to eq([LintTrap::Linter::CPPCheck.new])}
end
