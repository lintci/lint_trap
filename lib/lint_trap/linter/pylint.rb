require_relative 'base'

module LintTrap
  module Linter
    # Encapsulates logic specific to pylint command line tool.
    class PyLint < Base
    private

      def flags
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
