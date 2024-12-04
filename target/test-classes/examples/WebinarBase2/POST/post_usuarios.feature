Feature: Praticando karate framework com API Serverest

  Background:
    * url url

    #Teste de criação de usuário com e-mail incremental
    # Inicializa o identificador base com um valor padrão se ainda não existir
    # * if (!karate.get('emailNumero')) karate.set('emailNumero', 0)

    # Carregar o arquivo JSON que contém o número do e-mail externo
    * def emailInfo = read('classpath:examples/WebinarBase2/POST/json/emailInfo.json')

  @ignore
  Scenario: cadastrar usuarios com sucesso unico
    * def body =
    """
     {
        "nome": "LEONARDO HILARIO",
        "email": "hilarioleozinho@gmail.com",
        "password": "teste",
        "administrador": "true"
      }
    """

    Given  path "/usuarios"
    And request body
    When method POST
    Then status 201
    And match response.message == "Cadastro realizado com sucesso"


  Scenario: cadastrar usuarios com sucesso
    * def body =
    """
     {
        "nome": "LEONARDO HILARIO",
        "email": "hilarioleozinho@gmail.com",
        "password": "teste",
        "administrador": "true"
      }
    """

    Given  path "/usuarios"
    And request body
    When method POST
    Then status 400
    And match response.message == "Este email já está sendo usado"

  #@testUnico
  Scenario: cadastrar usuarios com sucesso com body em arquivo json

    #Randomico com varios caracteres
   * def now = function(){ return java.lang.System.currentTimeMillis() }

    #Numero radomico entre 1 e 10 aleatorio
    #* def now = function(){ return Math.floor(Math.random() * 10) }

    * def body = read("classpath:/examples/WebinarBase2/POST/json/usuario.json")
    * set body.nome = "Gessica"
    * set body.email = "hilarioleo+" + now() + "+@gmail.com"
    * print body.email
    * set body.password = "123456"
    * set body.administrador = "true"

    Given  path "/usuarios"
    And request body
    When method POST
    Then status 201
    And match response.message == "Cadastro realizado com sucesso"

  #@testUnico
  Scenario: Teste de criação de usuário com e-mail incremental / nao funcionou!!!!!!tentar novamente

   # Incrementa o número do e-mail
    * def novoEmailNumero = karate.get('emailNumero') + 1
    * karate.set('emailNumero', novoEmailNumero)

    # Construa o e-mail dinamicamente
    * def email = 'hilarioleo' + karate.get('emailNumero') + '@gmail.com'
    * print 'E-mail gerado:', email

    # Cria o corpo da requisição utilizando o e-mail
    * def body =
    """
    {
      nome: 'Gessica',
      email: email,
      password: '123456',
      administrador: 'true'
    }
    """

    * print 'Corpo da requisição:', body

    Given path "/usuarios"
    And request body
    When method POST
    Then status 201
    And match response.message == "Cadastro realizado com sucesso"

  @testUnico
  Scenario: Teste de criação de usuário com e-mail arquivo externo / nao funcionou!!!!!!tentar novamente

   # Incrementa o número do e-mail
    * def novoEmailNumero = emailInfo.emailNumero + 1
    * emailInfo.emailNumero = novoEmailNumero

    # Salva as alterações no arquivo JSON
    * karate.write(emailInfo, 'target/classes/examples/WebinarBase2/POST/json/emailInfo.json')

    # Cria o e-mail dinamicamente com o número incrementado
    * def email = 'hilarioleo' + emailInfo.emailNumero + 'gmail.com'
    * print 'E-mail gerado:', email

    # Cria o corpo da requisição utilizando o e-mail
    * def body =
    """
    {
      nome: 'Gessica',
      email: email,
      password: '123456',
      administrador: 'true'
    }
    """

    * print 'Corpo da requisição:', body

    Given path "/usuarios"
    And request body
    When method POST
    Then status 201
    And match response.message == "Cadastro realizado com sucesso"