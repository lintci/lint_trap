require 'pathname'

module LintTrap
  module Container
    class Base
      LOCAL_CONFIG_PATH = Pathname.new(File.expand_path('../../../../config', __FILE__))

      def initialize(image, repo_path)
        @image = image
        @repo_path = Pathname.new(repo_path)
      end

      def wrap(_command)
        raise NotImplementedError
      end

      def config_path(_path)
        raise NotImplementedError
      end

      def file_path(_path)
        raise NotImplementedError
      end

    protected

      attr_reader :image, :repo_path
    end
  end
end
