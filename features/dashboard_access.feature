Feature: Dashboard Access
  Scenario: Unauthenticated user tries to access dashboard
    Given I am not logged in
    When I visit the dashboard page
    Then I should be redirected to the login page
    And I should see "You need to sign in"

  Scenario: Authenticated user accesses dashboard
    Given I am logged in as "s@s.com" with password "123456"
    When I visit the dashboard page
    Then I should see "Welcome, s@s.com"