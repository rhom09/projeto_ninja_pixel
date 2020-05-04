*** Settings ***
Documentation       Este arquivo implementa abertura e fechamento do navegador

*** Variables ***
${base_url}      http://pixel-web:3000


*** Keywords ***
Open Session
    Open Chrome
    # Avisa ao selenium que ele tem 10s para achar o elemento na pagina
    Set Selenium Implicit Wait  10

Close Session
    Close Browser
# Ele abre e faz login na app
Login Session
    Open Session
    Login With      papito@ninjapixel.com       pwd123    

Open Chrome
    Open Browser   ${base_url}/login    chrome