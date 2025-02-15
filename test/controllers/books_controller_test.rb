require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book = books(:one)
    @user = users(:one)
    login_as(@user) # Log in before tests
  end

  test "should get index" do
    get books_url
    assert_response :success
    assert_not_nil assigns(:available_books)
    assert_not_nil assigns(:borrowed_books)
  end

  test "should get index with search query" do
    get books_url, params: { query: @book.title }
    assert_response :success
    assert_not_nil assigns(:books)
    assert_not_nil assigns(:search_query)
    assert_not_nil assigns(:available_books)
    assert_not_nil assigns(:borrowed_books)
  end

  test "should get show" do
    get book_url(@book)
    assert_response :success
    assert_not_nil assigns(:book)
    assert_not_nil assigns(:borrowing)
  end
end
