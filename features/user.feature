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

  Scenario: A user can delete his account
    Given the following user:
      | email                 | dan@example.com |
      | password              | pass            |
      | password_confirmation | pass            |
    And that user is logged in
    And I am on the home page
    When I follow "My Profile"
    And I follow "Delete My Account"
    Then I should see "Account successfully deleted."
    And I should see "Log In"
