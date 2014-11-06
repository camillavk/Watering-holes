require 'rails_helper'

def leave_review(thoughts, rating)
  visit '/'
  click_link 'Review'
  fill_in 'Thoughts', with: thoughts
  select rating, from: 'Rating'
  click_button 'Leave Review'
end

def sign_up(email, password, password_confirmation)
  visit '/'
  click_link 'Sign up'
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  fill_in 'Password confirmation', with: password_confirmation
  click_button 'Sign up'
end

describe 'reviewing' do
  before do
    sign_up('test@example.com', 'testtest', 'testtest')
    User.first().restaurants.create(name: 'KFC')
  end

  it 'allows users to leave a review using a form' do
    leave_review('so so', '4')
    expect(page).to have_content '★★★★☆'
  end

  it 'allows user to delete their own review' do
    leave_review('so so', '3')
    click_link 'KFC'
    click_link 'Delete Review'
    expect(page).to have_content 'Review deleted successfully'
  end

  it 'displays an average rating for all reviews' do
    leave_review('so so', '3')
    click_link 'Sign out'
    sign_up('sam@example.com', 'testtest', 'testtest')
    leave_review('Great', '5')
    expect(page).to have_content('Average rating: ★★★★☆')
  end

end
