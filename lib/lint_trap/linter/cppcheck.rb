require_relative 'base'

module LintTrap
  module Linter
    # Encapsulates logic specific to cppcheck command line tool.
    class CPPCheck < Base
      def version
        '1.67-1'
      end

    private

      def flags(_container, _options)
        [
          '--enable=all',
          '--error-exitcode=1',
          '--template="{file}:{line}:::{id}:{severity}:{message}"'
        ]
      end
    end
  end
end
