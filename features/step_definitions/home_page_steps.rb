When(/^I go to the homepage$/) do
  visit root_path
end

Then(/^I should see the Getting Started link$/) do
  expect(page).to have_content("Get started")
end

Then(/^I should see the english language option$/) do
  expect(page).to have_content("English")
end

Then(/^I should see the french language option$/) do
  expect(page).to have_content("Français")
end

Then(/^I should see the services option$/) do
  expect(page).to have_content("Services")
end