require "test_helper"

class AutocopperTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Autocopper::VERSION
  end
end
