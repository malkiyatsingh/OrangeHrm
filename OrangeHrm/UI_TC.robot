*** Settings ***

Library    SeleniumLibrary
Resource    ../OrangeHrm/Resource/common.robot
Suite Setup    Log To Console    Robot Start..    
Suite Teardown    Log To Console    Robot Work Done..    
Test Setup    common.OpenUrl
Test Teardown    common.Browserclose


*** Variables ***

@{LgCredential}    Admin    admin123
@{LgMessages}    Invalid credentials    Username cannot be empty    Password cannot be empty

*** Test Cases ***

TC01 Check Validation Message with Blank Username and Password
    [Tags]    Regression
    InputCredential    ${EMPTY}    ${EMPTY}
    MessagesforInvalidCredentials    ${LgMessages}[1]
    Capture Page Screenshot
    
TC02 Check Validation Message with invalid Username and Password
    [Tags]    Regression
    InputCredential    ${LgCredential}[0]    ${LgCredential}[0]
    MessagesforInvalidCredentials    ${LgMessages}[0]
    Capture Page Screenshot

TC03 Check Validation Message with valid Username and blank Password
    [Tags]    Regression
    InputCredential    ${LgCredential}[0]    ${EMPTY}
    MessagesforInvalidCredentials    ${LgMessages}[2]
    Capture Page Screenshot
    
TC04 Check Validation Message with blank Username and valid Password
    [Tags]    Regression
    InputCredential    ${EMPTY}    ${LgCredential}[1]
    MessagesforInvalidCredentials    ${LgMessages}[1]
    Capture Page Screenshot

TC05 Check ForgotPassword Link
    [Tags]    Regression
    Page Should Contain Element    id=forgotPasswordLink    ElementNotFound
    Capture Element Screenshot    id=forgotPasswordLink      

TC06 Check Validation Message with valid Username and valid Password
    [Tags]    Smoke
    InputCredential    ${LgCredential}[0]    ${LgCredential}[1]
    Wait Until Element Is Visible    id=welcome    30s    Login Failed
    Capture Page Screenshot

TC07 Add Leave Entitlement
    [Tags]    Smoke
    [Documentation]    Adding leave against Employee name 
    InputCredential    ${LgCredential}[0]    ${LgCredential}[1]
    Wait Until Element Is Visible    id=div_legend_pim_employee_distribution_legend    60s    Login Failed
    GoToLeave_Suboption    id=menu_leave_Entitlements
    Click Element    id=menu_leave_addLeaveEntitlement
    ReadExceldataInput    1    id=entitlements_employee_empName
    Press Keys    None    TAB
    Select From List By Label    id=entitlements_leave_type    FMLA US
    Input Text    id=entitlements_entitlement    10
    Capture Page Screenshot
    Click Button    id=btnSave    
    Wait Until Element Is Visible    id=btnDelete    60s    Days Not added
    Page Should Contain Button    id=btnDelete
    Capture Page Screenshot

TC08 Assign Leave for one full day
    [Tags]    Smoke
    [Documentation]    Validate Employee able to apply leave for a day
    InputCredential    ${LgCredential}[0]    ${LgCredential}[1]
    Wait Until Element Is Visible    id=div_legend_pim_employee_distribution_legend    60s    Login Failed
    GoToLeave_Suboption    id=menu_leave_assignLeave
    Wait Until Page Contains Element    id=assignBtn    30s    Suboption Page not open
    ReadExceldataInput    1    id=assignleave_txtEmployee_empName
    Select From List By Label    id=assignleave_txtLeaveType    FMLA US
    Wait Until Element Is Visible    id=assignleave_leaveBalance    30s    Leave Balance Failed
    ReadExceldataInput    3    id=assignleave_txtFromDate
    Press Keys    None    TAB
    ReadExceldataInput    3    id=assignleave_txtToDate
    Press Keys    None    TAB
    Wait Until Element Is Visible    id=assignleave_duration_duration    30s    Duration Dropdown not found
    Select From List By Label    id=assignleave_duration_duration    Full Day
    ReadExceldataInput    5    id=assignleave_txtComment
    Capture Page Screenshot
    Click Button    id=assignBtn
    Sleep    1s 
    Page Should Contain    Successfully Assigned
    Capture Page Screenshot
   
TC09 Apply Leave on Weekend
    [Tags]    Regression
    [Documentation]    Validate Employee able to apply leave for a day
    InputCredential    ${LgCredential}[0]    ${LgCredential}[1]
    Wait Until Element Is Visible    id=div_legend_pim_employee_distribution_legend    60s    Login Failed
    GoToLeave_Suboption    id=menu_leave_assignLeave
    Wait Until Page Contains Element    id=assignBtn    30s    Suboption Page not open
    ReadExceldataInput    1    id=assignleave_txtEmployee_empName
    Select From List By Label    id=assignleave_txtLeaveType    FMLA US
    Wait Until Element Is Visible    id=assignleave_leaveBalance    30s    Leave Balance Failed
    ReadExceldataInput    2    id=assignleave_txtFromDate
    Press Keys    None    TAB
    ReadExceldataInput    2    id=assignleave_txtToDate
    Press Keys    None    TAB
    Wait Until Element Is Visible    id=assignleave_duration_duration    30s    Duration Dropdown not found
    Select From List By Label    id=assignleave_duration_duration    Full Day
    ReadExceldataInput    5    id=assignleave_txtComment
    Capture Page Screenshot
    Click Button    id=assignBtn
    Sleep    1s
    Page Should Contain    Failed to Submit: No Working Days Selected
    Capture Page Screenshot  
