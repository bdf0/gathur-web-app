class User < ActiveRecord::Base

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	VALID_PHONE_REGEX = /[2-9]{1}[0-9]{9}/

	before_validation do
		self.phone.gsub!(/\D/, '')
	end
	
	before_save do
		self.email.downcase!
	end

	validates :first_name, presence: true, length: { maximum: 50 }
	
	validates :last_name, presence: true, length: { maximum: 50 }
	
	validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	
	validates :phone, presence: true, length: { maximum: 10, minimum: 10 }, format: { with: VALID_PHONE_REGEX}, uniqueness: true
	
	validates :password, presence: true, length: { minimum: 6 }
	
	has_secure_password
	
end
