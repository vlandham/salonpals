class Order < ActiveRecord::Base
  belongs_to :post
  has_many :transactions, :class_name => "OrderTransaction"
  
  attr_accessor :card_number, :card_verification
  
  validates_presence_of :first_name, :last_name, :address_street, :address_city, :address_state, :address_zip
  validate :validate_card
  
  #before_validation :populate_fields
  
  def populate_fields
    self.address_street = post.address_street
    self.address_city = post.address_city
    self.address_state = post.address_state
    self.address_zip = post.address_zip
    self.first_name = post.user.first_name
    self.last_name = post.user.last_name
  end
  
  def purchase
     response = GATEWAY.purchase(price_in_cents, credit_card, purchase_options)
     transactions.create!(:action => "purchase", :amount => price_in_cents, :response => response)
     post.activate! if response.success?
     response.success?
   end

   def price_in_cents
     (post.price*100).round
   end
   
   def name
     "#{self.first_name} #{self.last_name}"
   end
  
  private
    def purchase_options
      {
        :ip => ip_address,
        :billing_address => {
          :name     => self.name,
          :address1 => self.address_street,
          :city     => self.address_city,
          :state    => self.address_state,
          :country  => "US",
          :zip      => self.address_zip
        }
      }
    end

    def validate_card
      unless credit_card.valid?
        credit_card.errors.full_messages.each do |message|
          errors.add_to_base message
        end
      end
    end

    def credit_card
      @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
        :type               => card_type,
        :number             => card_number,
        :verification_value => card_verification,
        :month              => card_expires_on.month,
        :year               => card_expires_on.year,
        :first_name         => first_name,
        :last_name          => last_name
      )
    end
end
