class Event < ActiveRecord::Base
  belongs_to :user
  has_many :invitations
  
  default_scope -> { order(:start_time) }
  
  validates :user_id, presence: true
  
  validates :title, presence: true
  
  validates :location, presence: true
  
  validates :start_time, presence: true
  
  validates :end_time, presence: true
  
  validates_date :end_time, after: :start_time
  
end