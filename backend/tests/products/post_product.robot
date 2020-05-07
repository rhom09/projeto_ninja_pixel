*** Settings ***
Documentation       Testes da Rota /products da Pixel API

Resource    ../../resources/services.robot

*** Test Cases ***
Create new product
    [Tags]          success
    # Token que está encapsulado em services.robot na keyword(Get Token)
    ${token}=       Get Token       papito@ninjapixel.com       pwd123
    # POST REQUEST NA API atraves da keyword(POST PRODUCT) encapsulada em services.robot
    ${resp}=        Post Product    dk.json                     ${token}
    # Validação
    Status Should Be    200     ${resp}

Required title
    [Tags]          bad_request
    ${token}=       Get Token       papito@ninjapixel.com       pwd123

    ${resp}=        Post Product    no_title.json               ${token}
    
    Status Should Be    400     ${resp}
    # Validação exata no campo certo
    Should Be Equal     ${resp.json()['msg']}       Oops! title cannot be empty

Required category
    [Tags]          bad_request
    ${token}=       Get Token       papito@ninjapixel.com       pwd123

    ${resp}=        Post Product    no_cat.json               ${token}
    
    Status Should Be    400     ${resp}    

    Should Be Equal     ${resp.json()['msg']}       Oops! category cannot be empty

Required price
    [Tags]          bad_request
    ${token}=       Get Token       papito@ninjapixel.com       pwd123

    ${resp}=        Post Product    no_price.json               ${token}
    
    Status Should Be    400     ${resp}    

    Should Be Equal     ${resp.json()['msg']}       Oops! price cannot be empty