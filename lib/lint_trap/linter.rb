require_relative 'registerable'
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
require_relative 'linter/unknown'

module LintTrap
  # Linter registry
  module Linter
    extend Registerable

    class << self
      def register(linter_class, languages:, parser: nil)
        linter = super(linter_class)

        Array(languages).each do |language|
          linter.add_language(Language.find(language))
        end

        linter.parser = Parser.find(parser)
      end
    end

    register CheckStyle, languages: 'Java'
    register CoffeeLint, languages: 'CoffeeScript'
    register CPPCheck, languages: 'C++'
    register CSSLint, languages: 'CSS', parser: 'CSSLint'
    register GoLint, languages: 'Go', parser: 'VimQuickfix'
    register JSHint, languages: 'JavaScript'
    register JSONLint, languages: 'JSON'
    register PyLint, languages: 'Python'
    register RuboCop, languages: 'Ruby'
    register SCSSLint, languages: 'SCSS'
    default Unknown
  end
end
