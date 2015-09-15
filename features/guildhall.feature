Feature: Guildhalls
  Scenario: Each user has a guild hall
    Given I am on the home page
    When I follow "Sign up!"
    And I fill in the following:
      | Email                      | dan@example.com |
      | user_password              | pass            |
      | user_password_confirmation | pass            |
      | display_name               | Dan             |
    And I press "Create Account"
    And I follow "My Guildhall"
    Then I should see "Dan's Guild"
