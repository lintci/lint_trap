$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rspec/its'
require 'lint_trap'
require 'pry'
require_relative 'support/fixture_file_helper'
require_relative 'support/examples/language'
require_relative 'support/examples/linter'

ENV['DEBUG_LINTING'] = ENV['CI']

RSpec.configure do |config|
  config.include FixtureFileHelper
end
