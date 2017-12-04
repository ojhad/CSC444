require 'rails_helper.rb'

feature 'Sign In' do
  scenario 'Sign in with empty fields should return error' do
    visit '/users/sign_in'
    within '.button-container' do
      click_on(class: "login-btn")
    end
    expect(page).to have_content('Invalid Email or password.')
  end

  scenario 'Sign in attempt with password field empty should return error' do
    visit '/users/sign_in'
    fill_in 'user_email', with: 'client1@test.com'
    within '.button-container' do
      click_on(class: "login-btn")
    end
    expect(page).to have_content('Invalid Email or password.')
  end
  scenario 'Sign in attempt with valid credentials should succeed' do
    visit '/users/sign_in'
    fill_in 'user_email', with: 'client1@test.com'
    fill_in 'user_password', with: 'testtest'
    within '.button-container' do
      click_on(class: "login-btn")
    end
    expect(page).to have_content('Welcome')
  end
end