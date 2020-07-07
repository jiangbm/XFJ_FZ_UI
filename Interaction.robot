*** Settings ***
Library                                 Selenium2Library
Library                                 AutoItLibrary
Resource                                ../UI/common.robot
Suite Teardown                          Run Keyword If Any Tests Failed
...                                     Kill Process Chromedriver
Force Tags                              稿件互动
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
...                                     xpath=/html/body/div[1]/div/table/tbody/tr[2]/td[2]/div/table/tbody/tr[2]/td[2]/div/iframe    #置顶、固定、关联弹窗iframe
...                                     frmRefColumn        #关联iframe2
${FATHER_COLID}                         rs_tree_1_span
${COLID}                                rs_tree_8_span
${ARTICLE_ID}                           5079
@{CONTEXT_MENULIST}                     //*[@id="toolMenu"]/li[1]/a     #置顶
...                                     //*[@id="toolMenu"]/li[2]/a     #取消置顶
...                                     //*[@id="toolMenu"]/li[3]/a     #固定位置
...                                     //*[@id="toolMenu"]/li[6]/a     #关联
...                                     //*[@id="toolMenu"]/li[11]/a    #稿件详情
...                                     //*[@id="toolMenu"]/li[14]/a    #流程记录
${POSITION_LOCATOR}                     position
${ARTICLE_POSITION}                     5
${START_CHECK}                          isStart
${EXPIRE_CHECK}                         isExpire
${EXPIRETIME}                           expireTime
${COLSEARCH}                            colSearch
@{ACRESULTSLIST}                        //*[@class="ac_results"]/ul/li[8]
...                                     //*[@class="ac_results"]/ul/li[1]
${COLOKBTN}                             btnColOK
${STATUS}                               a_status
${SAVE_BTN}                             btnSave
${PUBLISH_ARTICLEID}                    5174
@{ARTICLE_HANDLELIST}                   //*[@id="5174"]/td[12]/span[1]
...                                     //*[@id="5174"]/td[12]/span[2]
...                                     //*[@id="5174"]/td[12]/span[3]

${REJECTREASON}                         rejectReason
${SUBMITBTN}                            doSubmit

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
    Select Frame                        ${FRAMELIST}[0]
    Sleep                               5
    Select Column                       ${FATHER_COLID}     ${COLID}

稿件互动--右键菜单操作：置顶、取消置顶
    #置顶
    Select Context Menu Item            ${ARTICLE_ID}       ${CONTEXT_MENULIST}[0]
    Wait Until Element Is Visible       ${FRAMELIST}[1]     5
    Select Frame                        ${FRAMELIST}[1]
    Click Element                       ${START_CHECK}
    Click Element                       ${EXPIRE_CHECK}
    Click Element                       ${EXPIRETIME}
    Sleep                               3
    Execute Javascript                  var s1=document.getElementsByClassName("day")[25].click();
    Execute Javascript                  var s2=document.getElementsByClassName("hour")[7].click();
    Execute Javascript                  var s3=document.getElementsByClassName("minute")[1].click();
    Sleep                               3
    Click Button                        ${SAVE_BTN}
    Unselect Frame
    #取消置顶
    Select Frame                        ${FRAMELIST}[0]
    Select Context Menu Item            ${ARTICLE_ID}       ${CONTEXT_MENULIST}[1]
    Handle Alert                        ACCEPT

稿件互动--右键菜单操作：固定位置、取消
    # Scroll Element Into View            4809
    #设置固定位置
    Sleep                               3
    Select Context Menu Item            ${ARTICLE_ID}       ${CONTEXT_MENULIST}[2]
    Wait Until Element Is Visible       ${FRAMELIST}[1]     5
    Select Frame                        ${FRAMELIST}[1]
    Click Element                       ${START_CHECK}
    Click Element                       ${EXPIRE_CHECK}
    Select From List By Value           ${POSITION_LOCATOR}
    ...                                 ${ARTICLE_POSITION}
    Sleep                               3
    Click Element                       ${EXPIRETIME}
    Sleep                               3
    Execute Javascript                  var s1=document.getElementsByClassName("day")[25].click();
    Execute Javascript                  var s2=document.getElementsByClassName("hour")[7].click();
    Execute Javascript                  var s3=document.getElementsByClassName("minute")[1].click();
    Sleep                               3
    Click Button                        ${SAVE_BTN}
    Unselect Frame

    #取消固定位置
    Select Frame                        ${FRAMELIST}[0]
    Sleep                               3
    Select Context Menu Item            ${ARTICLE_ID}       ${CONTEXT_MENULIST}[2]
    Wait Until Element Is Visible       ${FRAMELIST}[1]     5
    Select Frame                        ${FRAMELIST}[1]
    Click Element                       ${START_CHECK}
    Click Element                       ${EXPIRE_CHECK}
    Click Button                        ${SAVE_BTN}
    Unselect Frame

稿件互动--右键菜单操作：稿件详情
    Sleep                               3
    Select Frame                        ${FRAMELIST}[0]
    Select Context Menu Item            ${ARTICLE_ID}       ${CONTEXT_MENULIST}[4]
    Select Window                       稿件详情
    Title Should Be                     稿件详情
    Maximize Browser Window
    Sleep                               3
    Win Close                           稿件详情


稿件互动--右键菜单操作：流程记录
    Sleep                               3
    Select Window                       方正翔宇
    Select Frame                        ${FRAMELIST}[0]
    Select Context Menu Item            ${ARTICLE_ID}       ${CONTEXT_MENULIST}[5]
    Select Window                       流程日志
    Title Should Be                     流程日志
    Maximize Browser Window
    Sleep                               3
    Win Close                           流程日志

稿件互动--右键菜单操作：关联
    Sleep                               3
    Select Window                       方正翔宇
    Select Frame                        ${FRAMELIST}[0]
    Select Context Menu Item            ${ARTICLE_ID}       ${CONTEXT_MENULIST}[3]
    Wait Until Element Is Visible       ${FRAMELIST}[1]     5
    Select Frame                        ${FRAMELIST}[1]
    Select Frame                        ${FRAMELIST}[2]
    Input Text                          ${COLSEARCH}        专题
    Sleep                               3
    Click Element                       ${ACRESULTSLIST}[0]
    Sleep                               3
    Click Button                        ${COLOKBTN}
    Unselect Frame

稿件互动--已发布稿件操作：撤稿、重改、查看
    #重改
    Select Frame                        ${FRAMELIST}[0]
    Input Text                          ${COLSEARCH}        11月专题
    Sleep                               3
    Click Element                       ${ACRESULTSLIST}[1]
    Sleep                               3
    Select From List By Value           ${STATUS}           1   #稿件状态选择已发布
    Handle Article                      ${PUBLISH_ARTICLEID}
    ...                                 ${ARTICLE_HANDLELIST}[1]
    Select Window                       重改
    Title Should Be                     重改
    Sleep                               3
    Win Close                           重改

    #查看
    Select Window                       方正翔宇
    Select Frame                        ${FRAMELIST}[0]
    Handle Article                      ${PUBLISH_ARTICLEID}
    ...                                 ${ARTICLE_HANDLELIST}[2]
    Select Window                       稿件详情
    Title Should Be                     稿件详情
    Sleep                               3
    Win Close                           稿件详情

    #撤稿
    Select Window                       方正翔宇
    Select Frame                        ${FRAMELIST}[0]
    Handle Article                      ${PUBLISH_ARTICLEID}
    ...                                 ${ARTICLE_HANDLELIST}[0]
    Wait Until Element Is Visible       ${FRAMELIST}[1]     5
    Select Frame                        ${FRAMELIST}[1]
    Input Text                          ${REJECTREASON}            测试撤稿
    Click Button                        ${SUBMITBTN}
    Unselect Frame

稿件互动--撤稿稿件操作：送审
    #送审
    Select Window                       方正翔宇
    Select Frame                        ${FRAMELIST}[0]
    Select From List By Value           ${STATUS}            7   #稿件状态选择已撤稿
    Handle Article                      ${PUBLISH_ARTICLEID}
    ...                                 ${ARTICLE_HANDLELIST}[1]
    Sleep                               3
    Handle Alert                        ACCEPT
    Handle Alert                        ACCEPT

稿件互动--审批中稿件操作：预览、发布
    #预览
    Select Window                       方正翔宇
    Select Frame                        ${FRAMELIST}[0]
    Select From List By Value           ${STATUS}            4   #稿件状态选择审批中
    Sleep                               3
    Handle Article                      ${PUBLISH_ARTICLEID}
    ...                                 ${ARTICLE_HANDLELIST}[2]
    Select Window                       稿件详情
    Title Should Be                     稿件详情
    Sleep                               3
    Win Close                           稿件详情

    #发布
    Select Window                       方正翔宇
    Select Frame                        ${FRAMELIST}[0]
    Select From List By Value           ${STATUS}            4
    Handle Article                      ${PUBLISH_ARTICLEID}
    ...                                 ${ARTICLE_HANDLELIST}[1]
    Sleep                               3
    Handle Alert                        ACCEPT

    Close Browser

