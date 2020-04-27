*** Settings ***
Documentation       Cadastro de produtos
...         Sendo um administrador de catálogo
...         Quero cadastrar produtos
...         Para que eu possa disponibiliza-los na loja virtual

Library     SeleniumLibrary

Resource    ../resources/actions.robot
# Biblioteca que dá acesso ao sistema oprarcional
Library     OperatingSystem

# Abre e fecha o navegador importando de actions.robot
Test Setup      Open Session
Test Teardown   Close Session

*** Test Cases ***
Disponibilizar produto
    Dado que eu estou logado
    # Massa de teste vinda da coleção feita com json 
    Quando eu faço o cadastro desse produto     dk.json
    Devo ver este item no catálogo

*** Keywords ***
Dado que eu estou logado
    Login With  papito@ninjapixel.com  pwd123

# Passo a massa de teste com o [Arguments]
# Passo a coleção vinda do arquivo JSON para dentro da variavel ${json_file}
Quando eu faço o cadastro desse produto
    [Arguments]     ${json_file}
    # Crio uma variavel e nela chamo o GET FILE(Biblioteca OperatingSystem)
    # E passo o caminho da arquivo json, que já está setado na variavel ${json_file}
    ${product_file}=    Get File    tests/fixtures/${json_file}
    # E converto ele em json para pode carregar o valor do arquivo
    ${product_json}=     Evaluate    json.loads($product_file)   json

    Click Element                       class:product-add
    # Aqui eu passo o nome da variavel mais o valor dela no caso name
    Input Text                          css:input[name=title]           ${product_json['name']}
    Click Element                       css:input[placeholder=Gategoria]
    Click Element                       xpath://span[text()='${product_json['cat']}']
    Input Text                          css:input[name=price]           ${product_json['price']}
    Input Text                          css:textarea[name=description]  ${product_json['desc']}
    sleep   5