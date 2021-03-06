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
    Então devo ver uma mensagem de erro     Oops - Este produto já foi cadastrado!