*** Settings ***
Library     SeleniumLibrary


*** Keywords ***
Fill Login Form
    [Arguments]    ${accountID}    ${password}
    Input Text    //*[@id='accountId']    ${accountID}
    Input Text    //*[@id='password']    ${password}
