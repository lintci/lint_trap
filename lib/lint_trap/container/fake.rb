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
        File.join(LOCAL_CONFIG_PATH, path)
      end
    end
  end
end
