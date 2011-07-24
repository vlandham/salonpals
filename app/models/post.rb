class Post < ActiveRecord::Base
  include Workflow
  belongs_to :user
  has_one :order
  validates_presence_of :title, :description, :address_street, :address_city, :address_state, :address_zip, :business_name
  
  geocoded_by :address
  after_validation :geocode,
    :if => lambda{ |obj| obj.address_changed? }
    
  workflow do
    state :new do
      event :submit, :transitions_to => :preview
    end
    
    state :preview do
    end
    
  end
  
  def address
    "#{address_street} #{address_city} #{address_state}, #{address_zip}"
  end
  
  def address_changed?
    address_street_changed? or address_city_changed? or
    address_state_changed? or address_zip_changed?
  end
  
  def self.search_location location
    if location and location.present?
      near(location, 50, :order => :distance)
    else
      order("created_at DESC").all
    end
  end
end
