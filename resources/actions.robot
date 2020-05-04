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
### Login
Dado que eu acesso a página de login
    Open Session

Quando eu submeto minhas credenciais "${email}" e "${pass}"
    Login With  ${email}  ${pass}

Então devo ser autenticado
    Wait Until Element Is Visible       ${LOGGED_USER}
    Element Text Should Be              ${LOGGED_USER}    Papito    
# Passamos um argumento(massa de teste), como parametro na keyword
Então devo ver uma mensagem de alerta "${expect_message}"
    Wait Until Element Contains    class:alert     ${expect_message} 

### Products    

# Passo a massa de teste com o [Arguments]
# Passo a coleção vinda do arquivo JSON para dentro da variavel ${json_file}
Dado que eu tenho um novo produto
    [Arguments]     ${file_name}

     # Crio uma variavel e nela chamo o GET FILE(Biblioteca OperatingSystem)
    # E passo o caminho da arquivo json, que já está setado na variavel ${file_name}
    ${file}=    Get File    resources/fixtures/${file_name}
    # E converto ele em json para pode carregar o valor do arquivo
    ${product_json}=     Evaluate    json.loads($file)   json

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
    
Então devo ver este item no catálogo
    # Usa essa keyword pois o catalogo é uma table, e procuro dentro da class que contem td table
    Table Should Contain       class:table      ${product_json['name']}

Então devo ver a mensagem de alerta
    [Arguments]     ${expect_message}

    Wait Until Element Contains     class:alert-danger      ${expect_message}    