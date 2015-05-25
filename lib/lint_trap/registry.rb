module LintTrap
  # Allow registration and discovery of plugins
  class Registry
    def initialize
      @registry = {}
    end

    def default(thing_class)
      @registry.default = thing_class.new
    end

    def register(thing_class)
      thing = thing_class.new
      registry[thing.name] = thing
    end

    def find(name)
      registry[name]
    end

    def all
      registry.values
    end

  protected

    attr_reader :registry
  end
end
