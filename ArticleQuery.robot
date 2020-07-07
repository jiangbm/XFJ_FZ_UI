*** Settings ***
Library                                 Selenium2Library
Library                                 AutoItLibrary
Resource                                ../UI/common.robot
Suite Teardown                          Run Keyword If Any Tests Failed
...                                     Kill Process Chromedriver
Force Tags                              稿件筛选
...                                     作者：jiangbm

*** Variables ***
${USERCODE}                             UserCode
${USERNAME}                             fzrb
${USERPSW}                              UserPassword
${PSW}                                  Fzrb123456
${LOGIN_BTN}                            login-btn
${FIRST_TAB}                            cmainTab
${SECOND_TAB}                           subtab_a_capp
${FRAME}                                //*[@id="cappFrm"]/iframe
${FATHER_COLID}                         rs_tree_1_span
${COLID}                                rs_tree_8_span
${TYPE_LOCATOR}                         a_type
${PUBLISHTIME_START}                    a_pubTime_0
${PUBLISHTIME_END}                      a_pubTime_1
${DOSEARCH}                             searchList
${ARTCILEID}                            SYS_DOCUMENTID
${ID}                                   5079

*** Test Cases ***
打开浏览器并登陆
    Open Browser And Login              ${USERCODE}
    ...                                 ${USERNAME}
    ...                                 ${USERPSW}
    ...                                 ${PSW}
    ...                                 ${LOGIN_BTN}

定位到app发布库
    Change Tab                          ${FIRST_TAB}
    Sleep                               5
    change Tab                          ${SECOND_TAB}
选择栏目
    Select Frame                        ${FRAME}
    Sleep                               5
    Select Column                       ${FATHER_COLID}     ${COLID}

按稿件类型筛选
    Select From List By Label           ${TYPE_LOCATOR}     专题
    Sleep                               3

按稿件发布时间筛选
    Click Element                       ${PUBLISHTIME_START}
    Execute Javascript                  var s = document.getElementsByClassName("cui_pm icon-arrow-left")[0].click();
    Execute Javascript                  var s = document.getElementsByClassName("cui_dbtn")[0].click();
    Click Element                       ${PUBLISHTIME_END}
    Execute Javascript                  var s1=document.getElementsByClassName("day")[20].click();
    Execute Javascript                  var s = document.getElementsByClassName("cui_dbtn")[0].click();
    Click Element                       ${DOSEARCH}
    Sleep                               3

按稿件ID筛选
    Input Text                          ${ARTCILEID}        ${ID}
    Click Element                       ${DOSEARCH}
    Sleep                               3

    Close Browser
