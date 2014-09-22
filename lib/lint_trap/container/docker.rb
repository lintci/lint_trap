require_relative 'base'

module LintTrap
  module Container
    # Acts like a container, without actually requiring a container.
    class Docker < Base
      CONFIG_PATH = '/opt/lint_trap/config'
      CODE_PATH = '/home/code'

      def wrap(command)
        "docker run #{flags} #{image} #{command}"
      end

      def config_path(path)
        File.join(CONFIG_PATH, path)
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
          '--user=linter'
        ].join(' ')
      end
    end
  end
end
