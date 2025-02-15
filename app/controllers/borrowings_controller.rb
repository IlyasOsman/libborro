class BorrowingsController < ApplicationController
    before_action :set_book, only: [ :create ]
    before_action :set_borrowing, only: [ :return ]

    def index
      @active_borrowings = Current.user.active_borrowings
      @overdue_borrowings = @active_borrowings.overdue
    end

    def create
      @borrowing = Current.user.borrowings.build(book: @book, returned: false)

      if @borrowing.save
        redirect_to @book, notice: "Book borrowed successfully!"
      else
        redirect_to @book, alert: @borrowing.errors.full_messages.to_sentence
      end
    end

    def return
      if @borrowing.update(returned: true)
        redirect_to borrowings_path, notice: "Book returned successfully!"
      else
        redirect_to borrowings_path, alert: "Unable to return book"
      end
    end

    private

    def set_book
      @book = Book.find(params[:book_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to books_path, alert: "Book not found"
    end

    def set_borrowing
      @borrowing = Current.user.borrowings.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to borrowings_path, alert: "Borrowing not found"
    end
end
