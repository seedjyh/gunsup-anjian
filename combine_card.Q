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
MacroID=482b65b0-9959-4db5-b9fe-773d806c6079
Description=GunsUp全屏卡片合成
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
'==========以下是按键精灵录制的内容==========
'在1920*1080分辨率下，进入“物品栏”，鼠标停在要用来合成的那张卡的位置上，然后启动脚本。
'为了避免合成掉贵重卡，请避免运行时滚动鼠标滚轮。
SaveMousePos 
Dim KeepLoop
KeepLoop=1
While KeepLoop
	FindColor 800,400,800,620,"6B8995",intX,intY
	If intX> 0 And intY> 0 Then
		MoveTo intX, intY
		Delay 50
		KeyPress "Space", 1
		Delay 50
		KeepLoop=0
	Else 
		KeyPress "Space", 1
		Delay 50
	End If
Wend
RestoreMousePos

'==========以上是按键精灵录制的内容==========
