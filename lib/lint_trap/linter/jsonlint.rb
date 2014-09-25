require_relative 'base'

module LintTrap
  module Linter
    # Encapsulates logic specific to durable-json-lint command line tool.
    class JSONLint < Base
    private

      def command_name
        'durable-json-lint'
      end

      def flags
        ['--format', '{{file}}:{{line}}:{{column}}:::error:{{{description}}}']
      end
    end
  end
end
