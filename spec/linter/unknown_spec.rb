require 'spec_helper'

describe LintTrap::Linter::Unknown do
  let(:container){LintTrap::Container::Fake.new}
  let(:options){{}}
  let(:files){%w(good.un bad.un)}
  subject(:linter){described_class.new}
  let(:command){instance_double(LintTrap::Command)}

  it_behaves_like 'linter'

  its(:languages){is_expected.to eq([LintTrap::Language::Unknown.new])}
  its(:version){is_expected.to eq(LintTrap::VERSION)}
  its(:image){is_expected.to eq('lintci/unknown')}
  its(:image_version){is_expected.to eq('lintci/unknown:' + LintTrap::VERSION)}

  describe '#lint' do
    it 'is a noop' do
      expect(LintTrap::Command).to_not receive(:new)

      linter.lint(files, container, options)
    end
  end
end
