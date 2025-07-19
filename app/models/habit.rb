class Habit < ApplicationRecord
  belongs_to :user
  has_many :habit_checkins, dependent: :destroy
  validates :name, presence: true, uniqueness: { scope: :user_id }

  def done_days
    habit_checkins.pluck(:date)
  end

  def current_streak
    streak = 0
    day = Date.today
    while done_days.include?(day)
      streak += 1
      day -= 1
    end
    streak
  end

  def longest_streak
    sorted_days = done_days.sort
    longest = 0
    current = 0
    prev_day = nil

    sorted_days.each do |day|
      if prev_day && day == prev_day + 1
        current += 1
      else
        current = 1
      end
      longest = [ longest, current ].max
      prev_day = day
    end
    longest
  end

  def consistency_percentage
    total_days = (Date.today - created_at.to_date).to_i + 1
    return 0 if total_days.zero?
    ((done_days.count.to_f / total_days) * 100).round(2)
  end
end
