*** Settings ***
Documentation       Testes da Rota /auth da Pixel API

Library     RequestsLibrary
Library     Collections

*** Test Cases ***
Request Token
    Create Session      pixel       Http://pixel-api:3333

    &{payload}=         Create Dictionary       email=papito@ninjapixel.com     password=pwd123
    &{headers}=         Create Dictionary       Content-Type=application/json

    ${resp}             Post Request    pixel   /auth   data=${payload}     headers=${headers}

    Status Should Be    200     ${resp}

Incorrect Password      
    Create Session      pixel       Http://pixel-api:3333

    &{payload}=         Create Dictionary       email=papito@ninjapixel.com     password=abc123
    &{headers}=         Create Dictionary       Content-Type=application/json

    ${resp}             Post Request    pixel   /auth   data=${payload}     headers=${headers}

    Status Should Be    401     ${resp}