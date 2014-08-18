require 'spec_helper'

describe LintTrap do
  it 'has a version number' do
    expect(LintTrap::VERSION).not_to be nil
  end

  describe '.parse' do
    let(:io){StringIO.new("bad.rb:2:7:4:Style/MethodName:convention:Use snake_case for methods.\n")}

    it 'yields the expected violations' do
      expect{|b| LintTrap.parse('rubocop', io, &b)}.to yield_successive_args({
        file: 'bad.rb',
        line: '2',
        column: '7',
        length: '4',
        rule: 'Style/MethodName',
        severity: 'convention',
        message: 'Use snake_case for methods.'
      })
    end
  end
end
