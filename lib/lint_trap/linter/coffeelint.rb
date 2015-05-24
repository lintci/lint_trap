require_relative 'base'

module LintTrap
  module Linter
    # Encapsulates logic specific to coffeelint command line tool.
    class CoffeeLint < Base
      REPORTER = 'coffeelint/lint_trap.coffee'

      def languages
        super(Language::CoffeeScript)
      end

      def version
        '1.9.7'
      end

    private

      def flags(container, options)
        [
          "--reporter=#{container.config_path(REPORTER)}",
          '--nocolor'
        ].tap do |flags|
          flags.concat(["--file=#{options[:config]}"]) if options[:config]
        end
      end
    end
  end
end
