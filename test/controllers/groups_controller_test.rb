require 'test_helper'

class GroupsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get groups_new_url
    assert_response :success
  end

  test "should get show" do
    get groups_show_url
    assert_response :success
  end

  test "should get serch" do
    get groups_serch_url
    assert_response :success
  end

  test "should get score_label" do
    get groups_score_label_url
    assert_response :success
  end

  test "should get wrong_choice" do
    get groups_wrong_choice_url
    assert_response :success
  end

  test "should get edit" do
    get groups_edit_url
    assert_response :success
  end

  test "should get index" do
    get groups_index_url
    assert_response :success
  end

  test "should get correct_answer" do
    get groups_correct_answer_url
    assert_response :success
  end

  test "should get answering" do
    get groups_answering_url
    assert_response :success
  end

end
