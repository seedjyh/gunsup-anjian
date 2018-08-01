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
Description=GunsUp自动CPU防御
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
// 跨项目通用
// 打印带日期时间的日志
Sub logDebug(str)
	dt = Plugin.GetSysInfo.GetDateTime()
	Call Plugin.File.WriteFileEx("D:\gunsuplog.txt", dt + "|" + str)
End Sub

// 判断颜色a、b是否相似,a、b是十六进制字符串,diff是0~255之间的数。
// 颜色a、b的RGB距离必须都小于diff才算相似。
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
// 进程操作RB
// 关闭GunsUp和Steam
Function closeAll()
	logDebug ("closing all...")
	'关闭进程guns up
	Call Lib.系统.结束进程("GUNS UP.exe")
	Delay 3000
	
	'关闭进程steam
	Call Lib.系统.结束进程("Steam.exe")
	Delay 3000
End Function

// 启动Steam进程
Function startSteam()
	RunApp "C:\Program Files (x86)\Steam\Steam.exe"
	Delay 20000
End Function
////////////////////////////////////////////////////////////////////////////////////
// 操作原语
// 全屏绕一圈鼠标
Function moveAroundMouse()
	MoveTo 50, 50
	Delay 300
	MoveTo 50, 1030
	Delay 300
	MoveTo 1850, 1030
	Delay 300
	MoveTo 1850, 50
	Delay 300
	MoveTo 50, 50 // 最后停在左上角空白处
	Delay 1000
End Function

////////////////////////////////////////////////////////////////////////////////////
// 画面判断工具函数
// 判断画面顶部是不是“Guns Up!”字样
Function isTopGunsUp()
	// “G”左下
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

// 判断画面左下角是不是“欲查看资讯”
Function isLeftBottomQueryInformation()
	// “欲”
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

// 判断画面右下角是否有齿轮
Function isRightBottomGear()
	logDebug("test-isRightBottomGear")
	// 齿轮顶部
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

// 判断画面上方是不是“中心”
Function isTopCenter()
	// “中”
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

// 判断画面右上是否是“建造点数”
Function isRightTopBuildPoint()
	// “建”
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

// 判断画面顶部是否是“战事”
Function isTopWar()
	logDebug("test-isTopWar")
	// “战”
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

// 判断画面左下方是否是“返回”
Function isLeftBottomReturn()
	logDebug("test-isLeftBottomReturn")
	// “返”
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

// 判断画面顶部是否是“灰色战事”
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

// 判断画面中心是否是对话框“开始CPU防御”
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

// 判断画面中心是否是对话框“敌人接近中”
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

// 判断画面左上是否是“得分”
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

// 判断画面右上是否是“齿轮”
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

// 判断画面右下是否是“剩余时间”
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

// 判断画面顶部是否是“敌人已撤退”
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

// 判断画面右下是否是“继续”
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

// 判断画面顶部是否是“你已战败”
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

// 判断画面顶部是否是“已遭到攻击”
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

// 判断画面顶部是否是“敌人”
Function isTopEnemy()
	// 顶部“敌人”的“敌”
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

// 判断画面底部是否是“敌人将会再次进攻，请确保基地已做好准备！”
Function isBottomPrepareBase()
	// “确”
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

// 判断画面右下角是否有“星期”二字
Function isRightBottomDayOfWeek()
	// “星”
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

// 判断任务栏是否有steam，有则返回True
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

// 判断任务栏是否有GunsUp，有则返回True
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


// 判断是否能看到最大化的steam窗口
Function isMaxWindowSteam()
	Hwnd = Plugin.Window.Find(0, "Steam")
	If Plugin.Window.IsWindow(Hwnd) = 0 Then 
		isMaxWindowSteam = False
	Else
		sRect = Plugin.Window.GetClientRect(Hwnd)'获取窗口的4个坐标
		myArray = Split(srect, "|")
		L = CLng(myArray(0))
		T = CLng(myArray(1))
		R = CLng(myArray(2))
		B = CLng(myArray(3))
		// 左上角“steam”的“S”
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

// 判断是否Steam已经登出
Function isSteamLoggedOut()
	// 标题中“登录”的“登”
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
// 画面操作函数

Function tryCloseTeamViewerMessageBox()
	hwnd = Plugin.Window.Find(0, "发起会话")
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

// 点击任务栏“GunsUp”图标
Function clickGunsUpInTaskBar()
	FindColor 1860,223,1908,819,"2D4CC6",intX,intY
	If intX > 0 And intY > 0 Then 
		MoveTo intX, intY
		Delay 1000
		LeftClick 1
		Delay 3000
	End If
End Function

// 点击任务栏“Steam”图标
Function clickSteamInTaskBar()
	FindColor 1855,259,1911,796,"491D0C",intX,intY
	If intX > 0 And intY > 0 Then 
		MoveTo intX, intY
		Delay 1000
		LeftClick 1
		Delay 3000
	End If
End Function

// 点击“Steam”最大化窗口中的“库”按钮
Function clickStorageButtonInSteamMaxWindow()
	logDebug ("clickStorageButtonInSteamMaxWindow...")
	Hwnd = Plugin.Window.Find(0, "Steam")
	If Plugin.Window.IsWindow(Hwnd) = 1 Then 
		sRect = Plugin.Window.GetClientRect(Hwnd)'获取窗口的4个坐标
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

// 点击“Steam”最大化窗口中的“GunsUp”的“开始”按钮
Function clickGunsUpStartButtonInSteamMaxWindow()
	logDebug ("clickGunsUpStartButtonInSteamMaxWindow...")
	Hwnd = Plugin.Window.Find(0, "Steam")
	If Plugin.Window.IsWindow(Hwnd) = 1 Then 
		sRect = Plugin.Window.GetClientRect(Hwnd)'获取窗口的4个坐标
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

// 登录steam
Function loginSteam()
	logDebug ("loginSteam")
	MoveTo 825, 507
	Delay 300
	LeftClick 1
	Delay 300
	SayString Plugin.File.ReadFileEx("d:\steam-password.txt") // 此文件填入自己的steam密码（明文）。
	Delay 300
	MoveTo 832, 571
	Delay 300
	LeftClick 1
	Delay 300
End Function

////////////////////////////////////////////////////////////////////////////////////
// 跨函数通用

// 判断是否是“情报”画面
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
// 处理“情报”画面：进入基地
Function processInformation()
	Call moveAroundMouse()
	MoveTo 1600, 400
	Delay 300
	KeyPress "Space", 1
	Delay 1000
	// 从“情报”进入“中心”一般只有程序重启后
	Call resetSpeedSprit()
End Function

// 判断是否是“中心”画面
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

// 处理“中心”画面
Function processCenter()
	MoveTo 224, 825
	Delay 300
	KeyPress "Space", 1
	Delay 1000
End Function

// 判断是否是“战事”画面
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
// 处理“战事”画面
Function processWar()
	Call moveAroundMouse()
	MoveTo 350, 550
	Delay 1000
	KeyPress "Space", 1
	Delay 1000
End Function

// 判断是否是“开始CPU防御”画面
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
	'==========以下是按键精灵录制的内容==========
	MoveTo 1679, 430
	Delay 473
	KeyDown "Alt", 1
	Delay 82
	KeyDown "Tab", 1
	Delay 29
	KeyUp "Alt", 1
	Delay 124
	KeyUp "Tab", 1
	'==========以上是按键精灵录制的内容==========
End Function
// 重新设定变速精灵
Function resetSpeedSprit()
	Call doAltTab()
	// 使变速精灵在最前
	FindColor 1860,213,1904,799,"BBF4FE",intX,intY
	If intX > 0 And intY > 0 Then 
		MoveTo intX, intY
		LeftClick 1
		Delay 50
		LeftClick 1 // 伪双击可以确保窗口被激活在前台，无论窗口原来是否在前台
	End If
	Delay 1000
	// 点击窗口列表
	MoveTo 764, 500
	Delay 300
	LeftClick 1
	Delay 2000
	// 选择GunsUp并点击
	FindColor 707,532,850,828,"2E54D6",intX,intY
	If intX > 0 And intY > 0 Then 
		MoveTo intX, intY
		Delay 1000
		LeftClick 1
		Delay 1000
	End If
End Function
// 处理“开始CPU防御”画面
Function processStartingCpuDefence()
	Call moveAroundMouse()
	MoveTo 830, 600
	Delay 1000
	KeyPress "Space", 1
	Delay 1000
End Function

// 判断是否是“正在CPU防御”画面
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
// 处理“正在CPU防御”画面
Function processInCpuDefence()
	'点击收集掉落的军需和特殊品
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

// 判断是否是“暂停游戏以投降”画面
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
// 处理“暂停游戏以投降”画面
Function processPauseGameForSurrender()
	KeyPress "Esc", 1
	Delay 1000
End Function

// 判断是否是“敌人已撤退”画面
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
// 处理“敌人已撤退”画面
Function processEnemyRetreated()
	Call moveAroundMouse()
	MoveTo 1700, 1030
	Delay 300
	KeyPress "Space", 1
	Delay 1000
End Function

// 判断是否是“普通的暂停”画面
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
// 处理“普通的暂停”画面
Function processNormalPause()
	KeyPress "Esc", 1
	Delay 1000
End Function

// 判断是否是“你已战败”画面
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
// 处理“你已战败”画面
Function processYouHaveLost()
	Call moveAroundMouse()
	MoveTo 1700, 1030
	Delay 300
	KeyPress "Space", 1
	Delay 1000
End Function

// 判断是否是“敌人接近中”画面
Function isEnemyIncoming()
	If Not(isMessageBoxEnemyIncoming()) Then 
		isEnemyIncoming = False
	Else 
		logDebug("isEnemyIncoming")
		isEnemyIncoming = True
	End If
End Function

// 处理“敌人接近中”画面
Function processEnemyIncoming()
	Call moveAroundMouse()
	MoveTo 960, 538
	Delay 300
	LeftClick 1
	Delay 1000
End Function

// 判断是否是“已遭到攻击”画面
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

// 处理“已遭到攻击”画面
Function processAttacked()
	Call moveAroundMouse()
	MoveTo 100, 1030
	Delay 1000
	LeftClick 1
	Delay 1000
End Function

// 判断是否是“是否要防御总部”画面
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
// 处理“是否要防御总部”画面
Function processWannaDefence()
	Call moveAroundMouse()
	Deley 300
	MoveTo 811, 630
	Delay 300
	KeyPress "Space", 1
	Delay 1000
End Function

// 判断是否是“敌人进攻中”画面
Function isEnemyAttacking()
	If Not (isTopEnemy())  Then 
		isEnemyAttacking = False
	Else 
		isEnemyAttacking = True
	End If
End Function

// 处理“敌人进攻中”画面
Function processEnemyAttacking()
	Call processInCpuDefence() // 处理方法和CPU防御一样
End Function

// 判断是否是“防御成功”
Function isDefenceSucceeded()
	If Not (isBottomPrepareBase())  Then 
		isDefenceSucceeded = False
	Else 
		logDebug("isDefenceSucceeded")
		isDefenceSucceeded = True
	End If
End Function
// 处理“防御成功”
Function processDefenceSucceeded()
	Call moveAroundMouse()
	Delay 300
	MoveTo 1680, 1030
	Delay 300
	KeyPress "Space", 1
	Delay 1000
End Function

// 判断是否是“桌面”
Function isWindowsDesktop()
	isWindowsDesktop = isRightBottomDayOfWeek()
End Function

// 处理“桌面”
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

// 未知状态的处理
Function processUnknown()
	Call moveAroundMouse()
	Delay 1000
End Function
////////////////////////////////////////////////////////////////////////////////////
// 卡死状态判断
// 同一状态持续时间超过5分钟，视为卡死。
Dim lastStateName
Dim lastStateChangeTime

// 初始化卡死判断
Function initBlockIdentify()
	lastStateName = ""
	lastStateChangeTime = now
End Function

// 判断是否卡死
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

// 处理卡死
Function processBlocked()
	logDebug ("processBlocked")
	Call closeAll()
	Call startSteam()
End Function
////////////////////////////////////////////////////////////////////////////////////
// 统一状态判断函数，返回字符串。因此也同时定义了全部的状态名。
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
// 统一状态处理函数，传入状态名。
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
