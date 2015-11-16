class Invitation < ActiveRecord::Base
	has_one :user
	belongs_to :event
end
