require 'spec_helper'

describe LintTrap::Language::JSON do
  subject(:language){LintTrap::Language.find('JSON')}

  it_behaves_like 'language'

  its(:name){is_expected.to eq('JSON')}
  its(:linters){is_expected.to eq([LintTrap::Linter::JSONLint.new])}
end
