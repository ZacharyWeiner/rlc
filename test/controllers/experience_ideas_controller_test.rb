require 'test_helper'

class ExperienceIdeasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @experience_idea = experience_ideas(:one)
  end

  test "should get index" do
    get experience_ideas_url
    assert_response :success
  end

  test "should get new" do
    get new_experience_idea_url
    assert_response :success
  end

  test "should create experience_idea" do
    assert_difference('ExperienceIdea.count') do
      post experience_ideas_url, params: { experience_idea: { capacity: @experience_idea.capacity, category_id: @experience_idea.category_id, description: @experience_idea.description, duration: @experience_idea.duration, title: @experience_idea.title } }
    end

    assert_redirected_to experience_idea_url(ExperienceIdea.last)
  end

  test "should show experience_idea" do
    get experience_idea_url(@experience_idea)
    assert_response :success
  end

  test "should get edit" do
    get edit_experience_idea_url(@experience_idea)
    assert_response :success
  end

  test "should update experience_idea" do
    patch experience_idea_url(@experience_idea), params: { experience_idea: { capacity: @experience_idea.capacity, category_id: @experience_idea.category_id, description: @experience_idea.description, duration: @experience_idea.duration, title: @experience_idea.title } }
    assert_redirected_to experience_idea_url(@experience_idea)
  end

  test "should destroy experience_idea" do
    assert_difference('ExperienceIdea.count', -1) do
      delete experience_idea_url(@experience_idea)
    end

    assert_redirected_to experience_ideas_url
  end
end
