*** Settings ***
Library     SeleniumLibrary
Library     String
Resource    ../test_data/valid_data_user.robot
Resource    ./login.robot


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
    ${input_accountId}    Generate Random String    10    [NUMBERS]
    Input text    //*[@id='accountId']    ${input_accountId}
    ${accountId}    Get Value    //*[@id='accountId']
    Should Be Equal    ${accountId}    ${input_accountId}

Fill Register information with already registered data
    Input and verify accountId For Register Page    ${test_data_account_id}
    Input and verify password For Register Page    ${test_data_password}
    Input and verify firstname For Register Page    ${test_data_firstname}
    Input and verify lastname For Register Page    ${test_data_lastname}

Fill Register information AccountID=123456789
    Fill Registration Form    123456789    2566    FirstName    LastName

Fill Register information AccountID=1234567890
    Fill Registration Form    1234567890    2566    FirstName    LastName

Fill Register information AccountID=12345678901
    Fill Registration Form    12345678901    2566    FirstName    LastName

Fill Register information AccountID=1234567890A
    Fill Registration Form    1234567890A    2566    FirstName    LastName

Fill Register information AccountID=1234567890(already exit)
    Fill Registration Form    1234567890    2566    FirstName    LastName

Fill Register information password=256
    Fill Registration Form    1234567890    256    FirstName    LastName

Fill Register information password=2566
    Fill Registration Form    1234567890    2566    FirstName    LastName

Fill Register information password=25667
    Fill Registration Form    1234567890    25667    FirstName    LastName

Fill Register information password=256A
    Fill Registration Form    1234567890    256A    FirstName    LastName

Fill Register information fname lname less than 30
    Fill Registration Form
    ...    1234567890
    ...    2566
    ...    FirstNameFirstNameFirstNameFirstNameFirstNameFirstName
    ...    LastNameLastNameLastNameLastNameLastNameLastName

Fill Login information AccountID=123456789A
    Fill Login Form    123456789A    2566

Fill Login information AccountID=123456789
    Fill Login Form    123456789    2566

Fill Login information AccountID=1234567890
    Fill Login Form    1234567890    2566

Fill Login information AccountID=12345678909
    Fill Login Form    12345678909    2566

Fill Login information AccountID=9999999999
    Fill Login Form    9999999999    9999

Fill Login information Password=123A
    Fill Login Form    1234567890    123A

Fill Login information Password=123
    Fill Login Form    1234567890    123

Fill Login information Password=12345
    Fill Login Form    1234567890    12345

Fill Login information Password=1111 wrong password
    Fill Login Form    1234567890    1111

Click Register button
    Submit Form

Check Register Error
    [Arguments]    ${input_error}
    Submit Form
    Wait Until Element Is Visible    xpath=//*[@cid="register-error-mes"]
    ${element_text}    Get Text    xpath=//*[@cid="register-error-mes"]
    Should Be Equal As Strings    ${element_text}    ${input_error}

Login Page Check Error
    [Arguments]    ${input_error}
    Submit Form
    Wait Until Element Is Visible    xpath=//*[@cid="login-error-mes"]
    ${element_text}    Get Text    xpath=//*[@cid="login-error-mes"]
    Should Be Equal As Strings    ${element_text}    ${input_error}

Login Page Wait Load
    Wait Until Element Contains    //h2    Login

Wait Register Page Load
    Wait Until Element Contains    //h2    Register

Account Page Wait Load
    Wait Until Element Contains    //h2    Account ID:

Deposit check error
    [Arguments]    ${input_error}
    Submit Form
    Wait Until Element Is Visible    xpath=//*[@cid="deposite-error-mes"]
    ${element_text}    Get Text    xpath=//*[@cid="deposite-error-mes"]
    Should Be Equal As Strings    ${element_text}    ${input_error}

Check Alert and click OK
    Alert Should Be Present    success    ACCEPT

Account click confirm deposit
    Submit Form

Click Button Login
    Submit Form

Check Present URL
    [Arguments]    ${expectURL}
    ${PresentURL}    Get Location
    Should Be Equal As Strings    ${PresentURL}    ${expectURL}
