require 'rails_helper'
require_relative '../helpers/session_helpers'
include Session

feature 'liking a picture' do
  before do
    email = 'test@test.com'
    password = 'testtest'
    sign_up(email, password)
  end

  scenario 'a user can like a picture when logged in' do
    picture = Picture.create title: "test"
    visit '/'

    click_link 'Like'
    expect(current_path).to eq '/pictures'
    expect(picture.likes.count).to eq 1
  end
end