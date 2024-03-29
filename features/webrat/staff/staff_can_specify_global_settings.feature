Feature: Staff can specify global settings

  So that the app has enough information to produce useful results
  As a staff
  I want to specify app-wide settings

  Background: I am signed in as a staff
    Given I am registered as a "Staff"
    And I am signed in

  Scenario: I can specify global settings
    Given I am on the staff dashboard page
    When I follow "Update Settings"
    Then I should be on the update settings page

  Scenario: I specify the meeting time ranges
    Given I am on the update settings page
    When I add "January 1, 2011 10:00AM" to "12:00PM" to the meeting times
    And I add "January 1, 2011 1:00PM" to "2:00PM" to the meeting times
    And I press "Update Settings"
    Then I should see "Settings were successfully updated."

  Scenario: I remove a meeting time range
    Given the event has the following meeting times:
      | begin           | end              |
      | 1/1/2000 9:00AM | 1/1/2000 12:00PM |
      | 1/1/2000 2:00PM | 1/1/2000 3:00PM  |
    And I am on the update settings page
    When I remove the meeting time beginning with "1/1/2000 9:00AM"
    And I press "Update Settings"
    Then I should see "Settings were successfully updated."
    And there should not be a meeting time beginning with "1/1/2000 9:00AM"

  Scenario: I specify the threshold number of meetings for an admit to be unsatisfied
    Given I am on the update settings page
    When I fill in "Unsatisfied Admit Threshold" with "5"
    And I press "Update Settings"
    Then I should see "Settings were successfully updated."
    And the "Unsatisfied Admit Threshold" field should contain "5"

  Scenario: I prevent faculty and peer advisors from making further changes to availabilities and rankings
    Given I am on the update settings page
    When I check "Prevent Peer Advisors from changing Admits' availability and rankings"
    And I check "Prevent Faculty from changing their availability and rankings"
    And I press "Update Settings"
    Then I should see "Settings were successfully updated."

  Scenario: I update the scheduler weights
    Given I am on the update settings page
    When I select "20" from "Faculty Weight"
    And I select "5" from "Admit Weight"
    And I select "10" from "Rank Weight"
    And I select "20" from "Mandatory Weight"
    And I press "Update Settings"
    Then I should see "Settings were successfully updated."
