require 'forwardable'
require_relative 'registry'

module LintTrap
  # Provide a registry DSL
  module Registerable
    extend Forwardable

    def_delegator :registry, :register
    def_delegator :registry, :default
    def_delegator :registry, :find
    def_delegator :registry, :all

  protected

    def registry
      @registry ||= Registry.new
    end
  end
end
