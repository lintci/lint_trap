require_relative 'base'

module LintTrap
  module Linter
    # Encapsulates logic specific to cppcheck command line tool.
    class CPPCheck < Base
    private

      def flags
        [
          '--enable=all',
          '--error-exitcode=1',
          '--template="{file}:{line}:::{id}:{severity}:{message}"'
        ]
      end
    end
  end
end