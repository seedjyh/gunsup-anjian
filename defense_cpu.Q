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
MacroID=37fa30f4-4351-4a5d-b688-4cc23f2fc09d
Description=GunsUp�Զ�CPU����
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
gDiff = 5
gLargeDiff = 64
////////////////////////////////////////////////////////////////////////////////////
// ����Ŀͨ��
// ��ӡ������ʱ�����־
Sub logDebug(str)
	dt = Plugin.GetSysInfo.GetDateTime()
	Call Plugin.File.WriteFileEx("D:\gunsuplog.txt", dt + "|" + str)
End Sub

// �ж���ɫa��b�Ƿ�����,a��b��ʮ�������ַ���,diff��0~255֮�������
// ��ɫa��b��RGB������붼С��diff�������ơ�
Function similarColor(colorA, colorB, diff)
	Call Plugin.Color.ColorToRGB(colorA, aR, aG, aB)
	Call Plugin.Color.ColorToRGB(colorB, bR, bG, bB)
	If Abs(aR - bR) > diff Then 
		logDebug("Red difference:"+colorA+","+colorB)
		similarColor = False
	ElseIf Abs(aG - bG) > diff Then
		logDebug("Green difference:"+colorA+","+colorB)
		similarColor = False
	ElseIf Abs(aB - bB) > diff Then
		logDebug("Blue difference:"+colorA+","+colorB)
		similarColor = False
	Else
		similarColor = True
	End If
End Function
////////////////////////////////////////////////////////////////////////////////////
// ���̲���RB
// �ر�GunsUp��Steam
Function closeAll()
	logDebug ("closing all...")
	'�رս���guns up
	Call Lib.ϵͳ.��������("GUNS UP.exe")
	Delay 3000
	
	'�رս���steam
	Call Lib.ϵͳ.��������("Steam.exe")
	Delay 3000
End Function

// ����Steam����
Function startSteam()
	RunApp "C:\Program Files (x86)\Steam\Steam.exe"
	Delay 20000
End Function
////////////////////////////////////////////////////////////////////////////////////
// ����ԭ��
// ȫ����һȦ���
Function moveAroundMouse()
	MoveTo 50, 50
	Delay 300
	MoveTo 50, 1030
	Delay 300
	MoveTo 1850, 1030
	Delay 300
	MoveTo 1850, 50
	Delay 300
	MoveTo 50, 50 // ���ͣ�����Ͻǿհ״�
	Delay 1000
End Function

////////////////////////////////////////////////////////////////////////////////////
// �����жϹ��ߺ���
// �жϻ��涥���ǲ��ǡ�Guns Up!������
Function isTopGunsUp()
	// ��G������
	If Not (similarColor(GetPixelColor(720, 90), "4E454B", gDiff))  Then 
		isTopGunsUp = False
	ElseIf Not(similarColor(GetPixelColor(733, 90), "307BE9", gDiff)) Then 
		isTopGunsUp = False
	ElseIf Not(similarColor(GetPixelColor(733, 93), "3C5582", gDiff)) Then
		isTopGunsUp = False
	ElseIf Not(similarColor(GetPixelColor(741, 93), "3170D6", gDiff)) Then 
		isTopGunsUp = False
	Else
		isTopGunsUp = True
	End If
End Function

// �жϻ������½��ǲ��ǡ����鿴��Ѷ��
Function isLeftBottomQueryInformation()
	// ������
	If Not(similarColor(GetPixelColor(205, 1053), "6C6B6B", gDiff)) Then
		isLeftBottomQueryInformation = False
	ElseIf Not(similarColor(GetPixelColor(207, 1053), "302C2D", gDiff)) Then 
		isLeftBottomQueryInformation = False
	ElseIf Not(similarColor(GetPixelColor(209, 1053), "6F6F6F", gDiff)) Then 
		isLeftBottomQueryInformation = False
	ElseIf Not(similarColor(GetPixelColor(212, 1053), "3B3739", gDiff)) Then 
		isLeftBottomQueryInformation = False
	Else
		isLeftBottomQueryInformation = True
	End If
End Function

// �жϻ������½��Ƿ��г���
Function isRightBottomGear()
	logDebug("test-isRightBottomGear")
	// ���ֶ���
	If Not(similarColor(GetPixelColor(1851, 1016), "455964", gDiff)) Then
		isRightBottomGear = False
	ElseIf Not(similarColor(GetPixelColor(1851, 1018), "4D4D4D", gDiff)) Then 
		isRightBottomGear = False
	ElseIf Not(similarColor(GetPixelColor(1851, 1020), "FFFFFF", gDiff)) Then 
		isRightBottomGear = False
	ElseIf Not(similarColor(GetPixelColor(1851, 1026), "DAD9D9", gDiff)) Then 
		isRightBottomGear = False
	Else
		isRightBottomGear = True
	End If
End Function

// �жϻ����Ϸ��ǲ��ǡ����ġ�
Function isTopCenter()
	// ���С�
	If Not(similarColor(GetPixelColor(903, 26), "24CFFF", gDiff)) Then
		isTopCenter = False
	ElseIf Not(similarColor(GetPixelColor(908, 26), "24CFFF", gDiff)) Then 
		isTopCenter = False
	ElseIf Not(similarColor(GetPixelColor(912, 26), "24CFFF", gDiff)) Then 
		isTopCenter = False
	ElseIf Not(similarColor(GetPixelColor(908, 31), "1EB7FF", gDiff)) Then 
		isTopCenter = False
	ElseIf Not(similarColor(GetPixelColor(908, 23), "29DDFF", gDiff)) Then 
		isTopCenter = False
	Else
		isTopCenter = True
	End If
End Function

// �жϻ��������Ƿ��ǡ����������
Function isRightTopBuildPoint()
	// ������
	If Not(similarColor(GetPixelColor(1402, 142), "545454", gDiff)) Then
		isRightTopBuildPoint = False
	ElseIf Not(similarColor(GetPixelColor(1406, 142), "9C9C9C", gDiff)) Then 
		isRightTopBuildPoint = False
	ElseIf Not(similarColor(GetPixelColor(1408, 142), "606060", gDiff)) Then 
		isRightTopBuildPoint = False
	ElseIf Not(similarColor(GetPixelColor(1413, 142), "9B9B9B", gDiff)) Then 
		isRightTopBuildPoint = False
	Else
		isRightTopBuildPoint = True
	End If
End Function

// �жϻ��涥���Ƿ��ǡ�ս�¡�
Function isTopWar()
	logDebug("test-isTopWar")
	// ��ս��
	If Not(similarColor(GetPixelColor(895, 22), "2AE1FF", gDiff)) Then 
		isTopWar = False
	ElseIf Not(similarColor(GetPixelColor(895, 26), "24CEFF", gDiff)) Then 
		isTopWar = False
	ElseIf Not(similarColor(GetPixelColor(895, 32), "1DB2FF", gDiff)) Then 
		isTopWar = False
	Else 
		isTopWar = True
	End If
End Function

// �жϻ������·��Ƿ��ǡ����ء�
Function isLeftBottomReturn()
	logDebug("test-isLeftBottomReturn")
	// ������
	If similarColor(GetPixelColor(78, 1019), "DEDEDE", gDiff) And similarColor(GetPixelColor(78, 1023), "585858", gDiff) And similarColor(GetPixelColor(78, 1025), "5D4F9C", gDiff) And similarColor(GetPixelColor(78, 1029), "CDCDCD", gDiff) Then
		isLeftBottomReturn = True
	ElseIf similarColor(GetPixelColor(78, 1019), "FEFEFE", gDiff) And similarColor(GetPixelColor(78, 1023), "636363", gDiff) And similarColor(GetPixelColor(78, 1025), "5D4F9C", gDiff) And similarColor(GetPixelColor(78, 1029), "EDEDED", gDiff) Then
		isLeftBottomReturn = True
	ElseIf similarColor(GetPixelColor(78, 1019), "F1F1F1", gDiff) And similarColor(GetPixelColor(78, 1023), "5F5F5F", gDiff) And similarColor(GetPixelColor(78, 1025), "5D4F9C", gDiff) And similarColor(GetPixelColor(78, 1029), "E0E0E0", gDiff) Then
		isLeftBottomReturn = True
	Else 
		isLeftBottomReturn = False
	End If
End Function

// �жϻ��涥���Ƿ��ǡ���ɫս�¡�
Function isTopGreyWar()
	If Not(similarColor(GetPixelColor(895, 22), "0F6679", gDiff)) Then
		isTopGreyWar = False
	ElseIf Not(similarColor(GetPixelColor(895, 26), "0D5D79", gDiff)) Then 
		isTopGreyWar = False
	ElseIf Not(similarColor(GetPixelColor(895, 32), "0A5079", gDiff)) Then 
		isTopGreyWar = False
	Else
		isTopGreyWar = True
	End If
End Function

// �жϻ��������Ƿ��ǶԻ��򡰿�ʼCPU������
Function isMessageBoxStartingCpuDefence()
	If Not(similarColor(GetPixelColor(971, 483), "5E543D", gDiff)) Then
		isMessageBoxStartingCpuDefence = False
	ElseIf Not(similarColor(GetPixelColor(972, 483), "22201C", gDiff)) Then 
		isMessageBoxStartingCpuDefence = False
	ElseIf Not(similarColor(GetPixelColor(975, 483), "1CADFF", gDiff)) Then 
		isMessageBoxStartingCpuDefence = False
	ElseIf Not(similarColor(GetPixelColor(979, 483), "121212", gDiff)) Then 
		isMessageBoxStartingCpuDefence = False
	ElseIf Not(similarColor(GetPixelColor(981, 483), "5E543D", gDiff)) Then 
		isMessageBoxStartingCpuDefence = False
	Else
		isMessageBoxStartingCpuDefence = True
	End If
End Function

// �жϻ��������Ƿ��ǶԻ��򡰵��˽ӽ��С�
Function isMessageBoxEnemyIncoming()
	If Not(similarColor(GetPixelColor(958, 473), "20204E", gDiff)) Then
		isMessageBoxEnemyIncoming = False
	ElseIf Not(similarColor(GetPixelColor(958, 474), "4141DF", gDiff)) Then 
		isMessageBoxEnemyIncoming = False
	ElseIf Not(similarColor(GetPixelColor(958, 477), "23235F", gDiff)) Then 
		isMessageBoxEnemyIncoming = False
	ElseIf Not(similarColor(GetPixelColor(958, 478), "3D3DD9", gDiff)) Then 
		isMessageBoxEnemyIncoming = False
	ElseIf Not(similarColor(GetPixelColor(958, 480), "1A1A33", gDiff)) Then 
		isMessageBoxEnemyIncoming = False
	Else
		isMessageBoxEnemyIncoming = True
	End If
End Function

// �жϻ��������Ƿ��ǡ��÷֡�
Function isLeftTopScore()
	If Not(similarColor(GetPixelColor(125, 29), "FFFDF0", gDiff)) Then
		isLeftTopScore = False
	ElseIf Not(similarColor(GetPixelColor(125, 32), "5C4F24", gDiff)) Then 
		isLeftTopScore = False
	ElseIf Not(similarColor(GetPixelColor(125, 36), "FFF2DA", gDiff)) Then 
		isLeftTopScore = False
	ElseIf Not(similarColor(GetPixelColor(125, 39), "6D6234", gDiff)) Then 
		isLeftTopScore = False
	ElseIf Not(similarColor(GetPixelColor(125, 42), "FFEAC7", gDiff)) Then 
		isLeftTopScore = False
	Else
		isLeftTopScore = True
	End If
End Function

// �жϻ��������Ƿ��ǡ����֡�
Function isRightTopGear()
	If Not(similarColor(GetPixelColor(1882, 52), "4B5F6B", gDiff)) Then
		isRightTopGear = False
	ElseIf Not(similarColor(GetPixelColor(1884, 52), "232424", gDiff)) Then 
		isRightTopGear = False
	ElseIf Not(similarColor(GetPixelColor(1886, 52), "F7F7F7", gDiff)) Then 
		isRightTopGear = False
	ElseIf Not(similarColor(GetPixelColor(1892, 52), "485C66", gDiff)) Then 
		isRightTopGear = False
	Else
		isRightTopGear = True
	End If
End Function

// �жϻ��������Ƿ��ǡ�ʣ��ʱ�䡱
Function isRightBottomLeftTime()
	If Not(similarColor(GetPixelColor(1728, 964), "F3D0A6", gDiff)) Then
		isRightBottomLeftTime = False
	ElseIf Not(similarColor(GetPixelColor(1728, 970), "FFD394", gDiff)) Then 
		isRightBottomLeftTime = False
	ElseIf Not(similarColor(GetPixelColor(1728, 974), "F3BB76", gDiff)) Then 
		isRightBottomLeftTime = False
	ElseIf Not(similarColor(GetPixelColor(1728, 979), "ECAA5D", gDiff)) Then 
		isRightBottomLeftTime = False
	Else
		isRightBottomLeftTime = True
	End If
End Function

// �жϻ��涥���Ƿ��ǡ������ѳ��ˡ�
Function isTopEnemyRetreated()
	If Not(similarColor(GetPixelColor(1002, 218), "E9E9E9", gDiff)) Then
		isTopEnemyRetreated = False
	ElseIf Not(similarColor(GetPixelColor(1002, 224), "121212", gDiff)) Then 
		isTopEnemyRetreated = False
	ElseIf Not(similarColor(GetPixelColor(1002, 230), "DEDEDE", gDiff)) Then 
		isTopEnemyRetreated = False
	ElseIf Not(similarColor(GetPixelColor(1002, 235), "131313", gDiff)) Then 
		isTopEnemyRetreated = False
	ElseIf Not(similarColor(GetPixelColor(1002, 241), "D4D4D4", gDiff)) Then 
		isTopEnemyRetreated = False
	Else
		isTopEnemyRetreated = True
	End If
End Function

// �жϻ��������Ƿ��ǡ�������
Function isRightBottomContinue()
	If Not(similarColor(GetPixelColor(1695, 1044), "D2D2D2", gDiff)) Then
		isRightBottomContinue = False
	ElseIf Not(similarColor(GetPixelColor(1697, 1044), "121212", gDiff)) Then 
		isRightBottomContinue = False
	ElseIf Not(similarColor(GetPixelColor(1699, 1044), "AB8F54", gDiff)) Then 
		isRightBottomContinue = False
	ElseIf Not(similarColor(GetPixelColor(1703, 1044), "171717", gDiff)) Then 
		isRightBottomContinue = False
	ElseIf Not(similarColor(GetPixelColor(1705, 1044), "D2D2D2", gDiff)) Then 
		isRightBottomContinue = False
	Else
		isRightBottomContinue = True
	End If
End Function

// �жϻ��涥���Ƿ��ǡ�����ս�ܡ�
Function isTopYouHaveLost()
	If Not(similarColor(GetPixelColor(943, 240), "FFE779", gDiff)) Then
		isTopYouHaveLost = False
	ElseIf Not(similarColor(GetPixelColor(946, 240), "131312", gDiff)) Then 
		isTopYouHaveLost = False
	ElseIf Not(similarColor(GetPixelColor(951, 240), "D5D5D5", gDiff)) Then 
		isTopYouHaveLost = False
	ElseIf Not(similarColor(GetPixelColor(960, 240), "FFFF97", gDiff)) Then 
		isTopYouHaveLost = False
	ElseIf Not(similarColor(GetPixelColor(965, 240), "EEBE46", gDiff)) Then 
		isTopYouHaveLost = False
	Else
		isTopYouHaveLost = True
	End If
End Function

// �жϻ��涥���Ƿ��ǡ����⵽������
Function isTopAttacked()
	If Not(similarColor(GetPixelColor(858, 21), "2BE5FF", gDiff)) Then
		isTopAttacked = False
	ElseIf Not(similarColor(GetPixelColor(858, 23), "070909", gDiff)) Then 
		isTopAttacked = False
	ElseIf Not(similarColor(GetPixelColor(858, 26), "24CEFF", gDiff)) Then 
		isTopAttacked = False
	ElseIf Not(similarColor(GetPixelColor(858, 29), "070909", gDiff)) Then 
		isTopAttacked = False
	ElseIf Not(similarColor(GetPixelColor(858, 31), "1FB7FF", gDiff)) Then 
		isTopAttacked = False
	Else
		isTopAttacked = True
	End If
End Function

// �жϻ��涥���Ƿ��ǡ����ˡ�
Function isTopEnemy()
	// ���������ˡ��ġ��С�
	If Not(similarColor(GetPixelColor(899,27), "FFFFFF", gDiff)) Then 
		isTopEnemy = False
	ElseIf Not(similarColor(GetPixelColor(904,27), "FFFFFF", gDiff)) Then 
		isTopEnemy = False
	ElseIf Not(similarColor(GetPixelColor(902,24), "FFFFFF", gDiff)) Then 
		isTopEnemy = False
	ElseIf Not(similarColor(GetPixelColor(902,29), "FFFFFF", gDiff)) Then 
		isTopEnemy = False
	Else 
		isTopEnemy = True
	End If
End Function

// �жϻ���ײ��Ƿ��ǡ����˽����ٴν�������ȷ������������׼������
Function isBottomPrepareBase()
	// ��ȷ��
	If Not(similarColor(GetPixelColor(985,890), "DEDEDE", gDiff)) Then 
		isBottomPrepareBase = False
	ElseIf Not(similarColor(GetPixelColor(994,890), "DEDEDE", gDiff)) Then 
		isBottomPrepareBase = False
	ElseIf Not(similarColor(GetPixelColor(1003,890), "DEDEDE", gDiff)) Then 
		isBottomPrepareBase = False
	ElseIf Not(similarColor(GetPixelColor(985,894), "D7D7D7", gDiff)) Then 
		isBottomPrepareBase = False
	ElseIf Not(similarColor(GetPixelColor(994,894), "D7D7D7", gDiff)) Then 
		isBottomPrepareBase = False
	ElseIf Not(similarColor(GetPixelColor(1003,894), "D7D7D7", gDiff)) Then 
		isBottomPrepareBase = False
	Else 
		isBottomPrepareBase = True
	End If
End Function

// �жϻ������½��Ƿ��С����ڡ�����
Function isRightBottomDayOfWeek()
	// ���ǡ�
	If Not(similarColor(GetPixelColor(1875,990), "FFFFFF", gDiff)) Then 
		isRightBottomDayOfWeek = False
	ElseIf Not(similarColor(GetPixelColor(1875,991), "160F08", gLargeDiff)) Then 
		isRightBottomDayOfWeek = False
	ElseIf Not(similarColor(GetPixelColor(1875,992), "FFFFFF", gDiff)) Then 
		isRightBottomDayOfWeek = False
	ElseIf Not(similarColor(GetPixelColor(1875,993), "150E07", gLargeDiff)) Then 
		isRightBottomDayOfWeek = False
	ElseIf Not(similarColor(GetPixelColor(1875,994), "FFFFFF", gDiff)) Then 
		isRightBottomDayOfWeek = False
	Else 
		isRightBottomDayOfWeek = True
	End If
End Function

// �ж��������Ƿ���steam�����򷵻�True
Function existSteamInTaskBar()
	FindColor 1855,259,1911,796,"491D0C",intX,intY
	If intX > 0 And intY > 0 Then 
		logDebug("existSteamInTaskBar")
		existSteamInTaskBar = True
	Else
		logDebug("NOT existSteamInTaskBar")
		existSteamInTaskBar = False
	End If
End Function

// �ж��������Ƿ���GunsUp�����򷵻�True
Function existGunsUpInTaskBar()
	FindColor 1860,223,1908,819,"2D4CC6",intX,intY
	If intX > 0 And intY > 0 Then 
		logDebug("existGunsUpInTaskBar")
		existGunsUpInTaskBar = True
	Else 
		logDebug("NOT existGunsUpInTaskBar")
		existGunsUpInTaskBar = False
	End If
End Function


// �ж��Ƿ��ܿ�����󻯵�steam����
Function isMaxWindowSteam()
	Hwnd = Plugin.Window.Find(0, "Steam")
	If Plugin.Window.IsWindow(Hwnd) = 0 Then 
		isMaxWindowSteam = False
	Else
		sRect = Plugin.Window.GetClientRect(Hwnd)'��ȡ���ڵ�4������
		myArray = Split(srect, "|")
		L = CLng(myArray(0))
		T = CLng(myArray(1))
		R = CLng(myArray(2))
		B = CLng(myArray(3))
		// ���Ͻǡ�steam���ġ�S��
		If Not (similarColor(GetPixelColor(L + 15, T + 13), "311F1C", gDiff))  Then 
			isMaxWindowSteam = False
		ElseIf Not(similarColor(GetPixelColor(L + 15,T + 14), "7E736D", gLargeDiff)) Then 
			isMaxWindowSteam = False
		ElseIf Not(similarColor(GetPixelColor(L + 15,T + 15), "2F1F1C", gDiff)) Then 
			isMaxWindowSteam = False
		ElseIf Not(similarColor(GetPixelColor(L + 15,T + 16), "2F1F1C", gLargeDiff)) Then 
			isMaxWindowSteam = False
		ElseIf Not(similarColor(GetPixelColor(L + 15,T + 17), "7E736D", gDiff)) Then 
			isMaxWindowSteam = False
		ElseIf Not(similarColor(GetPixelColor(L + 15,T + 18), "59201C", gDiff)) Then 
			isMaxWindowSteam = False
		Else 
			isMaxWindowSteam = True
		End If
	End If
	
	If isMaxWindowSteam Then 
		logDebug ("isMaxWindowSteam")
	Else
		logDebug("NOT isMaxWindowSteam")
	End If
End Function

// �ж��Ƿ�Steam�Ѿ��ǳ�
Function isSteamLoggedOut()
	// �����С���¼���ġ��ǡ�
	If Not(similarColor(GetPixelColor(740,386), "9ECEE2", gDiff)) Then 
		isSteamLoggedOut = False
	ElseIf Not(similarColor(GetPixelColor(741,386), "31235A", gDiff)) Then 
		isSteamLoggedOut = False
	ElseIf Not(similarColor(GetPixelColor(742,386), "A49968", gDiff)) Then 
		isSteamLoggedOut = False
	Else 
		isSteamLoggedOut = True
	End If
	
	If isSteamLoggedOut Then 
		logDebug ("isSteamLoggedOut")
	End If
End Function

////////////////////////////////////////////////////////////////////////////////////
// �����������

Function tryCloseTeamViewerMessageBox()
	hwnd = Plugin.Window.Find(0, "����Ự")
	If hwnd > 0 Then 
		Rect = Plugin.Window.GetWindowRect(hwnd)
		MyArray = Split(Rect, "|")
		x = Clng(MyArray(0))
		y = Clng(MyArray(1))
		MoveTo x + 428, y + 143
		Delay 300
		LeftClick 1
		Delay 1000
	End If
End Function

// �����������GunsUp��ͼ��
Function clickGunsUpInTaskBar()
	FindColor 1860,223,1908,819,"2D4CC6",intX,intY
	If intX > 0 And intY > 0 Then 
		MoveTo intX, intY
		Delay 1000
		LeftClick 1
		Delay 3000
	End If
End Function

// �����������Steam��ͼ��
Function clickSteamInTaskBar()
	FindColor 1855,259,1911,796,"491D0C",intX,intY
	If intX > 0 And intY > 0 Then 
		MoveTo intX, intY
		Delay 1000
		LeftClick 1
		Delay 3000
	End If
End Function

// �����Steam����󻯴����еġ��⡱��ť
Function clickStorageButtonInSteamMaxWindow()
	logDebug ("clickStorageButtonInSteamMaxWindow...")
	Hwnd = Plugin.Window.Find(0, "Steam")
	If Plugin.Window.IsWindow(Hwnd) = 1 Then 
		sRect = Plugin.Window.GetClientRect(Hwnd)'��ȡ���ڵ�4������
		myArray = Split(srect, "|")
		L = CLng(myArray(0))
		T = CLng(myArray(1))
		R = CLng(myArray(2))
		B = CLng(myArray(3))
		MoveTo L+150, T+50
		Delay 1000
		LeftClick 1
		Delay 1000
	End If
End Function

// �����Steam����󻯴����еġ�GunsUp���ġ���ʼ����ť
Function clickGunsUpStartButtonInSteamMaxWindow()
	logDebug ("clickGunsUpStartButtonInSteamMaxWindow...")
	Hwnd = Plugin.Window.Find(0, "Steam")
	If Plugin.Window.IsWindow(Hwnd) = 1 Then 
		sRect = Plugin.Window.GetClientRect(Hwnd)'��ȡ���ڵ�4������
		myArray = Split(srect, "|")
		L = CLng(myArray(0))
		T = CLng(myArray(1))
		R = CLng(myArray(2))
		B = CLng(myArray(3))
		MoveTo L+340, T+200
		Delay 300
		LeftClick 1
		Delay 3000
	End If
End Function

// ��¼steam
Function loginSteam()
	logDebug ("loginSteam")
	MoveTo 825, 507
	Delay 300
	LeftClick 1
	Delay 300
	SayString Plugin.File.ReadFileEx("d:\steam-password.txt") // ���ļ������Լ���steam���루���ģ���
	Delay 300
	MoveTo 832, 571
	Delay 300
	LeftClick 1
	Delay 300
End Function

////////////////////////////////////////////////////////////////////////////////////
// �纯��ͨ��

// �ж��Ƿ��ǡ��鱨������
Function isInformation()
	If Not(isTopGunsUp()) Then 
		isInformation = False
	ElseIf Not(isLeftBottomQueryInformation()) Then 
		isInformation = False
	ElseIf Not(isRightBottomGear()) Then 
		isInformation = False
	Else 
		logDebug("isInformation")
		isInformation = True
	End If
End Function
// �������鱨�����棺�������
Function processInformation()
	Call moveAroundMouse()
	MoveTo 1600, 400
	Delay 300
	KeyPress "Space", 1
	Delay 1000
	// �ӡ��鱨�����롰���ġ�һ��ֻ�г���������
	Call resetSpeedSprit()
End Function

// �ж��Ƿ��ǡ����ġ�����
Function isCenter()
	If Not (isTopCenter())  Then 
		isCenter = False
	ElseIf Not (isRightTopBuildPoint())  Then
		isCenter = False
	ElseIf Not (isRightBottomGear())  Then
		isCenter = False
	Else 
		logDebug("isCenter")
		isCenter = True
	End If
End Function

// ���������ġ�����
Function processCenter()
	MoveTo 224, 825
	Delay 300
	KeyPress "Space", 1
	Delay 1000
End Function

// �ж��Ƿ��ǡ�ս�¡�����
Function isWar()
	logDebug("test-isWar")
	If Not (isTopWar())  Then
		isWar = False
	ElseIf Not (isLeftBottomReturn())  Then
		isWar = False
	ElseIf Not (isRightBottomGear())  Then
		isWar = False
	Else 
		logDebug("isWar")
		isWar = True
	End If
	logDebug("test-isWar-over!")
End Function
// ������ս�¡�����
Function processWar()
	Call moveAroundMouse()
	MoveTo 350, 550
	Delay 1000
	KeyPress "Space", 1
	Delay 1000
End Function

// �ж��Ƿ��ǡ���ʼCPU����������
Function isStartingCpuDefence()
	If Not (isTopGreyWar())  Then 
		isStartingCpuDefence = False
	ElseIf Not (isMessageBoxStartingCpuDefence())  Then
		isStartingCpuDefence = False
	Else 
		logDebug("isStartingCpuDefence")
		isStartingCpuDefence = True
	End If
End Function
Function doAltTab()
	'==========�����ǰ�������¼�Ƶ�����==========
	MoveTo 1679, 430
	Delay 473
	KeyDown "Alt", 1
	Delay 82
	KeyDown "Tab", 1
	Delay 29
	KeyUp "Alt", 1
	Delay 124
	KeyUp "Tab", 1
	'==========�����ǰ�������¼�Ƶ�����==========
End Function
// �����趨���پ���
Function resetSpeedSprit()
	Call doAltTab()
	// ʹ���پ�������ǰ
	FindColor 1860,213,1904,799,"BBF4FE",intX,intY
	If intX > 0 And intY > 0 Then 
		MoveTo intX, intY
		LeftClick 1
		Delay 50
		LeftClick 1 // α˫������ȷ�����ڱ�������ǰ̨�����۴���ԭ���Ƿ���ǰ̨
	End If
	Delay 1000
	// ��������б�
	MoveTo 764, 500
	Delay 300
	LeftClick 1
	Delay 2000
	// ѡ��GunsUp�����
	FindColor 707,532,850,828,"2E54D6",intX,intY
	If intX > 0 And intY > 0 Then 
		MoveTo intX, intY
		Delay 1000
		LeftClick 1
		Delay 1000
	End If
End Function
// ��������ʼCPU����������
Function processStartingCpuDefence()
	Call moveAroundMouse()
	MoveTo 830, 600
	Delay 1000
	KeyPress "Space", 1
	Delay 1000
End Function

// �ж��Ƿ��ǡ�����CPU����������
Function isInCpuDefence()
	If Not (isLeftTopScore())  Then 
		isInCpuDefence = False
	ElseIf Not (isRightTopGear())  Then
		isInCpuDefence = False
	ElseIf Not (isRightBottomLeftTime())  Then
		isInCpuDefence = False
	Else 
		logDebug("isInCpuDefence")
		isInCpuDefence = True
	End If
End Function
// ����������CPU����������
Function processInCpuDefence()
	'����ռ�����ľ��������Ʒ
	MoveTo 50,590
	LeftClick 1
	Delay 200
	MoveTo 167,500
	LeftClick 1
	Delay 200
	MoveTo 300,600
	LeftClick 1
	Delay 200
	MoveTo 370,450
	LeftClick 1
	Delay 200
	MoveTo 500,610
	LeftClick 1
	Delay 200
	MoveTo 530,410
	LeftClick 1
	Delay 200
	MoveTo 660,610
	LeftClick 1
	Delay 200
	MoveTo 680,380
	LeftClick 1
	Delay 200
	MoveTo 840,530
	LeftClick 1
	Delay 200
	MoveTo 950,370
	LeftClick 1
	Delay 200
	MoveTo 1110,500
	LeftClick 1
	Delay 200
	MoveTo 1120,320
	LeftClick 1
	Delay 200
	MoveTo 1250,430
	LeftClick 1
	Delay 200
	MoveTo 1320,250
	LeftClick 1
	Delay 200
	MoveTo 1453,277
	LeftClick 1
	Delay 200
	MoveTo 1570,170
	LeftClick 1
	Delay 200
	MoveTo 1840,180
	LeftClick 1
	Delay 200
End Function

// �ж��Ƿ��ǡ���ͣ��Ϸ��Ͷ��������
Function isPauseGameForSurrender()
	If Not(similarColor(GetPixelColor(952, 402), "DCDCDC", gDiff)) Then
		isPauseGameForSurrender = False
	ElseIf Not(similarColor(GetPixelColor(952, 405), "121212", gDiff)) Then 
		isPauseGameForSurrender = False
	ElseIf Not(similarColor(GetPixelColor(952, 408), "D1D1D1", gDiff)) Then 
		isPauseGameForSurrender = False
	ElseIf Not(similarColor(GetPixelColor(952, 534), "EFEFEF", gDiff)) Then 
		isPauseGameForSurrender = False
	ElseIf Not(similarColor(GetPixelColor(952, 536), "171717", gDiff)) Then 
		isPauseGameForSurrender = False
	ElseIf Not(similarColor(GetPixelColor(952, 538), "E7E7E7", gDiff)) Then 
		isPauseGameForSurrender = False
	Else
		logDebug("isPauseGameForSurrender")
		isPauseGameForSurrender = True
	End If
End Function
// ��������ͣ��Ϸ��Ͷ��������
Function processPauseGameForSurrender()
	KeyPress "Esc", 1
	Delay 1000
End Function

// �ж��Ƿ��ǡ������ѳ��ˡ�����
Function isEnemyRetreated()
	If Not (isTopEnemyRetreated())  Then 
		isEnemyRetreated = False
	ElseIf Not (isRightBottomReturn())  Then
		isEnemyRetreated = False
	Else 
		logDebug("isEnemyRetreated")
		isEnemyRetreated = True
	End If
End Function
// �����������ѳ��ˡ�����
Function processEnemyRetreated()
	Call moveAroundMouse()
	MoveTo 1700, 1030
	Delay 300
	KeyPress "Space", 1
	Delay 1000
End Function

// �ж��Ƿ��ǡ���ͨ����ͣ������
Function isNormalPause()
	If Not(similarColor(GetPixelColor(960, 309), "7092A2", gDiff)) Then
		isNormalPause = False
	ElseIf Not(similarColor(GetPixelColor(960, 324), "535353", gDiff)) Then 
		isNormalPause = False
	ElseIf Not(similarColor(GetPixelColor(960, 345), "3D5C74", gDiff)) Then 
		isNormalPause = False
	ElseIf Not(similarColor(GetPixelColor(960, 411), "906BDD", gDiff)) Then 
		isNormalPause = False
	Else 
		logDebug("isNormalPause")
		isNormalPause = True
	End If
End Function
// ��������ͨ����ͣ������
Function processNormalPause()
	KeyPress "Esc", 1
	Delay 1000
End Function

// �ж��Ƿ��ǡ�����ս�ܡ�����
Function isYouHaveLost()
	If Not (isTopYouHaveLost())  Then 
		isYouHaveLost = False
	ElseIf Not (isRightBottomReturn())  Then
		isYouHaveLost = False
	Else 
		logDebug("isYouHaveLost")
		isYouHaveLost = True
	End If
End Function
// ����������ս�ܡ�����
Function processYouHaveLost()
	Call moveAroundMouse()
	MoveTo 1700, 1030
	Delay 300
	KeyPress "Space", 1
	Delay 1000
End Function

// �ж��Ƿ��ǡ����˽ӽ��С�����
Function isEnemyIncoming()
	If Not(isMessageBoxEnemyIncoming()) Then 
		isEnemyIncoming = False
	Else 
		logDebug("isEnemyIncoming")
		isEnemyIncoming = True
	End If
End Function

// ���������˽ӽ��С�����
Function processEnemyIncoming()
	Call moveAroundMouse()
	MoveTo 960, 538
	Delay 300
	LeftClick 1
	Delay 1000
End Function

// �ж��Ƿ��ǡ����⵽����������
Function isAttacked()
	If Not(isTopAttacked())  Then 
		isAttacked = False
	ElseIf Not (isLeftBottomReturn())  Then
		isAttacked = False
	ElseIf Not (isRightBottomGear())  Then
		isAttacked = False
	Else 
		logDebug("isAttacked")
		isAttacked = True
	End If
End Function

// ���������⵽����������
Function processAttacked()
	Call moveAroundMouse()
	MoveTo 100, 1030
	Delay 1000
	LeftClick 1
	Delay 1000
End Function

// �ж��Ƿ��ǡ��Ƿ�Ҫ�����ܲ�������
Function isWannaDefence()
	If Not(similarColor(GetPixelColor(945, 546), "FBFBFB", gDiff)) Then
		isWannaDefence = False
	ElseIf Not(similarColor(GetPixelColor(945, 547), "727272", gDiff)) Then 
		isWannaDefence = False
	ElseIf Not(similarColor(GetPixelColor(945, 548), "121212", gDiff)) Then 
		isWannaDefence = False
	ElseIf Not(similarColor(GetPixelColor(945, 554), "EEEEEE", gDiff)) Then 
		isWannaDefence = False
	ElseIf Not(similarColor(GetPixelColor(945, 556), "242424", gDiff)) Then 
		isWannaDefence = False
	Else 
		logDebug("isWannaDefence")
		isWannaDefence = True
	End If
End Function
// �������Ƿ�Ҫ�����ܲ�������
Function processWannaDefence()
	Call moveAroundMouse()
	Deley 300
	MoveTo 811, 630
	Delay 300
	KeyPress "Space", 1
	Delay 1000
End Function

// �ж��Ƿ��ǡ����˽����С�����
Function isEnemyAttacking()
	If Not (isTopEnemy())  Then 
		isEnemyAttacking = False
	Else 
		isEnemyAttacking = True
	End If
End Function

// ���������˽����С�����
Function processEnemyAttacking()
	Call processInCpuDefence() // ����������CPU����һ��
End Function

// �ж��Ƿ��ǡ������ɹ���
Function isDefenceSucceeded()
	If Not (isBottomPrepareBase())  Then 
		isDefenceSucceeded = False
	Else 
		logDebug("isDefenceSucceeded")
		isDefenceSucceeded = True
	End If
End Function
// �����������ɹ���
Function processDefenceSucceeded()
	Call moveAroundMouse()
	Delay 300
	MoveTo 1680, 1030
	Delay 300
	KeyPress "Space", 1
	Delay 1000
End Function

// �ж��Ƿ��ǡ����桱
Function isWindowsDesktop()
	isWindowsDesktop = isRightBottomDayOfWeek()
End Function

// ���������桱
Function processWindowsDesktop()
	logDebug ("processing WindowsDesktop")
	Call tryCloseTeamViewerMessageBox()
	If isSteamLoggedOut() Then 
		Call loginSteam()
	ElseIf existGunsUpInTaskBar() Then 
		If existSteamInTaskBar() Then 
			Call clickGunsUpInTaskBar()
		Else 
			Call closeAll()
		End If
	Else 
		If existSteamInTaskBar() Then 
			If isMaxWindowSteam() Then 
				Call clickStorageButtonInSteamMaxWindow()
				Call clickGunsUpStartButtonInSteamMaxWindow()
			Else 
				Call clickSteamInTaskBar()
			End If
		Else 
			If isMaxWindowSteam() Then 
				Call closeAll()
			Else 
				Call startSteam()
			End If
		End If
	End If
End Function

// δ֪״̬�Ĵ���
Function processUnknown()
	Call moveAroundMouse()
	Delay 1000
End Function
////////////////////////////////////////////////////////////////////////////////////
// ����״̬�ж�
// ͬһ״̬����ʱ�䳬��5���ӣ���Ϊ������
Dim lastStateName
Dim lastStateChangeTime

// ��ʼ�������ж�
Function initBlockIdentify()
	lastStateName = ""
	lastStateChangeTime = now
End Function

// �ж��Ƿ���
Function isBlocked(stateName)
	If stateName <> lastStateName Then 
		logDebug("not blocked, state changing: " + lastStateName + "=>" + stateName)
		lastStateName = stateName
		lastStateChangeTime = now
		isBlocked = False
	Else 
		If datediff("s", lastStateChangeTime, now) >= 5 * 60 Then 
			logDebug("isBlocked")
			isBlocked = True
		Else 
			logDebug("not blocked yet:" + "lastStateChangeTime=" + CStr(lastStateChangeTime) + ", now=" + CStr(now))
			isBlocked = False
		End If
	End If
End Function

// ��������
Function processBlocked()
	logDebug ("processBlocked")
	Call closeAll()
	Call startSteam()
End Function
////////////////////////////////////////////////////////////////////////////////////
// ͳһ״̬�жϺ����������ַ��������Ҳͬʱ������ȫ����״̬����
Function getNowState()
	If isInformation() Then
		getNowState = "Information"
	ElseIf isCenter() Then
		getNowState = "Center"
	ElseIf isWar() Then
		getNowState = "War"
	ElseIf isStartingCpuDefence() Then
		getNowState = "StartingCpuDefence"
	ElseIf isInCpuDefence() Then
		getNowState = "InCpuDefence"
	ElseIf isPauseGameForSurrender() Then
		getNowState = "PauseGameForSurrender"
	ElseIf isEnemyRetreated() Then
		getNowState = "EnemyRetreated"
	ElseIf isNormalPause() Then
		getNowState = "NormalPause"
	ElseIf isYouHaveLost() Then
		getNowState = "YouHaveLost"
	ElseIf isAttacked() Then
		getNowState = "Attacked"
	ElseIf isWannaDefence() Then
		getNowState = "WannaDefence"
	ElseIf isEnemyAttacking() Then
		getNowState = "EnemyAttacking"
	ElseIf isDefenceSucceeded() Then
		getNowState = "DefenceSucceeded"
	ElseIf isEnemyIncoming() Then
		getNowState = "EnemyIncoming"
	ElseIf isWindowsDesktop() Then
		getNowState = "WindowsDesktop"
	Else
		getNowState = "Unknown"
	End If
End Function
// ͳһ״̬��������������״̬����
Function processNowState(state)
	logDebug ("processing state " + state)
	If state = "Information" Then
		Call processInformation()
	ElseIf state = "Center" Then
		Call processCenter()
	ElseIf state = "War" Then
		Call processWar()
	ElseIf state = "StartingCpuDefence" Then
		Call processStartingCpuDefence()
	ElseIf state = "InCpuDefence" Then
		Call processInCpuDefence()
	ElseIf state = "PauseGameForSurrender" Then
		Call processPauseGameForSurrender()
	ElseIf state = "EnemyRetreated" Then
		Call processEnemyRetreated()
	ElseIf state = "NormalPause" Then
		Call processNormalPause()
	ElseIf state = "YouHaveLost" Then
		Call processYouHaveLost()
	ElseIf state = "Attacked" Then
		Call processAttacked()
	ElseIf state = "WannaDefence" Then
		Call processWannaDefence()
	ElseIf state = "EnemyAttacking" Then
		Call processEnemyAttacking()
	ElseIf state = "DefenceSucceeded" Then
		Call processDefenceSucceeded()
	ElseIf state = "EnemyIncoming" Then
		Call processEnemyIncoming()
	ElseIf state = "WindowsDesktop" Then
		Call processWindowsDesktop()
	ElseIf state = "Unknown" Then
		Call processUnknown()
	Else 
		logDebug("Error! not-processed state name: " + state)
	End If
End Function
////////////////////////////////////////////////////////////////////////////////////
Call initBlockIdentify()
While True
	logDebug ("new round................................................................")
	nowState = getNowState()
	If isBlocked(nowState) Then 
		Call processBlocked()
		Call initBlockIdentify()
	Else
		Call processNowState(nowState)
	End If
Wend