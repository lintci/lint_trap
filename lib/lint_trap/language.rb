require 'linguist'

require_relative 'registerable'
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
  # Language registry
  module Language
    extend Registerable

    class << self
      def detect(file)
        language = Linguist::FileBlob.new(file).language

        find(language && language.name)
      end
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
    default Unknown
  end
end
