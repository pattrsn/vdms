Feature: Peer advisor can rank faculty on behalf of admits

  So that I can specify the meeting preferences of my admits
  As a peer advisor
  I want to rank the faculty on behalf of my admits

  Background: I am signed in as a peer advisor and my admits are registered
    Given I am registered as a "Peer Advisor"
    And I am signed in
    And the following "Admits" have been added:
      | first_name  | last_name  | email            | phone      | division               | area1                      | area2                |
      | First1      | Last1      | email1@email.com | 1234567891 | Computer Science       | Artificial Intelligence    | Theory               |
      | First2      | Last2      | email2@email.com | 1234567892 | Computer Science       | Human-Computer Interaction | Graphics             |
      | First3      | Last3      | email3@email.com | 1234567893 | Electrical Engineering | Integrated Circuits        | Physical Electronics |
    And the following "Faculty" have been added:
      | first_name  | last_name | email            | division               | area                |
      | Faculty     | Aaaa      | email1@email.com | Computer Science       | Theory              |
      | Faculty     | Cccc      | email2@email.com | Electrical Engineering | Integrated Circuits |
      | Faculty     | Bbbb      | email3@email.com | Computer Science       | Graphics            |

  Scenario: If the admit does not have any rankings entered, I am asked to select faculty to rank
    Given I am on the view admits page
    When I follow "Update Rankings"
    Then I should be on the select faculty page

  Scenario: I select new faculty to rank
    Given I am on the view admits page
    When I follow "Update Rankings"
    And I check "Faculty Aaaa"
    And I check "Faculty Cccc"
    And I press "Rank Hosts"
    Then I should be on the rank faculty page
    And I should see "Faculty Aaaa"
    And I should see "Faculty Cccc"

  Scenario: I rank some new faculty
    Given I am on the view admits page
    When I follow "Update Rankings"
    And I check "Faculty Aaaa"
    And I check "Faculty Cccc"
    And I press "Rank Hosts"
    And I rank the "first" faculty "2"
    And I rank the "second" faculty "1"
    And I press "Update Rankings"
    Then I should see "Visitor was successfully updated."
    And I should be on the rank faculty page

  Scenario: I give two faculty duplicate ranks
    Given I am on the view admits page
    When I follow "Update Rankings"
    And I check "Faculty Aaaa"
    And I check "Faculty Bbbb"
    And I press "Rank Hosts"
    And I rank the "first" faculty "2"
    And I rank the "second" faculty "2"
    And I press "Update Rankings"
    Then I should see "Ranks must be unique"
    And I should see "Faculty Aaaa"
    And I should see "Faculty Bbbb"

  Scenario: I give two faculty duplicate ranks twice
    Given I am on the view admits page
    When I follow "Update Rankings"
    And I check "Faculty Aaaa"
    And I check "Faculty Bbbb"
    And I press "Rank Hosts"
    And I rank the "first" faculty "2"
    And I rank the "second" faculty "2"
    And I press "Update Rankings"
    And I press "Update Rankings"
    Then I should see "Ranks must be unique"
    And I should see "Faculty Aaaa"
    And I should see "Faculty Bbbb"

  Scenario: I can view an admit's rankings
    Given my admit has the following faculty rankings:
      | rank | faculty      |
      | 1    | Faculty Aaaa |
      | 2    | Faculty Bbbb |
      | 3    | Faculty Cccc |
    And I am on the view admits page
    When I follow "Update Rankings"
    Then I should be on the rank faculty page
    And I should see "Faculty Aaaa"
    And I should see "Faculty Bbbb"
    And I should see "Faculty Cccc"

  Scenario: I see the admit's name
    Given my admit has the following faculty rankings:
      | rank | faculty      |
      | 1    | Faculty Aaaa |
      | 2    | Faculty Bbbb |
      | 3    | Faculty Cccc |
    And I am on the view admits page
    When I follow "Update Rankings"
    Then I should see "First1 Last1"

  Scenario: I add additional faculty rankings
    Given my admit has the following faculty rankings:
      | rank | faculty      |
      | 1    | Faculty Aaaa |
    And I am on the rank faculty page
    And I follow "Add"
    And I check "Faculty Cccc"
    And I press "Rank Hosts"
    And I rank the "first" faculty "2"
    And I rank the "second" faculty "1"
    And I press "Update Rankings"
    Then I should see "Visitor was successfully updated."
    And I should be on the rank faculty page

  Scenario: I change an admit's faculty rankings
    Given my admit has the following faculty rankings:
      | rank | faculty      |
      | 1    | Faculty Aaaa |
      | 2    | Faculty Bbbb |
      | 3    | Faculty Cccc |
    When I go to the rank faculty page
    And I rank the "first" faculty "2"
    And I rank the "second" faculty "1"
    And I press "Update Rankings"
    Then I should see "Visitor was successfully updated"
    And I should be on the rank faculty page

  Scenario: I remove an admit's faculty rankings
    Given my admit has the following faculty rankings:
      | rank | faculty      |
      | 1    | Faculty Aaaa |
      | 2    | Faculty Bbbb |
      | 3    | Faculty Cccc |
    When I go to the rank faculty page
    And I flag the "second" faculty for removal
    And I flag the "third" faculty for removal
    And I press "Update Rankings"
    Then I should see "Visitor was successfully updated"
    And I should see "Faculty Aaa"
    But I should not see "Faculty Bbb"
    And I should not see "Faculty Ccc"

  Scenario: The staff have disabled making further changes
    Given the staff have disabled peer advisors from making further changes
    When I go to the rank faculty page
    Then I should see "The Staff have disabled making further changes."
