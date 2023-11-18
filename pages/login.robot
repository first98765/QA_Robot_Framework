*** Settings ***
Library     SeleniumLibrary


*** Keywords ***
Fill Login Form
    [Arguments]    ${accountID}    ${password}
    Input Text    //*[@id='accountId']    ${accountID}
    Input Text    //*[@id='password']    ${password}

Verify accountId is empty For Login Page
   ${accountId}    Get Value    //*[@id='accountId']
    Should Be Equal    ${accountId}    ${EMPTY}

Input and verify accountId For Login Page
    [Arguments]    ${input_accountId} 
    Input text    //*[@id='accountId']    ${input_accountId} 
    ${accountId}    Get Value    //*[@id='accountId']
    Should Be Equal    ${accountId}    ${input_accountId}

Verify password is empty For Login Page
   ${password}    Get Value    //*[@id='password']
    Should Be Equal    ${password}    ${EMPTY}

Input and verify password For Login Page
    [Arguments]    ${input_password} 
    Input text    //*[@id='password']    ${input_password} 
    ${password}    Get Value    //*[@id='password']
    Should Be Equal    ${password}    ${input_password}

Click Login button
    Submit Form

Check Login Error
    [Arguments]    ${input_error}
    Submit Form
    ${element_text}=    Get Text    xpath=//*[@cid="login-error-mes"]
    Should Be Equal As Strings    ${element_text}    ${input_error}

Wait Login Page Load
    Wait Until Element Contains    //h2    Login