class Post < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :title, :description, :address_street, :address_city, :address_state, :address_zip, :business_name
  
  def self.search_location location
    if location
      
    else
      order("created_at DESC").all
    end
  end
end
