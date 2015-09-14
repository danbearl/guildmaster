Feature: User Profiles
  Scenario: A user has a profile
    Given the following user:
      | email                 | dan@example.com |
      | password              | pass            |
      | password_confirmation | pass            |
    And that user is logged in
    And I am on the home page
    When I follow "My Profile"
    Then I should see "Edit My Profile"
