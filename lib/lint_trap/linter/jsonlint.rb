require_relative 'base'

module LintTrap
  module Linter
    # Encapsulates logic specific to durable-json-lint command line tool.
    class JSONLint < Base
      def languages
        super(Language::JSON)
      end

      def version
        '0.0.4'
      end

    private

      def command_name(_container)
        'durable-json-lint'
      end

      def flags(_container, _options)
        ['--format', '{{file}}:{{line}}:{{column}}:::error:{{{description}}}']
      end
    end
  end
end
