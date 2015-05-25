shared_examples_for 'linter' do
  its(:languages){is_expected.to_not be_empty}

  describe '#languages' do
    it 'returns a list of languages which reference this linter' do
      linter.languages.each do |language|
        expect(language.linters).to include(linter),
                                    "expected #{language.name} to reference #{linter.name} as one of it's linters"
      end
    end
  end
end
