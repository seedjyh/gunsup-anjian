[General]
SyntaxVersion=2
BeginHotkey=121
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=484133e5-f3a8-457c-9965-fbdb17fefa72
Description=GunsUp卡片升级
Enable=0
AutoRun=0
[Repeat]
Type=1
Number=1
[SetupUI]
Type=2
QUI=
[Relative]
SetupOCXFile=
[Comment]

[Script]
// 针对当前位置卡片进行升级

SaveMousePos 

LeftClick 1
Delay 1000

For i=0 To 9
	KeepLoop = 0
	IfColor 948,809,"24CFFF",0 Then
		MoveTo 948, 809
		Delay 1000
		LeftClick 1
		Delay 300
	End If
	
	IfColor 1755,1025,"F2F2F2",0 Then
		MoveTo 1755,1025
		Delay 1000
		LeftClick 1
		Delay 300
	End If
	
	IfColor 1755,1025,"20BEFF",0 Then
		MoveTo 1755,1025
		Delay 1000
		LeftClick 1
		Delay 300
	End If

Next

RestoreMousePos 

