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

  Scenario: A fired adventurer should appear in the free market
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
    And I follow "Free Market"
    Then I should see "Billy Bob"

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

  Scenario: Users can only hire experienced adventurers if they can pay the advance
    Given the following user:
      | email                 | dan@example.com |
      | password              | pass            |
      | password_confirmation | pass            |
    And that user is logged in
    And a highly skilled unemployed adventurer
    And I am on the home page
    When I follow "Free Market"
    And I hire the first adventurer
    Then I should see "You can't afford"

  Scenario: A user can't hire more adventurers than her guild has capacity for
    Given the following adventurer:
      | name         | Billy |
      | guildhall_id | 0     |
    And a user with a full guild
    And that user is logged in
    And I am on the home page
    When I follow "Free Market"
    And I hire the first adventurer
    Then I should see "You cannot hire any more adventurers. Your guild is at capacity."
