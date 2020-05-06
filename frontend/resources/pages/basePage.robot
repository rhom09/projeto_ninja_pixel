*** Settings ***
Documentation       Este arquivo implementa abertura e fechamento do navegador

*** Variables ***
${base_url}      http://pixel-web:3000

${ALERT_DANGER}     class:alert-danger
${ALERT_INFO}       class:alert-info


*** Keywords ***
Open Session
    Open Chrome
    # Avisa ao selenium que ele tem 10s para achar o elemento na pagina
    Set Selenium Implicit Wait  10

Close Session
    Close Browser

After Test 
    Capture Page Screenshot

After Test WCLS
    Capture Page Screenshot
    Execute Javascript      localStorage.clear();     
    
# Ele abre e faz login na app
Login Session
    Open Session
    Login With      papito@ninjapixel.com       pwd123

Product Form Session
    Login Session
    Go To Product Form     

Open Chrome
    Open Browser   ${base_url}/login    chrome