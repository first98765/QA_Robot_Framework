*** Settings ***
Library     SeleniumLibrary


*** Keywords ***
Verify accountId
    [Arguments]    ${input_accountId}
    # ${element_text}=    Get Text    xpath=//*[@id="root"]/div/div/div/div[2]/article/h1[1]
    # Should Be Equal As Strings    ${element_text}    ${input_accountId}
    Wait Until Element Contains
    ...    xpath=//*[@id="root"]/div/div/div/div[2]/article/h1[1]
    ...    ${input_accountId}
    ...    timeout=10s

Verify name
    [Arguments]    ${input_firstname}    ${input_lastname}
    ${fullname}    Catenate    ${input_firstname}    ${input_lastname}
    # ${element_text}=    Get Text    xpath=//*[@id="root"]/div/div/div/div[2]/article/h1[2]
    # Should Be Equal As Strings    ${element_text}    ${fullname}
    Wait Until Element Contains    xpath=//*[@id="root"]/div/div/div/div[2]/article/h1[2]    ${fullname}    timeout=10s

Verify balance
    [Arguments]    ${input_balance}
    # ${element_text}=    Get Text    xpath=//*[@id="root"]/div/div/div/div[2]/article/h1[3]
    # Should Be Equal As Strings    ${element_text}    ${input_balance}
    Wait Until Element Contains
    ...    xpath=//*[@id="root"]/div/div/div/div[2]/article/h1[3]
    ...    ${input_balance}
    ...    timeout=10s

Verify has balance
    # ${element_text}=    Get Text    xpath=//*[@id="root"]/div/div/div/div[2]/article/h1[3]
    # Should Not Be Equal As Strings    ${element_text}    0
    Wait Until Element Does Not Contain    xpath=//*[@id="root"]/div/div/div/div[2]/article/h1[3]    0

Input and verify deposit
    [Arguments]    ${input_deposit}
    Input Text    xpath=//*[@cid="d1"]    ${input_deposit}
    ${deposit}    Get Value    xpath=//*[@cid="d1"]
    Should Be Equal    ${deposit}    ${input_deposit}

Input and verify withdraw
    [Arguments]    ${input_withdraw}
    Input Text    xpath=//*[@cid="w1"]    ${input_withdraw}
    ${withdraw}    Get Value    xpath=//*[@cid="w1"]
    Should Be Equal    ${withdraw}    ${input_withdraw}

Input and verify transfer accountID
    [Arguments]    ${input_transfer_accountID}
    Input Text    xpath=//*[@cid="t1"]    ${input_transfer_accountID}
    ${transfer_accountID}    Get Value    xpath=//*[@cid="t1"]
    Should Be Equal    ${transfer_accountID}    ${input_transfer_accountID}

Input and verify transfer amount
    [Arguments]    ${input_transfer_amount}
    Input Text    xpath=//*[@cid="t2"]    ${input_transfer_amount}
    ${transfer_amount}    Get Value    xpath=//*[@cid="t2"]
    Should Be Equal    ${transfer_amount}    ${input_transfer_amount}

Click deposit confirm
    Click Element    xpath=//*[@cid="dc"]

Click withdraw confirm
    Click Element    xpath=//*[@cid="wc"]

Click transfer confirm
    Click Element    xpath=//*[@cid="tc"]

Click bill payment confirm
    Click Element    xpath=//*[@cid="bc"]

Click bill payment water charge
    Click Element    xpath=//*[@cid="b1"]

Click bill payment electric charge
    Click Element    xpath=//*[@cid="b2"]

Click bill payment phone charge
    Click Element    xpath=//*[@cid="b3"]

Input and verify bill payment amount
    [Arguments]    ${input_transfer_amount}
    Input Text    xpath=//*[@cid="b4"]    ${input_transfer_amount}
    ${transfer_amount}    Get Value    xpath=//*[@cid="b4"]
    Should Be Equal    ${transfer_amount}    ${input_transfer_amount}

Wait Load Account Page
    Sleep    2s
    # Wait Until Element Contains    //*[@id="root"]/div/div/div/div[2]/article/h2[1]    Account ID:

Check error deposit
    [Arguments]    ${input_error}
    ${element_text}    Get Text    xpath=//*[@cid="deposite-error-mes"]
    Should Be Equal As Strings    ${element_text}    ${input_error}

Check error withdraw
    [Arguments]    ${input_error}
    ${element_text}    Get Text    xpath=//*[@cid="withdraw-error-mes"]
    Should Be Equal As Strings    ${element_text}    ${input_error}

Check error Bill
    [Arguments]    ${input_error}
    ${element_text}    Get Text    xpath=//*[@cid="billpayment-error-mes"]
    Should Be Equal As Strings    ${element_text}    ${input_error}

Check error transfer
    [Arguments]    ${input_error}
    Wait Until Element Contains    xpath=//*[@cid="transfer-error-mes"]    ${input_error}
    # ${element_text}    Get Text    xpath=//*[@cid="transfer-error-mes"]
    # Should Be Equal As Strings    ${element_text}    ${input_error}

Clear Balance
    Sleep    30ms
    ${element_text}    Get Text    xpath=//*[@id="root"]/div/div/div/div[2]/article/h1[3]
    Input and verify withdraw    ${element_text}
    Click withdraw confirm
