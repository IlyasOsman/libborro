class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :book
  attribute :returned, :boolean, default: false

  # Define the scope once
  scope :active, -> { where("returned = ? OR returned IS NULL", false) }
  scope :overdue, -> { active.where("due_date < ?", Time.current) }

  # Define the validations
  validates :book_id, uniqueness: {
    scope: :returned,
    message: "is already borrowed",
    conditions: -> { where(returned: false) }
  }

  before_create :set_due_date

  def overdue?
    !returned && due_date < Time.current
  end

  private

  def set_due_date
    self.due_date = 2.weeks.from_now
  end
end
