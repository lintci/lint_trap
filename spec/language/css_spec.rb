require 'spec_helper'

describe LintTrap::Language::CSS do
  subject(:language){LintTrap::Language.find('CSS')}

  it_behaves_like 'language'

  its(:name){is_expected.to eq('CSS')}
  its(:linters){is_expected.to eq([LintTrap::Linter::CSSLint.new])}
end
