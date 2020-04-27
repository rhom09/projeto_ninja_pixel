*** Settings ***
Documentation       Este arquivo implementa abertura e fechamento do navegador

*** Keywords ***
Open Session
    Open Browser    http://pixel-web:3000/login    chrome

Close Session
    Close Browser    