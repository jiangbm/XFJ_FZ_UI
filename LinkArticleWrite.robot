*** Settings ***
Documentation                           写链接稿件
Resource                                ../UI/common.robot
Force Tags                              视频
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
${TYPE}                                 //*[@id="toolArticleBtns"]/li[3]/button
${TOPIC_LOCATOR}                        SYS_TOPIC
${TOPIC_NEWS}                           自动化写链接稿标题
${AUTHOR_LOCATOR}                       SYS_AUTHORS
${AUTHOR_NEWS}                          jiangbm
${SOURCEBTN}                            btnSource
${SOURCE_NEWS}                          //*[@id="4"]/td[2]/input
${SOURCEFRAME}                          //*[contains(@src,'../../xy/GroupSelect.do?type=4&siteID=34')]
${LINK_URL}                             a_url
${ARTICLEURL}                           http://opinion.people.com.cn/n1/2020/0225/c223228-31603267.html
${TOPIC_PICTYPE}                        topicOne
${TOPICONEFRAME}                        xpath=/html/body/div[1]/div/table/tbody/tr[2]/td[2]/div/table/tbody/tr[2]/td[2]/div/iframe
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
    Select Frame                        ${FRAME}
    Sleep                               7
    Select Column                       ${FATHER_COLID}         ${COLID}

选择链接类型
    Select Article Type2                ${TYPE}
    Unselect Frame

切换到链接写稿窗口
    Select Window                       链接
    Title Should Be                     链接

写入稿件标题和作者
    Input Article                       ${TOPIC_LOCATOR}        ${TOPIC_NEWS}
    Input Article                       ${AUTHOR_LOCATOR}       ${AUTHOR_NEWS}

写入来源
    Choose Source                       ${SOURCEBTN}
    ...                                 ${SOURCEFRAME}
    ...                                 ${SOURCE_NEWS}
    ...                                 ${SAVE_BTN2}

写入稿件链接地址
    Input Article                       ${LINK_URL}              ${ARTICLEURL}

上传文章标题图
    Upload Pic2 In Topic                ${TOPIC_PICTYPE}
    ...                                 ${PICUP_PATH}
    ...                                 ${TOPICONEFRAME}
    Sleep                               3

保存文章
    Save Article                        ${SAVE_BTN}

    CLose Browser