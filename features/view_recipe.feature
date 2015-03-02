@javascript
Feature: Viewing a Recipe
  In order to cook a tasty meal
  I want to see the details of a given recipe

  Background:
    Given a recipe with name "Baked Potato w/ Cheese" and instructions "nuke for 20 minutes"
    And   a recipe with name "Baked Brussel Sprouts" and instructions "Slather in oil, and roast on high heat for 20 minutes"

  Scenario: Search and View Recipe
    Given I go to the home page
    And   I fill in keywords text box with "baked"
    And   I hit the button for "Search"
    When  I select "Baked Brussel Sprouts"
    Then  I should see the text "Baked Brussel Sprouts"
    And   I should see the text "Slather in oil"

  Scenario: View and Go Back
    Given I have searched for "baked"
    And   I select "Baked Brussel Sprouts"
    When  I hit the button for "Back"
    Then  I should see the text "Baked Brussel Sprouts"
    And   I should NOT see the text "Slather in oil"