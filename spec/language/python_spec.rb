require 'spec_helper'

describe LintTrap::Language::Python do
  subject(:language){LintTrap::Language.find('Python')}

  it_behaves_like 'language'

  its(:name){is_expected.to eq('Python')}
  its(:linters){is_expected.to eq([LintTrap::Linter::PyLint.new])}
end
