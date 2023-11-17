*** Settings ***
Library     SeleniumLibrary
Library     String

*** Keywords ***
Verify RedirectURL
    [Arguments]    ${ExpectURL}
    ${RedirectURL} =    Get Location
    Should Be Equal    ${RedirectURL}    ${ExpectURL}