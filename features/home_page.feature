Feature: Load Homepage Cucumber

  Scenario: Homepage is properly rendered
    When I go to the homepage
    Then I should see the Getting Started link