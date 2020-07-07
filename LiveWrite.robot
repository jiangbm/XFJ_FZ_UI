*** Settings ***
Library                                 Selenium2Library
Resource                                ../UI/common.robot
Suite Teardown                          Run Keyword If Any Tests Failed
...                                     Kill Process Chromedriver
Force Tags                              直播
...                                     作者：jiangbm

*** Variables ***
${USERCODE}                             UserCode
${USERNAME}                             fzrb
${USERPSW}                              UserPassword
${PSW}                                  Fzrb123456
${LOGIN_BTN}                            login-btn
${FIRST_TAB}                            cmainTab
${SECOND_TAB}                           subtab_a_capp
@{FRAMELIST}                            //*[@id="cappFrm"]/iframe    #app发布库iframe
...                                     //*[contains(@src,'../../xy/GroupSelect.do?type=4&siteID=34')]    #直播-来源iframe
...                                     //*[contains(@src,'../../xy/SimpleSelect.do?type=0&siteID=34')]    #直播-话题选择iframe
...                                     xpath=/html/body/div[1]/div/table/tbody/tr[2]/td[2]/div/table/tbody/tr[2]/td[2]/div/iframe    #直播-标题图iframe

${FATHER_COLID}                         rs_tree_1_span
${COLID}                                rs_tree_8_span
${TYPE}                                 //*[@id="toolArticleBtns"]/li[5]/button
${TOPIC_LOCATOR}                        SYS_TOPIC
${TOPIC_NEWS}                           自动化写直播稿标题
${AUTHOR_LOCATOR}                       SYS_AUTHORS
${AUTHOR_NEWS}                          jiangbm
&{SOURCEDICT}                           BTN=btnSource
...                                     NEWS=//*[@id="4"]/td[2]/input
${ABSTRACT_LOCATOR}                     a_abstract
${ABSTRACT_NEWS}                        摘要测试！！！
${LIVETEMPLATE_BTN}                     btnLiveTemplate
${LIVENEWS_JS}                          document.getElementsByClassName('list-check')[1].click()

${TOPIC_PICTYPE}                        topicOne
${LOCALPIC_BTN}                         localFile
${USEORGINAL_BTN}                       useOrignalBtn
${PIC_PATH}                             F:/XFJ/UI/pic.jpg
${PICUP_PATH}                           'F:/XFJ/UI/picupload.exe'
${SAVE_BTN2}                            doSave
${SAVE_BTN}                             btnSave
${PUBLISH_BTN}                          btnPublish
${CANCEL_BTN}                           btnCancel

*** Keywords ***

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
    Select Frame                        @{FRAMELIST}[0]
    Sleep    5
    Select Column                       ${FATHER_COLID}     ${COLID}

选择直播类型
    Select Article Type2                ${TYPE}
    Unselect Frame

切换到直播写稿窗口
    Select Window                       直播
    Title Should Be                     直播

写入稿件标题、作者、来源、摘要
    Input Article                       ${TOPIC_LOCATOR}    ${TOPIC_NEWS}
    Input Article                       ${AUTHOR_LOCATOR}   ${AUTHOR_NEWS}
    Choose Source                       &{SOURCEDICT}[BTN]
    ...                                 @{FRAMELIST}[1]
    ...                                 ${SOURCEDICT.NEWS}
    ...                                 ${SAVE_BTN2}
    Input Article                       ${ABSTRACT_LOCATOR}
    ...                                 ${ABSTRACT_NEWS}
    Sleep                               3

选择直播话题
    Click Button                        ${LIVETEMPLATE_BTN}
    Wait Until Element Is Visible       @{FRAMELIST}[2]     3
    Select Frame                        @{FRAMELIST}[2]
    Sleep                               3
    # Click Element                       //*[@id="84"]/td[2]/input
    Execute Javascript                  var s=${LIVENEWS_JS};
    Click Button                        ${SAVE_BTN2}
    Unselect Frame
    Sleep                               3

直播标题图上传
    Click Element                       ${TOPIC_PICTYPE}
    Sleep                               3
    Upload Local Pic                    @{FRAMELIST}[3]
    ...                                 ${LOCALPIC_BTN}
    ...                                 ${PIC_PATH}
    ...                                 ${USEORGINAL_BTN}
    Sleep                               3

保存文章
    Save Article                        ${SAVE_BTN}

    CLose Browser


