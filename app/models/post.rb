class Post < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :title, :description, :address_city, :address_state, :address_zip, :business_name
end
