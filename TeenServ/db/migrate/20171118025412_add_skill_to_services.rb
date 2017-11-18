class AddSkillToServices < ActiveRecord::Migration[5.1]
  def change
    add_column :services, :skill, :integer
  end
end
