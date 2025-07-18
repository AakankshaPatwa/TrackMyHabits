class HabitCheckin < ApplicationRecord
  belongs_to :habit
  validates :date, presence: true, uniqueness: { scope: :habit_id }
end
