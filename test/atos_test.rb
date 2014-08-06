require 'test_helper'

class AtosTest < ActiveSupport::TestCase
  def setup
    @atos = Atos.new
  end

  test "request: wrong arguments" do
    assert_raise RuntimeError do
      @atos.request({})
    end
  end

  test "Paths should be valids" do
    raise @atos.request_path.inspect
  end

end
