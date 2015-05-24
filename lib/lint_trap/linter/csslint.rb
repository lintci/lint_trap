require_relative 'base'
require_relative '../parser/csslint'

module LintTrap
  module Linter
    # Encapsulates logic specific to csslint command line tool.
    class CSSLint < Base
      def languages
        super(Language::CSS)
      end

      def version
        '0.10.0'
      end

    private

      def flags(_container, options)
        [
          '--format=compact'
        ].tap do |flags|
          flags.concat(["--config=#{options[:config]}"]) if options[:config]
        end
      end

      def parser(stdout, container)
        LintTrap::Parser::CSSLint.new(stdout, container)
      end
    end
  end
end
