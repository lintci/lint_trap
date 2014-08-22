# LintTrap

[ ![Codeship Status for lintci/lint_trap](https://codeship.io/projects/2ce67c60-0c55-0132-9858-121f4cfeea24/status)](https://codeship.io/projects/32171)

Parses the output of various linters. Designed for usage with [permpress](https://github.com/lintci/permpress) on [LintCI](http://www.lintci.com).

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

``` ruby
require 'lint_trap'
require 'stringio'

# This would typically be a stdout for another process
io = StringIO.new("bad.rb:2:7:4:Style/MethodName:convention:Use snake_case for methods.\n")

LintTrap.parse('rubocop', io) do |violation|
  puts violation.inspect
end

# Output
# {:file=>"bad.rb", :line=>"2", :column=>"7", :length=>"4", :rule=>"Style/MethodName", :severity=>"convention", :message=>"Use snake_case for methods."}
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/lint_trap/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
