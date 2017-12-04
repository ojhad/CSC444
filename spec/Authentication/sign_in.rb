require 'rails_helper.rb'

feature 'Sign In' do
  scenario 'Sign in with empty fields should return error' do
    visit '/users/sign_in'
    within '.button-container' do
      click_on(class: "login-btn")
    end
    expect(page).to have_content('Invalid Email or password.')
  end
end