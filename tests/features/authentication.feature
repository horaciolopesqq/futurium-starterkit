Feature: User authentication
  In order to protect the integrity of the website
  As a product owner
  I want to make sure only authenticated users can access the site administration

@javascript
Scenario: Anonymous user can see the user login page
  Given I am not logged in
  When I visit "user"
  Then I should see the text "Username"
  And I should see the text "Password"
  But I should not see the text "Log out"
  And I should not see the text "My account"

@javascript
Scenario: All main pages are visible
  Given I am not logged in
  When I visit "/"
  Then I should see the text "Futures"
  And I should see the text "Ideas"
  And I should see the text "Library"
  And I should see the text "Events"
  But I should not see the text "Stats"
