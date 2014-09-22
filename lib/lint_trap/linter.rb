require_relative 'linter/checkstyle'
require_relative 'linter/coffeelint'
require_relative 'linter/cppcheck'
require_relative 'linter/csslint'
require_relative 'linter/golint'
require_relative 'linter/jshint'
require_relative 'linter/jsonlint'
require_relative 'linter/pylint'
require_relative 'linter/rubocop'
require_relative 'linter/scsslint'

module LintTrap
  # Linter lookup
  module Linter
    class << self
      def find(name)
        classes = constants.map do |const|
          const_get(const)
        end

        classes.find do |linter|
          linter.name.split('::').last == name
        end
      end
    end
  end
end
