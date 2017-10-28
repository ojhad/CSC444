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
#
# Indexes
#
#  index_reviews_on_user_id  (user_id)
#

require 'test_helper'

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
end
