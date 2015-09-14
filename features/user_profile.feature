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

  Scenario: A user can update her profile
    Given the following user:
      | email                 | dan@example.com |
      | password              | pass            |
      | password_confirmation | pass            |
    And that user is logged in
    And I am on the home page
    When I follow "My Profile"
    And I follow "Edit My Profile"
    And I fill in the following:
      | profile_display_name | Angela                    |
      | About                | I am a noob at this game! |
    And I press "Update Profile"
    Then I should see "Profile successfully updated."
    And I should see "Angela"
    And I should see "I am a noob at this game!"

  Scenario: A user can view another user's profile
    Given the following user:
      | email                 | dan@example.com |
      | password              | pass            |
      | password_confirmation | pass            |
    And the following user:
      | email                 | angela@example.com |
      | password              | pass               |
      | password_confirmation | pass               |
    And that user is logged in
    When I visit "/users/1/profile"
    Then I should see "dan@example.com"

  Scenario: A user cannot edit another users profile
    Given the following user:
      | email                 | dan@example.com |
      | password              | pass            |
      | password_confirmation | pass            |
    And the following user:
      | email                 | angela@example.com |
      | password              | pass               |
      | password_confirmation | pass               |
    And that user is logged in
    When I visit "/users/1/profile/edit"
    Then I should see "You can only edit your own profile!"
