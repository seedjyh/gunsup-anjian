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
Description=GunsUpȫ����Ƭ�ϳ�
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
'==========�����ǰ�������¼�Ƶ�����==========
'��1920*1080�ֱ����£����롰��Ʒ���������ͣ��Ҫ�����ϳɵ����ſ���λ���ϣ�Ȼ�������ű���
'Ϊ�˱���ϳɵ����ؿ������������ʱ���������֡�
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

'==========�����ǰ�������¼�Ƶ�����==========