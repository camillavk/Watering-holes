class Restaurant < ActiveRecord::Base

  has_attached_file :image,
      :styles => {
        :medium => '300x300>',
        :thumb => '100x100>' },
        :default_url => '/images/:styles/missing.png'
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  has_many :reviews, dependent: :destroy
  belongs_to :user
  validates :name, length: {minimum: 2}, uniqueness: {
     :message => "This restaurant has already been created!" }

  def average_rating
    return 'N/A' if reviews.none?
    reviews.inject(0) {|memo, review| memo + review.rating} / reviews.count
  end

  def not_reviewed_by?(current_user)
    reviews.each do |review|
      return false if review.user == current_user
    end
      true
  end

end
