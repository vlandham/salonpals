class Post < ActiveRecord::Base
  include Workflow
  belongs_to :user
  has_one :order
  validates_presence_of :title, :description, :address_street, :address_city, :address_state, :address_zip, :business_name
  
  scope :active, where(:active => true).order("created_at DESC")
  
  scope :inactive, where(:active => false).order("created_at DESC")
  
  def self.search_location location
    if location and location.present?
      active.near(location, 50, :order => :distance)
    else
      active.all
    end
  end
  
  geocoded_by :address
  after_validation :geocode,
    :if => lambda{ |obj| obj.address_changed? }
    
  workflow do
    state :new do
      event :submit, :transitions_to => :preview
    end
    
    state :preview do
      event :approve, :transitions_to => :order
    end
    
    state :order do
      event :activate, :transitions_to => :active
    end
    
    state :active do
      event :expire, :transitions_to => :expired
    end
    
    state :expired do
    end
  end
  
  def submit
  end
  
  def approve
  end
  
  def activate
    self.active = true
    self.activated_at = Time.now
    self.date_expire = Time.now + 30.days
  end
  
  def expire
    self.active = false
  end
  
  def price
    30.0
  end
  
  def address
    "#{address_street} #{address_city} #{address_state}, #{address_zip}"
  end
  
  def address_changed?
    address_street_changed? or address_city_changed? or
    address_state_changed? or address_zip_changed?
  end
  
end
