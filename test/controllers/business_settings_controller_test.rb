require 'test_helper'

class BusinessSettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @business_setting = business_settings(:one)
  end

  test "should get index" do
    get business_settings_url
    assert_response :success
  end

  test "should get new" do
    get new_business_setting_url
    assert_response :success
  end

  test "should create business_setting" do
    assert_difference('BusinessSetting.count') do
      post business_settings_url, params: { business_setting: { ride_request_active: @business_setting.ride_request_active, title: @business_setting.title } }
    end

    assert_redirected_to business_setting_url(BusinessSetting.last)
  end

  test "should show business_setting" do
    get business_setting_url(@business_setting)
    assert_response :success
  end

  test "should get edit" do
    get edit_business_setting_url(@business_setting)
    assert_response :success
  end

  test "should update business_setting" do
    patch business_setting_url(@business_setting), params: { business_setting: { ride_request_active: @business_setting.ride_request_active, title: @business_setting.title } }
    assert_redirected_to business_setting_url(@business_setting)
  end

  test "should destroy business_setting" do
    assert_difference('BusinessSetting.count', -1) do
      delete business_setting_url(@business_setting)
    end

    assert_redirected_to business_settings_url
  end
end
