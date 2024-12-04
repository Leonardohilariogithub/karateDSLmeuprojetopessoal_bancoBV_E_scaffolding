
@auth @regressivo
Feature: Autenticação passando dados sensiveis(client id e secret)

  Background:
    * def headers = read("classpath:bv/com/bv/support/data/headers.yaml")
    * def yaml = read("classpath:examples/bancoBV_GET/pasta/auth.yaml")

  @token
  Scenario Outline:<status_code>

    Given url bancoBV_auth
    And path "auth/oauth/v2/token_jwt"

    And form field client_id = yaml.client_id
    And form field client_secret = yaml.client_secret
    And form field grant_type = yaml.grant_type
    And form field username = yaml.username
    And request {}
    When method POST
    Then status <status_code>
    #* if (responseStatus != 200) karate.abort()
    And match response contains {"acess_token": "#notnull"}

    Examples:
      | status_code |
      | 200         |
