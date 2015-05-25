require_relative 'base'
require_relative '../parser/csslint'

module LintTrap
  module Linter
    # Encapsulates logic specific to csslint command line tool.
    class CSSLint < Base
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
    end
  end
end
