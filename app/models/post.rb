class Post < ActiveRecord::Base
  attr_writer :current_step
  belongs_to :user
  has_one :order
  accepts_nested_attributes_for :order
  before_create :activate
  validates_presence_of :title, :description, :address_street, :address_city, :address_state, :address_zip, :business_name, :type
  
  scope :active, where(:active => true).order("created_at DESC")
  scope :inactive, where(:active => false).order("created_at DESC")
  
  def self.search params
    type = types.include?(params[:type]) ? params[:type] : "job"
    if params[:location] and params[:location].present?
      active.where(:type => type).near(params[:location], 50, :order => :distance)
    else
      active.where(:type => type).all
    end
  end
  
  def self.types
    ["job", "booth", "shop"]
  end
  
  def current_step
    @current_step || steps.first
  end
  
  def steps
    %w[create preview order]
  end

  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end

  def previous_step
    self.current_step = steps[steps.index(current_step)-1]
  end

  def first_step?
    current_step == steps.first
  end

  def last_step?
    current_step == steps.last
  end

  def all_valid?
    vld = steps.reverse.all? do |step|
      self.current_step = step
      valid?
    end
    vld &= self.order.valid?
  end
  
  geocoded_by :address
  after_validation :geocode,
    :if => lambda{ |obj| obj.address_changed? }
    
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
