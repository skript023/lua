require("sig_array")
require("pointers")

function ptr_string()--Pointer or Address To String
gptr      = readPointer
gadr      = getAddress
T_GET     = getAddressList()
L_GET     = getAddressList
getLuaEngine().cbShowOnPrint.Checked=false
getLuaEngine().hide()
auto_add()

------------------------ClassOffsets--------------------------------------------------------------
vtByte=0
vtWord=1
vtDword=2
vtQword=3
vtSingle=4
vtDouble=5
vtString=6
vtUnicodeString=7 --Only used by autoguess
vtByteArray=8
vtBinary=9
vtAutoAssembler=11
vtPointer=12 --Only used by autoguess and structures
vtCustom=13
vtGrouped=14
MAX_INT = 2147483647 or "2147483647"
MIN_INT = -2147483647 or "-2147483647"
MAX_UINT = 4294967295 or "4294967295"
MAX_ULONG = 18446744073709551615 or "18446744073709551615"
TRUE = 1
FALSE = 0

FLYING_HANDLING = 0x158

sfh = {
Thrust = 0x8;
ThrustFallOff = 0xC;
ThrustVectoring = 0x10;
YawMult = 0x1C;
YawStabilise = 0x20;
RollMult = 0x2C;
RllStabilise = 0x30;
PitchMult = 0x38;
PitchStabilise = 0x3C;
SideSlipMult = 0x24;
FrmLiftMult = 0x44;
AttackLiftMult = 0x48;
AttackDiveMult = 0x4C;
GearDwnDragV = 0x50;
GearDwnLiftMult = 0x54;
WindMult = 0x58;
MveRes = 0x5C;
TurnResX = 0x60;
TurnResY = 0x64;
TurnResZ = 0x68;
SpeedResX = 0x70;
SpeedResY = 0x74;
SpeedResZ = 0x78;
GearDrFrntpen = 0x80;
GearDrRearpen = 0x84;
GearDrRearpen2 = 0x88;
GearDrRearMpen = 0x8C;
TurublenceMagnitudeMax = 0x90;
TurublenceFrceMulti = 0x94;
TurublenceRllTrqueMulti = 0x98;
TurublencePitchTrqueMulti = 0x9C;
BdyDamageCntrlEffectMult = 0xA0;
InputSensitivityFrDifficulty = 0xA4;
nGrundYawBstSpeedCap = 0xAC;
nGrundYawBstSpeedPeak = 0xA8;
EngineffGlideMulti = 0xB0;
}

CPED   = 0x8
POS      = 0x30
GOD      = 0x189
HP       = 0X280
ARMOR    = 0X14E0
RAGDOLL  = 0X10B8
CORDX    = 0x50
CORDY    = 0x54
CORDZ    = 0x58
HEADX    = 0X20
HEADY	 = 0x24
IN_VEH   = 0X148C
IN_VEH2  = 0XE52
IN_VEH3  = 0x1477

MAX_HP  = 0X2A0

VEH      = 0XD30
VECX     = 0X90
VECY     = 0X94
VECZ     = 0X98
SEATBELT = 0X140C
VEH_HP1  = 0X908
VEH_HP2  = 0X840
VEH_HP3  = 0X844
HANDLING = 0X938
COL      = 0XF0
WEP_COL  = 0XF4
VEH_COL  = 0XF8
ENGINE_COL   = 0XFC
VEH_BODY = 0x824
VEH_ENGINE = 0x8E8
VEH_DIRT = 0x9D8

PLAYER_INFO  = 0X10C8
WANTED_LEVEL = 0X868
STAM = 0XCD4
STAM_MAX = 0XCD8
RUN_SPD = 0XCD0
SWIM_SPD = 0X150
SNEAK_SPD = 0X16C
HP_DMG = 0XCF0
ARMOR_DMG = 0XCF4

TUNING = 0x48
COLOR  = 0X20
-------------------------------VEHICLE MOD----------------------------------------------
---PRIMARY COLOUR---
VEH_P_COLOUR_R      = 0xA6
VEH_P_COLOUR_B      = 0xA4
VEH_P_COLOUR_G      = 0xA5
P_COLOUR_TYPE       = 0x3F6
---SECONDARY COLOUR---
VEH_S_COLOUR_R    = 0xAA
VEH_S_COLOUR_G    = 0xA9
VEH_S_COLOUR_B    = 0xA8
S_COLOUR_TYPE     = 0x3F7
----NEON COLOUR--------
NEON_R     = 0x3A2
NEON_G     = 0x3A1
NEON_B     = 0x3A0
NEON_L     = 0x402
NEON_R     = 0x403
NEON_B     = 0x404
NEON_F     = 0x405
-----TIRES COLOR--------
TIRES_R    = 0x3FC
TIRES_G    = 0x3FD
TIRES_B    = 0x3FE
-----PEARL COLOUR--------
PE_COLOUR_TYPE   = 0x3F8
PE_COLOUR_R      = 0xC2
PE_COLOUR_G      = 0xC1
PE_COLOUR_B      = 0xC0
------XENON---------------
XENON        = 0x3E1
XENON_COLOUR = 0x406
-------PERFORMANCE UPGRADE---
SUSPENSION     = 0x3DA
ARMOUR         = 0x3DB
TURBO          = 0x3DD
EMS            = 0x3D6
BRAKE          = 0x3D7
TRANSMISSION   = 0x3D8
--------------------------Signature Definition Changer-------------------------------
PED_FACTORY   = hook.GET("WorldPTR")
GLOBAL_SCRIPT = hook.GET("GlobalPTR")
PLAYER_LIST   = hook.GET("PlayerCountPTR")
CarSpawn      = hook.GET("[GlobalPTR+48]+C5000")
-------------------------global script-------------------------------------------------
CharSlot 		  = hook.GET(Global_(1312763))
NETWORK_HANDLER   = hook.GET(Global_(2462286+5))
VEH_HANDLER       = hook.GET(Global_(2462286+2))
--SPAWNER_CORD_X    = hook.GET("CarSpawn+1190")
--SPAWNER_CORD_Y    = hook.GET("CarSpawn+1198")
--SPAWNER_CORD_Z    = hook.GET("CarSpawn+11A0")
SPAWNER_SPOILER   = hook.GET(Global_(2462286+27+10))
BYPASS_VEH_1      = hook.GET(Global_(2462286+27+95))
BYPASS_VEH_2      = hook.GET(Global_(2462286+27+94))
VEH_LIST          = hook.GET(Global_(2462286+27+66))
AS_PEGASUS        = hook.GET(Global_(2462286+3))
SPW_LIVERY        = hook.GET(Global_(2462286+27+58))

SPAWNER_CORD_X    = hook.GET(Global_(2462286+7+0))
SPAWNER_CORD_Y    = hook.GET(Global_(2462286+7+1))
SPAWNER_CORD_Z    = hook.GET(Global_(2462286+7+2))
AFK1              = hook.GET(Global_(262145+87))
AFK2              = hook.GET(Global_(262145+88))
AFK3              = hook.GET(Global_(262145+89))
AFK4              = hook.GET(Global_(262145+90))
PLATE_LISENCE     = hook.GET(Global_(2462286+27+1))
TAKE_VISUAL       = hook.GET(Global_(1377909+4714))
CASH              = hook.GET(Global_(262145+28087))
ARTWORK           = hook.GET(Global_(262145+28088))
GOLD              = hook.GET(Global_(262145+28089))
DIAMOND           = hook.GET(Global_(262145+28090))
LESTER_CUT        = hook.GET(Global_(262145+28073))
SALJU             = hook.GET(Global_(262145+4724))
JOIN_STATUS       = hook.GET(Global_(2425869+PLAYER_ID()*443+1))
CHAR_EXP_1        = hook.GET(Global_(1378319+9851+28))
CHAR_EXP_2        = hook.GET(Global_(1378319+9851+29))
PLAYER_LEVEL      = hook.GET(Global_(1590682+1+PLAYER_ID()*883+211+6))
PLAYER_GLOBAL_RP  = hook.GET(Global_(1590682+1+PLAYER_ID()*883+211+5))
PLAYER_TOTAL_MONEY= hook.GET(Global_(1590682+1+PLAYER_ID()*883+211+56))
PLAYER_TOTAL_CASH = hook.GET(Global_(1590682+1+PLAYER_ID()*883+211+3))
PLAYER_CURRENT_EXP= hook.GET(Global_(1590682+1+PLAYER_ID()*883+211+1))
PLAYER_TOTAL_KILL = hook.GET(Global_(1590682+1+PLAYER_ID()*883+211+28))
SET_TO_PV         = hook.GET(Global_(2409291+8))
RESEACH_TEMP      = hook.GET(Global_(262145+21389))
P_DOC             = hook.GET(Global_(262145+16964))
P_CASH            = hook.GET(Global_(262145+16965))
P_COKE            = hook.GET(Global_(262145+16966))
P_METH            = hook.GET(Global_(262145+16967))
P_WEED            = hook.GET(Global_(262145+16968))
IS_SESSION_PUBLIC = hook.GET(Global_(2451787+742))
TIMER_CARGO       = hook.GET(Global_(262145+15116))
CURRENT_SESSION   = hook.GET(Global_(1312855))
CASINO_CUT_1      = hook.GET(Global_(1697303+2326))
CASINO_CUT_2      = hook.GET(Global_(1697303+2327))
CASINO_CUT_3      = hook.GET(Global_(1697303+2328))
CASINO_CUT_4      = hook.GET(Global_(1697303+2329))
DOOMSDAY_CUT_1    = hook.GET(Global_(1693565+812+50+1))
DOOMSDAY_CUT_2    = hook.GET(Global_(1693565+812+50+2))
DOOMSDAY_CUT_3    = hook.GET(Global_(1693565+812+50+3))
DOOMSDAY_CUT_4    = hook.GET(Global_(1693565+812+50+4))
APT_CUT_1         = hook.GET(Global_(1666210+3008+1))
APT_CUT_2         = hook.GET(Global_(1666210+3008+2))
APT_CUT_3         = hook.GET(Global_(1666210+3008+3))
APT_CUT_4         = hook.GET(Global_(1666210+3008+4))
CPERICO_1         = hook.GET(Global_(1704127+823+56+1))
CPERICO_2         = hook.GET(Global_(1704127+823+56+2))
CPERICO_3         = hook.GET(Global_(1704127+823+56+3))
CPERICO_4         = hook.GET(Global_(1704127+823+56+4))
CAYO_PERICO_BAG   = hook.GET(Global_(262145+28999))
BUNKER_MONEY	  = hook.GET(Global_(262145+21070))
DOC_MONEY		  = hook.GET(Global_(262145+16964))
CASH_MONEY		  = hook.GET(Global_(262145+16965))
COCAIN_MONEY	  = hook.GET(Global_(262145+16966))
WEED_MONEY		  = hook.GET(Global_(262145+16968))
METH_MONEY		  = hook.GET(Global_(262145+16967))
S_CARGO_1		  = hook.GET(Global_(262145+15337))
FLEECA			  = hook.GET(Global_(262145+8664))
PRISON_BREAK	  = hook.GET(Global_(262145+8665))
HUMANE_LAB		  = hook.GET(Global_(262145+8666))
A_SERIES		  = hook.GET(Global_(262145+8667))
PASIFIC_STANDARD  = hook.GET(Global_(262145+8668))
ACT_1             = hook.GET(Global_(262145+8669))
ACT_2 			  = hook.GET(Global_(262145+8670))
ACT_3   		  = hook.GET(Global_(262145+8671))
Panther  		  =	hook.GET(Global_(262145+29238))
Madrazo_Files	  =	hook.GET(Global_(262145+29237))
Pink_DIAMOND      = hook.GET(Global_(262145+29236))
Bearer_Bonds      =	hook.GET(Global_(262145+29235))
Ruby			  =	hook.GET(Global_(262145+29234))
Tequila	    	  = hook.GET(Global_(262145+29233))
--------------------------Address Definition--------------------------------------------------
PLAYER_CORDX = getAddress(CPlayerPos + 0x50,true)
PLAYER_CORDY = hook.GET(CPlayerPos + 0x54)
PLAYER_CORDZ = hook.GET(CPlayerPos + 0x58)

PLAYER_VECX  = hook.GET(CPlayer + 0x90)
PLAYER_VECY  = hook.GET(CPlayer + 0x94)
PLAYER_VECZ  = hook.GET(CPlayer + 0x98)

PLAYER_HEADING_X = hook.GET(CPlayerPos + 20)
PLAYER_HEADING_Y = hook.GET(CPlayerPos + 24)

--PLAYER_VEHX = hook.GET("[[[[WorldPTR]+8]+D28]+30]+50")
--PLAYER_VEHY = hook.GET("[[[[WorldPTR]+8]+D28]+30]+54")
--PLAYER_VEHZ = hook.GET("[[[[WorldPTR]+8]+D28]+30]+58")

--PLAYER_VEH_VECX  = hook.GET("[[[WorldPTR]+8]+D28]+90")
--PLAYER_VEH_VECY  = hook.GET("[[[WorldPTR]+8]+D28]+94")
--PLAYER_VEH_VECZ  = hook.GET("[[[WorldPTR]+8]+D28]+98")

PLAYER_GOD   = hook.GET(CPlayer + GOD)
PLAYER_HP    = hook.GET(CPlayer + 0x280)
PLAYER_ARMOR = hook.GET(CPlayer + 0x14E0)
DMG_TO_HP    = hook.GET(CPlayerInfo + 0xCF0)
DMG_TO_ARMOR = hook.GET(CPlayerInfo + 0xCF4)
PLAYER_RUN_SPD = hook.GET(CPlayerInfo + RUN_SPD)
PLAYER_SWIM_SPD = hook.GET(CPlayerInfo + SWIM_SPD)
PLAYER_SNEAK_SPD = hook.GET(CPlayerInfo + SNEAK_SPD)
PLAYER_MAX_HP    = hook.GET(CPlayer + 0x2A0)

PLAYER_WANTED_LEVEL   = hook.GET(CPlayerInfo + 0x868)
IS_PLAYER_WANTED_LEVEL   = hook.GET(CPlayerInfo + 0x860)
PLAYER_DMG_MULT_MELEE = hook.GET(CPlayerInfo + 0xCEC)
PLAYER_DMG_MULT_WEP   = hook.GET(CPlayerInfo + 0xCF8)
--TAKE_ALL        = hook.GET("[[GlobalPTR-128]+1180]+2A578")
TAKE_ALL        = hook.GET("[[GlobalPTR-128]+1180]+2A610")

TOTAL_PLAYER    = hook.GET("[PlayerCountPTR]+178")
TOTAL_SESSION   = hook.GET("[[[PlayerCountPTR]+11*8]+B0]")
--CUACA           = hook.GET("GTA5.exe+24C7720")
CUACA           = hook.GET("GTA5.exe+24EDC70")
RID             = hook.GET(CPlayerInfo + 0x70)
IP_ONLINE       = hook.GET(CPlayerInfo + 0x44)
IP_LAN          = hook.GET(CPlayerInfo + 0x34)
PORT            = hook.GET(CPlayerInfo + 0x38)
PLAYER_NAME     = hook.GET(CPlayerInfo + 0x84)
PLAYER_NAME     = hook.GET("GTA5.exe+28E9E74")
PLAYER_NAME     = hook.GET("GTA5.exe+28F47AC")
PLAYER_NAME     = hook.GET("GTA5.exe+28F48FC")
PLAYER_NAME     = hook.GET("GTA5.exe+2D2F304")
PLAYER_NAME     = hook.GET("GTA5.exe+2D3229F")
PLAYER_NAME     = hook.GET("GTA5.exe+2D3569F")
PLAYER_NAME     = hook.GET("GTA5.exe+2D35934")
DEL_CASH        = hook.GET("[[GlobalPTR-128]+EE0]+19E8")
DEL_COKE        = hook.GET("[[GlobalPTR-128]+F40]+19E8")
DEL_DOC         = hook.GET("[[GlobalPTR-128]+E98]+19E8")
DEL_WEED        = hook.GET("[[GlobalPTR-128]+F10]+19E8")
DEL_FLY         = hook.GET("[[GlobalPTR-128]+EB0]+19E8")
DEL_BKR         = hook.GET("[[GlobalPTR-128]+1180]+3F68")
DEL_CARGO       = hook.GET("[[GlobalPTR-128]+E38]+1268")
REQ_DEL_CARGO   = hook.GET("GTA5.exe+261833C")
--REQ_DEL_CARGO   = hook.GET("GTA5.exe+26102EC")
DEL_HANGAR      = hook.GET("[[GlobalPTR-128]+1180]+5E38")
FRAME_FLAG      = hook.GET(CPlayerInfo + 0x1F9)
INVISIBLE       = hook.GET(CPlayer + 0x2C)
PROP_HASH       = hook.GET("[[[[[ReplayInterfacePTR]+20]+B0]+0]+490]+E80")
PROP_HASH2      = hook.GET("[[[[[ReplayInterfacePTR]+20]+B0]+0]+490]+40")
--STAT_BOOL       = hook.GET("[[[GTA5.exe+02D9C378]+498]+220]+218")
--STAT_BOOL		= hook.GET("[[[[[GTA5.exe+02D9C378]+DC8]+3F0]+B8]+390]+218")
--STAT_BOOL		= hook.GET("[[[[[GTA5.exe+025E8C50]+1B8]+8]+B8]+390]+218")
STAT_BOOL		= hook.GET("[[[GTA5.exe+02DA43D8]+68]+B0]+218")
PLAYER_COLLISION = hook.GET("[[[[[[[WorldPTR]+8]+30]+10]+20]+70]+0]+2C")
RID_ASLI         = hook.GET("GTA5.exe+2D62A18")
dev_mode        = hook.GET("GTA5.exe+A738B4")
auto_aim        = hook.GET("GTA5.exe+1F805CC")
script          = coroutine
--IsTaking        = hook.GET("[[[[[GTA5.exe+01EE18A8]+0]+3B0]+918]+2A0]+318")
TAKE_ALL_C      = hook.GET("[[GlobalPTR-128]+1180]+4B500")
end

ptr_string()
--VSpawn.CEListView1.Items[0].Checked = true
if STAT_BOOL == nil then 
    local bool_backup1 = hook.GET("[[[GTA5.exe+02DA43D8]+60]+220]+218")
    STAT_BOOL = bool_backup1
elseif STAT_BOOL == nil then
    local bool_backup2 = hook.GET("[[[GTA5.exe+02DA43E8]+498]+220]+218")
    STAT_BOOL = bool_backup2
elseif STAT_BOOL == nil then
    local bool_backup3 = hook.GET("[[[[GTA5.exe+02DA43D8]+68]+E0]+20]+218")
    STAT_BOOL = bool_backup3
end

--[[function local_loader()
    Local.l_perico()
    Local.l_roulette()
    Local.l_three_card()
    Local.l_rig_slot()
    Local.l_black_jack()
    Local.l_lucky_wheel()
    Local.l_mission()
    Local.l_freemode()
    Local.l_selector()
    Local.l_social_controller()
    Local.l_stats_controller()
    Local.l_achievment_controller()
    Local.l_shop_controller()
    Local.l_code_controller()
    Local.l_building_controller()
    Local.l_am_mp_bunker()
    Local.l_gb_contraband_sell()
    --print("Running")
end

THREAD.func_1(local_loader,true,1000)]]