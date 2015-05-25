require 'pathname'
require_relative '../execution_error'

module LintTrap
  module Container
    # Interface for a container
    class Base
      ImagePullError = Class.new(ExecutionError)

      LOCAL_CONFIG_PATH = Pathname.new(File.expand_path('../../../../config', __FILE__))

      attr_reader :image

      def initialize(image, repo_path, options = {})
        @image = image
        @repo_path = Pathname.new(repo_path)
        @options = default_options.merge(options)
      end

      def pull
        raise NotImplementedError, 'Must implement pull.'
      end

      def wrap(_command)
        raise NotImplementedError, 'Must implement wrap.'
      end

      def config_path(_path)
        raise NotImplementedError, 'Must implement config_path.'
      end

      def file_path(_path)
        raise NotImplementedError, 'Must implement file_path.'
      end

    protected

      attr_reader :repo_path, :options

    private

      def default_options
        {}
      end
    end
  end
end
