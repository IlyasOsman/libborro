require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @new_user_params = {
      user: {
        email_address: "newuser@example.com",
        password: "password123",
        password_confirmation: "password123"
      }
    }
  end

  test "should get new registration page" do
    get new_registration_path
    assert_response :success
  end

  test "should create new user with valid params" do
    assert_difference('User.count') do
      post registration_path, params: @new_user_params
    end
    assert_redirected_to root_path
    assert_equal "Welcome! Your account has been created successfully.", flash[:notice]
  end

  test "should not create user with invalid email" do
    @new_user_params[:user][:email_address] = "invalid_email"
    assert_no_difference('User.count') do
      post registration_path, params: @new_user_params
    end
    assert_response :unprocessable_entity
    assert_equal "Please correct the errors below.", flash[:alert]
  end

  test "should not create user with existing email" do
    existing_user = users(:one)
    @new_user_params[:user][:email_address] = existing_user.email_address
    assert_no_difference('User.count') do
      post registration_path, params: @new_user_params
    end
    assert_response :unprocessable_entity
    assert_equal "This email address is already registered. Please sign in or use a different email.", flash[:alert]
  end

  test "should not create user with mismatched passwords" do
    @new_user_params[:user][:password_confirmation] = "different123"
    assert_no_difference('User.count') do
      post registration_path, params: @new_user_params
    end
    assert_response :unprocessable_entity
  end
end
