Given(/^visit homepage$/) do
  visit $URL
end

And(/^fill "([^"]*)" with "([^"]*)"$/) do |field, value|
  fill_in(field, with: value)
end

When(/^click Submit button$/) do |button|
  click_button('Submit')
end
Then(/^page (should|should_not) contain "([^"]*)" content$/) do |condition, content|
  # E.g. : page should contain "Test" content
  # E.g. : page should_not contain "Test" content
  # page.should have_content(content, count: count, wait: $timeout)
  sleep 1
  if condition == 'should'
    page.should have_content(content, wait: $timeout)

  elsif condition == 'should_not'
    page.should_not have_content(content, wait: $timeout)
  end
end