require_relative 'base'

module LintTrap
  module Linter
    # Encapsulates logic specific to scsslint command line tool.
    class Unknown < Base
      def lint(_files, _container, _options)
      end

      def languages
        [Language::Unknown.new]
      end

      def version
        LintTrap::VERSION
      end
    end
  end
end
