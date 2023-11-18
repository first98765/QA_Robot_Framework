*** Comments ***
Registration Tests
    [Tags]    registration
    TC1
    TC2


*** Settings ***
Resource            ./common/commonKeywords.robot
Resource            ./pages/login.robot
Resource            ./pages/register.robot
Resource            ./pages/common.robot
Resource            ./pages/account.robot
Resource            ./test_data/error_response.robot
Resource            ./test_data/valid_data_user.robot
Resource            environment.robot
Library             SeleniumLibrary

Test Teardown       Close All Browsers


*** Variables ***
${random_number}    Evaluate    ''.join([str(random.randint(0, 9)) for _ in range(10)])    WITH    random
${timestamp}        Get Time    epoch    result_format=%s

*** Keywords ***
Open Web
    Open Browser    ${WEB_URL}    ${WEB_BROWSER}
    Maximize Browser Window


*** Test Cases ***
TC1
    Open Web
    Wait Register Page Load
    Fill Register information AccountID password Fname Lname
    Click Register button and check the success alert text
    Verify RedirectURL    http://localhost:3000/

TC2
    Open Web
    Wait Login Page Load
    Fill Registration Form    1234567    1234    Taratip    Suwannasart
    Submit Form
    Wait Until Element Contains    //div    Please fill accountId 10 digits

TC3
    Open Web
    Maximize Browser Window
    Wait Login Page Load
    Input and verify accountId For Login Page    ${test_data_account_id} 
    Input and verify password For Login Page    ${test_data_password}
    Click Login button and check the success alert text
    Wait Load Account Page
    Input and verify deposit  100
    # Input and verify withdraw    1234
    # Click bill payment phone charge
    # Input and verify bill payment amount  1111
    Click deposit confirm
    Verify balance    100
    Clear Balance
    
