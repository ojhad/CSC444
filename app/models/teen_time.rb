class TeenTime < ApplicationRecord
  belongs_to :user

  validates_presence_of :user_id, :day, :start_time, :end_time
  validate :validateTimings

  def validateTimings
    if self.start_time && self.end_time && self.start_time > self.end_time
      errors[:base] << "Start Time must be before End Time"
    end
  end
end

# == Schema Information
#
# Table name: teen_times
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  day        :string
#  start_time :time
#  end_time   :time
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
