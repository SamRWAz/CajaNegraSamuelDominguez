Feature: Yo como tester quiero probar la funcionalidad de interruptor inteligente

  Background:
    * url 'https://statemachine--maria7221.replit.app/api/'

  Scenario: Verificar el estado del interruptor en un momento dado
    Given path 'switch/state'
    And headers { 'Content-Type': 'application/json', 'Accept': 'application/json' }
    When method GET
    Then status 200
    * print 'Estado actual del interruptor:', response.state

  @smokeTest
  Scenario: Verificar que el interruptor acepta solicitudes
    Given path 'switch/state'
    And headers { 'Content-Type': 'application/json', 'Accept': 'application/json' }
    When method GET
    Then status 200
    * print 'Get status:', responseStatus

  @ignore @doOn
  Scenario: Do Turn On
    Given path 'switch/on'
    And headers { 'Content-Type': 'application/json', 'Accept': 'application/json', 'Content-Length': '0' }
    When method POST
    Then status 200
    * print 'Response status when state is Off and do On:', responseStatus
    * match response == { state: 'on' }

  @ignore @invalidTransicion @invalidtransicionDoOn
  Scenario: Do Turn On when already On
    Given path 'switch/on'
    And headers { 'Content-Type': 'application/json', 'Accept': 'application/json', 'Content-Length': '0' }
    When method POST
    Then status 409
    * print 'Response status when state is On and do On:', responseStatus
    * match response contains { error: 'Invalid transition: the switch is already on' }

  @startOn
  Scenario: Verificar que el interruptor pueda encenderse
    * def getStatus = karate.call('@smokeTest')
    * def currentState = getStatus.response.state
    * print 'Estado previo:', currentState
    * if (currentState == 'off') karate.call('@doOn')
    * if (currentState == 'on') karate.call('@invalidtransicionDoOn')