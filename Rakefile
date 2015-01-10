require "bundler/gem_tasks"
require "rspec/core/rake_task"

$stdout.sync = true

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :credentials do
  require 'fileutils'

  credentials = "---\n:rubygems_api_key: #{ENV['RUBYGEMS_API_KEY']}\n"
  credentials_path = File.expand_path('~') + '/.gem/credentials'

  FileUtils.mkdir_p('~/.gem')
  File.write(credentials_path, credentials)
  FileUtils.chmod(0600, credentials_path)
end

namespace :docker do
  BuildError = Class.new(StandardError)
  DOCKER_CACHE_PATH = File.expand_path('~/.docker')
  DOCKER_IMAGE_PATH = File.join(DOCKER_CACHE_PATH, 'image.tar')

  def run(command)
    system(command)

    raise BuildError, 'There was a problem executing the command.' unless $?.zero?
  end

  def sha
    ENV['CIRCLE_SHA1'] ? ENV['CIRCLE_SHA1'] : ENV['SHA']
  end

  task :tag do
    require_relative 'lib/lint_trap/version'

    run("docker tag -f lintci/spin_cycle:#{sha} lintci/spin_cycle:latest")
    run("docker tag -f lintci/spin_cycle:#{sha} lintci/spin_cycle:#{LintTrap::VERSION}")
  end

  task :pull do
    run("docker pull lintci/spin_cycle:latest")
  end

  task :load do
    if File.exist?(DOCKER_IMAGE_PATH)
      run("docker load -i #{DOCKER_IMAGE_PATH}")
    end
  end

  task :dump do
    require 'fileutils'
    FileUtils.mkdir_p(DOCKER_CACHE_PATH)
    run("docker save lintci/spin_cycle > #{DOCKER_IMAGE_PATH}")
  end

  task :build do
    run("docker build -t lintci/spin_cycle:#{sha} .")
  end

  task :push do
    run("docker login -e #{ENV['DOCKER_EMAIL']} -u #{ENV['DOCKER_USER']} -p #{ENV['DOCKER_PASSWORD']}")
    run("docker push lintci/spin_cycle:#{sha}")
    run("docker push lintci/spin_cycle:#{LintTrap::VERSION}")
    run("docker push lintci/spin_cycle:latest")
  end
end
