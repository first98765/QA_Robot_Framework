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
${max_int}  90071992547409916
${example_math_syntax}  1.07898E+38

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

# duplicate with Scenario9 (nom) will skip
# Scenario10
# Scenario11

Scenario12 ลงทะเบียนผ่าน ชื่อ+นามสกุลและช่องว่างได้ 30 ตัว
    Open Web    /register
    Wait Register Page Load
    ${input_accountId}    Generate Random String    10    [NUMBERS]
    Input and verify accountId For Register Page    ${input_accountId}
    Input and verify password For Register Page    2556
    Input and verify firstname For Register Page  abcdefghijklmno
    Input and verify lastname For Register Page    abcdefghijklm
    Check Alert and click OK
    Check Present URL    http://localhost:3000/

Scenario13 ลงทะเบียนผ่าน ชื่อ+นามสกุลและช่องว่างได้ 29 ตัว
    Open Web    /register
    Wait Register Page Load
    ${input_accountId}    Generate Random String    10    [NUMBERS]
    Input and verify accountId For Register Page    ${input_accountId}
    Input and verify password For Register Page    2556
    Input and verify firstname For Register Page  abcdefghijklmnopq
    Input and verify lastname For Register Page    abcdefghijkl
    Check Alert and click OK
    Check Present URL    http://localhost:3000/

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
    Check error deposit    ${error_please_put_only_number}

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
    Check error withdraw    ${error_please_put_only_number}

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

    Check error transfer    ${error_please_put_only_number}

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

Scenario42 log-in ผ่าน เเละ ชำระบิล (ไม่ผ่าน Amount [only number])
    Open Web    /
    Login Page Wait Load
    Input and verify accountId For Login Page    1234567890
    Input and verify password For Login Page    2566
    Click Login button
    Wait Load Account Page
    Click bill payment phone charge
    Input and verify bill payment amount    0
    Click bill payment confirm
    Check error Bill    ${error_please_put_only_number}

Scenario43 log-in ผ่าน เเละ ชำระบิล (ไม่ผ่าน Amount [balance not enough])
    Open Web    /
    Login Page Wait Load
    Input and verify accountId For Login Page    ${test_data_account_id}
    Input and verify password For Login Page    ${test_data_password}
    Click Login button
    Wait Load Account Page
    Mock Data Balance 10000
    Wait Load Account Page
    Click bill payment phone charge
    Input and verify bill payment amount    99999
    Click bill payment confirm
    Check error Bill    ${error_your_balance_is_not_enough}

Scenario44 Log in pass and bill pass (nom)
    Open Web    /
    Login Page Wait Load
    Input and verify accountId For Login Page    ${test_data_account_id}
    Input and verify password For Login Page    ${test_data_password}
    Click Login button
    Wait Load Account Page
    Mock Data Balance 10000
    Wait Load Account Page
    Click bill payment water charge
    Input and verify bill payment amount    30
    Click bill payment confirm
    Verify balance    9970

Scenario45 Log in pass and bill pass (min)
    Open Web    /
    Login Page Wait Load
    Input and verify accountId For Login Page    1234567890
    Input and verify password For Login Page    2566
    Click Login button
    Wait Load Account Page
    Click bill payment phone charge
    Input and verify bill payment amount    1
    Click bill payment confirm

Scenario46 Log in pass and bill pass (min+)
    Open Web    /
    Login Page Wait Load
    Input and verify accountId For Login Page    ${test_data_account_id}
    Input and verify password For Login Page    ${test_data_password}
    Click Login button
    Wait Load Account Page
    Mock Data Balance 10000
    Wait Load Account Page
    Click bill payment water charge
    Input and verify bill payment amount    2
    Click bill payment confirm
    Verify balance    9998

#todo
# duplicate with Scenario43 skip
# Scenario47 log-in ผ่าน เเละ ชำระบิล (ไม่ผ่าน Amount [balance not enough])
# Scenario48 log-in ผ่าน เเละ ชำระบิล (ไม่ผ่าน Amount [balance not enough])
# Scenario49 log-in ผ่าน เเละ ชำระบิล (ไม่ผ่าน Amount [balance not enough])

Scenario51 ลงทะเบียนเเบบไม่ผ่าน Account number ติดลบ
    Open Web    /register
    Wait Register Page Load
    Input and verify accountId For Register Page    -123456789
    Input and verify password For Register Page    2566
    Input and verify firstname For Register Page  abcdefghijklmnopq
    Input and verify lastname For Register Page    abcdefghijkl
    Check Register Error    ${error_please_put_accountId_only_number}
Scenario52 ลงทะเบียนเเบบไม่ผ่าน Account number เป็นทศนิยม
    Open Web    /register
    Wait Register Page Load
    Input and verify accountId For Register Page    12345678.9
    Input and verify password For Register Page    2566
    Input and verify firstname For Register Page  abcdefghijklmnopq
    Input and verify lastname For Register Page    abcdefghijkl
    Check Register Error    ${error_please_put_accountId_only_number}

Scenario53 ลงทะเบียนเเบบไม่ผ่าน password เป็นทศนิยม
    Open Web    /register
    Wait Register Page Load
    ${input_accountId}    Generate Random String    10    [NUMBERS]
    Input and verify accountId For Register Page    ${input_accountId}
    Input and verify password For Register Page    25.6
    Input and verify firstname For Register Page  abcdefghijklmnopq
    Input and verify lastname For Register Page    abcdefghijkl
    Check Register Error    ${error_please_put_password_only_number}

Scenario54 ลงทะเบียนเเบบไม่ผ่าน password ติดลบ
    Open Web    /register
    Wait Register Page Load
    ${input_accountId}    Generate Random String    10    [NUMBERS]
    Input and verify accountId For Register Page    ${input_accountId}
    Input and verify password For Register Page    -256
    Input and verify firstname For Register Page  abcdefghijklmnopq
    Input and verify lastname For Register Page    abcdefghijkl
    Check Register Error    ${error_please_put_password_only_number}

Scenario55 ลงทะเบียนเเบบไม่ผ่าน Account number เป็น math syntax
    Open Web    /register
    Wait Register Page Load
    Input and verify accountId For Register Page    1.23456E+43
    Input and verify password For Register Page    2566
    Input and verify firstname For Register Page  abcdefghijklmnopq
    Input and verify lastname For Register Page    abcdefghijkl
    Check Register Error    ${error_please_put_accountId_only_number}

Scenario56 login ไม่ผ่าน accountId ติดลบ
    Open Web    /
    Login Page Wait Load
    Input and verify accountId For Login Page    -123456789
    Input and verify password For Login Page    2566
    Login Page Check Error    ${error_please_put_accountId_only_number}


Scenario57 login ไม่ผ่าน accountId เป็นทศนิยม
    Open Web    /
    Login Page Wait Load
    Input and verify accountId For Login Page    12345678.9
    Input and verify password For Login Page    2566
    Login Page Check Error    ${error_please_put_accountId_only_number}

Scenario58 login ไม่ผ่าน password เป็นทศนิยม
    Open Web    /
    Login Page Wait Load
    Input and verify accountId For Login Page    1234567890
    Input and verify password For Login Page    25.6
    Login Page Check Error    ${error_please_put_password_only_number}

Scenario59 login ไม่ผ่าน password ติดลบ
    Open Web    /
    Login Page Wait Load
    Input and verify accountId For Login Page    1234567890
    Input and verify password For Login Page    -256
    Login Page Check Error    ${error_please_put_password_only_number}


Scenario60 Login pass but deposit error math syntax
    Open Web    /
    Login Page Wait Load
    Input and verify accountId For Login Page    1234567890
    Input and verify password For Login Page    2566
    Click Login button
    Wait Load Account Page
    Input and verify deposit    ${example_math_syntax}
    Click deposit confirm
    Check error deposit    ${error_please_put_only_number}

Scenario61 Login pass but deposit balnace big int
    Open Web    /
    Login Page Wait Load
    Input and verify accountId For Login Page    1234567890
    Input and verify password For Login Page    2566
    Click Login button
    Wait Load Account Page
    Clear Balance
    Input and verify deposit    ${max_int}
    Click deposit confirm
    Sleep  1s
    Verify balance  ${max_int}

Scenario61 login ผ่าน แต่ withdraw ไม่ผ่าน(Amount เป็น Math Syntax)
    Open Web    /
    Login Page Wait Load
    Input and verify accountId For Login Page    ${test_data_account_id}
    Input and verify password For Login Page    ${test_data_password}
    Click Login button
    Wait Load Account Page
    Mock Data Balance 10000
    Wait Load Account Page
    Input and verify withdraw    ${example_math_syntax}
    Click withdraw confirm
    Check error withdraw    ${error_please_put_only_number}

Scenario62 login ผ่าน แต่ withdraw ไม่ผ่าน balance ไม่พอ(Amount เป็น Maxint)
    Open Web    /
    Login Page Wait Load
    Input and verify accountId For Login Page    ${test_data_account_id}
    Input and verify password For Login Page    ${test_data_password}
    Click Login button
    Wait Load Account Page
    Mock Data Balance 10000
    Wait Load Account Page
    Input and verify withdraw    ${max_int}
    Click withdraw confirm
    Check error withdraw    ${error_your_balance_is_not_enough}

Scenario63 login ผ่าน แต่ transfer ไม่ผ่าน(Amount เป็น Math Syntax)
    Open Web    /
    Login Page Wait Load
    Input and verify accountId For Login Page    ${test_data_account_id}
    Input and verify password For Login Page    ${test_data_password}
    Click Login button
    Wait Load Account Page
    Mock Data Balance 10000
    Wait Load Account Page
    Input and verify transfer accountID    1234567890
    Input and verify transfer amount    ${example_math_syntax}
    Click transfer confirm
    Check error transfer    ${error_please_put_only_number}

Scenario64 login ผ่าน แต่ transfer ไม่ผ่าน(AccountID เป็น Math Syntax)
    Open Web    /
    Login Page Wait Load
    Input and verify accountId For Login Page    ${test_data_account_id}
    Input and verify password For Login Page    ${test_data_password}
    Click Login button
    Wait Load Account Page
    Mock Data Balance 10000
    Wait Load Account Page
    Input and verify transfer accountID    ${example_math_syntax}
    Input and verify transfer amount    1000
    Click transfer confirm
    Check error transfer    ${error_please_put_accountId_only_number}

Scenario65 login ผ่าน แต่ transfer ไม่ผ่าน(AccountID เป็นทศนิยม)
    Open Web    /
    Login Page Wait Load
    Input and verify accountId For Login Page    ${test_data_account_id}
    Input and verify password For Login Page    ${test_data_password}
    Click Login button
    Wait Load Account Page
    Mock Data Balance 10000
    Wait Load Account Page
    Input and verify transfer accountID    12345678.9
    Input and verify transfer amount    1000
    Click transfer confirm
    Check error transfer    ${error_please_put_accountId_only_number}

Scenario66 login ผ่าน แต่ transfer ไม่ผ่าน(AccountID เป็นค่าลบ)
    Open Web    /
    Login Page Wait Load
    Input and verify accountId For Login Page    ${test_data_account_id}
    Input and verify password For Login Page    ${test_data_password}
    Click Login button
    Wait Load Account Page
    Mock Data Balance 10000
    Wait Load Account Page
    Input and verify transfer accountID    -123456789
    Input and verify transfer amount    1000
    Click transfer confirm
    Check error transfer    ${error_please_put_accountId_only_number}
    
Scenario67 login ผ่าน แต่ transfer ไม่ผ่าน(Amount เป็น Maxint)
    Open Web    /
    Login Page Wait Load
    Input and verify accountId For Login Page    ${test_data_account_id}
    Input and verify password For Login Page    ${test_data_password}
    Click Login button
    Wait Load Account Page
    Mock Data Balance 10000
    Wait Load Account Page
    Input and verify transfer accountID    1234567890
    Input and verify transfer amount    ${max_int}
    Click transfer confirm
    Check error transfer    ${error_your_balance_is_not_enough}

Scenario68 login ผ่าน แต่ bill payment ไม่ผ่าน(Amount เป็น Math Syntax)
    Open Web    /
    Login Page Wait Load
    Input and verify accountId For Login Page    ${test_data_account_id}
    Input and verify password For Login Page    ${test_data_password}
    Click Login button
    Wait Load Account Page
    Mock Data Balance 10000
    Wait Load Account Page
    Click bill payment phone charge
    Input and verify bill payment amount    ${example_math_syntax}
    Click bill payment confirm
    Check error Bill    ${error_please_put_accountId_only_number}

Scenario69 login ผ่าน แต่ bill payment ไม่ผ่าน(Amount เป็น Maxint)
    Open Web    /
    Login Page Wait Load
    Input and verify accountId For Login Page    ${test_data_account_id}
    Input and verify password For Login Page    ${test_data_password}
    Click Login button
    Wait Load Account Page
    Mock Data Balance 10000
    Wait Load Account Page
    Click bill payment phone charge
    Input and verify bill payment amount    ${max_int}
    Click bill payment confirm
    Check error Bill    ${error_your_balance_is_not_enough}


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


#p'print
# TC28
#     Open Web    /
#     Maximize Browser Window
#     Wait Login Page Load
#     Fill Login Form    -123456789    2566
#     Login Page Check Error    ${error_please_put_password_only_number}

# TC29
#     Open Web    /
#     Maximize Browser Window
#     Wait Login Page Load
#     Fill Login Form    12345678.9    2566
#     Login Page Check Error    ${error_please_put_password_only_number}

# TC30
#     Open Web    /
#     Maximize Browser Window
#     Wait Login Page Load
#     Fill Login Form    1234567890    25.6
#     Login Page Check Error    ${error_please_fill_password_4_digits}

# TC31
#     Open Web    /
#     Maximize Browser Window
#     Wait Login Page Load
#     Fill Login Form    1234567890    -256
#     Login Page Check Error    ${error_please_fill_password_4_digits}  

# TC32
#     Open Web    /
#     Login Page Wait Load
#     Input and verify accountId For Login Page    1234567890
#     Input and verify password For Login Page    2566
#     Click Login button
#     Wait Load Account Page
#     Input and verify deposit    0
#     Click deposit confirm
#     Check error deposit    ${error_please_put_only_number}

# TC33
#     Open Web    /
#     Login Page Wait Load
#     Input and verify accountId For Login Page    1234567890
#     Input and verify password For Login Page    2566
#     Click Login button
#     Wait Load Account Page
#     Input and verify deposit    -1
#     Click deposit confirm
#     Check error deposit    ${error_please_put_only_number}
    
# TC34
#     Open Web    /
#     Login Page Wait Load
#     Input and verify accountId For Login Page    1234567890
#     Input and verify password For Login Page    2566
#     Click Login button
#     Wait Load Account Page
#     Input and verify deposit    100000
#     Click deposit confirm

# TC35
#     Open Web    /
#     Login Page Wait Load
#     Input and verify accountId For Login Page    1234567890
#     Input and verify password For Login Page    2566
#     Click Login button
#     Wait Load Account Page
#     Input and verify deposit    1.08E+38
#     Click deposit confirm
#     Check error deposit    ${error_please_put_only_number}

# TC36
#     Open Web    /
#     Login Page Wait Load
#     Input and verify accountId For Login Page    1234567890
#     Input and verify password For Login Page    2566
#     Click Login button
#     Wait Load Account Page
#     Input and verify deposit    90071992547409916
#     Click deposit confirm

*** Keywords ***
Open Web
    [Arguments]    ${Path}
    Open Browser    ${WEB_URL}${Path}    ${WEB_BROWSER}
    Maximize Browser Window
