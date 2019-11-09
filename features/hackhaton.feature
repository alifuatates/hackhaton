Feature: kloia.com contact form

  @done
  Scenario: kloia.com fill contact form
    Given user visit homepage
    And fill "First name" with "kloia" at kloia
    And fill "Last name" with "Team-2" at kloia
    And fill "Company name" with "has kloia" at kloia
    And fill "Email*" with "team2@gmail.com" at kloia
    And click type "css" value ".hs-button.primary.large" web elementt
    Then page should contain "Thanks for your message. We'll be in contact shortly." content at kloia
