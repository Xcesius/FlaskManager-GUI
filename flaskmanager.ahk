;#####################################################################################
if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"
   ExitApp
}
;https://github.com/Kalamity/classMemory : memory reading library
#Include %A_ScriptDir%\libs\classMemory.ahk
SetBatchLines, -1

BF_timer := 0
Key1_Timer := 0
Key2_Timer := 0
Key3_Timer := 0
Flask1_timer := 0
Flask2_timer := 0
Flask3_timer := 0
Flask4_timer := 0
Flask5_timer := 0	
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
	defaultIni .= "HealthPct=100`n"
	defaultIni .= "ManaPct=100`n"
	defaultIni .= "DebugX=514`n"
	defaultIni .= "DebugY=1054`n"
	defaultIni .= "MonitorNumber=1`n"
	defaultIni .= "XPos=1920`n"
	defaultIni .= "YPos=1080`n"
	defaultIni .= "HealthPctChicken=0`n"
	defaultIni .= "ShieldPctChicken=0`n"
	
	defaultIni .= "HealthPercentKey1=75`n"
	defaultIni .= "DelayKey1=50`n"
	defaultIni .= "HealthPercentKey2=75`n"
	defaultIni .= "DelayKey2=50`n"
	defaultIni .= "HealthPercentKey3=75`n"
	defaultIni .= "DelayKey3=50`n"
	defaultIni .= "HealthPercentKey4=75`n"
	defaultIni .= "DelayKey4=50`n"
	
	defaultIni .= "[Checkbox]`n"
	defaultIni .= "Flaskbox1=1`n"
	defaultIni .= "Flaskbox2=1`n"
	defaultIni .= "Flaskbox3=1`n"
	defaultIni .= "Flaskbox4=1`n"
	defaultIni .= "Flaskbox5=1`n"
	defaultIni .= "FlaskType1=Normal`n"
	defaultIni .= "FlaskType2=Normal`n"
	defaultIni .= "FlaskType3=Normal`n"
	defaultIni .= "FlaskType4=Normal`n"
	defaultIni .= "FlaskType5=Normal`n"
	defaultIni .= "Steambox=0`n"
	defaultIni .= "ChickenBox=Disabled`n"
	defaultIni .= "BFReleaseBox=Disabled`n"
	defaultIni .= "AbilityKey1Box=Disabled`n"
	defaultIni .= "AbilityKey2Box=Disabled`n"
	defaultIni .= "AbilityKey3Box=Disabled`n"
	defaultIni .= "AbilityKey4Box=Disabled`n"
	
	
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
	
	defaultIni .= "AbilityKey1=1`n"
	defaultIni .= "AbilityKey2=2`n"
	defaultIni .= "AbilityKey3=3`n"
	defaultIni .= "AbilityKey4=4`n"
	FileAppend, %defaultIni%, Settings.ini, UTF-16
}

readFromFile()

global flasktrigger1 := flask1triggerkey
global flasktrigger2 := flask2triggerkey
global flasktrigger3 := flask3triggerkey
global flasktrigger4 := flask4triggerkey
global flasktrigger5 := flask5triggerkey

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

global Flaskbox1
global Flaskbox2
global Flaskbox3
global Flaskbox4
global Flaskbox5

global FlaskType1
global FlaskType2
global FlaskType3
global FlaskType4
global FlaskType5

Gui Add, Tab3, vTab x4 y-1 w550 h396 -wrap, Flasks|Abilites|Chicken
values = |Normal|Health|Mana
values1 = |Disabled|Health|Shield
values2 = |Disabled|Enabled
Gui, Tab, 1 ; General stuff
Gui Add, Hotkey, vFlask1key x47 y31 w50 h21, %flask1key%
Gui Add, Edit, vFlask1dur x102 y31 w40 h21, %flask1dur%
Gui Add, Edit, vFlask1triggerkey x148 y30 w50 h21, %flask1triggerkey%
Gui Add, Text, x7 y34 w35 h13, Flask 1
Gui Add, Checkbox, vFlaskbox1 x208 y32 w50 h13, Flask 1
Gui, Add, ComboBox, vFlaskType1 x270 y32 w70 h120, %values%

Gui Add, Hotkey, vFlask2key x47 y57 w50 h21, %flask2key%
Gui Add, Edit, vFlask2triggerkey x148 y57 w50 h21, %flask2triggerkey%
Gui Add, Edit, vFlask2dur x102 y57 w40 h21, %flask2dur%
Gui Add, Checkbox, vFlaskbox2 x208 y60 w50 h13, Flask 2
Gui Add, Text, x7 y60 w35 h13, Flask 2
Gui, Add, ComboBox, vFlaskType2 x270 y60 w70 h120, %values%

Gui Add, Hotkey, vFlask3key x47 y83 w50 h21, %flask3key%
Gui Add, Edit, vFlask3dur x102 y83 w40 h21, %flask3dur%
Gui Add, Edit, vFlask3triggerkey x148 y83 w50 h21, %flask3triggerkey%
Gui Add, Text, x7 y86 w35 h13, Flask 3
Gui Add, Checkbox, vFlaskbox3 x208 y86 w50 h13, Flask 3
Gui, Add, ComboBox, vFlaskType3 x270 y86 w70 h120, %values%

Gui Add, Hotkey, vFlask4key x47 y109 w50 h21, %flask4key%
Gui Add, Edit, vFlask4dur x102 y109 w40 h21, %flask4dur%
Gui Add, Edit, vFlask4triggerkey x148 y109 w50 h21, %flask4triggerkey%
Gui Add, Text, x7 y112 w35 h13, Flask 4
Gui Add, Checkbox, vFlaskbox4 x208 y112 w50 h13, Flask 4
Gui, Add, ComboBox, vFlaskType4 x270 y112 w70 h120, %values%

Gui Add, Hotkey, vFlask5key x47 y134 w50 h21, %flask5key%
Gui Add, Edit, vFlask5dur x102 y134 w40 h21, %flask5dur%
Gui Add, Edit, vFlask5triggerkey x148 y134 w50 h21, %flask5triggerkey%
Gui Add, Text, x7 y137 w35 h13, Flask 5
Gui Add, Checkbox, vFlaskbox5 x208 y138 w50 h13, Flask 5
Gui, Add, ComboBox, vFlaskType5 x270 y138 w70 h120, %values%

;Steam check
Gui Add, Text, x450 y100 w100 h50, Enable this if you are       running Steam!
Gui Add, Checkbox, vSteambox x500 y128 w50 h25

;Save Setting
Gui, Add, Button, x500 y23 w37 h23 default gupdateEverything, Save

;Health Stuff
Gui Add, Edit, vHealthPct x55 y210 w50 h21, %HealthPct%
Gui Add, Edit, vManaPct x175 y210 w50 h21, %ManaPct%
Gui, Font, s10 Arial
Gui Add, Text, x50 y170 w70 h40, Health Percentage
Gui Add, Text, x170 y170 w70 h40, Mana Percentage

Gui, Tab, 2 ;Debug stuff here
Gui, Font, s7 Arial
Gui Add, Text, x10 y40 w100 h30, Ability Key
Gui Add, Text, x70 y40 w100 h30, HP/CI
Gui Add, Text, x135 y40 w100 h30, Delay
Gui Add, Edit, vAbilityKey1 x10 y60 w30 h21, %AbilityKey1%
Gui Add, Edit, vHealthPercentKey1 x70 y60 w30 h21, %HealthPercentKey1%
Gui Add, Edit, vDelayKey1 x135 y60 w30 h21, %DelayKey1%
Gui Add, ComboBox, vAbilityKey1Box x200 y60 w80 h120, %values1%

Gui Add, Text, x10 y90 w100 h30, Ability Key 
Gui Add, Text, x70 y90 w100 h30, HP/CI
Gui Add, Text, x135 y90 w100 h30, Delay
Gui Add, Edit, vAbilityKey2 x10 y105 w30 h21, %AbilityKey2%
Gui Add, Edit, vHealthPercentKey2 x70 y105 w30 h21, %HealthPercentKey2%
Gui Add, Edit, vDelayKey2 x135 y105 w30 h21, %DelayKey2%
Gui Add, ComboBox, vAbilityKey2Box x200 y105 w80 h120, %values1%

Gui Add, Text, x10 y135 w100 h30, Ability Key 
Gui Add, Text, x70 y135 w100 h30, HP/CI
Gui Add, Text, x135 y135 w100 h30, Delay
Gui Add, Edit, vAbilityKey3 x10 y150 w30 h21, %AbilityKey3%
Gui Add, Edit, vHealthPercentKey3 x70 y150 w30 h21, %HealthPercentKey3%
Gui Add, Edit, vDelayKey3 x135 y150 w30 h21, %DelayKey3%
Gui Add, ComboBox, vAbilityKey3Box x200 y150 w80 h120, %values1%

Gui Add, Text, x10 y180 w100 h30, Ability Key 
Gui Add, Text, x70 y180 w100 h30, HP/CI
Gui Add, Text, x135 y180 w100 h30, Delay
Gui Add, Edit, vAbilityKey4 x10 y195 w30 h21, %AbilityKey4%
Gui Add, Edit, vHealthPercentKey4 x70 y195 w30 h21, %HealthPercentKey4%
Gui Add, Edit, vDelayKey4 x135 y195 w30 h21, %DelayKey4%
Gui Add, ComboBox, vAbilityKey4Box x200 y195 w80 h120, %values1%


Gui Add, Text, x370 y60 w90 h50, Blade Flurry Release
Gui Add, Combobox, vBFReleaseBox x370 y90 w90 h120, %values2%

Gui, Add, Button, x500 y23 w37 h23 default gupdateEverything, Save

Gui, Tab, 3 ;Debug stuff here
Gui Add, Edit, vHealthPctChicken x40 y55 w50 h21, %HealthPctChicken%
Gui Add, Edit, vShieldPctChicken x150 y55 w50 h21, %ShieldPctChicken%
Gui Add, ComboBox, vChickenBox x275 y55 w100 h120, %values1%
Gui, Font, s10 Arial
Gui Add, Text, x50 y30 w70 h25, HP
Gui Add, Text, x155 y30 w70 h25, Shield
Gui, Font, s7 Arial
Gui, Add, Button, x500 y23 w37 h23 default gupdateEverything, Save


Gui,Show,w550 h281,Flask Manager GUI

Loop 5
{ 
	IfExist, Settings.ini
{
		Iniread, Flaskbox%A_Index%, settings.ini, CheckBox, Flaskbox%A_index%
		valueFlask := Flaskbox%A_Index%
		Iniread, ChickenBox, settings.ini, CheckBox, ChickenBox
		valueChicken := ChickenBox
		Iniread, BFReleaseBox, settings.ini, CheckBox, BFReleaseBox
		valueBFRelease := BFReleaseBox
		Iniread, AbilityKey%A_Index%Box, settings.ini, CheckBox, AbilityKey%A_Index%Box
		valueAbility := AbilityKey%A_Index%Box
		Iniread, FlaskType%A_Index%, settings.ini, CheckBox, FlaskType%A_index%
		valueFlaskType := FlaskType%A_Index%
		;MsgBox %valueFlaskType%
		Iniread, Steambox, settings.ini, CheckBox, Steambox
		valueSteam := Steambox
		GuiControl, , Flaskbox%A_Index%, %valueFlask%
		GuiControl, ChooseString, AbilityKey%A_Index%Box, %valueAbility%
		GuiControl, , Steambox, %valueSteam%
		GuiControl, ChooseString, ChickenBox, %valueChicken%
		GuiControl, ChooseString, BFReleaseBox, %valueBFRelease%
		GuiControl, ChooseString, FlaskType%A_Index%, %valueFlaskType%
}
}

;=================startup load the frameBase (IngameState)===============
;https://github.com/TehCheat/PoEHUD/tree/x64/src/Poe/Offsets.cs:        private static readonly Pattern basePtrPattern = new Pattern(new byte[]
SetFormat, Integer, hex
basePtrPattern:=[0x40, 0x53, 0x48, 0x83, 0xEC, 0x50, 0x48, 0xC7, 0x44, 0x24, 0x20, 0xFE, 0xFF, 0xFF, 0xFF, 0xC7, 0x44, 0x24, 0x60, 0x00, 0x00, 0x00, 0x00, 0x48, 0x8b, 0x05]
	if(Steambox == 0){
		cliexe := "PathOfExile_x64.exe"
	}
	if(Steambox == 1){
		cliexe := "PathOfExile_x64Steam.exe"
	}
global poe := new _ClassMemory("ahk_exe " . cliexe, "", hProcessCopy)
PatternIsAt:=poe.modulePatternScan(cliexe, basePtrPattern*)-poe.BaseAddress

;https://github.com/TehCheat/PoEHUD/tree/x64/src/Poe/Offsets.cs :        Base = m.ReadInt(m.AddressOfProcess + array[0] + 0x1A) + array[0] + 0x1E;
baseMgrPtr:=poe.read(poe.BaseAddress+PatternIsAt+0x1A, "UInt")+PatternIsAt+0x1E

;https://github.com/TehCheat/PoEHUD/tree/x64/src/Poe/RemoteMemoryObjects/TheGame.cs :       Address = m.ReadLong(Offsets.Base + m.AddressOfProcess, 0x8, 0xf8);
;https://github.com/TehCheat/PoEHUD/tree/x64/src/Poe/RemoteMemoryObjects/TheGame.cs :       public IngameState IngameState => ReadObject<IngameState>(Address + 0x38);
;mBase+baseMgrPtr,4,0xFC,0x1c
global testBase:=poe.read(poe.BaseAddress+baseMgrPtr, "Int64", 0x8, 0xf8)
global testBase1:=poe.read(testBase+0x38, "Int64")
global frameBase:=poe.read(poe.BaseAddress+baseMgrPtr, "Int64", 0x8, 0xf8, 0x38)
global IngameState:=frameBase

;=======================retrieve current data============================
readPlayerStats(byRef PlayerStats){
	global Steambox
	;https://github.com/TehCheat/PoEHUD/tree/x64/src/Poe/RemoteMemoryObjects/IngameState.cs :       public IngameData Data => ReadObject<IngameData>(Address + 0x160 + Offsets.IgsOffset);
	if(Steambox == 1){
	InGameData:=poe.read(IngameState+0x160+0x28, "Int64")
	}
	if(Steambox == 0){
	InGameData:=poe.read(IngameState+0x160, "Int64")
	}
	; public string Name => M.ReadStringU(M.ReadLong(Address + 8, 0));
	
	serverData:=poe.read(IngameState+0x168+0x28, "Int64")
	inGameNumber:=poe.read(serverData+0x39C8, "Int64")
	global isProperInGame:=inGameNumber*100/100
	if(isProperInGame > 2){
		;serverData:=poe.read(IngameState+0x168+0x28, "Int64")
		;flaskArray:=poe.read(serverData+0x240, "Int64", 0x9C8, 0x948, 0xA00, 0x20)
		;flask1:=poe.read(flaskArray+2*8)
		;flask1Max:=poe.read(flask1+0x0, "Int64", 0x20)
		;MsgBox %flask1Max%
		;https://github.com/TehCheat/PoEHUD/tree/x64/src/Poe/RemoteMemoryObjects/IngameData.cs :        public Entity LocalPlayer => ReadObject<Entity>(Address + 0x180);
		LocalPlayer:=poe.read(InGameData+0x180, "Int64")
		;https://github.com/badplayerr/beta-autopot/blob/master/Autopot.ahk :         PlayerMain:=ReadMemUInt(pH,PlayerBase+4)       PlayerStatsOffset:=ReadMemUInt(pH,PlayerMain+0xC)
		LPLifeComponent:=poe.read(LocalPlayer+0x8, "Int64", 0x18)
		;https://github.com/TehCheat/PoEHUD/tree/x64/src/Poe/Components/Life.cs :      public int CurHP => Address != 0 ? M.ReadInt(Address + 0x54) : 1;   public int CurMana => Address != 0 ? M.ReadInt(Address + 0x84) : 1;
		poe.readRaw(LPLifeComponent, LifeStructure, 0xB8)
		
		BuffListStart:=poe.read(LPLifeComponent+0xD8, "Int64")
		BuffListEnd:=poe.read(LPLifeComponent+0xE0, "Int64")
		global BuffAmount:=((BuffListEnd-BuffListStart)/8)
		PlayerStats.BuffAmount:=((BuffListEnd-BuffListStart)/8)
			Loop, %BuffAmount%
	{
	  BuffBasePtr:=poe.read(BuffListStart+((A_Index-1)*8), "Int64", 8)
	  BuffNamePtr:=poe.read(BuffBasePtr+8, "Int64", 0)
	  BuffNameStr:=poe.readString(BuffNamePtr, length:=0, encoding := "utf-16")
      PlayerStats.BuffName[A_Index]:=BuffNameStr
      BuffCharges:=poe.read(BuffBasePtr+0x28)
      PlayerStats.BuffCharges[A_Index]:=BuffCharges
      BuffTimer:=poe.read(BuffBasePtr+0x14)
      PlayerStats.BuffTimer[A_Index]:=BuffTimer
   }
		;buffName:=NumGet(LifeStructure, 0x28, "UInt")
		curHP:=NumGet(LifeStructure, 0x54, "UInt")
		curCI:=NumGet(LifeStructure, 0xB4, "UInt")
		maxCI:=NumGet(LifeStructure, 0xB0, "UInt")
		resHP:=NumGet(LifeStructure, 0x60, "Uint")
		maxHP:=NumGet(LifeStructure, 0x50, "UInt")	
		curMana:=NumGet(LifeStructure, 0x84, "UInt")
		resMana:=NumGet(LifeStructure, 0x90, "Uint")
		maxMana:=NumGet(LifeStructure, 0x80, "UInt")
		
		if(maxHP>0 and curHP>0){
			PlayerStats.hpres:=resHP*100/100
			PlayerStats.hp:=(curHP*100)/100/maxHP*100
			PlayerStats.ci:=(curCI*100)/100/maxCI*100
			PlayerStats.mp:=(curMana*100)/100/maxMana*100
		}else{
			PlayerStats.hp:=0
			PlayerStats.ci:=0
			PlayerStats.mp:=0
		}
	}
}




PlayerStats:=Object()
Loop
{
	readPlayerStats(PlayerStats)
	IfWinActive, Path of Exile ahk_class POEWindowClass
	{
	PlayerHP:=PlayerStats.hp
	PlayerMP:=PlayerStats.mp
    PlayerCI:=PlayerStats.ci
	PlayerInGame:=isProperInGame
	loop, %BuffAmount%
		{
			BuffTimer:=PlayerStats.BuffTimer[A_Index]
            BuffCharges:=PlayerStats.BuffCharges[A_Index]
			If InStr(playerstats.BuffName[A_Index], "charged_attack")
			{
				if(BuffCharges>=6 and A_TickCount - BF_timer > 500 and BFReleaseBox == "Enabled"){
				if GetKeyState("RButton", "P") {
				Sendinput, {RButton Up}
				RandSleep(10,50)
				Sendinput, {RButton Down}
			} else {
				Sendinput, {RButton Up}
			}
			BF_timer := A_TickCount
				}
				continue
			}
		}
		if(PlayerInGame > 2){
	if(ChickenBox == "Health" and PlayerHP <= HealthPctChicken){
	if(Steambox == 1){
	run, cports.exe /close * * * * PathOfExile_x64Steam.exe
	}
	if(Steambox == 0){
	run, cports.exe /close * * * * PathOfExile_x64.exe
    }
    }
	if(ChickenBox == "Shield" and PlayerCI <= ShieldPctChicken){
	if(Steambox == 1){
	run, cports.exe /close * * * * PathOfExile_x64Steam.exe
    }
	if(Steambox == 0){
	run, cports.exe /close * * * * PathOfExile_x64.exe
    }
	}
			AbilityKey1Logic()
			AbilityKey2Logic()
			AbilityKey3Logic()
			AbilityKey4Logic()
			Flask1Logic()
			Flask2Logic()
			Flask3Logic()
			Flask4Logic()
			Flask5Logic()
}
}
	Sleep, 50
}

global PlayerHP
global PlayerMP
global PlayerCI
global HealthPct
global ManaPct


;#####################################################################################

AbilityKey1Logic() ; Atziri 3500 Base + 60% (20% quality, 12% alchemist, 20% druidic rite, 8% pathfinder) = 5600 ms
{
	global AbilityKey1
	global AbilityKey1Box
    global HealthPercentKey1
	global DelayKey1	
	global Key1_Timer
	if (A_TickCount - Key1_Timer > DelayKey1 and ((AbilityKey1Box == "Health" and  PlayerHP <= HealthPercentKey1) or (AbilityKey1Box == "Shield" and PlayerCI <= HealthPercentKey1))){
		Sendinput, {%AbilityKey1% Down}
		RandSleep(0,100)
		Sendinput, {%AbilityKey1% Up}
		Key1_Timer := A_TickCount
	}
}
;#####################################################################################

AbilityKey2Logic() ; Atziri 3500 Base + 60% (20% quality, 12% alchemist, 20% druidic rite, 8% pathfinder) = 5600 ms
{
	global AbilityKey2
	global AbilityKey2Box
    global HealthPercentKey2
	global DelayKey2	
	global Key2_Timer
	if (A_TickCount - Key2_Timer > DelayKey2 and ((AbilityKey2Box == "Health" and  PlayerHP <= HealthPercentKey2) or (AbilityKey2Box == "Shield" and PlayerCI <= HealthPercentKey2))){
		Sendinput, {%AbilityKey2% Down}
		RandSleep(0,100)
		Sendinput, {%AbilityKey2% Up}
		Key2_Timer := A_TickCount
	}
}
;#####################################################################################

AbilityKey3Logic() ; Atziri 3500 Base + 60% (20% quality, 12% alchemist, 20% druidic rite, 8% pathfinder) = 5600 ms
{
	global AbilityKey3
	global AbilityKey3Box
    global HealthPercentKey3
	global DelayKey3	
	global Key3_Timer
	if (A_TickCount - Key3_Timer > DelayKey3 and ((AbilityKey3Box == "Health" and  PlayerHP <= HealthPercentKey3) or (AbilityKey3Box == "Shield" and PlayerCI <= HealthPercentKey3))){
		Sendinput, {%AbilityKey3% Down}
		RandSleep(0,100)
		Sendinput, {%AbilityKey3% Up}
		Key3_Timer := A_TickCount
	}
}
;#####################################################################################

AbilityKey4Logic() ; Atziri 3500 Base + 60% (20% quality, 12% alchemist, 20% druidic rite, 8% pathfinder) = 5600 ms
{
	global AbilityKey4
	global AbilityKey4Box
    global HealthPercentKey4
	global DelayKey4	
	global Key4_Timer
	if (A_TickCount - Key4_Timer > DelayKey4 and ((AbilityKey4Box == "Health" and  PlayerHP <= HealthPercentKey4) or (AbilityKey4Box == "Shield" and PlayerCI <= HealthPercentKey4))){
		Sendinput, {%AbilityKey4% Down}
		RandSleep(0,100)
		Sendinput, {%AbilityKey4% Up}
		Key4_Timer := A_TickCount
	}
}
;#####################################################################################

Flask1Logic() ; Atziri 3500 Base + 60% (20% quality, 12% alchemist, 20% druidic rite, 8% pathfinder) = 5600 ms
{
	;MsgBox %PlayerMP% Player!
	;MsgBox %ManaPct% Setting!
	global Flask1_timer
	if (A_TickCount - Flask1_timer > flask1duration and Flaskbox1 == 1 and FlaskType1 == "Health" and PlayerHP <= HealthPct){
		Sendinput, {%flaskkeybind1% Down}
		RandSleep(0,100)
		Sendinput, {%flaskkeybind1% Up}
		Flask1_timer := A_TickCount
	}
	if (A_TickCount - Flask1_timer > flask1duration and Flaskbox1 == 1 and FlaskType1 == "Mana" and PlayerMP <= ManaPct){
		Sendinput, {%flaskkeybind1% Down}
		RandSleep(0,100)
		Sendinput, {%flaskkeybind1% Up}
		Flask1_timer := A_TickCount
	}
	if (A_TickCount - Flask1_timer > flask1duration and Flaskbox1 == 1 and FlaskType1 == "Normal" and GetKeyState(flasktrigger1, "P")){
		Sendinput, {%flaskkeybind1% Down}
		RandSleep(0,100)
		Sendinput, {%flaskkeybind1% Up}
		Flask1_timer := A_TickCount
	}
}

;#####################################################################################

Flask2Logic() ; Atziri 3500 Base + 60% (20% quality, 12% alchemist, 20% druidic rite, 8% pathfinder) = 5600 ms
{
	global Flask2_timer
	if (A_TickCount - Flask2_timer > flask2duration and Flaskbox2 == 1 and FlaskType2 == "Health" and PlayerHP <= HealthPct){
		Sendinput, {%flaskkeybind2% Down}
		RandSleep(0,100)
		Sendinput, {%flaskkeybind2% Up}
		Flask2_timer := A_TickCount
	}
	if (A_TickCount - Flask2_timer > flask2duration and Flaskbox2 == 1 and FlaskType2 == "Mana" and PlayerMP <= ManaPct){
		Sendinput, {%flaskkeybind2% Down}
		RandSleep(0,100)
		Sendinput, {%flaskkeybind2% Up}
		Flask2_timer := A_TickCount
	}
	if (A_TickCount - Flask2_timer > flask2duration and Flaskbox2 == 1 and FlaskType2 == "Normal" and GetKeyState(flasktrigger2, "P")){
		Sendinput, {%flaskkeybind2% Down}
		RandSleep(0,100)
		Sendinput, {%flaskkeybind2% Up}
		Flask2_timer := A_TickCount
	}
}

;#####################################################################################

Flask3Logic() ; Jade 4000 Base + 60% (20% quality, 12% alchemist, 20% druidic rite, 8% pathfinder) = 6400 ms
{
	global Flask3_timer
	if (A_TickCount - Flask3_timer > flask3duration and Flaskbox3 == 1 and FlaskType3 == "Health" and PlayerHP <= HealthPct){
		Sendinput, {%flaskkeybind3% Down}
		RandSleep(0,100)
		Sendinput, {%flaskkeybind3% Up}
		Flask3_timer := A_TickCount
	}
	if (A_TickCount - Flask3_timer > flask3duration and Flaskbox3 == 1 and FlaskType3 == "Mana" and PlayerMP <= ManaPct){
		Sendinput, {%flaskkeybind3% Down}
		RandSleep(0,100)
		Sendinput, {%flaskkeybind3% Up}
		Flask3_timer := A_TickCount
	}
	if (A_TickCount - Flask3_timer > flask3duration and Flaskbox3 == 1 and FlaskType3 == "Normal" and GetKeyState(flasktrigger3, "P")){
		Sendinput, {%flaskkeybind3% Down}
		RandSleep(0,100)
		Sendinput, {%flaskkeybind3% Up}
		Flask3_timer := A_TickCount
	}
}
;#####################################################################################

Flask4Logic() ; witchfire 5000 Base + 60% (20% quality, 12% alchemist, 20% druidic rite, 8% pathfinder) = 8000 ms
{
	global Flask4_timer
	if (A_TickCount - Flask4_timer > flask4duration and Flaskbox4 == 1 and FlaskType4 == "Health" and PlayerHP <= HealthPct){
		Sendinput, {%flaskkeybind4% Down}
		RandSleep(0,100)
		Sendinput, {%flaskkeybind4% Up}
		Flask4_timer := A_TickCount
	}
	if (A_TickCount - Flask4_timer > flask4duration and Flaskbox4 == 1 and FlaskType4 == "Mana" and PlayerMP <= ManaPct){
		Sendinput, {%flaskkeybind4% Down}
		RandSleep(0,100)
		Sendinput, {%flaskkeybind4% Up}
		Flask4_timer := A_TickCount
	}
	if (A_TickCount - Flask4_timer > flask4duration and Flaskbox4 == 1 and FlaskType4 == "Normal"  and GetKeyState(flasktrigger4, "P")){
		Sendinput, {%flaskkeybind4% Down}
		RandSleep(0,100)
		Sendinput, {%flaskkeybind4% Up}
		Flask4_timer := A_TickCount
	}
}
;#####################################################################################

Flask5Logic() ; witchfire 5000 Base + 60% (20% quality, 12% alchemist, 20% druidic rite, 8% pathfinder) = 8000 ms
{
	global Flask5_timer
	if (A_TickCount - Flask5_timer > flask5duration and Flaskbox5 == 1 and FlaskType5 == "Health" and PlayerHP <= HealthPct){
		Sendinput, {%flaskkeybind5% Down}
		RandSleep(0,100)
		Sendinput, {%flaskkeybind5% Up}
		Flask5_timer := A_TickCount
	}
	if (A_TickCount - Flask5_timer > flask5duration and Flaskbox5 == 1 and FlaskType5 == "Mana" and PlayerMP <= ManaPct){
		Sendinput, {%flaskkeybind5% Down}
		RandSleep(0,100)
		Sendinput, {%flaskkeybind5% Up}
		Flask5_timer := A_TickCount
	}
	if (A_TickCount - Flask5_timer > flask5duration and Flaskbox5 == 1 and FlaskType5 == "Normal"  and GetKeyState(flasktrigger5, "P")){
		Sendinput, {%flaskkeybind5% Down}
		RandSleep(0,100)
		Sendinput, {%flaskkeybind5% Up}
		Flask5_timer := A_TickCount
	}
}

;#####################################################################################

BladeFlurryReleaseAt6()
{
	if (A_TickCount - BF_timer > 500) {
		if (RET > 0) {
			if GetKeyState("RButton", "P") {
				Sendinput, {RButton Up}
				Sendinput, {RButton Down}
			} else {
				Sendinput, {RButton Up}
			}
			BF_timer := A_TickCount
		}
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


RandSleep(x,y) {
	Random, rand, %x%, %y%
	Sleep, %rand%
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
	IniRead, HealthPct, settings.ini, variables, HealthPct %A_Space%
	IniRead, ManaPct, settings.ini, variables, ManaPct %A_Space%
	IniRead, HealthPctChicken, settings.ini, variables, HealthPctChicken %A_Space%
	IniRead, ShieldPctChicken, settings.ini, variables, ShieldPctChicken %A_Space%
	
	;Monitor 
	IniRead, Monitor1number, settings.ini, variables, MonitorNumber %A_Space%
	
	;Ability Key stuff
	IniRead, HealthPercentKey1, settings.ini, variables, HealthPercentKey1 %A_Space%
	IniRead, DelayKey1, settings.ini, variables, DelayKey1 %A_Space%
	IniRead, AbilityKey1, settings.ini, hotkeys, AbilityKey1 %A_Space%
	IniRead, HealthPercentKey2, settings.ini, variables, HealthPercentKey2 %A_Space%
	IniRead, DelayKey2, settings.ini, variables, DelayKey2 %A_Space%
	IniRead, AbilityKey2, settings.ini, hotkeys, AbilityKey2 %A_Space%
	IniRead, HealthPercentKey3, settings.ini, variables, HealthPercentKey3 %A_Space%
	IniRead, HealthPercentKey4, settings.ini, variables, HealthPercentKey4 %A_Space%
	IniRead, DelayKey3, settings.ini, variables, DelayKey3 %A_Space%
	IniRead, AbilityKey3, settings.ini, hotkeys, AbilityKey3 %A_Space%
	IniRead, DelayKey4, settings.ini, variables, DelayKey4 %A_Space%
	IniRead, AbilityKey4, settings.ini, hotkeys, AbilityKey4 %A_Space%
	
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
	Return
}




submit(){  
updateEverything:
	global
	Gui, Submit 
	;Variables for Flasks and stuff
	IniWrite, %Flask1dur%, Settings.ini, variables, Flask1dur %A_Space%
	IniWrite, %Flask2dur%, Settings.ini, variables, Flask2dur %A_Space%
	IniWrite, %Flask3dur%, Settings.ini, variables, Flask3dur %A_Space%
	IniWrite, %Flask4dur%, Settings.ini, variables, Flask4dur %A_Space%
	IniWrite, %Flask5dur%, Settings.ini, variables, Flask5dur %A_Space%
	IniWrite, %HealthPct%, Settings.ini, variables, HealthPct %A_Space%
	IniWrite, %ManaPct%, Settings.ini, variables, ManaPct %A_Space%
	IniWrite, %HealthPctChicken%, settings.ini, variables, HealthPctChicken %A_Space%
	IniWrite, %ShieldPctChicken%, settings.ini, variables, ShieldPctChicken %A_Space%
	
	;Hotkeys and stuff
	IniWrite, %Flask1key%, Settings.ini, hotkeys, Flask1key %A_Space%
	IniWrite, %Flask1triggerkey%, Settings.ini, hotkeys, Flask1triggerkey %A_Space%
	IniWrite, %Flaskbox1%, settings.ini, Checkbox, Flaskbox1 %A_Space%
	IniWrite, %Flaskbox2%, settings.ini, Checkbox, Flaskbox2 %A_Space%
	IniWrite, %Flaskbox3%, settings.ini, Checkbox, Flaskbox3 %A_Space%
	IniWrite, %Flaskbox4%, settings.ini, Checkbox, Flaskbox4 %A_Space%
	IniWrite, %Flaskbox5%, settings.ini, Checkbox, Flaskbox5 %A_Space%
	IniWrite, %FlaskType1%, settings.ini, Checkbox, FlaskType1 %A_Space%
	IniWrite, %FlaskType2%, settings.ini, Checkbox, FlaskType2 %A_Space%
	IniWrite, %FlaskType3%, settings.ini, Checkbox, FlaskType3 %A_Space%
	IniWrite, %FlaskType4%, settings.ini, Checkbox, FlaskType4 %A_Space%
	IniWrite, %FlaskType5%, settings.ini, Checkbox, FlaskType5 %A_Space%
	IniWrite, %Steambox%, settings.ini, Checkbox, Steambox %A_Space%
	IniWrite, %ChickenBox%, settings.ini, Checkbox, ChickenBox %A_Space%
	
	
	IniWrite, %Flask2key%, Settings.ini, hotkeys, Flask2key %A_Space%
	IniWrite, %Flask2triggerkey%, Settings.ini, hotkeys, Flask2triggerkey %A_Space%
	
	IniWrite, %Flask3key%, Settings.ini, hotkeys, Flask3key %A_Space%
	IniWrite, %Flask3triggerkey%, Settings.ini, hotkeys, Flask3triggerkey %A_Space%
	
	IniWrite, %Flask4key%, Settings.ini, hotkeys, Flask4key %A_Space%
	IniWrite, %Flask4triggerkey%, Settings.ini, hotkeys, Flask4triggerkey %A_Space%
	
	IniWrite, %Flask5key%, Settings.ini, hotkeys, Flask5key %A_Space%
	IniWrite, %Flask5triggerkey%, Settings.ini, hotkeys, Flask5triggerkey %A_Space%
	
		;Ability Key stuff
	IniWrite, %HealthPercentKey1%, settings.ini, variables, HealthPercentKey1 %A_Space%
	IniWrite, %DelayKey1%, settings.ini, variables, DelayKey1 %A_Space%
	IniWrite, %AbilityKey1%, settings.ini, hotkeys, AbilityKey1 %A_Space%
	IniWrite, %AbilityKey1Box%, settings.ini, Checkbox, AbilityKey1Box %A_Space%
	
	IniWrite, %HealthPercentKey2%, settings.ini, variables, HealthPercentKey2 %A_Space%
	IniWrite, %DelayKey2%, settings.ini, variables, DelayKey2 %A_Space%
	IniWrite, %AbilityKey2%, settings.ini, hotkeys, AbilityKey2 %A_Space%
	IniWrite, %AbilityKey2Box%, settings.ini, Checkbox, AbilityKey2Box %A_Space%
	
	IniWrite, %HealthPercentKey3%, settings.ini, variables, HealthPercentKey3 %A_Space%
	IniWrite, %DelayKey3%, settings.ini, variables, DelayKey3 %A_Space%
	IniWrite, %AbilityKey3%, settings.ini, hotkeys, AbilityKey3 %A_Space%
	IniWrite, %AbilityKey3Box%, settings.ini, Checkbox, AbilityKey3Box %A_Space%
	
	IniWrite, %HealthPercentKey4%, settings.ini, variables, HealthPercentKey4 %A_Space%
	IniWrite, %DelayKey4%, settings.ini, variables, DelayKey4 %A_Space%
	IniWrite, %AbilityKey4%, settings.ini, hotkeys, AbilityKey4 %A_Space%
	IniWrite, %AbilityKey4Box%, settings.ini, Checkbox, AbilityKey4Box %A_Space%
	
	
	
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
