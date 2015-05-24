require 'spec_helper'

describe LintTrap::Language::SCSS do
  subject(:language){described_class.new}

  it_behaves_like 'language'

  its(:name){is_expected.to eq('SCSS')}
  its(:linters){is_expected.to eq([LintTrap::Linter::SCSSLint.new])}
  it{is_expected.to be_known}
end
