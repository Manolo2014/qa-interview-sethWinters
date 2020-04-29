Feature: MyRapName page displays Rap Names in ordered list

  Scenario: Validate that I am on the MyRapName.com homepage
    Given   I am on the "MyRapName.com" page
    Then    I see a message: "Enter your name to begin."

  Scenario: Validate that the input field exists
    Given   I am on the "MyRapName.com" page
    When    I see an input field for "firstname"
    Then    I can select and enter the text: "test" into the "firstname" input field

  Scenario: Validate that First Name input field must not be empty when suggesting male names
    Given   I am on the "MyRapName.com" page
    When    I see an input field for "lastinitial"
    And     I can select and enter the text: "A" into the "lastinitial" input field
    Then    I click the button "Suggest Male Rap Name"
    And     I see a message: "You must enter your first name."

  Scenario: Validate that First Name input field must not be empty when suggesting female names
    Given   I am on the "MyRapName.com" page
    When    I see an input field for "lastinitial"
    And     I can select and enter the text: "A" into the "lastinitial" input field
    Then    I click the button "Suggest Female Rap Name"
    And     I see a message: "You must enter your first name."

  Scenario: Validate that input field processes input data entered into the field for male names
    Given   I am on the "MyRapName.com" page
    When    I see an input field for "firstname"
    And     I can select and enter the text: "firstName" into the "firstname" input field
    And     I click the button "Suggest Male Rap Name"
    Then    I see results listed in the "Your rap name is:" table
    And     I do not see a message: "You must enter your first name."
    And     I do not see a message: "Enter your name to begin."

  Scenario: Validate that input field processes input data entered into the field for female names
    Given   I am on the "MyRapName.com" page
    When    I see an input field for "firstname"
    And     I can select and enter the text: "firstName" into the "firstname" input field
    And     I click the button "Suggest Female Rap Name"
    Then    I see results listed in the "Your rap name is:" table
    And     I do not see a message: "You must enter your first name."
    And     I do not see a message: "Enter your name to begin."
#
#  Scenario: Validate 1 rap name is prepended for male first name, nickname no last initial
#    Given   I am on the "MyRapName.com" page
#    When    I do enter a first name
#    And     I do not enter a last initial
#    And     I do check "Use Nickname" checkbox
#    Then    I see a new rap name at the top of the list of rap names
#
#  Scenario: Validate 2 rap names are prepended for female first name, last initial no nickname
#    Given   I am on the "MyRapName.com" page
#    When    I do enter a first name
#    And     I do enter a last initial
#    And     I do not check "Use Nickname" checkbox
#    Then    I do see 2 new rap names
#    And     The most recent rap name is at the top of the list