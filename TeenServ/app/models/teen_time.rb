class TeenTime < ApplicationRecord
  belongs_to :user
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
