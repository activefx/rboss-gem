Feature: Web Search
  In order to get web search results
  As a API user
  I want to query yahoo boss

  Scenario: Search
    Given a valid API key
    When I search for 'monkeys'
    Then I will receive search results
    And I will be able to see the total hits