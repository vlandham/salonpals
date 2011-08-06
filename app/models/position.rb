class Position < ActiveRecord::Base
  belongs_to :profile
  validates_presence_of :title, :company, :location
end
