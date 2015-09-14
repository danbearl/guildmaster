Feature: User Sessions
  Scenario: A user can log in
    Given the following user:
      | email                 | dan@example.com |
      | password              | pass            |
      | password_confirmation | pass            |
    And I am on the home page
    When I follow "Log In"
    And I fill in the following:
      | email    | dan@example.com |
      | password | pass            |
    And I press "Log In"
    Then I should see "Welcome back!"
    And I should see "Log Out"

  Scenario: A user can log out
    Given the following user:
      | email                 | dan@example.com |
      | password              | pass            |
      | password_confirmation | pass            |
    And that user is logged in
    When I follow "Log Out"
    Then I should see "Logged out successfully."
    And I should not see "Log Out"
    And I should see "Log In"
