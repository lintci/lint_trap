$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
  add_filter '/config/'

  add_group 'Containers', 'lib/lint_trap/container'
  add_group 'Languages', 'lib/lint_trap/language'
  add_group 'Linters', 'lib/lint_trap/linter'
  add_group 'Parser', 'lib/lint_trap/parser'

  coverage_dir ENV['CIRCLE_ARTIFACTS'] if ENV['CIRCLE_ARTIFACTS']
end

require 'rspec/its'
require 'lint_trap'
require 'pry'
require_relative 'support/fixture_file_helper'
require_relative 'support/dockerfile'
require_relative 'support/examples/language'
require_relative 'support/examples/linter'

ENV['DEBUG_LINTING'] = ENV['CI']

RSpec.configure do |config|
  config.include FixtureFileHelper
end
