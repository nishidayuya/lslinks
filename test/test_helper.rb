require "stringio"
require "test/unit"

require "lslinks"

class Lslinks::TestCase < Test::Unit::TestCase
  TEST_DATA_PATH = Pathname(__dir__) / "data"
end
