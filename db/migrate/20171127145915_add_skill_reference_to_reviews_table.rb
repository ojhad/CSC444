class AddSkillReferenceToReviewsTable < ActiveRecord::Migration[5.1]
  def change
    add_reference :reviews, :skill, foreign_key: true
  end
end
