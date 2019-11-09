Given(/^user visit homepage$/) do
  visit $URL
end

And(/^fill "([^"]*)" with "([^"]*)" at kloia$/) do |field, value|
  fill_in(field, with: value)
end

Then(/^click type "([^"]*)" value "([^"]*)" web elementt$/) do |web_element_type, web_element|
  # E.g: click type "id" value "save" web element
  page.should have_selector(:"#{web_element_type}", web_element)
  find(:"#{web_element_type}", web_element).click
end

Then(/^page (should|should_not) contain "([^"]*)" content at kloia$/) do |condition, content|

  sleep 1
  if condition == 'should'
    page.should have_content(content, wait: $timeout)

  elsif condition == 'should_not'
    page.should_not have_content(content, wait: $timeout)
  end
end