class Profile < ActiveRecord::Base
  belongs_to :user, :dependent => :destroy
  has_many :positions, :dependent => :destroy
end
