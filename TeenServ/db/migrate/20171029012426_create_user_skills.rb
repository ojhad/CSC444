class CreateUserSkills < ActiveRecord::Migration[5.1]
  def change
    create_table :user_skills do |t|
      t.bigint :user_id
      t.bigint :skill_id

      t.timestamps
    end
  end
end
