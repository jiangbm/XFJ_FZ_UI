$pic_path="F:\XFJ\UI\pic.jpg"
WinActivate("��");
ControlFocus("��","","Edit1")
WinWait("[CLASS:#32770]","",10)
ControlSetText("��","","Edit1",$pic_path)
Sleep(2000)
ControlClick("��","","Button1")