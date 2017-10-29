class CreateSkills < ActiveRecord::Migration[5.1]
  def change
    create_table :skills do |t|
      t.string :skill_name

      t.timestamps
    end
    Skill.create(:skill_name => "Babysitting")
    Skill.create(:skill_name => "Yard work")
    Skill.create(:skill_name => "Snow shoveling")
    Skill.create(:skill_name => "Furniture moving")
    Skill.create(:skill_name => "Simple cleaning tasks")
    Skill.create(:skill_name => "Vacation services")
    Skill.create(:skill_name => "Dog walking")
    Skill.create(:skill_name => "Computer help")
    Skill.create(:skill_name => "Tutoring")
    Skill.create(:skill_name => "Reading")
  end
end
