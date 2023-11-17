*** Settings ***
Library     SeleniumLibrary
Library     String


*** Keywords ***
Fill Registration Form
    [Arguments]    ${accountID}    ${password}    ${firstName}    ${lastName}
    Input Text    //*[@id='accountId']    ${accountID}
    Input Text    //*[@id='password']    ${password}
    Input Text    //*[@id='firstName']    ${firstName}
    Input Text    //*[@id='lastName']    ${lastName}

Fill Register information AccountID password Fname Lname
    ${AccountID} =    Generate Random String    10    [NUMBERS]
    Fill Registration Form    ${AccountID}    1234    Taratip    Suwannasart

Click Submit button and check the success alert text
    Submit Form
    Alert Should Be Present    success    ACCEPT

Verify RedirectURL
    [Arguments]    ${ExpectURL}
    ${RedirectURL} =    Get Location
    Should Be Equal    ${RedirectURL}    ${ExpectURL}
