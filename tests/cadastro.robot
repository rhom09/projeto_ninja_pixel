*** Settings ***
Documentation       Cadastro de produtos
...         Sendo um administrador de catálogo
...         Quero cadastrar produtos
...         Para que eu possa disponibiliza-los na loja virtual

Library     SeleniumLibrary

Resource    ../resources/actions.robot

# Abre e fecha o navegador importando de actions.robot
Test Setup      Open Session
Test Teardown   Close Session

*** Variables ***
# Quando vamos trabalhar com coleção usamos o &(e comercial)
# Ela vai preencher a massa de teste do step
&{dk}       name=Donkey Kong    cat=Super Nintendo  price=49.99     desc=Um jogo muito divertido!

*** Test Cases ***
Disponibilizar produto
    Dado que eu estou logado
    # Massa de teste vinda da coleção como argumento 
    Quando eu faço o cadastro desse produto     ${dk}
    Devo ver este item no catálogo

*** Keywords ***
Dado que eu estou logado
    Login With  papito@ninjapixel.com  pwd123

# Passo a massa de teste com o [Arguments]
# Passo a coleção para dentro da variavel ${product}
Quando eu faço o cadastro desse produto
    [Arguments]     ${product}

    Click Element                       class:product-add
    # Aqui eu passo o nome da variavel mais o valor dela no caso name
    Input Text                          css:input[name=title]           ${product['name']}
    Input Text                          css:input[name=price]           ${product['price']}
    Input Text                          css:textarea[name=description]  ${product['desc']}