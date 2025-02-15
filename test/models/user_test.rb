require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = User.new(
      email_address: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
  end

  ### Validation Tests ###
  
  test "should be valid with valid attributes" do
    assert @user.valid?
  end

  test "should not be valid without email" do
    @user.email_address = nil
    assert_not @user.valid?
    assert_includes @user.errors[:email_address], "can't be blank"
  end

  test "should not be valid with invalid email format" do
    @user.email_address = "invalid_email"
    assert_not @user.valid?
    assert_includes @user.errors[:email_address], "must be a valid email address"
  end

  test "should not allow duplicate emails" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
    assert_includes duplicate_user.errors[:email_address], "is already registered"
  end

  test "should normalize email address" do
    @user.email_address = " Test@EXAMPLE.com "
    @user.save
    assert_equal "test@example.com", @user.email_address
  end

  ### Password Tests ###

  test "should not be valid without password" do
    @user.password = nil
    assert_not @user.valid?
    assert_includes @user.errors[:password], "can't be blank"
  end

  test "should not be valid with short password" do
    @user.password = "12345"
    @user.password_confirmation = "12345"
    assert_not @user.valid?
    assert_includes @user.errors[:password], "must be at least 6 characters"
  end

  test "should not be valid with mismatched password confirmation" do
    @user.password_confirmation = "different123"
    assert_not @user.valid?
    assert_includes @user.errors[:password_confirmation], "doesn't match password"
  end

  ### Association Tests ###

  test "should destroy associated sessions when user is destroyed" do
    user = users(:one)
    user.sessions.create!
    assert_difference('Session.count', -1) do
      user.destroy
    end
  end
end
