require 'English'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require_relative 'lib/lint_trap'

$stdout.sync = true

RSpec::Core::RakeTask.new(:spec)

task default: :spec

task :credentials do
  require 'fileutils'

  credentials = "---\n:rubygems_api_key: #{ENV['RUBYGEMS_API_KEY']}\n"
  credentials_path = File.expand_path('~') + '/.gem/credentials'

  FileUtils.mkdir_p('~/.gem')
  File.write(credentials_path, credentials)
  FileUtils.chmod(0600, credentials_path)
end

namespace :docker do
  class Docker
    DOCKER_CACHE_PATH = File.expand_path('~/.docker')
    DOCKER_IMAGE_PATH = File.join(DOCKER_CACHE_PATH, 'image.tar')

    BuildError = Class.new(StandardError)

    attr_reader :linter

    def initialize(linter)
      @linter = linter
    end

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
      run("docker build -t #{image_sha} ./docker/#{linter.name.downcase}")
    end

    def push
      run("docker login -e #{ENV['DOCKER_EMAIL']} -u #{ENV['DOCKER_USER']} -p #{ENV['DOCKER_PASSWORD']}", true)
      run("docker push #{image_sha}")
      run("docker push #{image_version}")
      run("docker push #{image_latest}")
    end

  private

    def run(command, suppress = false)
      puts
      puts command unless suppress
      system(command)

      raise BuildError, 'There was a problem executing the command.' unless $CHILD_STATUS == 0
    end

    def image_sha
      "#{linter.image}:#{sha}"
    end

    def image_version
      linter.image_version
    end

    def image_latest
      "#{linter.image}:latest"
    end

    def sha
      sha = ENV['CIRCLE_SHA1'] ? ENV['CIRCLE_SHA1'] : `git rev-parse HEAD`.strip
    end
  end

  def for_each_linter(method)
    LintTrap::Linter.all.each do |linter|
      puts '', '#' * 80, linter.name, '#' * 80
      Docker.new(linter).send(method)
    end
  end

  task(:tag){for_each_linter(:tag)}
  task(:pull){for_each_linter(:pull)}
  task(:load){for_each_linter(:load)}
  task(:dump){for_each_linter(:dump)}
  task(:build){for_each_linter(:build)}
  task(:push){for_each_linter(:push)}
end
