require 'rails_helper'
require_relative '../helpers/session_helpers'
include Session

feature 'pictures' do

  before do
    email = 'test@test.com'
    password = 'testtest'
    sign_up(email, password)
  end

  context 'upload a picture' do
    scenario 'should display a prompt to add a picture when user is signed in' do
      visit '/pictures'
      expect(page).to have_content 'No pictures yet'
      expect(page).to have_link 'Upload a picture'
    end
     scenario 'should NOT display a prompt to add a picture when user is signed out' do
      visit('/')
      click_link('Sign out')
      expect(page).not_to have_content('Upload a picture')
    end

    scenario 'add a picture when signed in' do
      visit('/')
      click_link('Upload a picture')
      attach_file('Image', File.join(Rails.root, 'spec', 'features/uploads', 'dover.jpg'))
      fill_in 'Title', with: 'At the sea'
      click_button('Upload')
      expect(current_path).to eq ('/pictures')
      expect(page).to have_content('At the sea ')
      expect(page).to have_css('.img-post')
    end
  end

  context 'deleting pictures' do
    before { Picture.create title: 'at the sea' }

    scenario 'removes a picture when a user clicks a delete link' do
      visit '/pictures'
      click_link 'Delete picture'
      expect(page).not_to have_content 'at the sea'
      expect(page).to have_content 'Picture deleted successfully'
    end
  end
end