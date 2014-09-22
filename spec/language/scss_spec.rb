require 'spec_helper'

describe LintTrap::Language::SCSS do
  subject(:language){described_class}

  its(:name){is_expected.to eq('SCSS')}
  its(:linters){is_expected.to eq([LintTrap::Linter::SCSSLint])}
end
