*** Settings ***
Documentation       Pixel Api GET /products

Resource    ../../resources/services.robot

*** Test Cases ***
Get Unique Product
    [Tags]      success

    ${token}=       Get Token       papito@ninjapixel.com       pwd123
    ${payload}=     Get Json        get_unique.json
    ${product}=     Post Product    ${payload}                  ${token}

    ${id}=          Convert To String   ${product.json()['id']}
    ${resp}=        Get Product         ${id}   ${token}

    Status Should Be    200     ${resp}

    Should Be Equal     ${resp.json()['title']}     ${payload['title']}

# Para testar sem id existente passamos somente o token e get request com um id qualquer
Product Precondition Failed
    [Tags]      precondition_failed    

    ${token}=       Get Token       papito@ninjapixel.com       pwd123

    ${resp}=        Get Product         9999   ${token}

    Status Should Be    412     ${resp}