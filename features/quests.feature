Feature: Quests
  Scenario: A user can browse unclaimed quests
    Given the following user:
      | email                 | dan@example.com |
      | password              | pass            |
      | password_confirmation | pass            |
    And that user is logged in
    And 3 quests
    And I am on the home page
    When I follow "Quest Bulletins"
    Then I should see "The following quests are available for bids:"


  Scenario: There are no quests available
    Given the following user:
      | email                 | dan@example.com |
      | password              | pass            |
      | password_confirmation | pass            |
    And that user is logged in
    And I am on the home page
    When I follow "Quest Bulletins"
    Then I should see "There are no more quests available today. Please check again tomorrow."

  Scenario: A user can bid on a quest
    Given the following user:
      | email                 | dan@example.com |
      | password              | pass            |
      | password_confirmation | pass            |
    And that user is logged in
    And 1 quest
    And I am on the home page
    When I follow "Quest Bulletins"
    And I follow "Bid"
    And I fill in the following:
      | Amount | 10 |
    And I press "Place Bid"
    Then I should see "Bid placed."
    And I should see "10 gold"
