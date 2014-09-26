require_relative 'base'

module LintTrap
  module Container
    # Acts like a container, without actually requiring a container.
    class Fake < Base
      def initialize
        super('no/image', 'local')
      end

      def wrap(command)
        command
      end

      def config_path(path)
        LOCAL_CONFIG_PATH.join(path).to_s
      end

      def container_path(path)
        path
      end

      def local_path(path)
        path
      end
    end
  end
end
