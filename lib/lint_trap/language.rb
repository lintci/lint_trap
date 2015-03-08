require 'linguist'

require_relative 'language/coffeescript'
require_relative 'language/cpp'
require_relative 'language/css'
require_relative 'language/go'
require_relative 'language/java'
require_relative 'language/javascript'
require_relative 'language/json'
require_relative 'language/python'
require_relative 'language/ruby'
require_relative 'language/scss'
require_relative 'language/unknown'

module LintTrap
  # Language lookup
  module Language
    @languages = {}

    class << self
      def register(language_class)
        language = language_class.new
        languages[language.name] = language
      end

      def detect(file)
        if (language = Linguist::FileBlob.new(file).language)
          find(language.name)
        else
          Unknown.new
        end
      end

      def find(name)
        languages[name] || Unknown.new(name)
      end

    protected

      attr_reader :languages
    end

    register CoffeeScript
    register CPP
    register CSS
    register Go
    register Java
    register JavaScript
    register JSON
    register Python
    register Ruby
    register SCSS
  end
end
