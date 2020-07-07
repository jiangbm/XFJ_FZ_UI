*** Settings ***
Library                                 Selenium2Library
Library                                 OperatingSystem

** Variables ***
${SERVER_URL}                           http://47.111.8.90:8080/e5workspace/Login.jsp
${BROWSER}                              chrome

*** Keywords ***
Open Browser And Login
	[Documentation]					    登录工作平台
    [Arguments]                         ${usercode}
    ...                                 ${username}
    ...                                 ${userpassword}
    ...                                 ${password}
    ...                                 ${loginbtn}
    Open Browser                        ${SERVER_URL}       ${BROWSER}
    Maximize Browser Window
    Wait Until Element IS Visible       ${usercode}         10
    Clear Element Text                  ${usercode}
    Input Text                          ${usercode}         ${username}
    Input Text                          ${userpassword}     ${password}
    Click Button                        ${loginbtn}

Change Tab
    [Documentation]					    切换tab页
    [Arguments]                         ${tab_id}
    Wait Until Element Is Visible       ${tab_id}           10
    Click Element                       ${tab_id}

Select Column
    [Documentation]					    选择投稿栏目
    [Arguments]                         ${father_colid}
    ...                                 ${colid}
    Wait Until Element Is Visible       ${father_colid}
    Click Element                       ${father_colid}
    Click Element                       ${colid}

Select Article Type
    [Documentation]                     选择写稿
    [Arguments]                         ${type}
    Wait Until Element Is Visible       //*[@id="toolTR"]   5
    Execute Javascript                  var s=${type}

Select Article Type2
    [Documentation]                     选择写稿类型
    [Arguments]                         ${type}
    Click button                        //*[@title="更多类型"]
    Wait Until Element Is Visible       //*[@id="toolArticleBtns"]       5
    Click Button                        ${type}

Input Article
    [Documentation]                     输入文章内容（标题/作者等）
    [Arguments]                         ${locator}
    ...                                 ${locator1}
    Wait Until Element Is Visible       ${locator}          20
    Input Text                          ${locator}          ${locator1}

Choose Source
    [Documentation]                     选择文章来源
    [Arguments]                         ${locator}
    ...                                 ${frame}
    ...                                 ${locator1}
    ...                                 ${savebtn}
    Click Button                        ${locator}
    Sleep                               3
    Select Frame                        ${frame}
    Click Element                       ${locator1}
    Click Button                        ${savebtn}
    Unselect Frame

Choose Pic From PicLibrary1
    [Documentation]                     图片库选择图片
    [Arguments]                         ${frame}
    ...                                 ${locator1}
    ...                                 ${savebtn}
    # Execute Javascript                var s=${locator}
    # Sleep                             3
    Select Frame                        ${frame}
    Click Element                       ${locator1}
    Click Button                        ${savebtn}
    Unselect Frame

Choose Pic From PicLibrary
    [Documentation]                     图片库选择图片
    [Arguments]                         ${locator}
    ...                                 ${frame}
    ...                                 ${locator1}
    ...                                 ${savebtn}
    Execute Javascript                  var s=${locator}
    Sleep                               3
    Select Frame                        ${frame}
    Click Element                       ${locator1}
    Click Button                        ${savebtn}
    Unselect Frame

Choose Video From VideoLibrary
    [Documentation]                     本地视频选择视频
    [Arguments]                         ${locator}
    ...                                 ${frame}
    ...                                 ${locator1}
    ...                                 ${submitbtn}
    Execute Javascript                  var s=${locator}
    Sleep                               5
    Select Frame                        ${frame}
    Click Element                       ${locator1}
    Click Button                        ${submitbtn}
    Unselect Frame

Clear Img
    [Arguments]                         ${locator}
    ...                                 ${imgpreview}
    ${bool}                             Run Keyword And Return Status
    ...                                 Page Should Contain     ${imgpreview}
    Log                                 ${bool}
    Run Keyword If                      ${bool}
    ...                                 Click Element           ${locator}
    Handle Alert                        ACCEPT

Upload Local Pic
    [Documentation]                     上传本地图方法 choose file关键字
    [Arguments]                         ${frame}
    ...                                 ${locator}
    ...                                 ${filepath}
    ...                                 ${savebtn}
    Select Frame                        ${frame}
    Choose File                         ${locator}          ${filepath}
    Sleep                               3
    Click Button                        ${savebtn}
    Unselect Frame

Upload Local Pic2
    [Documentation]                     上传本地图方法  autoit软件和eavaluate关键字
    [Arguments]                         ${frame}
    ...                                 ${locator}
    ...                                 ${filepath}
    ...                                 ${savebtn}
    Select Frame                        ${frame}
    Click Element                       ${locator}
    Evaluate                            os.system(${filepath})  os
    Sleep                               10
    Click Button                        ${savebtn}
    Unselect Frame

Upload Pic In Topic
    [Documentation]                     上传标题图方法 choose file关键字
    [Arguments]                         ${topictype}
    ...                                 ${filepath}
    ...                                 ${frame}
    Click Element                       ${topictype}
    Sleep                               5
    Select Frame                        ${frame}
    Choose File                         localFile               ${filepath}
    Sleep                               3
    Click Button                        useOrignalBtn
    Unselect Frame

Upload Pic2 In Topic
    [Documentation]                     上传标题图方法  autoit软件和eavaluate关键字
    [Arguments]                         ${topictype}
    ...                                 ${filepath}
    ...                                 ${frame}
    Click Element                       ${topictype}
    Sleep                               5
    # Select Frame                      //*[contains(@src,'../../xy/ueditor/initTitleDialog.do?imagePath=&radio=NaN*NaN&itype=all&siteID=34')]
    Select Frame                        ${frame}
    Click Element                       localFile
    Evaluate                            os.system(${filepath})  os
    Sleep                               10
    Click Button                        useOrignalBtn
    Unselect Frame

Upload Pic In Body
    [Documentation]                     上传本地图片到正文
    [Arguments]                         ${picbtn}
    ...                                 ${choosebtn}
    ...                                 ${picpath}
    ...                                 ${acceptbtn}
    Wait Until Element Is Visible       ${picbtn}               10
    Click Element                       ${picbtn}
    Sleep                               3
    Select Frame                        edui85_iframe
    Choose File                         ${choosebtn}            ${picpath}
    Unselect Frame
    Sleep                               3
    Click Element                       ${acceptbtn}

Save Article
    [Documentation]                     保存文章
    [Arguments]                         ${locator}
    Wait Until Element Is Visible       ${locator}          5
    Click Button                        ${locator}
    Sleep                               1
    # Handle Alert                      ACCEPT

Publish Article
    [Documentation]                     发布文章
    [Arguments]                         ${locator}
    Wait Until Element Is Visible       ${locator}          3
    Click Button                        ${locator}
    Sleep                               1

Cancel Article
    [Documentation]                     取消保存文章
    [Arguments]                         ${locator}
    Wait Until Element Is Visible       ${locator}          3
    Click Button                        ${locator}
    Sleep                               1
    Handle Alert                        ACCEPT

Kill Process Chromedriver
    [Documentation]                     结束chromedriver进程
    OperatingSystem.Run                 tasklist|find "chromedriver">nul && taskkill /f /t /im chromedriver.exe

Select Context Menu Item
    [Documentation]                     选择右键菜单项
    [Arguments]                         ${article}
    ...                                 ${item}
    Wait Until Element Is Visible       ${article}                5
    Right Click Element                 ${article}
    Sleep                               3
    Click Element                       ${item}

Handle Article
    [Documentation]                     文章操作
    [Arguments]                         ${article}
    ...                                 ${item}
    Wait Until Element Is Visible       ${article}                5
    Click Element                       ${item}