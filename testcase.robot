*** Comments ***
Registration Tests
    [Tags]    registration
    Scenario1
    Scenario9
    Scenario16
    Scenario22
    Scenario24
    Scenario28
    Scenario37
    Scenario42
    Scenario46


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
Scenario1
    Open Web    /register
    Wait Register Page Load
    Fill Register information AccountID=123456789
    Check Register Error    Please fill accountId 10 digits

Scenario9
    Open Web    /register
    Wait Register Page Load
    Fill Register information AccountID=1234567890
    Click Register button
    Check Alert and click OK
    Check Present URL    http://localhost:3000/

Scenario16
    Open Web    /
    Login Page Wait Load
    Fill Login information AccountID=123456789
    Login Page Check Error    Please fill accountId 10 digits

Scenario22
    Open Web    /
    Login Page Wait Load
    Input and verify accountId For Login Page    1234567890
    Input and verify password For Login Page    2566
    Click Login button
    Wait Load Account Page
    Input and verify deposit    -1
    Click deposit confirm
    Check error deposit    Please put only number

Scenario24
    Open Web    /
    Login Page Wait Load
    Input and verify accountId For Login Page    1234567890
    Input and verify password For Login Page    2566
    Click Login button
    Wait Load Account Page
    Input and verify deposit    100000
    Click deposit confirm
    Wait Load Account Page
    Input and verify withdraw    -1
    Click withdraw confirm
    Check error withdraw    Please put only number

Scenario28
    Open Web    /
    Login Page Wait Load
    Input and verify accountId For Login Page    1234567890
    Input and verify password For Login Page    2566
    Click Login button
    Wait Load Account Page
    Input and verify deposit    100000
    Click deposit confirm
    Wait Load Account Page
    Input and verify withdraw    99999
    Click withdraw confirm
    Wait Load Account Page
    Input and verify transfer accountID    1111111111
    Input and verify transfer amount    -1
    Click transfer confirm

    Check error transfer    Please put only number

Scenario37
    Open Web    /
    Login Page Wait Load
    Input and verify accountId For Login Page    1234567890
    Input and verify password For Login Page    2566
    Click Login button
    Wait Load Account Page
    Input and verify deposit    100000
    Click deposit confirm
    Wait Load Account Page
    Input and verify withdraw    1
    Click withdraw confirm
    Wait Load Account Page
    Input and verify transfer accountID    1111111111
    Input and verify transfer amount    1
    Click transfer confirm

Scenario42
    Open Web    /
    Login Page Wait Load
    Input and verify accountId For Login Page    1234567890
    Input and verify password For Login Page    2566
    Click Login button
    Wait Load Account Page
    Click bill payment phone charge
    Input and verify bill payment amount    0
    Click bill payment confirm
    Check error Bill    Please put only number

Scenario46
    Open Web    /
    Login Page Wait Load
    Input and verify accountId For Login Page    1234567890
    Input and verify password For Login Page    2566
    Click Login button
    Wait Load Account Page
    Click bill payment phone charge
    Input and verify bill payment amount    1
    Click bill payment confirm

# Scenario3
#    Open Web    /register
#    Wait Register Page Load
#    Fill Register information password=256
#    Check Register Error    Please fill password 4 digits

# Scenario4
#    Open Web    /register
#    Wait Register Page Load
#    Fill Register information password=256A
#    Check Register Error    Please put password only number

# Scenario5
#    Open Web    /register
#    Wait Register Page Load
#    Fill Register information fname lname less than 30
#    Check Register Error    your name length is exceed 30 digits

# Scenario10
#    Open Web    /
#    Login Page Wait Load
#    Fill Login information AccountID=123456789A
#    Login Page Check Error    Please put accountId only number

# Scenario11
#    Open Web    /
#    Login Page Wait Load
#    Fill Login information AccountID=123456789
#    Login Page Check Error    Please fill accountId 10 digits

# Scenario12
#    Open Web    /
#    Login Page Wait Load
#    Fill Login information AccountID=9999999999
#    Login Page Check Error    Not Found User

# Scenario13
#    Open Web    /
#    Login Page Wait Load
#    Fill Login information Password=123A
#    Login Page Check Error    Please put password only number

# Scenario14
#    Open Web    /
#    Login Page Wait Load
#    Fill Login information Password=123
#    Login Page Check Error    Please fill password 4 digits

# TC1
#    Open Web    /register
#    Wait Register Page Load
#    Fill Register information AccountID=123456789
#    Check Register Error    Please fill accountId 10 digits

# TC2
#    Open Web    /register
#    Wait Register Page Load
#    Fill Register information AccountID=1234567890
#    Click Register button
#    Check Alert and click OK
#    Check Present URL    http://localhost:3000/

# TC3
#    Open Web    /register
#    Wait Register Page Load
#    Fill Register information AccountID=12345678901
#    Check Register Error    Please fill accountId 10 digits

# TC4
#    Open Web    /register
#    Wait Register Page Load
#    Fill Register information AccountID=1234567890A
#    Check Register Error    Please put accountId only number

# TC5
#    Open Web    /register
#    Wait Register Page Load
#    Fill Register information AccountID=1234567890(already exit)
#    Check Register Error    Account ID already existed

# TC6
#    Open Web    /register
#    Wait Register Page Load
#    Fill Register information password=256
#    Check Register Error    Please fill password 4 digits

# TC7
#    Open Web    /register
#    Wait Register Page Load
#    Fill Register information password=2566
#    Click Register button
#    Check Alert and click OK
#    Check Present URL    http://localhost:3000/

# TC8
#    Open Web    /register
#    Wait Register Page Load
#    Fill Register information password=25667
#    Check Register Error    Please fill password 4 digits

# TC9
#    Open Web    /register
#    Wait Register Page Load
#    Fill Register information password=256A
#    Check Register Error    Please put password only number

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
