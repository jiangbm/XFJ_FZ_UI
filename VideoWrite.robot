*** Settings ***
Documentation                           写视频稿件
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
# ${COLID}                                rs_tree_19_span              #测吧栏目
${TYPE}                                 //*[@id="toolArticleBtns"]/li[2]/button
${TOPIC_LOCATOR}                        SYS_TOPIC
${TOPIC_NEWS}                           自动化写视频稿标题
${AUTHOR_LOCATOR}                       SYS_AUTHORS
${AUTHOR_NEWS}                          jiangbm
${FRAME1}                               ueditor_0
${SOURCEBTN}                            btnSource
${SOURCE_NEWS}                          //*[@id="4"]/td[2]/input
${SOURCEFRAME}                          //*[contains(@src,'../../xy/GroupSelect.do?type=4&siteID=34')]
${DISPLAY_H}                            //*[@id="a_videoDirection"]/label[1]/span
${DISPLAY_V}                            //*[@id="a_videoDirection"]/label[1]/span
${VIDEO_LOCAL}                          //*[@id="videonext"]/label[1]/span
${VIDEO_LINK}                           //*[@id="videonext"]/label[2]/span
${LOCALVIDEO_LOCATOR}                   document.getElementsByClassName('linklivideo clearfix')[0].click()
${VIDEOLIB_FRAME}                       //*[contains(@src,'../../xy/GroupSelect.do?type=1&siteID=34')]
${VIDEO_NEWS}                           //*[@id="videos"]/div[2]/ol/li[3]
${VIDEO_SUBMIT}                         video-submit
${VIDEO_URL}                            videoUrl
${IMG_URL}                              imgUrl
${IMG_PREVIEW}                          logoImage
${VIDEO_IMG}                            videoPicUploadInput
${CLEARIMG_BTN}                         clearImg
${BODY_NEWS}                            "自动化写视频稿正文！"
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
    Select Frame                        ${FRAME}
    Sleep                               5
    Select Column                       ${FATHER_COLID}         ${COLID}

选择视频类型
    Select Article Type2                ${TYPE}
    Unselect Frame

切换到视频写稿窗口
    Select Window                       视频
    Title Should Be                     视频

写入稿件标题和作者
    Input Article                       ${TOPIC_LOCATOR}        ${TOPIC_NEWS}
    Input Article                       ${AUTHOR_LOCATOR}       ${AUTHOR_NEWS}

写入来源
    Choose Source                       ${SOURCEBTN}
    ...                                 ${SOURCEFRAME}
    ...                                 ${SOURCE_NEWS}
    ...                                 ${SAVE_BTN2}

写入稿件正文
    Select Frame                        ${FRAME1}
    Execute Javascript                  var s=document.getElementsByTagName("body");s[0].innerHTML=${BODY_NEWS};
    Unselect Frame

选择默认横屏、上传本地视频文件
    Choose Video From VideoLibrary      ${LOCALVIDEO_LOCATOR}
    ...                                 ${VIDEOLIB_FRAME}
    ...                                 ${VIDEO_NEWS}
    ...                                 ${VIDEO_SUBMIT}
    Sleep                               3

选择链接视频、写入视频地址和图片
    Click Element                       ${VIDEO_LINK}
    Click Element                       ${DISPLAY_V}
    Input Article                       ${VIDEO_URL}            https://rmrbcmsonline.peopleapp.com/upload/video/201902/15499413136e134274ac171809.mp4
    Choose File                         ${VIDEO_IMG}            ${PIC_PATH}
    Sleep                               5

清除视频图片
    Clear Img                           ${CLEARIMG_BTN}         ${IMG_PREVIEW}
    Sleep                               5

取消文章
    Cancel Article                      ${CANCEL_BTN}

    CLose Browser
