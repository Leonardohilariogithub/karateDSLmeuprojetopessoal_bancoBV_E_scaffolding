Feature:

  Background:
    * def urlBase = "https://fakerestapi.azurewebsites.net/"
    * def headers = read("classpath:examples/marcosCunhaAllTests/config/headers.yaml")
    * def body = read("classpath:/examples/marcosCunhaAllTests/json/json.json")

  Scenario:
    Given url urlBase
    And path "/api/v1/Users"
    And headers headers.headers_POST
    And request body
    When method POST
    Then assert responseStatus == 200 || responseStatus == 204 || responseStatus == 415
    And match response != 'Error'
    * if (responseStatus != 200 || responseStatus == 204 || responseStatus == 415) karate.abort()


    #And match response.message == ""
