When(/^I go to the homepage$/) do
  visit root_path
end

Then(/^I should see the Getting Started link$/) do
  expect(page).to have_content("Get started")
end