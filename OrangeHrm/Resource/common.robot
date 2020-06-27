*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary    
 
  
*** Variables ***

${URL}    https://opensource-demo.orangehrmlive.com/
${Browser}    chrome
${ExcelPath}    ../OrangeHrm/DataSheet/OrangeHRM.xlsx
${Excel_Row_num}    3

*** Keywords ***

OpenUrl
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Wait Until Element Is Visible    id=frmLogin    60s    PageNotOpen

InputCredential
    [Arguments]    ${username}    ${password}
    Input Text    id=txtUsername    ${username}
    Input Password    id=txtPassword    ${password}
    Click Button    id=btnLogin
    
LogoutApp
    Click Element    id=welcome
    Sleep    2s
    Click Element    xpath://*[@id="welcome-menu"]/ul/li[2]/a

Browserclose
    Close Browser
        
MessagesforInvalidCredentials
    [Arguments]    ${messages}
    ${ValidationMessage}    Get Text    id=spanMessage
    Should Be Equal As Strings    ${messages}    ${ValidationMessage}
    
GoToLeave_Suboption
    [Arguments]    ${Suboption_id}
    Click Element    id=menu_leave_viewLeaveModule
    Sleep    3s
    Click Element    ${Suboption_id}
      


ReadExceldataInput
    [Arguments]    ${Col_num}    ${UIlocator_id}
    Open Excel Document    ${ExcelPath}    doc_id
    sleep    2s
    ${CellValue}    Read Excel Cell    row_num= ${Excel_Row_num}    col_num= ${Col_num}   
    Input Text    ${UIlocator_id}    ${CellValue}
    Close Current Excel Document
    sleep    2s