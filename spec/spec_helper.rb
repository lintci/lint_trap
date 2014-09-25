$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rspec/its'
require 'lint_trap'
require_relative 'support/fixture_file_helper'

RSpec.configure do |config|
  config.include FixtureFileHelper
end
