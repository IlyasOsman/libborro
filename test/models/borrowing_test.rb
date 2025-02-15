require "test_helper"

class BorrowingTest < ActiveSupport::TestCase
  test "active scope should return only active borrowings" do
    assert_includes Borrowing.active, borrowings(:one)
    assert_not_includes Borrowing.active, borrowings(:two) if borrowings(:two).returned
  end

  test "overdue scope should return only overdue borrowings" do
    borrowings(:one).update!(due_date: 2.days.ago)
    assert_includes Borrowing.overdue, borrowings(:one)
  end

  test "should not allow duplicate active borrowings for the same book" do
    borrowing = Borrowing.new(user: users(:one), book: books(:one), returned: false)
    assert_not borrowing.valid?, "Duplicate active borrowing should be invalid"
  end

  test "set_due_date should assign a due date before creation" do
    borrowing = Borrowing.new(user: users(:one), book: books(:available))
    borrowing.save!
    assert_not_nil borrowing.due_date, "Due date should be set automatically"
  end


  test "overdue? should return true for overdue borrowings" do
    borrowings(:one).update!(due_date: 1.day.ago, returned: false)
    assert borrowings(:one).overdue?, "Borrowing should be overdue"
  end
end
