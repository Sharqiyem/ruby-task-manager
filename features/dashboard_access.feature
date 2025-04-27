Feature: Dashboard Access

  Scenario: Unauthenticated user tries to access dashboard
    Given I am not signed in
    When I visit the dashboard page
    Then I should be on the sign-in page
    And I should see the "You need to sign in or sign up before continuing." in the alert

  Scenario: Authenticated user accesses dashboard
    Given I am logged in as "s@s.com" with password "123456"
    When I visit the dashboard page
    Then I should see "Welcome back"
