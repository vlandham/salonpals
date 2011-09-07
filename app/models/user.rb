class User < ActiveRecord::Base
  has_many :user_types
  has_many :roles, :through => :user_types
  has_one :profile
  has_many :posts, :order => "created_at DESC"
  #before_validation :convert_language
  

  validates_presence_of  :first_name, :last_name, :email, :password, :zip_code, :language
  validates_uniqueness_of :email
  #validates_numericality_of :zip_code, :only_integer => true
  validates_inclusion_of :language, :in => LANGUAGES.keys
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :first_name, :last_name, :language, :zip_code
  
  def name
    "#{self.first_name} #{self.last_name}"
  end
  
  def owns_posts?
    !self.posts.empty?
  end
  
  def owns_post? post
    self.id == post.user_id
  end
  
  def admin?
    roles = self.roles
    roles.select {|r| r.name == 'admin'}.size > 0
  end
end
