require_relative 'base'
require_relative '../parser/csslint'

module LintTrap
  module Linter
    # Encapsulates logic specific to csslint command line tool.
    class CSSLint < Base
    private

      def flags
        [
          '--format=compact'
        ].tap do |flags|
          flags.concat(["--config=#{options[:config]}"]) if options[:config]
        end
      end

      def parser(stdout)
        LintTrap::Parser::CSSLint.new(stdout)
      end
    end
  end
end
