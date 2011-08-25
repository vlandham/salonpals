class SkillCategory < ActiveRecord::Base
  has_many :skill_sets
  has_many :skills, :through => :skill_sets
end
