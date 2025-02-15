require "test_helper"

class BookTest < ActiveSupport::TestCase
  setup do
    @book = Book.new(
      title: "Test Book",
      author: "Test Author",
      isbn: "978-0-13-134135-4"
    )
  end

  test "should be valid with valid attributes" do
    book = Book.new(title: "Valid Title", author: "Valid Author", isbn: "978-3-16-148410-0")
    assert book.valid?, "Book should be valid with proper attributes"
  end

  test "should not be valid without title" do
    @book.title = nil
    assert_not @book.valid?
    assert_includes @book.errors[:title], "can't be blank"
  end

  test "should not be valid with short title" do
    @book.title = "a"
    assert_not @book.valid?
  end

  test "should not be valid without author" do
    @book.author = nil
    assert_not @book.valid?
    assert_includes @book.errors[:author], "can't be blank"
  end

  test "should not be valid with short author name" do
    @book.author = "a"
    assert_not @book.valid?
  end

  test "should not be valid without isbn" do
    @book.isbn = nil
    assert_not @book.valid?
    assert_includes @book.errors[:isbn], "can't be blank"
  end

  test "should not be valid with invalid isbn format" do
    @book.isbn = "invalid-isbn"
    assert_not @book.valid?
    assert_includes @book.errors[:isbn], "must be a valid ISBN format"
  end

  test "should not allow duplicate isbn" do
    duplicate_book = @book.dup
    @book.save
    assert_not duplicate_book.valid?
    assert_includes duplicate_book.errors[:isbn], "has already been taken"
  end

  test "available? should return true when book has no active borrowings" do
    book = books(:available)
    assert book.available?
  end

  test "available? should return false when book has active borrowings" do
    book = books(:one)
    assert_not book.available?, "available? should be false for books with active borrowings"
  end

  test "current_borrowing should return active borrowing" do
    book = books(:one)
    borrowing = borrowings(:one)
    assert_equal borrowing, book.current_borrowing, "current_borrowing should return the active borrowing"
  end

  test "current_borrowing should return nil when no active borrowing" do
    book = books(:available)
    assert_nil book.current_borrowing
  end

  test "should destroy associated borrowings when book is destroyed" do
    book = books(:borrowed)
    assert_difference("Borrowing.count", -book.borrowings.count) do
      book.destroy
    end
  end
end
