Feature: User Authentication
  As a user
  I want to sign in and out
  So I can access my tasks

  Scenario: Successful login
    Given I am on the login page
    When I fill in "Email" with "test@example.com"
    And I fill in "Password" with "password123"
    And I click "Log in"
    Then I should see "Signed in successfully"

  Scenario: Failed login
    Given I am on the login page
    When I fill in "Email" with "wrong@example.com"
    And I fill in "Password" with "wrongpass"
    And I click "Log in"
    Then I should see "Invalid Email or password"