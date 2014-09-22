# Simplifies referencing fixture files
module FixtureFileHelper
  FIXTURE_PATH = File.expand_path('../../fixtures', __FILE__)

  def fixture_path(path)
    File.join(FIXTURE_PATH, path)
  end
end
