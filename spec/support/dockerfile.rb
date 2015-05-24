# Wraps a dockerfile to allow it to be easily tested
class Dockerfile
  attr_reader :path

  def initialize(name)
    @path = Pathname.new(File.expand_path("../../../docker/#{name.downcase}/Dockerfile", __FILE__))
  end

  def include_env?(name, value)
    path.read =~ /ENV #{name} (#{value}|"#{value}")/
  end
end
