class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :plan
  attr_accessor :stripe_card_token

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  def save_with_payment
  	if valid?
  		customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_card_token)
  		self.stripe_customer_token = customer.plan_id
  		save!
  	end
  end
end
