require 'rails_helper'

describe 'reviewing' do
  before do
    visit '/'
    click_link 'Sign up'
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button 'Sign up'
    User.first().restaurants.create(name: 'KFC')
  end

  it 'allows users to leave a review using a form' do
    visit '/'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'so so'
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/'
    expect(page).to have_content 'so so'
  end

  it 'allows user to delete their own review' do
    visit '/'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'so so'
    select '3', from: 'Rating'
    click_button 'Leave Review'
    click_link 'Delete Review'
    # expect(page).not_to have_content 'so so'
    expect(page).to have_content 'Review deleted successfully'
  end
end
