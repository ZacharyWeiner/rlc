require 'test_helper'

class ShuttleStopsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shuttle_stop = shuttle_stops(:one)
  end

  test "should get index" do
    get shuttle_stops_url
    assert_response :success
  end

  test "should get new" do
    get new_shuttle_stop_url
    assert_response :success
  end

  test "should create shuttle_stop" do
    assert_difference('ShuttleStop.count') do
      post shuttle_stops_url, params: { shuttle_stop: { address: @shuttle_stop.address, latitude: @shuttle_stop.latitude, longitude: @shuttle_stop.longitude, order: @shuttle_stop.order, person_count: @shuttle_stop.person_count, shuttle_id: @shuttle_stop.shuttle_id } }
    end

    assert_redirected_to shuttle_stop_url(ShuttleStop.last)
  end

  test "should show shuttle_stop" do
    get shuttle_stop_url(@shuttle_stop)
    assert_response :success
  end

  test "should get edit" do
    get edit_shuttle_stop_url(@shuttle_stop)
    assert_response :success
  end

  test "should update shuttle_stop" do
    patch shuttle_stop_url(@shuttle_stop), params: { shuttle_stop: { address: @shuttle_stop.address, latitude: @shuttle_stop.latitude, longitude: @shuttle_stop.longitude, order: @shuttle_stop.order, person_count: @shuttle_stop.person_count, shuttle_id: @shuttle_stop.shuttle_id } }
    assert_redirected_to shuttle_stop_url(@shuttle_stop)
  end

  test "should destroy shuttle_stop" do
    assert_difference('ShuttleStop.count', -1) do
      delete shuttle_stop_url(@shuttle_stop)
    end

    assert_redirected_to shuttle_stops_url
  end
end
