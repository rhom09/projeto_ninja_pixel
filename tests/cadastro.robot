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

Nome não informado
    [Tags]      name
    [Template]          Tentativa de cadastro
    contra.json         Oops - Informe o nome do produto! 

Categoria não selecionada
    [Tags]      cat
    [Template]          Tentativa de cadastro
    goldenAxe.json      Oops - Selecione uma categoria! 

preço não informado
    [Tags]      price
    [Template]          Tentativa de cadastro
    streetFII.json      Oops - Informe o preço também!

*** Keywords ***
# Crio uma keyword que servirá de template para todos e chamo em cada um deles
Tentativa de cadastro
    [Arguments]     ${file_name}        ${expect_message}

    Dado que eu tenho um novo produto           ${file_name}
    Quando eu faço o cadastro desse produto
    Então devo ver uma mensagem informativa     ${expect_message} 