require 'spec_helper'

describe LintTrap::Language::Java do
  subject(:language){LintTrap::Language.find('Java')}

  it_behaves_like 'language'

  its(:name){is_expected.to eq('Java')}
  its(:linters){is_expected.to eq([LintTrap::Linter::CheckStyle.new])}
end
