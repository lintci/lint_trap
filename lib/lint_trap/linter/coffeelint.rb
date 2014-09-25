require_relative 'base'

module LintTrap
  module Linter
    # Encapsulates logic specific to coffeelint command line tool.
    class CoffeeLint < Base
      REPORTER = 'coffeelint/lint_trap.coffee'

    private

      def flags
        [
          "--reporter=#{config_path(REPORTER)}",
          '--nocolor'
        ].tap do |flags|
          flags.concat(["--file=#{options[:config]}"]) if options[:config]
        end
      end
    end
  end
end
