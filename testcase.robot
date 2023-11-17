*** Comments ***
Registration Tests
    [Tags]    registration
    TC1
    TC2


*** Settings ***
Resource            ./common/commonKeywords.robot
Resource            ./pages/login.robot
Resource            ./pages/register.robot
Library             SeleniumLibrary

Test Teardown       Close All Browsers


*** Variables ***
${random_number}    Evaluate    ''.join([str(random.randint(0, 9)) for _ in range(10)])    WITH    random
${timestamp}        Get Time    epoch    result_format=%s


*** Test Cases ***
TC1
    Open Browser    http://localhost:3000/register    chrome
    Maximize Browser Window
    Wait Until Element Contains    //h2    Register
    Fill Register information AccountID password Fname Lname
    Click Submit button and check the success alert text
    Verify RedirectURL    http://localhost:3000

TC2
    Open Browser    http://localhost:3000/    chrome
    Maximize Browser Window
    Wait Until Element Contains    //h2    Login
    Fill Registration Form    1234567    1234    Taratip    Suwannasart
    Submit Form
    Wait Until Element Contains    //div    Please fill accountId 10 digits
