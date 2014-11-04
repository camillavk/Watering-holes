class Restaurant < ActiveRecord::Base

  has_many :reviews, dependent: :destroy
  belongs_to :user
  validates :name, length: {minimum: 2}, uniqueness: true


end
