class UserSkillsController < ApplicationController
  def new

  end

  def create
    @userSkill = UserSkill.new(user_id: current_user.id, skill_id: params[:skill_id])
    @userSkill.save
  end

  def destroy
    @userSkill = UserSkill.find_by_user_id_and_skill_id(current_user.id, params[:skill_id])
    UserSkill.destroy(@userSkill.id)
  end
end
