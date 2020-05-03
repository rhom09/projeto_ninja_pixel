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
    Então devo ver este item no catálogo

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

    # Keyword para deletar o produto do DB
    Delete Product By Name      ${product_json['name']}

    # Clica no botão add produto
    Click Element                       class:product-add
    # Aqui eu passo o nome da variavel mais o valor dela no caso name
    Input Text                          css:input[name=title]           ${product_json['name']}
    # Clica em categoria
    Click Element                       css:input[placeholder=Gategoria]
    # Espera que o elemento esteja visivel para pode clicar
    Wait Until Element Is Visible       class:el-select-dropdown__list
    Click Element                       xpath://li//span[text()='${product_json['cat']}']
    # Preenche o preço do produto
    Input Text                          css:input[name=price]           ${product_json['price']}
    # Cria uma lista no robot com os dados do arquivo json dos produtores
    @{producers}=   Set Variable    ${product_json['producers']}
    # Para os produtores como é um array devemos fazer um FOR(robot) para capturar os dados
    : FOR   ${item}     IN      @{producers}
    \   Log     ${item}
    \   Input Text      class:producers     ${item}
    \   Press Keys      class:producers     TAB   
    # Preenche a descrição do produto
    Input Text                          css:textarea[name=description]  ${product_json['desc']}
    # Clica no botão cadastrar
    Click Element       id:create-product

    # Deixo a variavel visivel para todos
    Set Test Variable       ${product_json}

Então devo ver este item no catálogo
    # Usa essa keyword pois o catalogo é uma table, e procuro dentro da class que contem td table
    Table Should Contain       class:table      ${product_json['name']}