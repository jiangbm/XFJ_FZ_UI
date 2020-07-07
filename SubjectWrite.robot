*** Settings ***
Documentation     写专题稿件
Library                                 AutoItLibrary
Resource                                ../UI/common.robot
Force Tags                              视频
...                                     作者：jiangbm

# Suite Setup       Log    0# 0
Suite Teardown                          Run Keyword If Any Tests Failed
...                                     Kill Process Chromedriver
# Test Setup        Log    1# 1   Test Setup/Teardown每个case均执行一遍
# Test Teardown     Log    2# 4

*** Variables ***
${USERCODE}                             UserCode
${USERNAME}                             fzrb
${USERPSW}                              UserPassword
${PSW}                                  Fzrb123456
${LOGIN_BTN}                            login-btn
${FIRST_TAB}                            cmainTab
${SECOND_TAB}                           subtab_a_capp
@{FRAMELIST}                            //*[@id="cappFrm"]/iframe    #app发布库iframe
...                                     //*[contains(@src,'../../xy/GroupSelect.do?type=4&siteID=34')]    #专题-来源iframe
...                                     //*[contains(@src,'../../xy/ueditor/initTitleDialog.do?imagePath=&radio=NaN*NaN&itype=big&siteID=34')]    #专题头图iframe
...                                     xpath=/html/body/div[1]/div/table/tbody/tr[2]/td[2]/div/table/tbody/tr[2]/td[2]/div/iframe    #专题-栏目选择、标题图iframe
...                                     groupSelect    #专题-图片库iframe
#列表创建             @{list};调用      @{list}[n]

# ${FRAME}                              //*[@id="cappFrm"]/iframe
# ${SOURCEFRAME}                        //*[contains(@src,'../../xy/GroupSelect.do?type=4&siteID=34')]
# ${COL_FRAME}                          xpath=/html/body/div[1]/div/table/tbody/tr[2]/td[2]/div/table/tbody/tr[2]/td[2]/div/iframe
# ${COVERIMG_FRAME}                     //*[contains(@src,'../../xy/ueditor/initTitleDialog.do?imagePath=&radio=NaN*NaN&itype=big&siteID=34')]
# ${PICLIB_FRAME}                       groupSelect
# ${TOPICONEFRAME}                      xpath=/html/body/div[1]/div/table/tbody/tr[2]/td[2]/div/table/tbody/tr[2]/td[2]/div/iframe
${FATHER_COLID}                         rs_tree_1_span
${COLID}                                rs_tree_8_span
${TYPE}                                 //*[@id="toolArticleBtns"]/li[4]/button
${TOPIC_LOCATOR}                        SYS_TOPIC
${TOPIC_NEWS}                           自动化写专题稿标题
${AUTHOR_LOCATOR}                       SYS_AUTHORS
${AUTHOR_NEWS}                          jiangbm
&{SOURCEDICT}                           BTN=btnSource
...                                     NEWS=//*[@id="4"]/td[2]/input
#字典创建             &{dict};          调用    &{dict}[key]    ${dict.key}
# ${SOURCEBTN}                          btnSource
# ${SOURCE_NEWS}                        //*[@id="4"]/td[2]/input
${ABSTRACT_LOCATOR}                     a_abstract
${ABSTRACT_NEWS}                        摘要测试！！！
${LINKCOL_LOCATOR}                      btnlinkColName
${COLSEARCH}                            colSearch
${SEARCH_KW}                            专题  #吃遍美食
${POPLIST_LOCATOR}                      //*[@class="ac_results"]/ul/li[7]
${POPLIST}                              //*[contains(@class,'ac_even')
${COL_LOCATOR}                          rs_tree_23_a
${COLOK_BTN}                            btnColOK
${CHOOSEPIC_BTN}                        iconSpecial
${COLICON16BY9}                         colIcon16by9
${PICLIB_TAB}                           //a[contains(text(),'图片库')]    #//*[@id="tabUl"]/li[2]/a
${PICLIBRARY_PIC}                       //*[@id="SYS_DOCUMENTID"]/img
${LOCALPIC_BTN}                         localFile
${USEORGINAL_BTN}                       useOrignalBtn
${LISTDISPLAY}                          //*[@id="divRight"]/div[1]/ul/li[2]
${TOPIC_PICTYPE}                        topicBig
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
    Select Frame                        @{FRAMELIST}[0]     #${FRAME}
    Sleep    7
    Select Column                       ${FATHER_COLID}     ${COLID}

选择专题类型
    Select Article Type2                ${TYPE}
    Unselect Frame

切换到专题写稿窗口
    Select Window                       专题
    Title Should Be                     专题

写入稿件标题、作者、来源、摘要
    Input Article                       ${TOPIC_LOCATOR}    ${TOPIC_NEWS}
    Input Article                       ${AUTHOR_LOCATOR}   ${AUTHOR_NEWS}
    Choose Source                       &{SOURCEDICT}[BTN]
    ...                                 @{FRAMELIST}[1]     #${SOURCEFRAME}
    ...                                 ${SOURCEDICT.NEWS}
    ...                                 ${SAVE_BTN2}
    Input Article                       ${ABSTRACT_LOCATOR}
    ...                                 ${ABSTRACT_NEWS}

挂载栏目选择
    Execute Javascript                  ${LINKCOL_LOCATOR}.click();
    Wait Until Element Is Visible       @{FRAMELIST}[3]     10    #${COL_FRAME}    10
    Select Frame                        @{FRAMELIST}[3]
    Input Text                          ${COLSEARCH}        ${SEARCH_KW}
    Sleep                               5

    Click Element                       ${POPLIST_LOCATOR}
    #---鼠标悬浮时class值为ac_even ac_over,用contains模糊匹配所有包含ac_even的class属性值---
    # @{popmenu}                          Get Webelements     ${POPLIST}
    # Click Element                       @{popmenu}[3]
    Sleep                               5

    # AutoItLibrary.Send                  {ENTER}
    # Sleep                               3
    AutoItLibrary.Send                {PGDN}
    # Scroll Element Into View            ${COL_LOCATOR}    #rs_tree_24_span
    Sleep                               3
    Click Button                        ${COLOK_BTN}
    Unselect Frame

专题头图上传(本地图片)
    Execute Javascript                  ${CHOOSEPIC_BTN}.click();
    Sleep                               3
    Upload Local Pic                    @{FRAMELIST}[2]     #${COVERIMG_FRAME}
    ...                                 ${LOCALPIC_BTN}
    ...                                 ${PIC_PATH}
    ...                                 ${USEORGINAL_BTN}
    Sleep                               5

专题头图上传(图片库)
    Click Element                       ${COLICON16BY9}     #切换16：9
    Execute Javascript                  ${CHOOSEPIC_BTN}.click();
    Sleep                               5
    Select Frame                        @{FRAMELIST}[3]     #${TOPICONEFRAME}
    Click Link                          ${PICLIB_TAB}       #切换图片库tab页
    Sleep                               5
    Choose Pic From PicLibrary1         @{FRAMELIST}[4]     #${PICLIB_FRAME}
    ...                                 ${PICLIBRARY_PIC}
    ...                                 ${SAVE_BTN2}
    Select Frame                        @{FRAMELIST}[3]     #${TOPICONEFRAME}
    Sleep                               5
    Click Button                        ${USEORGINAL_BTN}
    Unselect Frame
    Sleep                               3

上传文章标题图
    Click Element                       ${LISTDISPLAY}
    Upload Pic2 In Topic                ${TOPIC_PICTYPE}
    ...                                 ${PICUP_PATH}
    ...                                 @{FRAMELIST}[3]    #${TOPICONEFRAME}
    Sleep                               3

保存文章
    Save Article                        ${SAVE_BTN}

    CLose Browser


