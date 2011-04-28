require 'test_helper'

class ApartmentsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:apartments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create apartment" do
    assert_difference('Apartment.count') do
      post :create, :apartment => { }
    end

    assert_redirected_to apartment_path(assigns(:apartment))
  end

  test "should show apartment" do
    get :show, :id => apartments(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => apartments(:one).to_param
    assert_response :success
  end

  test "should update apartment" do
    put :update, :id => apartments(:one).to_param, :apartment => { }
    assert_redirected_to apartment_path(assigns(:apartment))
  end

  test "should destroy apartment" do
    assert_difference('Apartment.count', -1) do
      delete :destroy, :id => apartments(:one).to_param
    end

    assert_redirected_to apartments_path
  end
end
