class Review < ActiveRecord::Base

  belongs_to :restaurant
  belongs_to :user
  has_many :endorsements
  validates :rating, inclusion: (1..5)
  validates :user_id, :uniqueness => {:scope => :restaurant_id}


end
