require 'rails_helper'
require_relative '../helpers/session_helpers'
include Session

feature 'commenting' do
  before { Picture.create title: "test" }
  before do
    @email = 'test@test.com'
    @password = 'testtest'
    sign_up(@email, @password)
  end

  scenario 'a user can add a comment to the picture when signed in' do
    visit '/'
    click_link('Sign out')
    sign_in(@email, @password)
    click_link 'Add a comment'
    fill_in 'Comment', with: 'beautiful picture'
    click_button 'Leave comment'
    expect(current_path).to eq '/pictures'
    expect(page).to have_content 'beautiful picture'
  end
  scenario 'a user cannot add a comment to the picture when signed out' do
    visit '/'
    click_link('Sign out')
    expect(page).not_to have_content ('Add a comment')
  end
end
