*** Settings ***
Documentation                           写图片稿件
Resource                                ../UI/common.robot
Force Tags                              图片
...                                     jiangbm

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
# ${COLID}                                rs_tree_19_span              #测吧栏目
# ${JS_TYPE1}                             document.getElementsByClassName('btn btn-small')[0].click()
${TYPE}                                 //*[@id="toolArticleBtns"]/li[1]/button
${TOPIC_LOCATOR}                        SYS_TOPIC
${TOPIC_NEWS}                           自动化写图片稿标题
${AUTHOR_LOCATOR}                       SYS_AUTHORS
${AUTHOR_NEWS}                          jiangbm
${SOURCEBTN}                            btnSource
${SOURCE_NEWS}                          //*[@id="4"]/td[2]/input
${FRAME1}                               ueditor_0
${BODY_NEWS}                            "自动化图片写稿正文！"
${PICUPLOAD_BTN}                        picUploadInput
${PICLIBRARY_BTN}                       document.getElementsByClassName('btn btn-primary btn-lg btn-piclib')[0].click()
${PICLIBRARY_PIC}                       //*[@id="SYS_DOCUMENTID"]/img
${SOURCEFRAME}                          //*[contains(@src,'../../xy/GroupSelect.do?type=4&siteID=34')]
${PICLIBFRAME}                          //*[contains(@src,'../GroupSelect.do?type=0&siteID=34')]
${TOPICBIGFRAME}                        //*[contains(@src,'../../xy/ueditor/initTitleDialog.do?imagePath=&radio=NaN*NaN&itype=all&siteID=34')]
${TOPIC_PICTYPE}                        topicBig
${LOCALPIC_BTN}                         //*[@id="localFile"]
${PIC_PATH}                             F:/XFJ/UI/pic.jpg
${PICUP_PATH}                           'F:/XFJ/UI/picupload.exe'
${SAVE_BTN2}                            doSave
${SAVE_BTN}                             btnSave
${PUBLISH_BTN}                          btnPublish

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
    Sleep                               8
    Select Column                       ${FATHER_COLID}         ${COLID}

选择图片类型
    Select Article Type2                ${TYPE}
    Unselect Frame

切换到图片写稿窗口
    Select Window                       图片
    Title Should Be                     图片

写入稿件标题和作者
    Input Article                       ${TOPIC_LOCATOR}        ${TOPIC_NEWS}
    Input Article                       ${AUTHOR_LOCATOR}       ${AUTHOR_NEWS}

写入来源
    Choose Source                       ${SOURCEBTN}
    ...                                 ${SOURCEFRAME}
    ...                                 ${SOURCE_NEWS}
    ...                                 ${SAVE_BTN2}

本地上传图片
    # Execute Javascript                  ${PICUPLOAD_BTN}.click();
    # Evaluate                            os.system('E:/XFJ/UI/picupload.exe')            os
    Choose File                         ${PICUPLOAD_BTN}        ${PIC_PATH}
    Sleep                               5

图片库选择图片
    Choose Pic From PicLibrary          ${PICLIBRARY_BTN}
    ...                                 ${PICLIBFRAME}
    ...                                 ${PICLIBRARY_PIC}
    ...                                 ${SAVE_BTN2}

写入稿件正文
    Select Frame                        ${FRAME1}
    Execute Javascript                  var s=document.getElementsByTagName("body");s[0].innerHTML=${BODY_NEWS};
    Unselect Frame

# 本地上传图片
#     Execute Javascript                  ${PICUPLOAD_BTN}.click();
#     Evaluate                            os.system('E:/XFJ/UI/picupload.exe')            os

上传文章标题图
    Upload Pic In Topic                 ${TOPIC_PICTYPE}
    ...                                 ${PIC_PATH}
    ...                                 ${TOPICBIGFRAME}
    Sleep                               3

保存文章
    Publish Article                     ${PUBLISH_BTN}

    CLose Browser
