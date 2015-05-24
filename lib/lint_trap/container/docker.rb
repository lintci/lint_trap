require_relative 'base'
require 'pathname'
require 'open3'

module LintTrap
  module Container
    # Acts like a container, without actually requiring a container.
    class Docker < Base
      CONFIG_PATH = Pathname.new('/config')
      CODE_PATH = Pathname.new('/src')

      def pull
        command = "docker pull #{image}"
        Open3.popen2e(command) do |_, stdout, thread|
          if thread.value.success?
            true
          else
            raise ImagePullError.new(command, stdout.read)
          end
        end
      end

      def wrap(command)
        "docker run #{flags} #{image} #{command}"
      end

      def config_path(path)
        CONFIG_PATH.join(path).to_s
      end

      def local_path(path)
        relative_path = Pathname.new(path).relative_path_from(CODE_PATH)

        repo_path.join(relative_path).to_s
      end

      def container_path(path)
        relative_path = Pathname.new(path).relative_path_from(repo_path)

        CODE_PATH.join(relative_path).to_s
      end

    private

      def flags
        [
          # '-m', '50m', # memory
          # '-c', '1', # number of cpus
          '--net="none"',
          '--privileged=false',
          '-v', "#{LOCAL_CONFIG_PATH}:#{CONFIG_PATH}",
          '-v', "#{repo_path}:#{CODE_PATH}",
          "--workdir=#{CODE_PATH}",
          '--user=lint_trap'
        ].join(' ')
      end
    end
  end
end
