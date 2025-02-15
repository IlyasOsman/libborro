class BooksController < ApplicationController
    before_action :set_book, only: [ :show ]

    def index
      @books = Book.all.order(:title)

      if params[:query].present?
        @search_query = params[:query].strip
        # Search across all books
        @books = Book.where("title LIKE :query OR author LIKE :query OR isbn LIKE :query",
                           query: "%#{@search_query}%").order(:title)
        # Then split into available and borrowed
        @available_books = @books.available
        @borrowed_books = @books.borrowed.includes(borrowings: :user)
      else
        @available_books = Book.available
        @borrowed_books = Book.borrowed.includes(borrowings: :user)
      end
    end

    def show
      @borrowing = @book.current_borrowing
    end

    private

    def set_book
      @book = Book.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to books_path, alert: "Book not found"
    end
end
