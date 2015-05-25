require 'spec_helper'

describe LintTrap::Language::JavaScript do
  subject(:language){LintTrap::Language.find('JavaScript')}

  it_behaves_like 'language'

  its(:name){is_expected.to eq('JavaScript')}
  its(:linters){is_expected.to eq([LintTrap::Linter::JSHint.new])}
end
