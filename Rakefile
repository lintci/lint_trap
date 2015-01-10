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
  module Docker
    DOCKER_CACHE_PATH = File.expand_path('~/.docker')
    DOCKER_IMAGE_PATH = File.join(DOCKER_CACHE_PATH, 'image.tar')
    IMAGE_NAME = 'lintci/spin_cycle'

    BuildError = Class.new(StandardError)


    def tag
      run("docker tag -f #{image_sha} #{image_latest}")
      run("docker tag -f #{image_sha} #{image_version}")
    end

    def pull
      run("docker pull #{image_latest}")
    end

    def load
      if File.exist?(DOCKER_IMAGE_PATH)
        run("docker load -i #{DOCKER_IMAGE_PATH}")
      else
        pull
      end
    end

    def dump
      require 'fileutils'

      FileUtils.mkdir_p(DOCKER_CACHE_PATH)
      run("docker save #{image_latest} > #{DOCKER_IMAGE_PATH}")
    end

    def build
      run("docker build -t #{image_sha} .")
    end

    def push
      run("docker login -e #{ENV['DOCKER_EMAIL']} -u #{ENV['DOCKER_USER']} -p #{ENV['DOCKER_PASSWORD']}")
      run("docker push #{image_sha}")
      run("docker push #{image_version}")
      run("docker push #{image_latest}")
    end

  private

    def run(command)
      system(command)

      raise BuildError, 'There was a problem executing the command.' unless $?.zero?
    end

    def image_sha
      "#{IMAGE_NAME}:#{sha}"
    end

    def image_version
      require_relative 'lib/lint_trap/version'

      "#{IMAGE_NAME}:#{LintTrap::VERSION}"
    end

    def image_latest
      "#{IMAGE_NAME}:latest"
    end

    def sha
      sha = ENV['CIRCLE_SHA1'] ? ENV['CIRCLE_SHA1'] : `git rev-parse HEAD`.strip
    end
  end

  include Docker

  task(:tag){tag}
  task(:pull){pull}
  task(:load){load}
  task(:dump){dump}
  task(:build){build}
  task(:push){push}
end
