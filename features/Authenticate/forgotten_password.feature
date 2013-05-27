Feature: Forgotten Password
  In order to recuperate a password when forgiven
  As a user
  I want to be able to retrieve it

  Background:
    Given I exist as a user
    And I am not logged in
    And I am on the forgotten password page

  Scenario: Using a valid email
    When I fill in "user_email" with "tests@inovitex.com"
    And I press "Envoyer les instructions"
    Then "tests@inovitex.com" should receive an email
    When I open the email
    Then I should see "Change my password" in the email body
    When I follow "Change my password" in the email
    Then I should see "Modifiez votre mot de passe"

  Scenario: Using an invalid email
    When I fill in "user_email" with "test@inovitex.com"
    And I press "Envoyer les instructions"
    Then I should see "Email not found"