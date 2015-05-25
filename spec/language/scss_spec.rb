require 'spec_helper'

describe LintTrap::Language::SCSS do
  subject(:language){LintTrap::Language.find('SCSS')}

  it_behaves_like 'language'

  its(:name){is_expected.to eq('SCSS')}
  its(:linters){is_expected.to eq([LintTrap::Linter::SCSSLint.new])}
end
