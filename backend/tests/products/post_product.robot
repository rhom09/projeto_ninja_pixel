*** Settings ***
Documentation       Pixel Api POST /products
Resource    ../../resources/services.robot

*** Test Cases ***
Create new product
    [Tags]          success
    # Token que está encapsulado em services.robot na keyword(Get Token)
    ${token}=       Get Token       papito@ninjapixel.com       pwd123
    # Encapsulado e convertido na Keyword(GET JSON), na camada services.robot
    ${payload}=     Get Json        dk.json

    # POST REQUEST NA API atraves da keyword(POST PRODUCT) encapsulada em services.robot
    ${resp}=        Post Product    ${payload}                  ${token}
    # Validação
    Status Should Be    200     ${resp}

### DESAFIO ###
Duplicated Product
    [Tags]          conflict    

    ${token}=       Get Token       papito@ninjapixel.com       pwd123
    ${payload}=     Get Json        dk.json
    # Aqui eu chamo a nova keyword(Product Existing), criada na camada services.robot
    ${resp}=        Product Existing    ${payload}                  ${token}

    Status Should Be    409     ${resp}

Required title
    [Tags]          bad_request
    ${token}=       Get Token       papito@ninjapixel.com       pwd123

    ${payload}=     Get Json        no_title.json
    ${resp}=        Post Product    ${payload}                  ${token}
    
    Status Should Be    400     ${resp}
    # Validação exata no campo certo
    Should Be Equal     ${resp.json()['msg']}       Oops! title cannot be empty

Required category
    [Tags]          bad_request
    ${token}=       Get Token       papito@ninjapixel.com       pwd123

    ${payload}=     Get Json        no_cat.json
    ${resp}=        Post Product    ${payload}                  ${token}
    
    Status Should Be    400     ${resp}    

    Should Be Equal     ${resp.json()['msg']}       Oops! category cannot be empty

Required price
    [Tags]          bad_request
    ${token}=       Get Token       papito@ninjapixel.com       pwd123

    ${payload}=     Get Json        no_price.json
    ${resp}=        Post Product    ${payload}                  ${token}
    
    Status Should Be    400     ${resp}    

    Should Be Equal     ${resp.json()['msg']}       Oops! price cannot be empty