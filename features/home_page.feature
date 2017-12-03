Feature: Load Homepage Cucumber

  Scenario: Homepage is properly rendered
    When I go to the homepage
    Then I should see the Getting Started link
    Then I should see the english language option
    Then I should see the french language option
    Then I should see the services option
