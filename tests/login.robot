*** Settings ***
Documentation    Login
...              Sendo um administrador de catálogo
...              Quero me autenticar no sistema
...              Para que eu possa gerenciar o catálogo de produtos

Library    SeleniumLibrary
# Gancho que é executado toda vez que um caso de teste termina
Test Teardown   Close Browser


*** Test Cases ***
Login com sucesso
    Dado que eu acesso a página de login
    Quando eu submeto minhas credenciais "papito@ninjapixel.com" e "pwd123"
    Então devo ser autenticado

Senha incorreta
    # Cria um template da keyword com os argumentos e nele passo os argumentos criados
    [Template]      Tentativa de login
    papito@ninjapixel.com   abc123      Usuário e/ou senha inválidos

Email não existe
    [Template]      Tentativa de login
    404@yahoo.com   abc123      Usuário e/ou senha inválidos

Email obrigatório
    [Template]      Tentativa de login
    ${EMPTY}   abc123      Opps. Informe o seu email!

Senha obrigatória
    [Template]      Tentativa de login
    404@yahoo.com   ${EMPTY}      Opps. Informe a sua senha!

*** Keywords ***
# Keyword documentada, ela vai ter a implementação das steps dentro dela
# Ela implementa o comportamento inteiro de tentativas de login
Tentativa de login
    [Arguments]     ${email}    ${pass}     ${output}
    Dado que eu acesso a página de login
    Quando eu submeto minhas credenciais "${email}" e "${pass}"
    Então devo ver uma mensagem de alerta "${output}"

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