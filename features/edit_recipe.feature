@javascript
Feature: Editing a Recipe
  In order to cook a tasty meal
  I want to be able to create, update and delete recipe data

  Scenario: Create Recipe
    Given I go to the home page
    And   I hit the button for "New Recipe"
    And   I fill in name text box with "Stewed Beef" 
    And   I fill in instructions text box with "Make it beefalicious!"
    And   I hit the button for "Save"
    When  I have searched for "beef"
    Then  I should see the text "Stewed Beef"

  Scenario: Edit Recipe
    

  Scenario: Delete Recipe