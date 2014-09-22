require_relative 'container/fake'
require 'open3'

module LintTrap
  # Wraps the execution of linter commands
  class Command
    attr_reader :binary

    def initialize(binary, flags, files)
      @binary = binary
      @flags = flags
      @files = files
    end

    def run(container)
      Bundler.with_clean_env do
        Open3.popen3(command(container)) do |_, stdout, _, thread|
          yield stdout

          thread.join
        end
      end
    end

    def command(container = LintTrap::Container::Fake.new)
      container.wrap("#{binary} #{flags} #{files} 2>&1")
    end
    alias_method :to_s, :command

    def files
      Shellwords.join(@files)
    end

    def flags
      @flags.join(' ')
    end
  end
end
