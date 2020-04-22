*** Settings ***
Documentation    Login
...              Sendo um administrador de catálogo
...              Quero me autenticar no sistema
...              Para que eu possa gerenciar o catálogo de produtos

Library    SeleniumLibrary


*** Test Cases ***
Login com sucesso
    Dado que eu acesso a página de login
    Quando eu submeto minhas credenciais "papito@ninjapixel.com" e "pwd123"
    Então devo ser autenticado

Senha incorreta
    Dado que eu acesso a página de login
    Quando eu submeto minhas credenciais "papito@ninjapixel.com" com senha incorreta
    Então devo ver uma mensagem de alerta "Usuário e/ou senha inválidos"    

*** Keywords ***
Dado que eu acesso a página de login
    Open Browser    http://pixel-web:3000/login    chrome

Quando eu submeto minhas credenciais "${email}" e "${pass}"
    Input Text       id:emailId    ${email}
    Input Text       id:passId     ${pass}
    Click Element    class:btn

Então devo ser autenticado
    Wait Until Page Contains    Papito
    Close Browser

Quando eu submeto minhas credenciais "${email}" com senha incorreta
    Input Text       id:emailId    ${email}
    Input Text       id:passId     123456
    Click Element    class:btn

Então devo ver uma mensagem de alerta "${msg}"
    Wait Until Page Contains    ${msg}
    Close Browser               