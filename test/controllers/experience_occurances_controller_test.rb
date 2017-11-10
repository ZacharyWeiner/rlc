require 'test_helper'

class ExperienceOccurancesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @experience_occurance = experience_occurances(:one)
  end

  test "should get index" do
    get experience_occurances_url
    assert_response :success
  end

  test "should get new" do
    get new_experience_occurance_url
    assert_response :success
  end

  test "should create experience_occurance" do
    assert_difference('ExperienceOccurance.count') do
      post experience_occurances_url, params: { experience_occurance: { capacity: @experience_occurance.capacity, date: @experience_occurance.date, experience_id: @experience_occurance.experience_id } }
    end

    assert_redirected_to experience_occurance_url(ExperienceOccurance.last)
  end

  test "should show experience_occurance" do
    get experience_occurance_url(@experience_occurance)
    assert_response :success
  end

  test "should get edit" do
    get edit_experience_occurance_url(@experience_occurance)
    assert_response :success
  end

  test "should update experience_occurance" do
    patch experience_occurance_url(@experience_occurance), params: { experience_occurance: { capacity: @experience_occurance.capacity, date: @experience_occurance.date, experience_id: @experience_occurance.experience_id } }
    assert_redirected_to experience_occurance_url(@experience_occurance)
  end

  test "should destroy experience_occurance" do
    assert_difference('ExperienceOccurance.count', -1) do
      delete experience_occurance_url(@experience_occurance)
    end

    assert_redirected_to experience_occurances_url
  end
end
