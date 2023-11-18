*** Comments ***
Registration Tests
    [Tags]    registration
    TC1
    TC2
    TC3
    TC4
    TC5


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


*** Test Cases ***
TC1
    Open Web    /register
    Wait Register Page Load
    Fill Register information AccountID=123456789
    Check Register Error    Please fill accountId 10 digits

TC2
    Open Web    /register
    Wait Register Page Load
    Fill Register information AccountID=1234567890
    Click Register button
    Check Alert and click OK
    Check Present URL    http://localhost:3000/

TC3
    Open Web    /register
    Wait Register Page Load
    Fill Register information AccountID=12345678901
    Check Register Error    Please fill accountId 10 digits

TC4
    Open Web    /register
    Wait Register Page Load
    Fill Register information AccountID=1234567890A
    Check Register Error    Please put accountId only number

TC5
    Open Web    /register
    Wait Register Page Load
    Fill Register information AccountID=1234567890(already exit)
    Check Register Error    Account ID already existed

# TC3
#    Open Web    /
#    Maximize Browser Window
#    Wait Login Page Load
#    Input and verify accountId For Login Page    ${test_data_account_id}
#    Input and verify password For Login Page    ${test_data_password}
#    Click Login button
#    Wait Load Account Page
#    Input and verify deposit    100
#    # Input and verify withdraw    1234
#    # Click bill payment phone charge
#    # Input and verify bill payment amount    1111
#    Click deposit confirm
#    Verify balance    100
#    Clear Balance


*** Keywords ***
Open Web
    [Arguments]    ${Path}
    Open Browser    ${WEB_URL}${Path}    ${WEB_BROWSER}
    Maximize Browser Window
