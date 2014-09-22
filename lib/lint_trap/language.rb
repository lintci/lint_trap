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

module LintTrap
  # Language lookup
  module Language
    class << self
      def find(name)
        classes = constants.map{|const| const_get(const)}

        classes.find{|language| language.name == name}
      end
    end
  end
end
