$pic_path="F:\XFJ\UI\pic.jpg"
WinActivate("打开");
ControlFocus("打开","","Edit1")
WinWait("[CLASS:#32770]","",10)
ControlSetText("打开","","Edit1",$pic_path)
Sleep(2000)
ControlClick("打开","","Button1")