*** Settings ***
Documentation       Este arquivo implementa abertura e fechamento do navegador

*** Keywords ***
Open Session
    Open Browser    http://pixel-web:3000/login    chrome
    # Avisa ao selenium que ele tem 10s para achar o elemento na pagina
    Set Selenium Implicit Wait  10

Close Session
    Close Browser    