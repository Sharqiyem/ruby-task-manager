Feature: Task Management
  As a user
  I want to manage tasks
  So I can organize my work

  Background:
    Given I am logged in as "test@example.com" with password "password123"

  Scenario: Create a new task
    When I visit the tasks page
    And I click "New Task"
    And I fill in "Title" with "Finish project"
    And I select "High" from priority
    And I click "Create Task"
    Then I should see "Task was successfully created"

  Scenario: View my tasks
    Given I have a task "Write tests"
    When I visit the tasks page
    Then I should see "Write tests"


Scenario: Edit an existing task
  Given I have a task "Original task"
  When I visit the tasks page
  And I click "Edit" for "Original task"
  And I fill in "Title" with "Updated task"
  And I click "Update Task"
  Then I should see "Task was successfully updated"
  And I should see "Updated task"

Scenario: Delete a task
  Given I have a task "Task to delete"
  When I visit the tasks page
  And I click "Delete" for "Task to delete"
  And I confirm the deletion
  Then I should see "Task was successfully destroyed"
  And I should not see "Task to delete"

Scenario: Change task status via drag and drop
  Given I have a task "Draggable task" with status "todo"
  When I drag "Draggable task" to the "in_progress" column
  Then I should see "Draggable task" in the "in_progress" column

Scenario: View task history
  Given I have a task "Historical task"
  When I change the status from "todo" to "in_progress"
  And I visit the task details page
  Then I should see the status change in the history log