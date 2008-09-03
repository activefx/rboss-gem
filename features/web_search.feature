Feature: Web Search
  In order to get search results
  As a API user
  I want to query yahoo boss

  Scenario: Search web
    Given a valid API key
    When I do a 'web' search for 'monkeys'
    Then I will receive search results
    And I will be able to see the total hits
    
  | type   | term   |
  | web    | monkey |
  | images | monkey |
  | news   | monkey |
  | spell  | girafe |

