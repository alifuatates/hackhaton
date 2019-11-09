Given(/^visit homepage$/) do
  visit $URL
end

And(/^fill "([^"]*)" with "([^"]*)"$/) do |field, value|
  fill_in(field, with: value)
end

When(/^click Submit button$/) do |button|
  click_button('Submit')
end