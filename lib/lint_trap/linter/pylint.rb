require_relative 'base'

module LintTrap
  module Linter
    # Encapsulates logic specific to pylint command line tool.
    class PyLint < Base
      def languages
        super(Language::Python)
      end

      def version
        '1.3.1-3'
      end

    private

      def flags(_container, options)
        [
          '-r', 'no',
          '--msg-template', '"{abspath}:{line}:{column}::{symbol}:{category}:{msg}"'
        ].tap do |flags|
          flags.concat(['--rcfile', options[:config]]) if options[:config]
        end
      end
    end
  end
end
