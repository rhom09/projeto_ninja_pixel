*** Settings ***
Documentation   Actions é o arquivo que terá as keywords que implementam os steps

Library    SeleniumLibrary

*** Keywords ***

Dado que eu acesso a página de login
    Open Browser    http://pixel-web:3000/login    chrome

Quando eu submeto minhas credenciais "${email}" e "${pass}"
    Input Text       id:emailId    ${email}
    Input Text       id:passId     ${pass}
    Click Element    class:btn

Então devo ser autenticado
    Wait Until Page Contains    Papito    
# Passamos um argumento(massa de teste), como parametro na keyword
Então devo ver uma mensagem de alerta "${expect_message}"
    Wait Until Element Contains    class:alert     ${expect_message} 