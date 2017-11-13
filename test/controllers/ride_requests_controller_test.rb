require 'test_helper'

class RideRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ride_request = ride_requests(:one)
  end

  test "should get index" do
    get ride_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_ride_request_url
    assert_response :success
  end

  test "should create ride_request" do
    assert_difference('RideRequest.count') do
      post ride_requests_url, params: { ride_request: { completed: @ride_request.completed, dropoff_address: @ride_request.dropoff_address, pickup_address: @ride_request.pickup_address, requester_name: @ride_request.requester_name, riders: @ride_request.riders, shuttle_id: @ride_request.shuttle_id } }
    end

    assert_redirected_to ride_request_url(RideRequest.last)
  end

  test "should show ride_request" do
    get ride_request_url(@ride_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_ride_request_url(@ride_request)
    assert_response :success
  end

  test "should update ride_request" do
    patch ride_request_url(@ride_request), params: { ride_request: { completed: @ride_request.completed, dropoff_address: @ride_request.dropoff_address, pickup_address: @ride_request.pickup_address, requester_name: @ride_request.requester_name, riders: @ride_request.riders, shuttle_id: @ride_request.shuttle_id } }
    assert_redirected_to ride_request_url(@ride_request)
  end

  test "should destroy ride_request" do
    assert_difference('RideRequest.count', -1) do
      delete ride_request_url(@ride_request)
    end

    assert_redirected_to ride_requests_url
  end
end
