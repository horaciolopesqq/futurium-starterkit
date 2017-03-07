Feature: User authentication
  In order to protect the integrity of the website
  As a product owner
  I want to make sure only authenticated users can access the site administration

Scenario: Anonymous user can see the user login page
  Given I am not logged in
  When I visit "user"
  Then I should see the text "Username"
  And I should see the text "Password"
  But I should not see the text "Log out"
  And I should not see the text "My account"

Scenario: All main pages are visible
  Given I am not logged in
  When I visit "/"
  Then I should see the text "Futures"
  And I should see the text "Ideas"
  And I should see the text "Library"
  And I should see the text "Events"
  But I should not see the text "Stats"

Scenario: All main pages are accessible for anonymous, except the stats page
  Given I am not logged in
  Given I am on the homepage
  Then I should see the text "Futures" in the "main_menu" region
  Then I should see the text "Ideas" in the "main_menu" region
  Then I should see the text "Library" in the "main_menu" region
  Then I should see the text "Events" in the "main_menu" region
  And I should not see the text "Stats" in the "main_menu" region

@api
Scenario: Administrators can see the stats page
  Given I am logged in as a user with the "administrator" role
  Given I am on the homepage
  Then I should see the text "Stats" in the "main_menu" region
  And I visit "/analytics"
  Then I should see the heading "Site analytics" in the "content" region

