require 'rails_helper'

RSpec.describe Review, :type => :model do
  it 'is invalid if the rating is more than 5' do
    review = Review.new(rating: 10)
    expect(review).to have(1).error_on(:rating)
  end

  it 'is not valid if it does not have a unique user' do
    Review.create(thoughts: 'Makers', rating: 2, user_id: 2)
    review = Review.new(thoughts: 'Makers', rating: 2, user_id: 2)
    expect(review).to have(1).error_on(:user_id)
  end

end
