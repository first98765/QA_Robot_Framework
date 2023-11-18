*** Settings ***
Library     SeleniumLibrary
Library     String
Resource    ../test_data/valid_data_user.robot

*** Keywords ***
Fill Registration Form
    [Arguments]    ${accountID}    ${password}    ${firstName}    ${lastName}
    Input Text    //*[@id='accountId']    ${accountID}
    Input Text    //*[@id='password']    ${password}
    Input Text    //*[@id='firstName']    ${firstName}
    Input Text    //*[@id='lastName']    ${lastName}

Verify firstname is empty For Register Page
   ${firstname}    Get Value    //*[@id='firstName']
    Should Be Equal    ${firstname}    ${EMPTY}

Input and verify firstname For Register Page
    [Arguments]    ${input_firstname} 
    Input text    //*[@id='firstName']    ${input_firstname} 
    ${firstname}    Get Value    //*[@id='firstName']
    Should Be Equal    ${firstname}    ${input_firstname}

Verify lastname is empty For Register Page
   ${lastname}    Get Value    //*[@id='lastName']
    Should Be Equal    ${lastname}    ${EMPTY}

Input and verify lastname For Register Page
    [Arguments]    ${input_lastname} 
    Input text    //*[@id='lastName']    ${input_lastname} 
    ${lastname}    Get Value    //*[@id='lastName']
    Should Be Equal    ${lastname}    ${input_lastname} 


Verify password is empty For Register Page
   ${password}    Get Value    //*[@id='password']
    Should Be Equal    ${password}    ${EMPTY}

Input and verify password For Register Page
    [Arguments]    ${input_password} 
    Input text    //*[@id='password']    ${input_password} 
    ${password}    Get Value    //*[@id='password']
    Should Be Equal    ${password}    ${input_password}

Verify accountId is empty For Register Page
   ${accountId}    Get Value    //*[@id='accountId']
    Should Be Equal    ${accountId}    ${EMPTY}

Input and verify accountId For Register Page
    [Arguments]    ${input_accountId} 
    Input text    //*[@id='accountId']    ${input_accountId} 
    ${accountId}    Get Value    //*[@id='accountId']
    Should Be Equal    ${accountId}    ${input_accountId}

Input and verify accountId with Random Number For Register Page
    ${input_accountId} =    Generate Random String    10    [NUMBERS]
    Input text    //*[@id='accountId']    ${input_accountId} 
    ${accountId}    Get Value    //*[@id='accountId']
    Should Be Equal    ${accountId}    ${input_accountId}

Fill Register information with already registered data
    Input and verify accountId For Register Page  ${test_data_account_id}
    Input and verify password For Register Page   ${test_data_password}
    Input and verify firstname For Register Page  ${test_data_firstname}
    Input and verify lastname For Register Page   ${test_data_lastname}

Fill Register information AccountID password Fname Lname
    ${AccountID} =    Generate Random String    10    [NUMBERS]
    Fill Registration Form    ${AccountID}    1234    Taratip    Suwannasart

Click Register button
    Submit Form

Check Register Error
    [Arguments]    ${input_error}
    Submit Form
    ${element_text}=    Get Text    xpath=//*[@cid="register-error-mes"]
    Should Be Equal As Strings    ${element_text}    ${input_error}

Wait Register Page Load
    Wait Until Element Contains    //h2    Register