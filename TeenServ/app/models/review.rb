class Review < ApplicationRecord
  belongs_to :person
end

# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  rating     :integer
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  person_id  :integer
#
