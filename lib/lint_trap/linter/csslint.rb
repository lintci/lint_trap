require_relative 'base'
require_relative '../parser/csslint'

module LintTrap
  module Linter
    # Encapsulates logic specific to csslint command line tool.
    class CSSLint < Base
      def languages
        super(Language::CSS)
      end

    private

      def flags
        [
          '--format=compact'
        ].tap do |flags|
          flags.concat(["--config=#{options[:config]}"]) if options[:config]
        end
      end

      def parser(stdout)
        LintTrap::Parser::CSSLint.new(stdout, container)
      end
    end
  end
end
