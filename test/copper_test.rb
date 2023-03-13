require "test_helper"

class CopperTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Copper::VERSION
  end
end
