*** Settings ***
Documentation       Pixel Api GET /products

Resource    ../../resources/services.robot

*** Test Cases ***
Get Unique Product

    ${token}=       Get Token       papito@ninjapixel.com       pwd123
    ${payload}=     Get Json        get_unique.json
    ${product}=     Post Product    ${payload}                  ${token}

    ${id}=          Convert To String   ${product.json()['id']}

    ${resp}=        Get Product     ${id}   ${token}

    Status Should Be    200     ${resp}

    Should Be Equal     ${resp.json()['title']}     ${payload['title']}