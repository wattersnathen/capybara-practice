require 'yaml'
require 'date'
# require 'os'
$cfg = YAML.load_file("#{$filePath}objectRepository.yaml")

# Example of accessing object repository:
# find(:xpath, $cfg['key'], wait:30).click
#
# Example of visiting the url
# visit 'https://americas.datasite.com'

Given(/^Open the app url$/) do
  visit '/'
  expect(page).to have_css($cfg['login_form'])
end

When(/^user fills out login form with credentials$/) do |table|
  credentials = table.hashes[0]
  within($cfg['login_form']) do
    fill_in $cfg['login_username'], with: credentials['email']
    fill_in $cfg['login_password'], with: credentials['password']
    find(:xpath, $cfg['login_submit']).click
  end
end

When(/^user clicks forgot password$/) do
  find(:xpath, $cfg['forgot_password_link']).click
  expect(page).to have_css($cfg['forgot_password_email'])
end

When('user submits forgot password form with email {string}') do |string|
  find(:css, $cfg['forgot_password_email']).set(string)
  find(:xpath, $cfg['forgot_password_submit']).click
end

When('user clicks {string}') do |string|
  find_link(string).click
  expect(page).to have_content(/#{string}/im)
end

When('user clicks on the language drop-down') do
  find($cfg['menu_open']).click
  find($cfg['language_dropdown']).click
end

Then(/^date is up to date$/) do
  today = Date.today
  str = "#{Date::MONTHNAMES[today.month]} #{today.day}, #{today.year}"
  expect(find(:xpath, $cfg['tos_date'])).to have_content(str), "Today's date was not presented"
end

Then('drop-down should contain') do |table|
  languages = table.raw[0]
  lang_item_text = find($cfg['language_list']).all('li a.langnavitem-link').collect(&:text)
  expect(languages & lang_item_text == languages).to eql(true), "Languages available did not match, expected: #{languages}, found: #{lang_item_text}"
end

Then(/^user is presented with an error message$/) do
  expect(page).to have_content("We didn't recognize the username or password you entered. Please try again.")
end

Then('form validation error is presented to the user {string}') do |string|
  expect(find(:css, 'small')).to have_content(string)
end
