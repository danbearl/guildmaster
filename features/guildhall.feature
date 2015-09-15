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

  Scenario: A user can edit their guild hall
    Given the following user:
      | email                 | dan@example.com |
      | password              | pass            |
      | password_confirmation | pass            |
    And that user is logged in
    And I am on the home page
    When I follow "My Guildhall"
    And I follow "Edit Guildhall"
    And I fill in the following:
      | Name | Thunder Hammers |
    And I press "Update Guild"
    Then I should see "Thunder Hammers"
