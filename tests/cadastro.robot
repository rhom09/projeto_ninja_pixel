*** Settings ***
Documentation       Cadastro de produtos
...         Sendo um administrador de catálogo
...         Quero cadastrar produtos
...         Para que eu possa disponibiliza-los na loja virtual

Resource    ../resources/actions.robot

# Abre(e faz login) e fecha o navegador importando de actions.robot
Suite Setup     Login Session
Suite Teardown  Close Session

Test Teardown   After Test 

*** Test Cases ***
Disponibilizar produto
    # Massa de teste vinda da coleção feita com json 
    Dado que eu tenho um novo produto   dk.json
    Quando eu faço o cadastro desse produto
    Então devo ver este item no catálogo

Produto duplicado
    [Tags]      dup
    Dado que eu tenho um novo produto   master.json
    Mas este produto já foi cadastrado
    Quando eu faço o cadastro desse produto
    Então devo ver a mensagem de alerta     Oops - Este produto já foi cadastrado!

Nome não informado
    [Tags]      nome
    Dado que eu tenho um novo produto   contra.json
    Quando eu faço o cadastro desse produto
    Então devo ver uma mensagem informativa     Oops - Informe o nome do produto! 

Categoria não selecionada
    [Tags]      cat
    Dado que eu tenho um novo produto   goldenAxe.json
    Quando eu cadastro sem categoria
    Então devo ver uma mensagem informativa     Oops - Selecione uma categoria! 

preço não informado
    [Tags]      preco
    Dado que eu tenho um novo produto   streetFII.json
    Quando eu faço o cadastro desse produto
    Então devo ver uma mensagem informativa     Oops - Informe o preço também!               