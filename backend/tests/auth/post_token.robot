*** Settings ***
Documentation       Testes da Rota /auth da Pixel API

Resource    ../../resources/services.robot

*** Test Cases ***
Request Token
    # A ação da chamada está toda encapsulada na camada services.robot na keyword(POST TOKEN)
    ${resp}             Post Token      papito@ninjapixel.com       pwd123

    Status Should Be    200     ${resp}

Incorrect Password      
    ${resp}             Post Token      papito@ninjapixel.com       abc123

    Status Should Be    401     ${resp}