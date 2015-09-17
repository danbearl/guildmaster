Given /^that user is logged in$/ do
  visit "/log_in/"

  fill_in "email", :with => @user.email
  fill_in "password", :with => "pass"

  click_button "Log In"
end

Given /^a user with a full guild$/ do
  @user = Fabricate(:user,
                    email: "dan@example.com",
                    password:"pass",
                    password_confirmation: "pass"
                   ) do
    guildhall
  end

  4.times do
    Fabricate(:adventurer, guildhall_id: 1)
  end
end

Given /^I am on the home page$/ do
  visit root_path
end

Given /^a highly skilled unemployed adventurer$/ do
  Fabricate(:adventurer, skills: {archery: 100, melee: 100, stealth: 100}, guildhall_id: 0)
end

Given /^I am on the log in page$/ do
  visit log_in_path
end

When /^I follow "(.*?)"$/ do |link|
  click_link(link)
end

When /^I fill in the following:?/ do |form|
  rows = form.raw

  rows.each do |r|
    fill_in r[0], :with => r[1]
  end
end

When /^I press "(.*?)"$/ do |action|
  click_button action
end

When /^I press the hire button$/ do
  within "td#adventurer_1_form" do
    click_button "Hire"
  end
end

When /^I hire the first adventurer$/ do
  within "td#adventurer_1_form" do
    click_link "Hire"
  end
end

Then /^I should see "(.*?)"$/ do |text|
  expect(page).to have_content(text)
end

Then /^I should not see "(.*?)"$/ do |text|
  expect(page).to(have_no_content(text))
end

When /^I visit "(.*?)"$/ do |url|
  visit url
end
