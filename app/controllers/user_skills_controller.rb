class UserSkillsController < ApplicationController
  def new

  end

  def create
    @userSkill = UserSkill.new(user_id: current_user.id, skill_id: params[:skill_id])
    @userSkill.save
    redirect_to edit_user_skill_path(current_user.id)
  end

  def destroy
    @userSkill = UserSkill.find_by_user_id_and_skill_id(current_user.id, Skill.find_by_skill_name(params[:skill_id]).id)
    UserSkill.destroy(@userSkill.id)
    redirect_to edit_user_skill_path(current_user.id)
  end

  def edit
    @user = User.find(current_user.id)
    @userSkills = Skill.find_by_sql("SELECT skills.id, skills.skill_name FROM skills JOIN user_skills ON skills.id = user_skills.skill_id where user_id = #{@user.id} ORDER BY id")
  end
end
