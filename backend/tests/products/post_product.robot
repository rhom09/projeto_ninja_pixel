*** Settings ***
Documentation       Testes da Rota /products da Pixel API

Library     RequestsLibrary
Library     Collections
Library     OperatingSystem

*** Test Cases ***
Create new product
    Create Session      pixel       Http://pixel-api:3333

    ### PEGANDO O TOKEN DE AUTH ###
    &{payload}=         Create Dictionary       email=papito@ninjapixel.com     password=pwd123
    &{headers}=         Create Dictionary       Content-Type=application/json

    ${resp}             Post Request    pixel   /auth   data=${payload}     headers=${headers}
    # Cria uma variavel para armazenar o token e pode usar para autorizar o post product
    ${token}            Convert To String       ${resp.json()['token']}

    ### PAYLOAD VINDO DO ARQUIVO JSON ###
    # get file(keyword) para carregar arquivos em memorias, e como é GET sempre vai retornar algo
    # Por isso guardamos em uma variavel(${file})
    ${file}=            Get File        ${EXECDIR}/resources/fixtures/dk.json
    # Como API aceita o formato json nós convertemos o $file em json para mandar para a API
    ${payload}=         evaluate        json.loads($file)   json

    # Headers com content-type e authorization
    &{headers}=         Create Dictionary       Content-Type=application/json   Authorization=JWT ${token}

    # POST REQUEST NA API
    ${resp}             Post Request    pixel   /products   data=${payload}     headers=${headers}
    # Validação
    Status Should Be    200     ${resp}