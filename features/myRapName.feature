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
    Then    I click the button "Suggest Male Rap Name" "1" time(s)
    And     I see a message: "You must enter your first name."

  Scenario: Validate that First Name input field must not be empty when suggesting female names
    Given   I am on the "MyRapName.com" page
    When    I see an input field for "lastinitial"
    And     I can select and enter the text: "A" into the "lastinitial" input field
    Then    I click the button "Suggest Female Rap Name" "1" time(s)
    And     I see a message: "You must enter your first name."

  Scenario: Validate that input field processes input data entered into the field for male names
    Given   I am on the "MyRapName.com" page
    When    I see an input field for "firstname"
    And     I can select and enter the text: "firstName" into the "firstname" input field
    And     I click the button "Suggest Male Rap Name" "1" time(s)
    Then    I see "1" result(s) listed in the "Your rap name is:" table
    And     I do not see a message: "You must enter your first name."
    And     I do not see a message: "Enter your name to begin."

  Scenario: Validate that input field processes input data entered into the field for female names
    Given   I am on the "MyRapName.com" page
    When    I see an input field for "firstname"
    And     I can select and enter the text: "firstName" into the "firstname" input field
    And     I click the button "Suggest Female Rap Name" "1" time(s)
    Then    I see "1" result(s) listed in the "Your rap name is:" table
    And     I do not see a message: "You must enter your first name."
    And     I do not see a message: "Enter your name to begin."

  Scenario: Validate 1 rap name is prepended for male first name, with nickname no last initial
    Given   I am on the "MyRapName.com" page
    And     I see a message: "Enter your name to begin."
    When    I see an input field for "firstname"
    And     I can select and enter the text: "BigMaleRapperMan" into the "firstname" input field
    And     I see an input field for "lastinitial"
    And     I can select and enter the text: "" into the "lastinitial" input field
    And     I can see the "Use Nickname:" checkbox and it should be checked = "true"
    And     I click the button "Suggest Male Rap Name" "1" time(s)
    Then    I see "1" result(s) listed in the "Your rap name is:" table

  Scenario: Validate 2 rap names are prepended for female first name, last initial no nickname
    Given   I am on the "MyRapName.com" page
    And     I see a message: "Enter your name to begin."
    When    I see an input field for "firstname"
    And     I can select and enter the text: "RoughToughFemaleTesterWoman" into the "firstname" input field
    And     I see an input field for "lastinitial"
    And     I can select and enter the text: "Q" into the "lastinitial" input field
    And     I can see the "Use Nickname:" checkbox and it should be checked = "false"
    And     I click the button "Suggest Female Rap Name" "3" time(s)
    Then    I see "3" result(s) listed in the "Your rap name is:" table

  Scenario: Validate each time a new rap name is suggested it is prepended to the list and old suggestions move down
    Given   I am on the "MyRapName.com" page
    And     I see a message: "Enter your name to begin."
    When    I see an input field for "firstname"
    And     I can select and enter the text: "RepeatedRapperNamer" into the "firstname" input field
    And     I see an input field for "lastinitial"
    And     I can select and enter the text: "Z" into the "lastinitial" input field
    And     I can see the "Use Nickname:" checkbox and it should be checked = "false"
    Then    I click the button "Suggest Female Rap Name" "6" times and after each click I watch previous suggestions move down the "Your rap name is:" table