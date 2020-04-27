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

*** Test Cases ***
Disponibilizar produto
    Dado que eu estou logado
    # Os três pontinhos representam uma continuação da keyword(step)
    # Especificação com o robot junto
    E que eu tenho um novo produto
    ...     Donkey Kong     Super Nintendo  49.99   Um jogo muito divertido!
    Quando eu faço o cadastro desse produto
    Devo ver este item no catálogo

*** Keywords ***
Dado que eu estou logado
    Login With  papito@ninjapixel.com  pwd123

# Passo a massa de teste com o [Arguments]
E que eu tenho um novo produto
    [Arguments]     ${name}     ${category}     ${price}     ${desc}
    
    Set Test Variable   ${name}
    Set Test Variable   ${price}
    Set Test Variable   ${desc}

Quando eu faço o cadastro desse produto
    Click Element                       class:product-add
    Input Text                          css:input[name=title]           ${name}
    Input Text                          css:input[name=price]           ${price}
    Input Text                          css:textarea[name=description]  ${desc}                    