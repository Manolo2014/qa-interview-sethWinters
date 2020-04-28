Given(/^I am on the homepage$/) do
  find('h1', :text => "Welcome to MyRapWebsite.com")
end

Then(/^I see the text "(.*?)"$/) do |text|
  page.has_text?(text)
end
