*** Settings ***
Documentation       Pixel Api GET /products

Resource    ../../resources/services.robot

*** Test Cases ***
Get Unique Product

    ${token}=       Get Token       papito@ninjapixel.com       pwd123
    ${product}=     Post Product    get_unique.json             ${token}

    ${id}=          Convert To String   ${product.json()['id']}

    ${resp}=        Get Product     ${id}   ${token}

    Status Should Be    200     ${resp}

    Should Be Equal     ${resp.json()['title']}     GameBoy