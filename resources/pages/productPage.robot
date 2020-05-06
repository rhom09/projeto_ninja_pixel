*** Settings ***
Documentation       Este arquivo implementa funções e elementos da página Produtos

*** Keywords ***
Create New Product
    [Arguments]     ${product_json}

     # Clica no botão add produto
    Click Element                       class:product-add
    # Aqui eu passo o nome da variavel mais o valor dela no caso name
    Input Text                          css:input[name=title]           ${product_json['name']}
    # Colocamos um if aqui pois se não for selecionado a categoria o teste passa direto
    Run Keyword if              "${product_json['cat']}"
    ...     Select Category      ${product_json['cat']}
    # Preenche o preço do produto
    Input Text                          css:input[name=price]           ${product_json['price']}

    Input Producers     ${product_json['producers']}
    # Preenche a descrição do produto
    Input Text                          css:textarea[name=description]  ${product_json['desc']}
    
    Upload Photo    ${product_json['image']}
    
    # Clica no botão cadastrar
    Click Element       id:create-product

Upload Photo
    [Arguments]     ${image}    
    
    ${file}         Set Variable    ${EXECDIR}/resources/fixtures/images/${image}

    Choose File     id:upcover      ${file}
    
Select Category
    [Arguments]     ${cat}    

    # Clica em categoria
    Click Element                       css:input[placeholder=Gategoria]
    Set Selenium Speed   1
    # Espera que o elemento esteja visivel para pode clicar
    Wait Until Element Is Visible       class:el-select-dropdown__list
    Click Element                       xpath://li//span[text()='${cat}']
    Set Selenium Speed   0

Input Producers
    [Arguments]     ${producers}

    # Para os produtores como é um array devemos fazer um FOR(robot) para capturar os dados
    : FOR   ${item}     IN      @{producers}
    \   Log     ${item}
    \   Input Text      class:producers     ${item}
    \   Press Keys      class:producers     TAB    