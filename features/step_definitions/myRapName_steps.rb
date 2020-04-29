## Custom Methods

Capybara.add_selector(:xpath) do
  xpath {|arg| "//#{arg}"}
end


## Given Section ##

Given /I am on the "(.*?)" page/ do |string|
  if page.find(:xpath, "h1[contains(text(),'" + string + "')]")
    puts('xpath on page matching: '+ string)
  end
end




## When Section ##

When(/^I see an input field for "(.*?)"$/) do |string|
  if page.find(:xpath, "input[@name='" + string + "']")
    puts string + ' input field is on the page'
  end
end




## Then Section ##

Then /I see a message: "(.*?)"/ do |string|
  if page.find('h1', text: string)
    puts 'The "' + string + '" text is visible on the screen'
  end
end

Then(/^I can select and enter the text: "([^"]*)" into the "(.*?)" input field$/) do |arg, string|
  if page.fill_in(string, with: arg)
    puts 'I can enter the text: "' + arg + '" into the "' + string + '" input field'
  end
end

Then(/^I click the button "([^"]*)"$/) do |string|
  if page.click_on(string)
    puts 'I clicked the "' + string + '" button'
  end
end

Then(/^I see results listed in the "([^"]*)" table$/) do |string|
  a = page.find(:xpath, "strong[contains(text(),'" + string + "')]/../following-sibling::div/table").text
  puts a
end

Then(/^I do not see a message: "([^"]*)"$/) do |string|
  puts 'The message: "' + string + '" is not on the screen' if page.assert_no_selector('h1', text: string)
end