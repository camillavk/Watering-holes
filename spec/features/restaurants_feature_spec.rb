require 'rails_helper'

describe 'creating restaurants' do

  it 'requires the user to be sign in first' do
    visit '/'
    click_link 'Add a restaurant'
    expect(page).to have_content 'You need to sign in'
  end

end

describe 'creating restaurants' do
  before do
    visit '/'
    click_link 'Sign up'
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button 'Sign up'
  end

  it 'prompts user to fill out a form, then displays the new restaurant' do
    visit '/'
    click_link 'Add a restaurant'
    fill_in 'Name', with: 'KFC'
    click_button 'Create Restaurant'
    expect(page).to have_content 'KFC'
    expect(current_path).to eq '/'
  end

  context 'an invalid restaurant' do
    it 'does not let you submit a name that is too short' do
      visit '/'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'z'
      click_button 'Create Restaurant'
      expect(page).not_to have_content 'z'
      expect(page).to have_content 'Error'
    end

  end
end

describe 'restaurants' do
  context 'no restaurants have been added' do
    it 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'KFC')
    end

    it 'should display restaurants' do
      visit '/'
      expect(page).to have_content 'KFC'
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'viewing restaurants' do
    before do
      @kfc = Restaurant.create(name:'KFC')
    end

    it 'lets a user view a restaurant' do
      visit '/'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{@kfc.id}"
    end
  end

  context 'editing restaurants' do
    before do
      visit '/'
      click_link 'Sign up'
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button 'Sign up'
      User.first().restaurants.create(name: 'KFC')

    end

    it 'lets a user edit own restaurant' do
      visit '/'
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(current_path).to eq '/'
    end
  end
end

describe 'deleting restaurants' do
  before do
    # Restaurant.create(name: 'KFC')
    visit '/'
    click_link 'Sign up'
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button 'Sign up'
    User.first().restaurants.create(name: 'KFC')
  end

  it 'removes restaurant when the user clicks a delete link' do
    visit '/'
    click_link 'Delete KFC'
    expect(page).not_to have_content 'KFC'
    expect(page).to have_content 'Restaurant deleted successfully'
  end
end
