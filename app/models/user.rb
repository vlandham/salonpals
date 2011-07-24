class User < ActiveRecord::Base
  has_one :profile
  has_many :posts, :order => "created_at DESC"
  before_validation :convert_language
  
  validates_uniqueness_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  validates_presence_of :email, :password, :first_name, :last_name
  #validates_numericality_of :zip_code, :only_integer => true
  #validates_inclusion_of :language, :in => LANGUAGES.values
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :first_name, :last_name
  
  def name
    "#{self.first_name} #{self.last_name}"
  end
  
  def owns_posts?
    !self.posts.empty?
  end
  
  def owns_post? post
    self.id == post.user_id
  end

  private
  
  def convert_language
    self.language = self.language.to_i
    puts self.inspect
    puts LANGUAGES.values
  end
end
