require_relative 'base'
require 'pathname'

module LintTrap
  module Container
    # Acts like a container, without actually requiring a container.
    class Docker < Base
      CONFIG_PATH = Pathname.new('/opt/lint_trap/config')
      CODE_PATH = Pathname.new('/home/spin_cycle')

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
          '--privileged=false',
          '-v', "#{LOCAL_CONFIG_PATH}:#{CONFIG_PATH}",
          '-v', "#{repo_path}:#{CODE_PATH}",
          "--workdir=#{CODE_PATH}",
          '--user=spin_cycle'
        ].join(' ')
      end
    end
  end
end
