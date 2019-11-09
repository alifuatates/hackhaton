Feature: kloia.com contact form

  @done
  Scenario: kloia.com fill contact form
    Given user visit homepage
    And fill "First name" with "kloia"
    And fill "Last name" with "Team-2"
    And fill "Company name" with "has kloia"
    And fill "Email*" with "team2@gmail.com"
    And click Submit button
    Then page should contain "Thanks for your message. We'll be in contact shortly." content
