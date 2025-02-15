class Book < ApplicationRecord
    has_many :borrowings, dependent: :destroy
    has_many :users, through: :borrowings

    validates :title, presence: true, length: { minimum: 2, maximum: 255 }
    validates :author, presence: true, length: { minimum: 2, maximum: 255 }
    validates :isbn, presence: true,
                    uniqueness: true,
                    format: { with: /\A[\d-]{10,17}\z/, message: "must be a valid ISBN format" }

    scope :available, -> { where.not(id: Borrowing.active.select(:book_id)) }
    scope :borrowed, -> { where(id: Borrowing.active.select(:book_id)) }

    def available?
      borrowings.active.empty?
    end

    def current_borrowing
      borrowings.active.first
    end
end
