require 'test_helper'

class ShuttlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shuttle = shuttles(:one)
  end

  test "should get index" do
    get shuttles_url
    assert_response :success
  end

  test "should get new" do
    get new_shuttle_url
    assert_response :success
  end

  test "should create shuttle" do
    assert_difference('Shuttle.count') do
      post shuttles_url, params: { shuttle: { address: @shuttle.address, current_lat: @shuttle.current_lat, current_long: @shuttle.current_long, name: @shuttle.name, previous_lat: @shuttle.previous_lat, previous_long: @shuttle.previous_long } }
    end

    assert_redirected_to shuttle_url(Shuttle.last)
  end

  test "should show shuttle" do
    get shuttle_url(@shuttle)
    assert_response :success
  end

  test "should get edit" do
    get edit_shuttle_url(@shuttle)
    assert_response :success
  end

  test "should update shuttle" do
    patch shuttle_url(@shuttle), params: { shuttle: { address: @shuttle.address, current_lat: @shuttle.current_lat, current_long: @shuttle.current_long, name: @shuttle.name, previous_lat: @shuttle.previous_lat, previous_long: @shuttle.previous_long } }
    assert_redirected_to shuttle_url(@shuttle)
  end

  test "should destroy shuttle" do
    assert_difference('Shuttle.count', -1) do
      delete shuttle_url(@shuttle)
    end

    assert_redirected_to shuttles_url
  end
end
