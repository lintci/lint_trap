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
  DockerError = Class.new(StandardError)

  def fail_on_error
    return if $? == 0

    raise DockerError, 'There was a problem executing the command.'
  end

  def sha
    ENV['CIRCLE_SHA1'] ? ENV['CIRCLE_SHA1'] : ENV['SHA']
  end

  task :tag do
    require_relative 'lib/lint_trap/version'

    system("docker tag -f lintci/spin_cycle:#{sha} lintci/spin_cycle:latest") or fail_on_error
    system("docker tag -f lintci/spin_cycle:#{sha} lintci/spin_cycle:#{LintTrap::VERSION}") or fail_on_error
  end

  task :build do
    system("docker pull lintci/spin_cycle:latest") or fail_on_error
    system("docker build -t lintci/spin_cycle:#{sha} .") or fail_on_error
  end

  task :push do
    system("docker login -e #{ENV['DOCKER_EMAIL']} -u #{ENV['DOCKER_USER']} -p #{ENV['DOCKER_PASSWORD']}") or fail_on_error
    system("docker push lintci/spin_cycle:#{sha}") or fail_on_error
    system("docker push lintci/spin_cycle:#{LintTrap::VERSION}") or fail_on_error
    system("docker push lintci/spin_cycle:latest") or fail_on_error
  end
end
