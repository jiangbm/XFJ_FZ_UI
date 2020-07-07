*** Settings ***
Documentation                           写图文稿件
Resource                                ../UI/common.robot
Force Tags                              功能自动化测试
...         							jiangbm

*** Variables ***
${USERCODE}								UserCode
${USERNAME}                             fzrb
${USERPSW}                              UserPassword
${PSW}                                  Fzrb123456
${LOGIN_BTN}							login-btn
${FIRST_TAB}							cmainTab
${SECOND_TAB}							subtab_a_capp
${FRAME}								//*[@id="cappFrm"]/iframe
${FATHER_COLID}							rs_tree_1_span
# ${COLID}								rs_tree_8_span
${COLID}								rs_tree_19_span              #测吧栏目
${JS_TYPE1}								document.getElementsByClassName('btn btn-small')[0].click()
${TYPE}									//*[@id="toolArticleBtns"]/li[2]/button
${TOPIC_LOCATOR}						SYS_TOPICDIV
${TOPIC_NEWS}							自动化写稿标题
${AUTHOR_LOCATOR}						SYS_AUTHORS
${AUTHOR_NEWS}							jiangbm
${FRAME1} 								ueditor_0
${TOPICONEFRAME} 						xpath=/html/body/div[1]/div/table/tbody/tr[2]/td[2]/div/table/tbody/tr[2]/td[2]/div/iframe   #绝对路径要写上xpath=
${BODY_NEWS}							"自动化写稿正文！"
${BODYPIC}								//*[@id="edui91_body"]/div
${BODYPIC_CHOOSE} 						picUploadInput
${BODYPIC_ACCEPT} 						//*[@id="edui89_body"]/div[2]
${TOPIC_PICTYPE} 						topicOne
${LOCALPIC_BTN} 						//*[@id="localFile"]
${PIC_PATH} 							F:/XFJ/UI/pic.jpg
${PICUP_PATH}							'F:/XFJ/UI/picupload.exe'
${SAVE_BTN}								btnSave

*** Keywords ***

*** Test Cases ***
打开浏览器并登陆
	Open Browser And Login  			${USERCODE}
	...									${USERNAME}
	...									${USERPSW}
	...									${PSW}
	...									${LOGIN_BTN}
定位到app发布库
	Change Tab 							${FIRST_TAB}
	Sleep 								5
	change Tab 							${SECOND_TAB}

选择栏目
	Select Frame						${FRAME}
	Sleep 								3
	Select Column						${FATHER_COLID}			${COLID}
	Select Article type					${JS_TYPE1}
	# 选择稿件类型下拉中的视频类型
	# Select Article Type2				${TYPE}
	Unselect Frame

	# 切换到视频写稿窗口E:/XFJ/
	# Select Window						视频
	# Title Should Be       			视频

切换到图文写稿窗口
	Select Window						写稿
	Title Should Be       				写稿

写入稿件标题和作者
	Input Article 						${TOPIC_LOCATOR}		${TOPIC_NEWS}
	Input Article 						${AUTHOR_LOCATOR}		${AUTHOR_NEWS}

写入稿件正文
	Select Frame 						${FRAME1}
    Execute Javascript                  var s=document.getElementsByTagName("body");s[0].innerHTML=${BODY_NEWS};
	Unselect Frame

插入正文图片
	Upload Pic In Body  				${BODYPIC}
	...									${BODYPIC_CHOOSE}
	...									${PIC_PATH}
	...									${BODYPIC_ACCEPT}

上传文章标题图
	Upload Pic2 In Topic				${TOPIC_PICTYPE}
	... 								${PICUP_PATH}
	... 								${TOPICONEFRAME}
	Sleep 								3

保存文章
	Save Article 						${SAVE_BTN}

	CLose Browser
