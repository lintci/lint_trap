require 'spec_helper'

describe LintTrap::Parser::Standard do
  let(:parser_output) do
    "bad.java:1:0::com.puppycrawl.tools.checkstyle.checks.javadoc.JavadocTypeCheck:error:"\
    "Missing a Javadoc comment.\n"\
    "bad.coffee:1:::camel_case_classes:error:Class names should be camel cased\n"\
    "bad.js:2:13::W030:warning:Expected an assignment or function call and instead saw an expression.\n"\
    "bad.json:2:2:::error:Json strings must use double quotes\n"\
    "bad.rb:2:7:4:Style/MethodName:convention:Use snake_case for methods.\n"\
    "bad.scss:2:3:12:BorderZero:warning:`border: 0;` is preferred over `border: none;`\n"
  end
  let(:io){StringIO.new(parser_output)}
  let(:container){LintTrap::Container::Fake.new}
  subject(:parser){described_class.new(io, container)}

  describe '.parse' do
    it 'parses violations from io' do
      expect{|b| @result = parser.parse(&b)}.to yield_successive_args(
        {
          file: 'bad.java',
          line: '1',
          column: '0',
          length: nil,
          rule: 'com.puppycrawl.tools.checkstyle.checks.javadoc.JavadocTypeCheck',
          severity: 'error',
          message: 'Missing a Javadoc comment.'
        },
        {
          file: 'bad.coffee',
          line: '1',
          column: nil,
          length: nil,
          rule: 'camel_case_classes',
          severity: 'error',
          message: 'Class names should be camel cased'
        },
        {
          file: 'bad.js',
          line: '2',
          column: '13',
          length: nil,
          rule: 'W030',
          severity: 'warning',
          message: 'Expected an assignment or function call and instead saw an expression.'
        },
        {
          file: 'bad.json',
          line: '2',
          column: '2',
          length: nil,
          rule: nil,
          severity: 'error',
          message: 'Json strings must use double quotes'
        },
        {
          file: 'bad.rb',
          line: '2',
          column: '7',
          length: '4',
          rule: 'Style/MethodName',
          severity: 'convention',
          message: 'Use snake_case for methods.'
        },
        {
          file: 'bad.scss',
          line: '2',
          column: '3',
          length: '12',
          rule: 'BorderZero',
          severity: 'warning',
          message: '`border: 0;` is preferred over `border: none;`'
        }
      )

      expect(@result).to eq('')
    end
  end
end
