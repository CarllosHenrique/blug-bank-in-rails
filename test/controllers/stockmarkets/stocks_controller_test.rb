require "test_helper"

class Stockmarkets::StocksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get stockmarkets_stocks_index_url
    assert_response :success
  end
end
