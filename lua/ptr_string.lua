require("sig_array")
require("pointers")
require("CPH")

-- x = x * 2 ^ y - 1;
function SecondaryLoot(Location) -- (1 << 24) - 1 
    local x = (1 << Location) - 1
    return x
end

function ptr_string() -- Pointer or Address To String
    gptr = readPointer
    gadr = getAddress
    T_GET = getAddressList()
    L_GET = getAddressList
    getLuaEngine().cbShowOnPrint.Checked = false
    getLuaEngine().hide()
    auto_add()

    ------------------------ClassOffsets--------------------------------------------------------------
    vtByte = 0
    vtWord = 1
    vtDword = 2
    vtQword = 3
    vtSingle = 4
    vtDouble = 5
    vtString = 6
    vtUnicodeString = 7 -- Only used by autoguess
    vtByteArray = 8
    vtBinary = 9
    vtAutoAssembler = 11
    vtPointer = 12 -- Only used by autoguess and structures
    vtCustom = 13
    vtGrouped = 14
    MAX_INT = 2147483647 or "2147483647"
    MIN_INT = -2147483647 or "-2147483647"
    MAX_UINT = 4294967295 or "4294967295"
    MAX_ULONG = 18446744073709551615
    _G.TRUE = 1
    _G.FALSE = 0

    LOOT_LOC_A = SecondaryLoot(1)
    LOOT_LOC_B = SecondaryLoot(2)
    LOOT_LOC_C = SecondaryLoot(3)
    LOOT_LOC_D = SecondaryLoot(4)
    LOOT_LOC_E = SecondaryLoot(5)
    LOOT_LOC_F = SecondaryLoot(6)
    LOOT_LOC_G = SecondaryLoot(7)
    LOOT_LOC_H = SecondaryLoot(8)
    LOOT_LOC_I = SecondaryLoot(9)
    LOOT_LOC_J = SecondaryLoot(10)
    LOOT_LOC_K = SecondaryLoot(11)
    LOOT_LOC_L = SecondaryLoot(12)
    LOOT_LOC_M = SecondaryLoot(13)
    LOOT_LOC_N = SecondaryLoot(14)
    LOOT_LOC_O = SecondaryLoot(15)
    LOOT_LOC_P = SecondaryLoot(16)
    LOOT_LOC_Q = SecondaryLoot(17)
    LOOT_LOC_R = SecondaryLoot(18)
    LOOT_LOC_S = SecondaryLoot(19)
    LOOT_LOC_T = SecondaryLoot(20)
    LOOT_LOC_U = SecondaryLoot(21)
    LOOT_LOC_V = SecondaryLoot(22)
    LOOT_LOC_W = SecondaryLoot(23)
    LOOT_LOC_X = SecondaryLoot(24)

    FLYING_HANDLING = 0x158

    sfh = {
        Thrust = 0x8,
        ThrustFallOff = 0xC,
        ThrustVectoring = 0x10,
        YawMult = 0x1C,
        YawStabilise = 0x20,
        RollMult = 0x2C,
        RllStabilise = 0x30,
        PitchMult = 0x38,
        PitchStabilise = 0x3C,
        SideSlipMult = 0x24,
        FrmLiftMult = 0x44,
        AttackLiftMult = 0x48,
        AttackDiveMult = 0x4C,
        GearDwnDragV = 0x50,
        GearDwnLiftMult = 0x54,
        WindMult = 0x58,
        MveRes = 0x5C,
        TurnResX = 0x60,
        TurnResY = 0x64,
        TurnResZ = 0x68,
        SpeedResX = 0x70,
        SpeedResY = 0x74,
        SpeedResZ = 0x78,
        GearDrFrntpen = 0x80,
        GearDrRearpen = 0x84,
        GearDrRearpen2 = 0x88,
        GearDrRearMpen = 0x8C,
        TurublenceMagnitudeMax = 0x90,
        TurublenceFrceMulti = 0x94,
        TurublenceRllTrqueMulti = 0x98,
        TurublencePitchTrqueMulti = 0x9C,
        BdyDamageCntrlEffectMult = 0xA0,
        InputSensitivityFrDifficulty = 0xA4,
        nGrundYawBstSpeedCap = 0xAC,
        nGrundYawBstSpeedPeak = 0xA8,
        EngineffGlideMulti = 0xB0
    }

    CPED = 0x8
    POS = 0x30
    GOD = 0x189
    HP = 0X280
    ARMOR = 0X14E0
    RAGDOLL = 0X10B8
    CORDX = 0x50
    CORDY = 0x54
    CORDZ = 0x58
    HEADX = 0X20
    HEADY = 0x24
    IN_VEH = 0X148C
    IN_VEH2 = 0XE52
    IN_VEH3 = 0x1477

    MAX_HP = 0X2A0

    VEH = 0XD30
    VECX = 0X90
    VECY = 0X94
    VECZ = 0X98
    SEATBELT = 0X140C
    VEH_HP1 = 0X908
    VEH_HP2 = 0X840
    VEH_HP3 = 0X844
    HANDLING = 0X938
    COL = 0XF0
    WEP_COL = 0XF4
    VEH_COL = 0XF8
    ENGINE_COL = 0XFC
    VEH_BODY = 0x824
    VEH_ENGINE = 0x8E8
    VEH_DIRT = 0x9D8

    PLAYER_INFO = 0X10C8
    WANTED_LEVEL = 0X888
    STAM = 0XCF4
    STAM_MAX = 0XCF8
    RUN_SPD = 0XCF0
    SWIM_SPD = 0X170
    SNEAK_SPD = 0X18C
    HP_DMG = 0XD10
    ARMOR_DMG = 0XD14

    TUNING = 0x48
    COLOR = 0X20
    -------------------------------VEHICLE MOD----------------------------------------------
    ---PRIMARY COLOUR---
    VEH_P_COLOUR_R = 0xA6
    VEH_P_COLOUR_B = 0xA4
    VEH_P_COLOUR_G = 0xA5
    P_COLOUR_TYPE = 0x3F6
    ---SECONDARY COLOUR---
    VEH_S_COLOUR_R = 0xAA
    VEH_S_COLOUR_G = 0xA9
    VEH_S_COLOUR_B = 0xA8
    S_COLOUR_TYPE = 0x3F7
    ----NEON COLOUR--------
    NEON_R = 0x3A2
    NEON_G = 0x3A1
    NEON_B = 0x3A0
    NEON_L = 0x402
    NEON_R = 0x403
    NEON_B = 0x404
    NEON_F = 0x405
    -----TIRES COLOR--------
    TIRES_R = 0x3FC
    TIRES_G = 0x3FD
    TIRES_B = 0x3FE
    -----PEARL COLOUR--------
    PE_COLOUR_TYPE = 0x3F8
    PE_COLOUR_R = 0xC2
    PE_COLOUR_G = 0xC1
    PE_COLOUR_B = 0xC0
    ------XENON---------------
    XENON = 0x3E1
    XENON_COLOUR = 0x406
    -------PERFORMANCE UPGRADE---
    SUSPENSION = 0x3DA
    ARMOUR = 0x3DB
    TURBO = 0x3DD
    EMS = 0x3D6
    BRAKE = 0x3D7
    TRANSMISSION = 0x3D8
    --------------------------Signature Definition Changer-------------------------------
    PED_FACTORY = get.Memory("WorldPTR")
    GLOBAL_SCRIPT = get.Memory("GlobalPTR")
    PLAYER_LIST = get.Memory("PlayerCountPTR")
    CarSpawn = get.Memory("[GlobalPTR+48]+C5000")
    -------------------------global script-------------------------------------------------
    CharSlot = get.Memory(Global_(1312763))
    NETWORK_HANDLER = get.Memory(Global_(2462514 + 5))
    VEH_HANDLER = get.Memory(Global_(2462514 + 2))
    -- SPAWNER_CORD_X    = get.Memory("CarSpawn+1190")
    -- SPAWNER_CORD_Y    = get.Memory("CarSpawn+1198")
    -- SPAWNER_CORD_Z    = get.Memory("CarSpawn+11A0")
    SPAWNER_SPOILER = get.Memory(Global_(2462514 + 27 + 10))
    BYPASS_VEH_1 = get.Memory(Global_(2462514 + 27 + 95))
    BYPASS_VEH_2 = get.Memory(Global_(2462514 + 27 + 94))
    VEH_LIST = get.Memory(Global_(2462514 + 27 + 66))
    AS_PEGASUS = get.Memory(Global_(2462514 + 3))
    SPW_LIVERY = get.Memory(Global_(2462514 + 27 + 58))

    SPAWNER_CORD_X = get.Memory(Global_(2462514 + 7 + 0))
    SPAWNER_CORD_Y = get.Memory(Global_(2462514 + 7 + 1))
    SPAWNER_CORD_Z = get.Memory(Global_(2462514 + 7 + 2))
    AFK1 = get.Memory(Global_(262145 + 87))
    AFK2 = get.Memory(Global_(262145 + 88))
    AFK3 = get.Memory(Global_(262145 + 89))
    AFK4 = get.Memory(Global_(262145 + 90))
    PLATE_LISENCE = get.Memory(Global_(2462514 + 27 + 1))
    TAKE_VISUAL = get.Memory(Global_(1377909 + 4714))
    CASH = get.Memory(Global_(262145 + 28088))
    ARTWORK = get.Memory(Global_(262145 + 28089))
    GOLD = get.Memory(Global_(262145 + 28090))
    DIAMOND = get.Memory(Global_(262145 + 28091))
    LESTER_CUT = get.Memory(Global_(262145 + 28074))
    SALJU = get.Memory(Global_(262145 + 4724))
    JOIN_STATUS = get.Memory(Global_(2426097 + PLAYER_ID() * 443 + 1))
    CHAR_EXP_1 = get.Memory(Global_(1378319 + 9851 + 28))
    CHAR_EXP_2 = get.Memory(Global_(1378319 + 9851 + 29))
    PLAYER_LEVEL = get.Memory(Global_(1590682 + 1 + PLAYER_ID() * 883 + 211 + 6))
    PLAYER_GLOBAL_RP = get.Memory(Global_(1590682 + 1 + PLAYER_ID() * 883 + 211 + 5))
    PLAYER_TOTAL_MONEY = get.Memory(Global_(1590682 + 1 + PLAYER_ID() * 883 + 211 + 56))
    PLAYER_TOTAL_CASH = get.Memory(Global_(1590682 + 1 + PLAYER_ID() * 883 + 211 + 3))
    PLAYER_CURRENT_EXP = get.Memory(Global_(1590682 + 1 + PLAYER_ID() * 883 + 211 + 1))
    PLAYER_TOTAL_KILL = get.Memory(Global_(1590682 + 1 + PLAYER_ID() * 883 + 211 + 28))
    SET_TO_PV = get.Memory(Global_(2409291 + 8))
    RESEACH_TEMP = get.Memory(Global_(262145 + 21389))
    P_DOC = get.Memory(Global_(262145 + 16964))
    P_CASH = get.Memory(Global_(262145 + 16965))
    P_COKE = get.Memory(Global_(262145 + 16966))
    P_METH = get.Memory(Global_(262145 + 16967))
    P_WEED = get.Memory(Global_(262145 + 16968))
    IS_SESSION_PUBLIC = get.Memory(Global_(2452015 + 742))
    TIMER_CARGO = get.Memory(Global_(262145 + 15116))
    CURRENT_SESSION = get.Memory(Global_(1312855))
    CASINO_CUT_1 = get.Memory(Global_(1697306 + 2326))
    CASINO_CUT_2 = get.Memory(Global_(1697306 + 2327))
    CASINO_CUT_3 = get.Memory(Global_(1697306 + 2328))
    CASINO_CUT_4 = get.Memory(Global_(1697306 + 2329))
    DOOMSDAY_CUT_1 = get.Memory(Global_(1693568 + 812 + 50 + 1))
    DOOMSDAY_CUT_2 = get.Memory(Global_(1693568 + 812 + 50 + 2))
    DOOMSDAY_CUT_3 = get.Memory(Global_(1693568 + 812 + 50 + 3))
    DOOMSDAY_CUT_4 = get.Memory(Global_(1693568 + 812 + 50 + 4))
    APT_CUT_1 = get.Memory(Global_(1666211 + 3008 + 1))
    APT_CUT_2 = get.Memory(Global_(1666211 + 3008 + 2))
    APT_CUT_3 = get.Memory(Global_(1666211 + 3008 + 3))
    APT_CUT_4 = get.Memory(Global_(1666211 + 3008 + 4))
    CPERICO_1 = get.Memory(Global_(1704130 + 823 + 56 + 1))
    CPERICO_2 = get.Memory(Global_(1704130 + 823 + 56 + 2))
    CPERICO_3 = get.Memory(Global_(1704130 + 823 + 56 + 3))
    CPERICO_4 = get.Memory(Global_(1704130 + 823 + 56 + 4))
    CAYO_PERICO_BAG = get.Memory(Global_(262145 + 29000))
    BUNKER_MONEY = get.Memory(Global_(262145 + 21070))
    DOC_MONEY = get.Memory(Global_(262145 + 16964))
    CASH_MONEY = get.Memory(Global_(262145 + 16965))
    COCAIN_MONEY = get.Memory(Global_(262145 + 16966))
    WEED_MONEY = get.Memory(Global_(262145 + 16968))
    METH_MONEY = get.Memory(Global_(262145 + 16967))
    S_CARGO_1 = get.Memory(Global_(262145 + 15337))
    FLEECA = get.Memory(Global_(262145 + 8664))
    PRISON_BREAK = get.Memory(Global_(262145 + 8665))
    HUMANE_LAB = get.Memory(Global_(262145 + 8666))
    A_SERIES = get.Memory(Global_(262145 + 8667))
    PASIFIC_STANDARD = get.Memory(Global_(262145 + 8668))
    ACT_1 = get.Memory(Global_(262145 + 8669))
    ACT_2 = get.Memory(Global_(262145 + 8670))
    ACT_3 = get.Memory(Global_(262145 + 8671))
    Panther = get.Memory(Global_(262145 + 29239))
    Madrazo_Files = get.Memory(Global_(262145 + 29238))
    Pink_DIAMOND = get.Memory(Global_(262145 + 29237))
    Bearer_Bonds = get.Memory(Global_(262145 + 29236))
    Ruby = get.Memory(Global_(262145 + 29235))
    Tequila = get.Memory(Global_(262145 + 29234))
    TransitionStatus = get.Memory(Global_(1312792))
    CheatNum = get.Memory(Global_(1388057))
    OffensiveLang = get.Memory(Global_(1388059))
    Griefing = get.Memory(Global_(1388060))
    TagPlate = get.Memory(Global_(1388062))
    OffensiveUGC = get.Memory(Global_(1388063))
    AntiDespawn = get.Memory(Global_(4269479))
    --------------------------Address Definition--------------------------------------------------
    PLAYER_CORDX = get.Memory(CPlayerPos + 0x50, true)
    PLAYER_CORDY = get.Memory(CPlayerPos + 0x54)
    PLAYER_CORDZ = get.Memory(CPlayerPos + 0x58)

    PLAYER_VECX = get.Memory(CPlayer + 0x90)
    PLAYER_VECY = get.Memory(CPlayer + 0x94)
    PLAYER_VECZ = get.Memory(CPlayer + 0x98)

    PLAYER_HEADING_X = get.Memory(CPlayerPos + 20)
    PLAYER_HEADING_Y = get.Memory(CPlayerPos + 24)

    -- PLAYER_VEHX = get.Memory("[[[[WorldPTR]+8]+D28]+30]+50")
    -- PLAYER_VEHY = get.Memory("[[[[WorldPTR]+8]+D28]+30]+54")
    -- PLAYER_VEHZ = get.Memory("[[[[WorldPTR]+8]+D28]+30]+58")

    -- PLAYER_VEH_VECX  = get.Memory("[[[WorldPTR]+8]+D28]+90")
    -- PLAYER_VEH_VECY  = get.Memory("[[[WorldPTR]+8]+D28]+94")
    -- PLAYER_VEH_VECZ  = get.Memory("[[[WorldPTR]+8]+D28]+98")

    PLAYER_GOD = get.Memory(CPlayer + GOD)
    PLAYER_HP = get.Memory(CPlayer + 0x280)
    PLAYER_ARMOR = get.Memory(CPlayer + 0x14E0)
    DMG_TO_HP = get.Memory(CPlayerInfo + HP_DMG)
    DMG_TO_ARMOR = get.Memory(CPlayerInfo + ARMOR_DMG)
    PLAYER_RUN_SPD = get.Memory(CPlayerInfo + RUN_SPD)
    PLAYER_SWIM_SPD = get.Memory(CPlayerInfo + SWIM_SPD)
    PLAYER_SNEAK_SPD = get.Memory(CPlayerInfo + SNEAK_SPD)
    SUPER_PUNCH = get.Memory(CPlayerInfo + 0xD1C)
    PLAYER_MAX_HP = get.Memory(CPlayer + 0x2A0)

    PLAYER_WANTED_LEVEL = get.Memory(CPlayerInfo + 0x888)
    IS_PLAYER_WANTED_LEVEL = get.Memory(CPlayerInfo + 0x880)
    PLAYER_DMG_MULT_MELEE = get.Memory(CPlayerInfo + 0xD14) -- CEC CF8
    PLAYER_DMG_MULT_WEP = get.Memory(CPlayerInfo + 0xD18)
    -- TAKE_ALL        = get.Memory("[[GlobalPTR-128]+1180]+2A578")
    TAKE_ALL = get.Memory(Indicators + 0x2A610)
    TAKE_ALL_C = get.Memory(Indicators + 0x4B500)
    VAULT_DOOR_ARCADE = get.Memory(get.Ptr(GetGlobal + 0xFD0) + 0x3B50)
    VAULT_DOOR = get.Memory(Indicators + 0x127B8)
    TOTAL_PLAYER = get.Memory("[PlayerCountPTR]+178")
    TOTAL_SESSION = get.Memory("[[[PlayerCountPTR]+11*8]+B0]")
    -- CUACA           = get.Memory("GTA5.exe+24C7720") GTA5.exe+24EDC70
    CUACA = get.Memory("GTA5.exe+2500D20")
    RID = get.Memory(CPlayerInfo + 0x90)
    IP_ONLINE = get.Memory(CPlayerInfo + 0x6C)
    IP_LAN = get.Memory(CPlayerInfo + 0x74)
    PORT = get.Memory(CPlayerInfo + 0x78)
    PLAYER_NAME = get.Memory(CPlayerInfo + 0xA4)
    DEL_CASH = get.Memory("[[GlobalPTR-128]+EE0]+19E8")
    DEL_COKE = get.Memory("[[GlobalPTR-128]+F40]+19E8")
    DEL_DOC = get.Memory("[[GlobalPTR-128]+E98]+19E8")
    DEL_WEED = get.Memory("[[GlobalPTR-128]+F10]+19E8")
    DEL_FLY = get.Memory("[[GlobalPTR-128]+EB0]+19E8")
    DEL_BKR = get.Memory("[[GlobalPTR-128]+1180]+3F68")
    DEL_CARGO = get.Memory("[[GlobalPTR-128]+E38]+1268")
    REQ_DEL_CARGO = get.Memory("GTA5.exe+262B3CC")
    -- REQ_DEL_CARGO   = get.Memory("GTA5.exe+26102EC")
    DEL_HANGAR = get.Memory("[[GlobalPTR-128]+1180]+5E38")
    FRAME_FLAG = get.Memory(CPlayerInfo + 0x219)
    INVISIBLE = get.Memory(CPlayer + 0x2C)
    PROP_HASH = get.Memory("[[[[[ReplayInterfacePTR]+20]+B0]+0]+490]+E80")
    PROP_HASH2 = get.Memory("[[[[[ReplayInterfacePTR]+20]+B0]+0]+490]+40")
    -- STAT_BOOL       = get.Memory("[[[GTA5.exe+02D9C378]+498]+220]+218")
    -- STAT_BOOL		= get.Memory("[[[[[GTA5.exe+02D9C378]+DC8]+3F0]+B8]+390]+218")
    -- STAT_BOOL		= get.Memory("[[[[[GTA5.exe+025E8C50]+1B8]+8]+B8]+390]+218")
    STAT_BOOL = get.Memory("[[GlobalPTR-128]+ 0x10C0]+ 0x4AC8")
    PLAYER_COLLISION = get.Memory("[[[[[[[WorldPTR]+8]+30]+10]+20]+70]+0]+2C")
    RID_ASLI = get.Memory("GTA5.exe+29240E8")
    dev_mode = get.Memory("GTA5.exe+A738B4")
    auto_aim = get.Memory("GTA5.exe+1F805CC")
    -- IsTaking        = get.Memory("[[[[[GTA5.exe+01EE18A8]+0]+3B0]+918]+2A0]+318")
    AIM_STATUS = get.Memory("GTA5.exe+1F8BD6C", true)
    JAM = get.Memory("GTA5.exe+1CEE608")
    MENIT = get.Memory("GTA5.exe+1CEE60C")
    DETIK = get.Memory("GTA5.exe+1CEE610")
    Thermalvision = get.Memory("GTA5.exe+22544FA")
    Nightvision = get.Memory("GTA5.exe+225548E")
    Playername1 = get.Memory("GTA5.exe+1F8BD48")
    Playername2 = get.Memory("GTA5.exe+2916514")
    Playername3 = get.Memory("GTA5.exe+2924164")
    Playername4 = get.Memory("GTA5.exe+292F16C")
    Playername5 = get.Memory("GTA5.exe+292F2FC")
    Playername6 = get.Memory("GTA5.exe+2BDF504")
    Playername7 = get.Memory("GTA5.exe+2BE24DF")
    Playername8 = get.Memory("GTA5.exe+2BE58AF")
    Playername9 = get.Memory("GTA5.exe+2BE5B44")
    PublicPlayerID = get.Memory("[GlobalPTR+0x30]+24788+PLAYER_ID()*1B98")
    PrivatePlayerID = get.Memory("[GlobalPTR+0x30]+00*1B98+24788")
    CurrentPlayerID = get.Memory("[GlobalPTR+0x48]+9E2A8")
    Lightning = get.Memory("GTA5.exe+2BA5B48")
    MatiLampu = get.Memory("GTA5.exe+2256FF8")
end

ptr_string()
-- VSpawn.CEListView1.Items[0].Checked = true
if STAT_BOOL == nil then
    local bool_backup1 = get.Memory("[[[GTA5.exe+02DA43D8]+60]+220]+218")
    STAT_BOOL = bool_backup1
elseif STAT_BOOL == nil then
    local bool_backup2 = get.Memory("[[[GTA5.exe+02DA43E8]+498]+220]+218")
    STAT_BOOL = bool_backup2
elseif STAT_BOOL == nil then
    local bool_backup3 = get.Memory("[[[[[[GTA5.exe+02603D20]+1B8]+8]+158]+F0]+180]+218")
    STAT_BOOL = bool_backup3
end

SecondaryLocation = {SecondaryLoot(1), SecondaryLoot(2), SecondaryLoot(3), SecondaryLoot(4), SecondaryLoot(5),
                     SecondaryLoot(6), SecondaryLoot(7), SecondaryLoot(8), SecondaryLoot(9), SecondaryLoot(10),
                     SecondaryLoot(11), SecondaryLoot(12), SecondaryLoot(13), SecondaryLoot(14), SecondaryLoot(15),
                     SecondaryLoot(16), SecondaryLoot(17), SecondaryLoot(18), SecondaryLoot(19), SecondaryLoot(20),
                     SecondaryLoot(21), SecondaryLoot(22), SecondaryLoot(23), SecondaryLoot(24), SecondaryLoot(25)}

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
