Feature: Adventurers
  Scenario: A user can hire a fresh recruit
    Given the following user:
      | email                 | dan@example.com |
      | password              | pass            |
      | password_confirmation | pass            |
    And that user is logged in
    And I am on the home page
    When I follow "Town Square"
    And I press the hire button
    Then I should see "hired!"

  Scenario: A user can fire an adventurer
    Given the following user:
      | email                 | dan@example.com |
      | password              | pass            |
      | password_confirmation | pass            |
    And that user is logged in
    And the following adventurer:
      | name         | Billy Bob |
      | guildhall_id | 1         |
    And I am on the home page
    When I follow "My Guildhall"
    And I follow "Billy Bob"
    And I follow "Fire Adventurer"
    Then I should see "Billy Bob has left your guild."

  Scenario: Unemployed adventurers appear on the free market
    Given the following user:
      | email                 | dan@example.com |
      | password              | pass            |
      | password_confirmation | pass            |
    And that user is logged in
    And the following adventurers:
      | guildhall_id | name  |
      | 0            | Billy |
      | 0            | Joe   |
      | 0            | Sally |
    And I am on the home page
    When I follow "Free Market"
    Then I should see "Billy"
    And I should see "Joe"
    And I should see "Sally"
