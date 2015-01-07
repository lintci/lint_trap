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
    @linters = {}

    class << self
      def register(linter)
        linters[linter.canonical_name] = linter
      end

      def find(name)
        linters[name]
      end

    protected

      attr_reader :linters
    end

    register CheckStyle
    register CoffeeLint
    register CPPCheck
    register CSSLint
    register GoLint
    register JSHint
    register JSONLint
    register PyLint
    register RuboCop
    register SCSSLint
  end
end
