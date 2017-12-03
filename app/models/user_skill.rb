class UserSkill < ApplicationRecord

    def calculate_avg_review(user_id)
      user = User.find_by_id(user_id)
      reviews = user.reviews.where(:skill_id => self.skill_id)
      reviews.map(&:rating).instance_eval { reduce(:+) / size.to_f } if reviews.any?
    end
end

# == Schema Information
#
# Table name: user_skills
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  skill_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_user_skills_on_skill_id  (skill_id)
#  index_user_skills_on_user_id   (user_id)
#
