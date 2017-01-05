;███████╗██╗      █████╗ ███████╗██╗  ██╗    ███╗   ███╗ █████╗ ███╗   ██╗ █████╗  ██████╗ ███████╗██████╗     
;██╔════╝██║     ██╔══██╗██╔════╝██║ ██╔╝    ████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝ ██╔════╝██╔══██╗    
;█████╗  ██║     ███████║███████╗█████╔╝     ██╔████╔██║███████║██╔██╗ ██║███████║██║  ███╗█████╗  ██████╔╝    
;██╔══╝  ██║     ██╔══██║╚════██║██╔═██╗     ██║╚██╔╝██║██╔══██║██║╚██╗██║██╔══██║██║   ██║██╔══╝  ██╔══██╗    
;██║     ███████╗██║  ██║███████║██║  ██╗    ██║ ╚═╝ ██║██║  ██║██║ ╚████║██║  ██║╚██████╔╝███████╗██║  ██║    
;╚═╝     ╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝    ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝    
; Flask 1 2 5 - utility flask like quicksilver, diamond and stibnite. They will be activated by pressing/holding spacebar.
; Support different timer for every flask (4800 default for 1 2, 2000 for 5)
; Flask 3 and 4 - Divine instant life flasks
; Chat detection. Will not send 12345 to game chat Kappa
; F12 - close script
; ████████████████████████████████████████████████████████████████████████████████████████████████████████████

;#####################################################################################
if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"
   ExitApp
}
#Include %A_ScriptDir%\libs\Gdip.ahk
#Include %A_ScriptDir%\libs\Gdip_ImageSearch.ahk
#SingleInstance force
SetBatchLines, -1
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen

pToken := Gdip_Startup()
pBitmapNeedle := Gdip_CreateBitmapFromFile("bf6.png") ;vaalspark
BF_timer := 0
Flask1_timer := 0
Flask2_timer := 0
Flask3_timer := 0
Flask4_timer := 0
Flask5_timer := 0
FlaskHP_timer := 0
FlaskMP_timer := 0
Enter_key_timer := 0
;#####################################################################################

IfNotExist, Settings.ini
{
	defaultIni .= "[variables]`n"
	defaultIni .= "Flask1dur=4000`n"
	defaultIni .= "Flask2dur=4000`n"
	defaultIni .= "Flask3dur=4000`n"
	defaultIni .= "Flask4dur=4000`n"
	defaultIni .= "Flask5dur=4000`n"
	defaultIni .= "DebugX=514`n"
	defaultIni .= "DebugY=1054`n"
	defaultIni .= "MonitorNumber=1`n"
	
	defaultIni .= "[Checkbox]`n"
	defaultIni .= "Flaskbox1=1`n"
	defaultIni .= "Flaskbox2=1`n"
	defaultIni .= "Flaskbox3=1`n"
	defaultIni .= "Flaskbox4=1`n"
	defaultIni .= "Flaskbox5=1`n"
	
	
	defaultIni .= "[hotkeys]`n"
	defaultIni .= "Flask1key=1`n"
	defaultIni .= "Flask2key=2`n"
	defaultIni .= "Flask3key=3`n"
	defaultIni .= "Flask4key=4`n"
	defaultIni .= "Flask5key=5`n"
	defaultIni .= "Flask1triggerkey=RButton`n"
	defaultIni .= "Flask2triggerkey=RButton`n"
	defaultIni .= "Flask3triggerkey=RButton`n"
	defaultIni .= "Flask4triggerkey=RButton`n"
	defaultIni .= "Flask5triggerkey=RButton`n"
	FileAppend, %defaultIni%, Settings.ini, UTF-16
}


readFromFile()

Gui,Add,Hotkey,x48 y4 w50 h21 vFlask1key,%flask1key%
Gui,Add,Edit,x105 y4 w40 h21 vFlask1dur,%flask1dur%
Gui,Add,Edit,x153 y4 w50 h21 vFlask1triggerkey, %flask1triggerkey%
Gui,Add,Text,x5 y7 w35 h13,Flask 1
Gui,Add,Checkbox,x210 y8 w95 h13 vFlaskbox1, Flask 1 Enabled

Gui,Add,Hotkey,x48 y30 w50 h21 vFlask2key, %flask2key%
Gui,Add,Edit,x153 y30 w50 h21 vFlask2triggerkey, %flask2triggerkey%
Gui,Add,Edit,x105 y31 w40 h21 vFlask2dur,%flask2dur%
Gui,Add,Checkbox,x210 y32 w95 h13 vFlaskbox2,Flask 2 Enabled
Gui,Add,Text,x5 y35 w35 h13,Flask 2

Gui,Add,Hotkey,x48 y57 w50 h21 vFlask3key, %flask3key%
Gui,Add,Edit,x105 y58 w40 h21 vFlask3dur,%flask3dur%
Gui,Add,Edit,x153 y58 w50 h21 vFlask3triggerkey, %flask3triggerkey%
Gui,Add,Text,x5 y61 w35 h13,Flask 3
Gui,Add,Checkbox,x210 y61 w95 h13 vFlaskbox3,Flask 3 Enabled

Gui,Add,Hotkey,x48 y85 w50 h21 vFlask4key, %flask4key%
Gui,Add,Edit,x105 y85 w40 h21 vFlask4dur,%flask4dur%
Gui,Add,Edit,x153 y86 w50 h21 vFlask4triggerkey, %flask4triggerkey%
Gui,Add,Text,x5 y88 w35 h13,Flask 4
Gui,Add,Checkbox,x210 y91 w95 h13 vFlaskbox4,Flask 4 Enabled

Gui,Add,Hotkey,x48 y113 w50 h21 vFlask5key, %flask5key%
Gui,Add,Edit,x105 y114 w40 h21 vFlask5dur,%flask5dur%
Gui,Add,Edit,x153 y114 w50 h21 vFlask5triggerkey, %flask5triggerkey%
Gui,Add,Text,x5 y118 w35 h13,Flask 5
Gui,Add,Checkbox,x210 y119 w95 h13 vFlaskbox5,Flask 5 Enabled


Gui,Font,norm s14,
Gui,Add,Text,x14 y167 w100 h30,Debug
Gui,Add,Text,x167 y167 w100 h30,Health
Gui,Add,Text,x330 y167 w100 h30,Mana

Gui,Font
Gui,Add,Text,x17 y193 w21 h13,X
Gui,Add,Text,x55 y193 w21 h13,Y

Gui,Add,Text,x174 y193 w21 h13,X
Gui,Add,Text,x211 y193 w21 h13,Y

Gui,Add,Text,x332 y193 w21 h13,X
Gui,Add,Text,x367 y193 w21 h13,Y
Gui,Add,Edit,x9 y212 w30 h21 vDebugX,%debugX%
Gui,Add,Edit,x47 y212 w30 h21 vDebugY,%debugY%

Gui,Add,Edit,x166 y212 w30 h21 vHealthx,15
Gui,Add,Edit,x203 y212 w30 h21 vHealthy,1233
Gui,Add,Edit,x323 y212 w30 h21 vManax,1324
Gui,Add,Edit,x360 y212 w30 h21 vManay,1254

Gui,Add,Text,x17 y233 w21 h13,R
Gui,Add,Text,x56 y233 w21 h13,G
Gui,Add,Text,x89 y233 w21 h13,B

Gui,Add,Text,x174 y233 w21 h13,R
Gui,Add,Text,x212 y233 w21 h13,G
Gui,Add,Text,x249 y233 w21 h13,B

Gui,Add,Text,x331 y233 w21 h13,R
Gui,Add,Text,x368 y233 w21 h13,G
Gui,Add,Text,x407 y233 w21 h13,B

;Debugger RGB
Gui,Add,Edit,x8 y248 w27 h21 vDebugr,%debugR%
Gui,Add,Edit,x48 y248 w27 h21 vDebugg,%debugG%
Gui,Add,Edit,x87 y248 w27 h21 vDebugb,%debugB%

;Health RGB
Gui,Add,Edit,x166 y248 w27 h21 vHealthr,6
Gui,Add,Edit,x203 y248 w27 h21 vHealthg,6
Gui,Add,Edit,x239 y248 w27 h21 vHealthb,9

;Mana RGB
Gui,Add,Edit,x322 y248 w27 h21 vManar,3
Gui,Add,Edit,x360 y248 w27 h21 vManag,3
Gui,Add,Edit,x398 y248 w27 h21 vManab,2

;Monitor Setting
Gui Add, Text, x11 y285 w100 h30, Monitor Number
Gui Add, Edit, x32 y305 w30 h21 vMonitor1number, %monitor1number%

Gui, Add, Button, ys default gupdateHotkeys, Okay
Gui,Show,w500 h375,Flask Manager GUI

global flasktrigger1 := flask1triggerkey
global flasktrigger2 := flask2triggerkey
global flasktrigger3 := flask3triggerkey
global flasktrigger4 := flask4triggerkey
global flasktrigger5 := flask5triggerkey

global monitornumber := monitor1number

global flaskkeybind1 := flask1key
global flaskkeybind2 := flask2key
global flaskkeybind3 := flask3key
global flaskkeybind4 := flask4key
global flaskkeybind5 := flask5key

global flask1duration := flask1dur
global flask2duration := flask2dur
global flask3duration := flask3dur
global flask4duration := flask4dur
global flask5duration := flask5dur

global flaskbox1 := Flaskbox1
global flaskbox2 := Flaskbox2
global flaskbox3 := Flaskbox3
global flaskbox4 := Flaskbox4
global flaskbox5 := Flaskbox5


Loop 5
{ 
	IfExist, settings.ini
{
		
		value := flaskbox%A_Index%
		Iniread, Flaskbox%A_Index%, settings.ini, CheckBox, FlaskBox%A_index%
		value := Flaskbox%A_Index%
		GuiControl, , Flaskbox%A_Index%, %value%
}
}

Loop
{
	IfWinActive, Path of Exile ahk_class POEWindowClass
	{
		pBitmapHaystack := Gdip_BitmapFromScreen(monitornumber) ;Grabing screenshot from main monitor
		Gdip_LockBits(pBitmapHaystack, 0, 0, 1920, 1080, Stride, Scan, BitmapData)
        	
		;MsgBox %monitornumber%
		;if(GetKeyState(flasktrigger1, "P")){
		;MeasureAverageColor3x3(Scan, debugX, debugY, Stride)
     	;}
		;MeasureAverageColor3x3(Scan, 514, 1054, Stride)
		
		;if(GetKeyState(flask1triggerkey, "P")) {
		;MsgBox You're dumb.
		;}
		if IsIngame() { ;checking ingame state (green shop button)
		Flask1Logic() 
		Flask2Logic() 
		Flask3Logic() 
		Flask4Logic() 
		Flask5Logic() 
		}
		else {
			Sleep 500
		}
		Gdip_UnlockBits(pBitmapHaystack, BitmapData)
		Gdip_DisposeImage(pBitmapHaystack)
		Sleep 100 ;Small sleep timer in main cycle
	}
	else
		Sleep 3000 ;Waiting for game to activate
}

IsIngame()
{
	global Scan, Stride
	if ((Scan = 0) or (Stride = 0))
		return false
	if IsSameColors(Scan, 1441, 991, Stride, 54, 129, 37) ;checking ingame state (green shop button)
		&& !IsSameColors(Scan, 20, 394, Stride, 48, 21, 16) ;closed chat window (Local chat button enabled and shown on screen)
		&& !IsSameColors(Scan, 1504, 66, Stride, 165, 131, 71) { ;closed invenory (yellow pixels near "INVENTORY")
		return true
	}
	return false
}


;#####################################################################################

Flask1Logic() ; Atziri 3500 Base + 60% (20% quality, 12% alchemist, 20% druidic rite, 8% pathfinder) = 5600 ms
{
	global Flask1_timer
	if (A_TickCount - Flask1_timer > flask1duration) and Flaskbox1 == 1 and GetKeyState(flasktrigger1, "P") {
		Sendinput, {%flaskkeybind1% Down}
		Sendinput, {%flaskkeybind1% Up}
		Flask1_timer := A_TickCount
	}
}

;#####################################################################################

Flask2Logic() ; Atziri 3500 Base + 60% (20% quality, 12% alchemist, 20% druidic rite, 8% pathfinder) = 5600 ms
{
	global Flask2_timer
	if (A_TickCount - Flask2_timer > flask2duration) and Flaskbox2 == 1 and GetKeyState(flasktrigger2, "P") {
		Sendinput, {%flaskkeybind2% Down}
		Sendinput, {%flaskkeybind2% Up}
		Flask2_timer := A_TickCount
	}
}

;#####################################################################################

Flask3Logic() ; Jade 4000 Base + 60% (20% quality, 12% alchemist, 20% druidic rite, 8% pathfinder) = 6400 ms
{
	global Flask3_timer
	if (A_TickCount - Flask3_timer > flask3duration) and Flaskbox3 == 1 and GetKeyState(flasktrigger3, "P") {
		Sendinput, {%flaskkeybind3% Down}
		Sendinput, {%flaskkeybind3% Up}
		Flask3_timer := A_TickCount
	}
}
;#####################################################################################

Flask4Logic() ; witchfire 5000 Base + 60% (20% quality, 12% alchemist, 20% druidic rite, 8% pathfinder) = 8000 ms
{
	global Flask4_timer
	if (A_TickCount - Flask4_timer > flask4duration) and Flaskbox4 == 1 and GetKeyState(flasktrigger4, "P") {
		Sendinput, {%flaskkeybind4% Down}
		Sendinput, {%flaskkeybind4% Up}
		Flask4_timer := A_TickCount
	}
}
;#####################################################################################

Flask5Logic() ; witchfire 5000 Base + 60% (20% quality, 12% alchemist, 20% druidic rite, 8% pathfinder) = 8000 ms
{
	global Flask5_timer
	if (A_TickCount - Flask5_timer > flask5duration) and Flaskbox5 == 1 and GetKeyState(flasktrigger5, "P") {
		Sendinput, {%flaskkeybind5% Down}
		Sendinput, {%flaskkeybind5% Up}
		Flask5_timer := A_TickCount
	}
}

;#####################################################################################

BladeFlurryReleaseAt6()
{
	global pBitmapNeedle, BF_timer
	if (A_TickCount - BF_timer > 500) {
		pBitmapHaystack := Gdip_BitmapFromScreen(1) ;Grabing screenshot from main monitor
		RET := Gdip_ImageSearch(pBitmapHaystack,pBitmapNeedle,LIST,0,60,1600,90,128,,5,0) ;limiting area to search faster
		if (RET > 0) {
			if GetKeyState("RButton", "P") {
				Sendinput, {RButton Up}
				Sendinput, {RButton Down}
			} else {
				Sendinput, {RButton Up}
			}
			BF_timer := A_TickCount
		}
		Gdip_DisposeImage(pBitmapHaystack)
	}
}

;#####################################################################################

;ManaLogic()
;{
;	UseManaFlask4()
;}

;#####################################################################################

;UseHealFlask5()
;{
;	global FlaskHP_timer
;	if (A_TickCount - FlaskHP_timer > 2500) and IsSameColors(Scan, 514, 1054, Stride, 80, 19, 9) { ;divine 4 flask is ready
  ;      Sendinput, {5 Down}
   ;     Sendinput, {5 Up}
	;	FlaskHP_timer := A_TickCount
	;	return true
	;}
	;return false
;}

;#####################################################################################

;UseManaFlask4()
;{
	;global FlaskMP_timer
	;if (A_TickCount - FlaskMP_timer > 1500) and IsSameColors(Scan, 469, 1059, Stride, 10, 33, 63) { ;divine 4 flask is ready
    ;    Sendinput, {4 Down}
   ;     Sendinput, {4 Up}
	;	FlaskMP_timer := A_TickCount
;		return true
;	}
;	return false
;}

;#####################################################################################

MeasureAverageColor3x3(Scan, x, y, Stride) ;Shows average color of 3x3 pixel box
{
	r0 := 0
	g0 := 0
	b0 := 0	

	Loop 3 {
		X_index := A_index
		Loop 3 {
			Gdip_FromARGB(Gdip_GetLockBitPixel(Scan, x - 2 + X_index, y - 2 + A_index, Stride), a1, r1, g1, b1)
			r0 := r0 + r1
			g0 := g0 + g1
			b0 := b0 + b1
		}
	}
	r0 := r0 / 9
	g0 := g0 / 9
	b0 := b0 / 9
	MsgBox %r0% %g0% %b0%
}




;#####################################################################################

IsSameColors(Scan, x, y, Stride, r2, g2, b2) {
	r0 := 0
	g0 := 0
	b0 := 0	

	Loop 3 {
		X_index := A_index
		Loop 3 {
			Gdip_FromARGB(Gdip_GetLockBitPixel(Scan, x - 2 + X_index, y - 2 + A_index, Stride), a1, r1, g1, b1)
			r0 := r0 + r1
			g0 := g0 + g1
			b0 := b0 + b1
		}
	}
	r0 := r0 / 9
	g0 := g0 / 9
	b0 := b0 / 9

	return ((r0 - r2)*(r0 - r2) + (b0 - b2)*(b0 - b2) + (g0 - g2)*(g0 - g2) < 49)
}

;#####################################################################################

RandSleep(x,y) {
	Random, rand, %x%, %y%
	Sleep %rand%
}

;#####################################################################################

~Enter:: ;Chat detection
	Enter_key_timer := A_TickCount
return

;#####################################################################################

~Q:: ;Movement skill (WB)
	if (A_TickCount - Enter_key_timer > 15000) {
		IfWinActive, Path of Exile ahk_class POEWindowClass 
		{

		}
	}
return


;#####################################################################################


readFromFile(){
	global
	Hotkey,F10, optionsCommand, Off
	
	;variables
	IniRead, Flask1dur, settings.ini, variables, Flask1dur %A_Space%
	IniRead, Flask2dur, settings.ini, variables, Flask2dur %A_Space%
	IniRead, Flask3dur, settings.ini, variables, Flask3dur %A_Space%
	IniRead, Flask4dur, settings.ini, variables, Flask4dur %A_Space%
	IniRead, Flask5dur, settings.ini, variables, Flask5dur %A_Space%
	
	;Monitor 
	IniRead, Monitor1number, settings.ini, variables, MonitorNumber %A_Space%
	
	;debugstuff variables
	IniRead, DebugX, settings.ini, variables, DebugX %A_Space%
	IniRead, DebugY, settings.ini, variables, DebugY %A_Space%
	
	;Hotkeys
	IniRead, Flask1key, settings.ini, hotkeys, Flask1key %A_SPACE%
	IniRead, Flask1triggerkey, settings.ini, hotkeys, Flask1triggerkey %A_Space%
	IniRead, Flask2key, settings.ini, hotkeys, Flask2key %A_SPACE%
	IniRead, Flask2triggerkey, settings.ini, hotkeys, Flask2triggerkey %A_Space%
	IniRead, Flask3key, settings.ini, hotkeys, Flask3key %A_SPACE%
	IniRead, Flask3triggerkey, settings.ini, hotkeys, Flask3triggerkey %A_Space%
	IniRead, Flask4key, settings.ini, hotkeys, Flask4key %A_SPACE%
	IniRead, Flask4triggerkey, settings.ini, hotkeys, Flask4triggerkey %A_Space%
	IniRead, Flask5key, settings.ini, hotkeys, Flask5key %A_SPACE%
	IniRead, Flask5triggerkey, settings.ini, hotkeys, Flask5triggerkey %A_Space%
	
	

	Hotkey,F10, optionsCommand, On
}




submit(){  
updateHotkeys:
	global
	Gui, Submit 
	;Variables for Flasks and stuff
	IniWrite, %Flask1dur%, Settings.ini, variables, Flask1dur %A_Space%
	IniWrite, %Flask2dur%, Settings.ini, variables, Flask2dur %A_Space%
	IniWrite, %Flask3dur%, Settings.ini, variables, Flask3dur %A_Space%
	IniWrite, %Flask4dur%, Settings.ini, variables, Flask4dur %A_Space%
	IniWrite, %Flask5dur%, Settings.ini, variables, Flask5dur %A_Space%
	IniWrite, %DebugX%, Settings.ini, variables, DebugX %A_Space%
	IniWrite, %DebugY%, Settings.ini, variables, DebugY %A_Space%
	IniWrite, %Monitor1number%, settings.ini, variables, MonitorNumber %A_Space%
	
	
	;Hotkeys and stuff
	IniWrite, %Flask1key%, Settings.ini, hotkeys, Flask1key %A_Space%
	IniWrite, %Flask1triggerkey%, Settings.ini, hotkeys, Flask1triggerkey %A_Space%
	IniWrite, %Flaskbox1%, settings.ini, Checkbox, Flaskbox1 %A_Space%
	IniWrite, %Flaskbox2%, settings.ini, Checkbox, Flaskbox2 %A_Space%
	IniWrite, %Flaskbox3%, settings.ini, Checkbox, Flaskbox3 %A_Space%
	IniWrite, %Flaskbox4%, settings.ini, Checkbox, Flaskbox4 %A_Space%
	IniWrite, %Flaskbox5%, settings.ini, Checkbox, Flaskbox5 %A_Space%
	
	IniWrite, %Flask2key%, Settings.ini, hotkeys, Flask2key %A_Space%
	IniWrite, %Flask2triggerkey%, Settings.ini, hotkeys, Flask2triggerkey %A_Space%
	
	IniWrite, %Flask3key%, Settings.ini, hotkeys, Flask3key %A_Space%
	IniWrite, %Flask3triggerkey%, Settings.ini, hotkeys, Flask3triggerkey %A_Space%
	
	IniWrite, %Flask4key%, Settings.ini, hotkeys, Flask4key %A_Space%
	IniWrite, %Flask4triggerkey%, Settings.ini, hotkeys, Flask4triggerkey %A_Space%
	
	IniWrite, %Flask5key%, Settings.ini, hotkeys, Flask5key %A_Space%
	IniWrite, %Flask5triggerkey%, Settings.ini, hotkeys, Flask5triggerkey %A_Space%
	
	
	readFromFile()
	
	return    
}

hotkeys(){
optionsCommand:
	global
	Gui, Show,, Flask Manager GUI
	processWarningFound := 0
	Gui, 6:Hide
	return
}
