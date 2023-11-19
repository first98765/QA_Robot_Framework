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
Scenario1 ลงทะเบียนเเบบไม่ผ่าน Account number 9 digits
    Open Web    /register
    Wait Register Page Load
    Fill Register information AccountID=123456789
    Check Register Error    ${error_please_fill_accountId_10_digits}

Scenario2 ลงทะเบียนเเบบไม่ผ่าน Account number 11 digits
    Open Web    /register
    Wait Register Page Load
    Fill Register information AccountID=12345678901
    Check Register Error    ${error_please_fill_accountId_10_digits}

Scenario3 ลงทะเบียนเเบบไม่ผ่าน Account number (only number)
    Open Web    /register
    Wait Register Page Load
    Fill Register information AccountID=12345678901
    Check Register Error    ${error_please_fill_accountId_10_digits}

Scenario4 ลงทะเบียนเเบบไม่ผ่าน Account number (Account ID alrady existed)
    Open Web    /register
    Wait Register Page Load
    Fill Register information AccountID=1234567890(already exit)
    Check Register Error    ${error_account_id_already_existed}
Scenario5 ลงทะเบียนเเบบไม่ผ่าน Password (error 3 digit )
    Open Web    /register
    Wait Register Page Load
    Fill Register information password=256
    Check Register Error    ${error_please_fill_accountId_10_digits}
Scenario6 ลงทะเบียนเเบบไม่ผ่าน Password (error 5 digit )'
    Open Web    /register
    Wait Register Page Load
    Fill Register information password=2566
    Check Register Error    ${error_please_fill_accountId_10_digits}
Scenario7 ลงทะเบียนเเบบไม่ผ่าน Password ( only number )
    Open Web    /register
    Wait Register Page Load
    Fill Register information password=256A
    Check Register Error    ${error_please_put_password_only_number}
Scenario8 ลงทะเบียนเเบบไม่ผ่าน Firstname+Lastname (more than 30)
    Open Web    /register
    Wait Register Page Load
    Fill Register information fname lname less than 30
    Check Register Error    ${error_your_name_length_is_exceed_30_digits}

Scenario9 ลงทะเบียนผ่าน
    Open Web    /register
    Wait Register Page Load
    Fill Register information AccountID=1234567890
    Click Register button
    Check Alert and click OK
    Check Present URL    http://localhost:3000/
# Scenario10 ลงทะเบียนผ่าน
# Scenario11
# Scenario12 ลงทะเบียนผ่าน ชื่อ+นามสกุลและช่องว่างได้ 30 ตัว ชื่อ>นามสกุล
# Scenario13 ลงทะเบียนผ่าน ชื่อ+นามสกุลและช่องว่างได้ 30 ตัว ชื่อ<นามสกุล
Scenario14 login ไม่ผ่าน accountId มีตัวอักษร
    Open Web    /
    Login Page Wait Load
    Fill Login information AccountID=123456789A
    Login Page Check Error    ${error_please_put_accountId_only_number}
Scenario15 login ไม่ผ่าน accountId มี 9 digits
    Open Web    /
    Login Page Wait Load
    Fill Login information AccountID=123456789
    Login Page Check Error    ${error_please_fill_accountId_10_digits}
Scenario16 login ไม่ผ่าน accountId มี 11 digits
    Open Web    /
    Login Page Wait Load
    Fill Login information AccountID=12345678909
    Login Page Check Error    ${error_please_fill_accountId_10_digits}
Scenario17 login ไม่ผ่าน ไม่มี user
    Open Web    /
    Login Page Wait Load
    Fill Login information AccountID=9999999999
    Login Page Check Error    ${error_not_found_user}
Scenario18 login ไม่ผ่าน password มีตัวอักษร
    Open Web    /
    Login Page Wait Load
    Fill Login information Password=123A
    Login Page Check Error    ${error_please_put_password_only_number}
Scenario19 login ไม่ผ่าน password 3 digits
    Open Web    /
    Login Page Wait Load
    Fill Login information Password=123
    Login Page Check Error    ${error_please_fill_password_4_digits}
Scenario20 login ไม่ผ่าน password 5 digits
    Open Web    /
    Login Page Wait Load
    Fill Login information Password=12345
    Login Page Check Error    ${error_please_fill_password_4_digits}
Scenario21 login ไม่ผ่าน password ผิด
    Open Web    /
    Login Page Wait Load
    Fill Login information Password=1111 wrong password
    Login Page Check Error    ${error_password_incorrect}
Scenario22 Login pass but deposit error
    Open Web    /
    Login Page Wait Load
    Input and verify accountId For Login Page    1234567890
    Input and verify password For Login Page    2566
    Click Login button
    Wait Load Account Page
    Input and verify deposit    -1
    Click deposit confirm
    Check error deposit    ${error_please_put_pnly_number}

Scenario24 Log in pass and deposit pass but withdraw error
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
    Check error withdraw    ${error_please_put_pnly_number}

Scenario28 Log in pass and deposit pass and withdraw pass and transfer error
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

    Check error transfer    ${error_please_put_pnly_number}

Scenario37 Log in pass and deposit pass and withdraw pass and transfer pass
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

Scenario42 Log in pass and bill error
    Open Web    /
    Login Page Wait Load
    Input and verify accountId For Login Page    1234567890
    Input and verify password For Login Page    2566
    Click Login button
    Wait Load Account Page
    Click bill payment phone charge
    Input and verify bill payment amount    0
    Click bill payment confirm
    Check error Bill    ${error_please_put_pnly_number}

Scenario46 Log in pass and bill pass
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
#    Check Register Error    ${error_please_fill_password_4_digits}

# Scenario4
#    Open Web    /register
#    Wait Register Page Load
#    Fill Register information password=256A
#    Check Register Error    ${error_please_put_password_only_number}

# Scenario5
#    Open Web    /register
#    Wait Register Page Load
#    Fill Register information fname lname less than 30
#    Check Register Error    ${error_your_name_length_is_exceed_30_digits}

# Scenario10
#    Open Web    /
#    Login Page Wait Load
#    Fill Login information AccountID=123456789A
#    Login Page Check Error    Please put accountId only number

# Scenario11
#    Open Web    /
#    Login Page Wait Load
#    Fill Login information AccountID=123456789
#    Login Page Check Error    ${error_please_fill_accountId_10_digits}

# Scenario12
#    Open Web    /
#    Login Page Wait Load
#    Fill Login information AccountID=9999999999
#    Login Page Check Error    ${error_not_found_user}

# Scenario13
#    Open Web    /
#    Login Page Wait Load
#    Fill Login information Password=123A
#    Login Page Check Error    ${error_please_put_password_only_number}

# Scenario14
#    Open Web    /
#    Login Page Wait Load
#    Fill Login information Password=123
#    Login Page Check Error    ${error_please_fill_password_4_digits}

# TC1
#    Open Web    /register
#    Wait Register Page Load
#    Fill Register information AccountID=123456789
#    Check Register Error    ${error_please_fill_accountId_10_digits}

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
#    Check Register Error    ${error_please_fill_accountId_10_digits}

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
#    Check Register Error    ${error_please_fill_password_4_digits}

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
#    Check Register Error    ${error_please_fill_password_4_digits}

# TC9
#    Open Web    /register
#    Wait Register Page Load
#    Fill Register information password=256A
#    Check Register Error    ${error_please_put_password_only_number}

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

TC28
    Open Web    /
    Maximize Browser Window
    Wait Login Page Load
    Fill Login Form    -123456789    2566
    Login Page Check Error    ${error_please_put_password_only_number}

TC29
    Open Web    /
    Maximize Browser Window
    Wait Login Page Load
    Fill Login Form    12345678.9    2566
    Login Page Check Error    ${error_please_put_password_only_number}

TC30
    Open Web    /
    Maximize Browser Window
    Wait Login Page Load
    Fill Login Form    1234567890    25.6
    Login Page Check Error    ${error_please_fill_password_4_digits}

TC31
    Open Web    /
    Maximize Browser Window
    Wait Login Page Load
    Fill Login Form    1234567890    -256
    Login Page Check Error    ${error_please_fill_password_4_digits}  

TC32
    Open Web    /
    Login Page Wait Load
    Input and verify accountId For Login Page    1234567890
    Input and verify password For Login Page    2566
    Click Login button
    Wait Load Account Page
    Input and verify deposit    0
    Click deposit confirm
    Check error deposit    ${error_please_put_pnly_number}

TC33
    Open Web    /
    Login Page Wait Load
    Input and verify accountId For Login Page    1234567890
    Input and verify password For Login Page    2566
    Click Login button
    Wait Load Account Page
    Input and verify deposit    -1
    Click deposit confirm
    Check error deposit    ${error_please_put_pnly_number}
    
TC34
    Open Web    /
    Login Page Wait Load
    Input and verify accountId For Login Page    1234567890
    Input and verify password For Login Page    2566
    Click Login button
    Wait Load Account Page
    Input and verify deposit    100000
    Click deposit confirm

TC35
    Open Web    /
    Login Page Wait Load
    Input and verify accountId For Login Page    1234567890
    Input and verify password For Login Page    2566
    Click Login button
    Wait Load Account Page
    Input and verify deposit    1.08E+38
    Click deposit confirm
    Check error deposit    ${error_please_put_pnly_number}

TC36
    Open Web    /
    Login Page Wait Load
    Input and verify accountId For Login Page    1234567890
    Input and verify password For Login Page    2566
    Click Login button
    Wait Load Account Page
    Input and verify deposit    90071992547409916
    Click deposit confirm

*** Keywords ***
Open Web
    [Arguments]    ${Path}
    Open Browser    ${WEB_URL}${Path}    ${WEB_BROWSER}
    Maximize Browser Window
