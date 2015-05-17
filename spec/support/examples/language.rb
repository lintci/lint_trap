shared_examples_for 'language' do
  its(:linters){is_expected.to_not be_empty}

  describe '#linters' do
    it 'returns a list of linters which reference this language' do
      language.linters.each do |linter|
        expect(linter.languages).to include(language),
                                    "expected #{linter.name} to reference #{language.name} as one of it's languages"
      end
    end
  end
end
