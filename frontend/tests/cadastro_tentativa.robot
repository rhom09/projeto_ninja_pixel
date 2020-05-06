*** Settings ***
Documentation       Cadastro de produtos
...         Sendo um administrador de catálogo
...         Quero cadastrar produtos
...         Para que eu possa disponibiliza-los na loja virtual

Resource    ../resources/actions.robot

# Abre(e faz login) e fecha o navegador importando de actions.robot
# Product Form Session faz login uma unica vez e volta para a pagina de cadastro
Suite Setup     Product Form Session
Suite Teardown  Close Session

Test Setup      Reload Page
Test Teardown   After Test
# É o template da suite(dado,quando e então), serve principalmente para quando
# Tiver muitos comportamentos iguais
Test Template   Tentativa de cadastro

*** Keywords ***
# Crio uma keyword que servirá de template para todos os comportamentos iguais
Tentativa de cadastro
    [Arguments]     ${file_name}        ${expect_message}

    Dado que eu tenho um novo produto           ${file_name}
    Quando eu tento cadastrar o produto
    Então devo ver uma mensagem informativa     ${expect_message} 

# Test cases vai receber dois parametros(PRODUTO E SAIDA)
*** Test Cases ***              produto             saida
Nome não informado              contra.json         Oops - Informe o nome do produto!
Categoria não selecionada       goldenAxe.json      Oops - Selecione uma categoria!
preço não informado             streetFII.json      Oops - Informe o preço também! 
       