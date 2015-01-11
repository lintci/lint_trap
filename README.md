# LintTrap

[![Circle CI](https://circleci.com/gh/lintci/lint_trap.svg?style=svg)](https://circleci.com/gh/lintci/lint_trap)

Detects languages of files, determines appropriate linters, and runs then. Created for [LintCI](http://www.lintci.com).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lint_trap'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lint_trap

## Usage

### Language Detection

``` ruby
require 'lint_trap'

language = LintTrap::Language.detect('bad.rb')
language.name #=> 'Ruby'
language.linters #=> [<Rubocop>]
```

### Linting

``` ruby
require 'lint_trap'

container = LintTrap::Container::Docker.new('lintci/lint_trap')
linter = LintTrap::Linter.find('RuboCop')

linter.run(['bad.rb'], container, {}) do |violation|
  violation #=> {
            #     file: 'bad.rb',
            #     line: '2',
            #     column: '7',
            #     length: '4',
            #     rule: 'Style/MethodName',
            #     severity: 'convention',
            #     message: 'Use snake_case for methods.'
            #   }
end

```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/lint_trap/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
