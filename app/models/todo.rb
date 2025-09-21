class Todo < ApplicationRecord
  validates :title, presence: true, length: { minimum: 1, maximum: 100 }
  validates :description, length: { maximum: 500 }

  # Set default value for completed
  after_initialize :set_defaults, if: :new_record?

  # Scopes for filtering
  scope :completed, -> { where(completed: true) }
  scope :pending, -> { where(completed: false) }

  private

  def set_defaults
    self.completed ||= false
  end
end
