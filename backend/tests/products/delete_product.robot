*** Settings ***
Documentation       Pixel Api DELETE /products

Resource    ../../resources/services.robot

*** Test Cases ***
Delete Unique Product
    [Tags]      success

    ${token}=       Get Token       papito@ninjapixel.com       pwd123
    ${payload}=     Get Json        get_unique.json
    ${product}=     Post Product    ${payload}                  ${token}

    ${id}=          Convert To String   ${product.json()['id']}
    ${resp}=        Delete Product      ${id}   ${token}

    Status Should Be    204     ${resp}