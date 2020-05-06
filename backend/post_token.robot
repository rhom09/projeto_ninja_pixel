*** Settings ***
Library     Collections
Library     RequestsLibrary

*** Test Cases ***
Post Auth Token
    # Aqui eu crio uma sessão com nome pixel na url da api
    Create Session      pixel           http://pixel-api:3333
    # Monto um dicionario de dados para trabalhar com o payload e o headers
    # Porque o robot não trabalha nativamente com json como o javascript
    # Variavel com & serve para fazer um dicionario de dados
    &{payload}=     Create Dictionary   email=papito@ninjapixel.com     password=pwd123
    &{headers}=     Create Dictionary   Content-Type=application/json
    # Aqui eu faço um post request na sessão pixel com a rota auth
    # Data recebe o payload(dicionario)criado para comsumir as informações
    # Headers recebe o cabeçalho(header) da api
    ${resp}=            Post Request    pixel       /auth   data=${payload}     headers=${headers}
    # Validação
    Status Should Be    200     ${resp}

Unauthorized
    Create Session      pixel           http://pixel-api:3333
   
    &{payload}=     Create Dictionary   email=papito@ninjapixel.com     password=abc123
    &{headers}=     Create Dictionary   Content-Type=application/json
    
    ${resp}=            Post Request    pixel       /auth   data=${payload}     headers=${headers}
    Status Should Be    401     ${resp}    