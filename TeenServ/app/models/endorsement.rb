class Endorsement < ApplicationRecord
  belongs_to :user

  def author
    User.find_by_id(self.author_id)
  end
end

# == Schema Information
#
# Table name: endorsements
#
#  id         :integer          not null, primary key
#  body       :text
#  author_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_endorsements_on_user_id  (user_id)
#
