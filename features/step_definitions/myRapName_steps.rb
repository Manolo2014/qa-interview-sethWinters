require 'logger'

## Logger Method TODO move to a config
logger = Logger.new('logs/logfile.log')
logger.level = Logger::DEBUG

## Custom Methods

Capybara.add_selector(:xpath) do
  xpath { |arg| "//#{arg}" }
end

def clickonceandgetname(suggest_button, results_table, num)
  page.click_on(suggest_button)
  a = page.find(:xpath, "strong[contains(text(),'" + results_table + "')]/../following-sibling::div/table/tbody//tr[#{num}]").text
  return a
end

## Given Section ##

Given /I am on the "(.*?)" page/ do |page_name|
  page.find(:xpath, "h1[contains(text(),'" + page_name + "')]")
  logger.debug('xpath on page matching: ' + page_name)
end

## When Section ##

When(/^I see an input field for "(.*?)"$/) do |first_name|
  page.find(:xpath, "input[@name='" + first_name + "']")
  logger.debug(first_name + ' input field is on the page')
end

## Then Section ##

Then /I see a message: "(.*?)"/ do |alert_message|
  page.find('h1', text: alert_message)
  logger.debug('The "' + alert_message + '" text is visible on the screen')
end

Then(/^I can select and enter the text: "([^"]*)" into the "(.*?)" input field$/) do |actual_name, first_name|
  page.fill_in(first_name, with: actual_name)
  logger.debug('I can enter the text: "' + actual_name + '" into the "' + first_name + '" input field')
end

Then(/^I click the button "([^"]*)" "([^"]*)" time\(s\)$/) do |suggest_button, num_of_clicks|
  num = num_of_clicks.to_i
  if num.zero?
    logger.warn('The button is not clicked at all')
  elsif num == 1
    page.click_on(suggest_button)
    logger.debug('I clicked the "' + suggest_button + '" button')
  else
    x = 1
    while num.positive?
      page.click_on(suggest_button)
      logger.debug("I clicked the '" + suggest_button + "' button times #{x} times")
      x += 1
      num -= 1
    end
  end
end

Then(/^I see "([^"]*)" result\(s\) listed in the "([^"]*)" table$/) do |num_of_results, results_table|
  num = num_of_results.to_i
  if num == 1
    a = page.find(:xpath, "strong[contains(text(),'" + results_table + "')]/../following-sibling::div/table/tbody//tr[#{num_of_results}]").text
    logger.debug('The single result in the table is: ' + a)
  elsif num > 1
    logger.debug('results are printed from bottom up - oldest to most recent')
    while num.positive?
      a = page.find(:xpath, "strong[contains(text(),'" + results_table + "')]/../following-sibling::div/table/tbody//tr[#{num}]").text
      logger.debug('The number ' + num.to_s + ' result in the table is: ' + a)
      num -= 1
    end
  else
    logger.warn('There must be more than 1 result in the table to validate')
  end
end

Then(/^I do not see a message: "([^"]*)"$/) do |alert_message|
  if page.assert_no_selector('h1', text: alert_message)
    logger.debug('The message: "' + alert_message + '" is not on the screen')
  end
end

Then(/^I can see the "([^"]*)" checkbox and it should be checked = "([^"]*)"$/) do |check_box_name, should_be_checked|
  is_checked = page.find(:xpath, "h2[input][contains(text(),'" + check_box_name + "')]/input[3]").checked?
  a = is_checked.to_s
  b = check_box_name.to_s
  c = should_be_checked.to_s
  if is_checked == should_be_checked
    logger.debug('The "' + b + '" checkbox is checked: "' + a + '" which matches what it should be: "' + c + '"')
  else
    logger.debug('The "' + b + '" checkbox is checked: "' + a + '" does not match what it should be: "' + c + '"')
    find('input[type="checkbox"]').click
    is_now_checked = page.find(:xpath, "h2[input][contains(text(),'" + b + "')]/input[3]").checked?
    d = is_now_checked.to_s
    logger.debug('The "' + b + '" checkbox is now checked: "' + d + '" which matches what it should be: "' + c + '"')
  end
end

# TODO create common methods that can replace duplicate code
Then(/^I click the button "([^"]*)" "([^"]*)" times and after each click I watch previous suggestions move down the "([^"]*)" table$/) do |suggest_button,num_of_clicks,results_table|
  num = num_of_clicks.to_i
  suggestions = []
  if num == 1
    a = clickonceandgetname(suggest_button, results_table, num)
    logger.debug('The single result in the table is: ' + a)
  end
  if num > 1
    x = 1
    # this gets the name of the item at the top of the list and adds it to an arrayin the reverse order
    # so that after 6 items are added, the oldest is element[0] and the newest is element[5]
    while num.positive?
      a = clickonceandgetname(suggest_button, results_table, x)
      num -= 1
      suggestions << a
    end
  end

  x = num_of_clicks.to_i
  suggestions.each do |suggestion|
    suggestion_list = page.find(:xpath, "strong[contains(text(),'" + results_table + "')]/../following-sibling::div/table/tbody//tr[#{x}]").text
    if suggestion == suggestion_list
      logger.debug('list matches suggestion array')
      x -= 1
    else
      logger.warn('list doesn\'t match')
    end
  end
end