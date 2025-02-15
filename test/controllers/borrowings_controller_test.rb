require "test_helper"

class BorrowingsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @borrowing = borrowings(:one)
    login_as(@user)
  end

  test "should create borrowing" do
    post borrowings_url, params: { borrowing: { book_id: books(:one).id } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test "should update borrowing to returned" do
    patch return_borrowing_url(@borrowing), params: { borrowing: { returned: true } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end
end
