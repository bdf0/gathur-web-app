class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  
  validates :user_id, presence: true
  validates :text, presence: true
end
