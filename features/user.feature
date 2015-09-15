Feature: Users
  Scenario: An anonymous user can create a new user
    Given I am on the home page
    When I follow "Sign up!"
    And I fill in the following:
      | Email                      | dan@example.com |
      | display_name               | dan             |
      | user_password              | pass            |
      | user_password_confirmation | pass            |
    And I press "Create Account"
    Then I should see "Account successfully created!"
    And I should see "Log Out"
