*** Settings ***
Documentation   Actions é o arquivo que terá as keywords que implementam os steps

Library    SeleniumLibrary
# Importa ações do Browser
Resource    pages/basePage.robot
# Importa o login with para actions
Resource    pages/loginPage.robot

*** Keywords ***

Dado que eu acesso a página de login
    Open Session

Quando eu submeto minhas credenciais "${email}" e "${pass}"
    Login With  ${email}  ${pass}

Então devo ser autenticado
    Wait Until Page Contains    Papito    
# Passamos um argumento(massa de teste), como parametro na keyword
Então devo ver uma mensagem de alerta "${expect_message}"
    Wait Until Element Contains    class:alert     ${expect_message} 