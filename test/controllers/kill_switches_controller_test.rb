require 'test_helper'

class KillSwitchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @kill_switch = kill_switches(:one)
  end

  test "should get index" do
    get kill_switches_url
    assert_response :success
  end

  test "should get new" do
    get new_kill_switch_url
    assert_response :success
  end

  test "should create kill_switch" do
    assert_difference('KillSwitch.count') do
      post kill_switches_url, params: { kill_switch: { is_active: @kill_switch.is_active } }
    end

    assert_redirected_to kill_switch_url(KillSwitch.last)
  end

  test "should show kill_switch" do
    get kill_switch_url(@kill_switch)
    assert_response :success
  end

  test "should get edit" do
    get edit_kill_switch_url(@kill_switch)
    assert_response :success
  end

  test "should update kill_switch" do
    patch kill_switch_url(@kill_switch), params: { kill_switch: { is_active: @kill_switch.is_active } }
    assert_redirected_to kill_switch_url(@kill_switch)
  end

  test "should destroy kill_switch" do
    assert_difference('KillSwitch.count', -1) do
      delete kill_switch_url(@kill_switch)
    end

    assert_redirected_to kill_switches_url
  end
end
