*** Settings ***
Documentation   Aqui nós vamos encapsular algumas chamadas de serviços

Library     RequestsLibrary
Library     Collections
Library     OperatingSystem

Library     libs/db.py

*** Keywords ***
### Helpers ###
# Coverter o arquivo json
Get Json
    [Arguments]     ${json_file}

    ### PAYLOAD VINDO DO ARQUIVO JSON ###
    # get file(keyword) para carregar arquivos em memorias, e como é GET sempre vai retornar algo
    # Por isso guardamos em uma variavel(${file})
    ${file}=         Get File        ${EXECDIR}/backend/resources/fixtures/${json_file}
    # Como API aceita o formato json nós convertemos o $file em json para mandar para a API
    ${json}=         evaluate        json.loads($file)   json

    [Return]    ${json}


Get Token
    [Arguments]     ${email}        ${pass}
    
    # Essa variavel armazena a keyword(POST TOKEN) e salva seu resultado  
    ${resp}         Post Token      ${email}        ${pass}

    # Cria uma variavel para armazenar o token e poder usar para autorizar o post product
    # E retorno ele lá em post_product
    ${token}            Convert To String       ${resp.json()['token']}
    [Return]            ${token}

# Keyword que faz a chamada post para obter o token
Post Token   
    [Arguments]     ${email}        ${pass}

    Create Session      pixel       Http://pixel-api:3333

    ### PEGANDO O TOKEN DE AUTH ###
    &{payload}=         Create Dictionary       email=${email}     password=${pass}
    &{headers}=         Create Dictionary       Content-Type=application/json

    ${resp}             Post Request    pixel   /auth   data=${payload}     headers=${headers}
    [Return]            ${resp}

# Keyword para encapsular o post product
Post Product
    [Arguments]     ${payload}    ${token}

    # Remove os dados do DB
    Remove Product By Title             ${payload['title']}

    # Headers com content-type e authorization
    &{headers}=         Create Dictionary       Content-Type=application/json   Authorization=JWT ${token}

    ${resp}             Post Request    pixel   /products   data=${payload}     headers=${headers}
    [Return]            ${resp}

# Nova Keyword criada para atender ao DESAFIO!!!
# Implementei uma keyword dentro da outra, assim essa keyword não ficará dependente de outra
Product Existing   

    [Arguments]     ${payload}    ${token}

    Post Product    ${payload}   ${token}

    &{headers}=         Create Dictionary       Content-Type=application/json   Authorization=JWT ${token}

    ${resp}             Post Request    pixel   /products   data=${payload}     headers=${headers}
    [Return]            ${resp}

### GET ###
Get Product
    [Arguments]     ${id}       ${token}

    Create Session      pixel       Http://pixel-api:3333    

    &{headers}=         Create Dictionary       Content-Type=application/json   Authorization=JWT ${token}

    ${resp}             Get Request    pixel    /products/${id}     headers=${headers}
    [Return]    ${resp}

Delete Product    
    [Arguments]     ${id}       ${token}

    Create Session      pixel       Http://pixel-api:3333    

    &{headers}=         Create Dictionary       Content-Type=application/json   Authorization=JWT ${token}

    ${resp}             Delete Request    pixel    /products/${id}     headers=${headers}
    [Return]    ${resp}




