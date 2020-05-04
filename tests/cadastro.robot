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
    # Massa de teste vinda da coleção feita com json 
    Quando eu faço o cadastro desse produto     dk.json
    Então devo ver este item no catálogo