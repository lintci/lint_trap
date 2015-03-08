require 'spec_helper'

describe LintTrap::Linter::Unknown do
  let(:container){LintTrap::Container::Fake.new}
  let(:options){{}}
  let(:files){%w(good.un bad.un)}
  subject(:linter){described_class.new}
  let(:command){instance_double(LintTrap::Command)}

  it_behaves_like 'linter'

  its(:languages){is_expected.to eq([LintTrap::Language::Unknown.new])}

  describe '#lint' do
    it 'is a noop' do
      expect(LintTrap::Command).to_not receive(:new)

      linter.lint(files, container, options)
    end
  end
end
