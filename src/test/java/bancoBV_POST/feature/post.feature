@feature @regressivo
Feature: POST

  Background:
    * def auth = call read("classpath:examples/bancoBV/auth/auth_mostrando_dados_sensiveis.feature@token")
    * def headers = read("classpath:examples/bancoBV/support/headers/headers.yaml")
    * def yaml = call read("classpath:examples/bancoBV/feature/yaml/" + env + "/cliente.yaml")
    * def body = call read("classpath:bancoBV_POST/feature/payload/payload_de_sucesso.json")

  @bancoBV
  Scenario Outline:<status_code> POST
    * def cpf = <cpf>
    * def valor = <valor>
    * def vencimento = <vencimento>

    Given url bancoBV_auth_post
    And path "/v2/consulta"
    And headers headers.headers.POST
    And headers Authorization = "Bearer" + auth.response.access.token
    And request bory
    When method POST
    Then status <status_code>

    Examples:
      |  | status_code |  | cpf              | valor | vencimento   |
      |  | 200         |  | yaml.cliente_cpf | 100   | "2024-12-25" |
