require 'test_helper'

class HarvestTrellosControllerTest < ActionController::TestCase
  setup do
    @harvest_trello = harvest_trellos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:harvest_trellos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create harvest_trello" do
    assert_difference('HarvestTrello.count') do
      post :create, harvest_trello: { harvest_name: @harvest_trello.harvest_name, trello_project_id: @harvest_trello.trello_project_id }
    end

    assert_redirected_to harvest_trello_path(assigns(:harvest_trello))
  end

  test "should show harvest_trello" do
    get :show, id: @harvest_trello
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @harvest_trello
    assert_response :success
  end

  test "should update harvest_trello" do
    put :update, id: @harvest_trello, harvest_trello: { harvest_name: @harvest_trello.harvest_name, trello_project_id: @harvest_trello.trello_project_id }
    assert_redirected_to harvest_trello_path(assigns(:harvest_trello))
  end

  test "should destroy harvest_trello" do
    assert_difference('HarvestTrello.count', -1) do
      delete :destroy, id: @harvest_trello
    end

    assert_redirected_to harvest_trellos_path
  end
end
