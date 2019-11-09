Given(/^user visit homepage$/) do
  puts 'visiting url:' + $URL
  visit $URL
end

And(/^fill "([^"]*)" with "([^"]*)" at kloia$/) do |field, value|
  fill_in(field, with: value)
end

When(/^click Submit button$/) do |button|
  click_button('Submit')
end

Then(/^page (should|should_not) contain "([^"]*)" content at kloia$/) do |condition, content|

  sleep 1
  if condition == 'should'
    page.should have_content(content, wait: $timeout)

  elsif condition == 'should_not'
    page.should_not have_content(content, wait: $timeout)
  end
end