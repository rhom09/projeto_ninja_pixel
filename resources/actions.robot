*** Settings ***
Documentation   Actions é o arquivo que terá as keywords que implementam os steps

Library    libs/db.py 
Library    SeleniumLibrary
# Biblioteca que dá acesso ao sistema oprarcional
Library     OperatingSystem

# Importa ações do Browser
Resource    pages/basePage.robot
Resource    pages/sidebar.robot
# Importa o login with para actions
Resource    pages/loginPage.robot
Resource    pages/productPage.robot

*** Keywords ***

### Helpers

# Passo a massa de teste com o [Arguments]
# Passo a coleção vinda do arquivo JSON para dentro da variavel ${file_name}
Get Product Json
    [Arguments]     ${file_name}

    # Crio uma variavel e nela chamo o GET FILE(Biblioteca OperatingSystem)
    # E passo o caminho da arquivo json, que já está setado na variavel ${file}
    ${file}=    Get File    resources/fixtures/${file_name}
    # E converto ele em json para pode carregar o valor do arquivo
    ${json}=     Evaluate    json.loads($file)   json

    [Return]    ${json}

### Login
Dado que eu acesso a página de login
    Go To       ${base_url}/login

Quando eu submeto minhas credenciais "${email}" e "${pass}"
    Login With  ${email}  ${pass}

Então devo ser autenticado
    Wait Until Element Is Visible       ${LOGGED_USER}
    Element Text Should Be              ${LOGGED_USER}    Papito 

# Passamos um argumento(massa de teste), como parametro na keyword
Então devo ver uma mensagem de alerta "${expect_message}"
    Wait Until Element Contains    class:alert     ${expect_message} 

### Products    

Dado que eu tenho um novo produto
    [Arguments]     ${file_name}

    ${product_json}=    Get Product Json        ${file_name}

    # Keyword para deletar o produto do DB
    # Ela é criada automaticamente atraves do metodo PYTHON que foi criado
    # E o robot transforma ela em keyword 
    Remove Product By Name      ${product_json['name']}
    Set Test Variable           ${product_json} 

Mas este produto já foi cadastrado
    Create New Product      ${product_json}

Quando eu faço o cadastro desse produto
    # Importa a keyword de productPage
    Create New Product      ${product_json}

Quando eu cadastro sem categoria
    Create New Product Without Category  ${product_json}

    
Então devo ver este item no catálogo
    # Usa essa keyword pois o catalogo é uma table, e procuro dentro da class que contem td table
    Table Should Contain       class:table      ${product_json['name']}

Então devo ver a mensagem de alerta
    [Arguments]     ${expect_message}

    Wait Until Element Contains     class:alert-danger      ${expect_message}

Então devo ver uma mensagem informativa 
    [Arguments]     ${expect_message}

    Wait Until Element Contains     class:alert-info      ${expect_message}   

### Remove

Dado que eu tenho o produto "${file_name}" no catálogo
    # Converter o arquivo para json
    ${product_json}=    Get Product Json        ${file_name}
    # Deleta no banco e Cria um novo produto
    Remove Product By Name      ${product_json['name']}
    Create New Product          ${product_json}
    # E deixa ele disponivel
    Set Test Variable           ${product_json} 

Quando solicito a exclusão
    Click Element   xpath://tr[td//text()[contains(., '${product_json['name']}')]]//button
    # E pegamos a class do modal(janela de confirmação)
    Wait Until Element Is Visible   class:swal2-modal 

E confirmo a solicitação
    # Inspecionamos o botão de confirmar e pegamos sua class
    Click Element   class:swal2-confirm

Mas cancelo a solicitação
    Click Element   class:swal2-cancel

Então não devo ver este item no catálogo    
    # Keyword de verificação para o elemento não existente
    Wait Until Element Does Not Contain       class:table      ${product_json['name']}











