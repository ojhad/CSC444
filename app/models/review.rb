class Review < ApplicationRecord
  belongs_to :user
  belongs_to :skill, required: false
  after_save :update_average

  def author
    User.find_by_id(self.author_id)
  end

  private
  def update_average
    @user = User.find(self.user_id)
    old_avg = @user.average_rating
    reviews_count = @user.reviews.count
    if reviews_count > 1
      new_avg = ((old_avg * (reviews_count - 1)) + self.rating) / reviews_count
      @user.update_attribute(:average_rating, new_avg)
    else
      @user.update_attribute(:average_rating, self.rating)
    end
  end
end

# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  rating     :float            default(5.0)
#  author_id  :integer
#  skill_id   :integer
#
# Indexes
#
#  index_reviews_on_skill_id  (skill_id)
#  index_reviews_on_user_id   (user_id)
#
