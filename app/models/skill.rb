class Skill < ActiveRecord::Base
  has_many :experiences
  has_many :profiles, :through => :experiences
  has_many :requirements
  has_many :posts, :through => :requirements
  has_many :skill_sets
  has_many :skill_categories, :through => :skill_sets
end
