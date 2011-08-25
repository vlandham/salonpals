class Profile < ActiveRecord::Base
  belongs_to :user, :dependent => :destroy
  has_many :positions, :dependent => :destroy
  has_many :experiences
  has_many :skills, :through => :experiences
end
