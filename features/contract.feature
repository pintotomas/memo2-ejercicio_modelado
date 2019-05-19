Feature: Contract modification
  In order to make changes to a contract
  As a user
  I want to be able to modify It if It has not been confirmed yet 

@wip
  Scenario: Modify unconfirmed contract
    Given I have created a contract 'contrato1' in '20190101' for 'artear' with content 'volver al futuro' for a monto of '10000'
    And with a license with '1' amount of repetitions, '1' repetition frequency for 'volver,canal13'
    When I modify the monto to '200000'
    Then the monto should have changed without problem