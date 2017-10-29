class SkillsController < ApplicationController
  def show
    @allSkills = Skill.all
  end
end
