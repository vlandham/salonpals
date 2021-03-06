class Post < ActiveRecord::Base
  attr_writer :current_step
  belongs_to :user
  has_many :requirements
  has_many :skills, :through => :requirements
  has_one :order
  accepts_nested_attributes_for :order
  before_create :activate
  validates_presence_of :title, :description, :address_street, :address_city, :address_state, :address_zip, :business_name, :kind
  
  scope :active, where(:active => true).order("created_at DESC")
  scope :inactive, where(:active => false).order("created_at DESC")
  
  def self.search params
    kind = kinds.include?(params[:kind]) ? params[:kind] : "job"
    if params[:location] and params[:location].present?
      active.where(:kind => kind).near(params[:location], 50, :order => :distance)
    else
      active.where(:kind => kind).all
    end
  end
  
  def self.kinds
    ["job", "booth", "shop"]
  end
  
  def current_step
    @current_step || steps.first
  end
  
  def steps
    #Removing order for now. Free posts
    #%w[create preview order]
    %w[create preview]
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
    #Removing order for now. Free posts
    #vld &= self.order.valid?
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
