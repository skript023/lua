require("sig_array")
require("pointers")
require("joaat")
require("prop_array")
require("ptr_string")
require("mobil")
require("STATS")
require("CPH")
require("instant_heist_array")
require("f_string")

WEAPON = {}
function SetList(Name, boolean)
    getAddressList().getMemoryRecordByDescription(Name).Active = boolean
end

function SetListV(Name, value)
    getAddressList().getMemoryRecordByDescription(Name).Value = value
end

function AddressEditor(Name, Addressing)
    getAddressList().getMemoryRecordByDescription(Name).Address = Addressing
end

function ChangeType(Name, Types)
    getAddressList().getMemoryRecordByDescription(Name).Type = Types
end

ReadMem = function(Name)
    return AddressList.getMemoryRecordByDescription(Name).Value
end

GetMem = function(Name)
    return ReadMem(Name)
end

function ReadAct(Name)
    return AddressList.getMemoryRecordByDescription(Name).Active
end

function AddressReading(Name)
    return AddressList.getMemoryRecordByDescription(Name).Address
end

function CheckTypes(Name)
    return AddressList.getMemoryRecordByDescription(Name).Type
end

----------------------------Function------------------------------------------------------------------
function teleport_to_waypoint()
    local a = get.Memory("BlipPTR")
    for i = 2000, 1, -1 do
        local n = get.Ptr(a + (i * 8))
        if (n > 0) and (8 == get.Int(n + 0x40)) and (84 == get.Int(n + 0x48)) then
            local x = get.Float(n + 0x10)
            local y = get.Float(n + 0x14)
            local p = CPlayer
            if PED.IS_PED_IN_ANY_VEHICLE() then
                p = get.Ptr(p + VEH)
            end
            local v = get.Ptr(p + POS)
            set.float(v + CORDX, x)
            set.float(v + CORDY, y)
            set.float(v + CORDZ, -210)
            set.float(p + VECX, x)
            set.float(p + VECY, y)
            set.float(p + VECZ, -210)
        end
    end
end

function teleport_to_objective()
    local a = get.Memory("BlipPTR")
    for i = 2000, 1, -1 do
        local n = get.Ptr(a + (i * 8))
        if (n > 0) and (1 == get.Int(n + 0x40)) and
            ((5 == get.Int(n + 0x48)) or (60 == get.Int(n + 0x48)) or (66 == get.Int(n + 0x48))) then
            local x = get.Float(n + 0x10)
            local y = get.Float(n + 0x14)
            local z = get.Float(n + 0x18)
            local p = CPlayer
            if PED.IS_PED_IN_ANY_VEHICLE() then
                p = get.Ptr(p + VEH)
            end
            local v = get.Ptr(p + POS)
            set.float(v + CORDX, x)
            set.float(v + CORDY, y)
            set.float(v + CORDZ, z)
            set.float(p + VECX, x)
            set.float(p + VECY, y)
            set.float(p + VECZ, z)
        end
    end
end

function teleport_to_player(coord_x, coord_y, coord_z)
    local x = get.Float(coord_x)
    local y = get.Float(coord_y)
    local z = get.Float(coord_z)
    local p = get.Ptr(get.Ptr(get.Memory("WorldPTR")) + 0x8)
    if PED.IS_PED_IN_ANY_VEHICLE() then
        p = get.Ptr(p + 0xD30)
    end
    local v = get.Ptr(p + 0x30)
    set.float(v + 0x50, x)
    set.float(v + 0x54, y)
    set.float(v + 0x58, z)
    set.float(p + 0x90, x)
    set.float(p + 0x94, y)
    set.float(p + 0x98, z)
end

function neon_color(R, G, B)
    local Is_In_Vehicle = PED.IS_PED_IN_ANY_VEHICLE()
    if Is_In_Vehicle == true then
        set.byte(CUpgrade + 0x3A2, R)
        set.byte(CUpgrade + 0x3A0, B)
        set.byte(CUpgrade + 0x3A1, G)
    end
end

function tire_color(R, G, B)
    set.byte("[[[[WorldPTR]+8]+VEH]+48]+3FC", R)
    set.byte("[[[[WorldPTR]+8]+VEH]+48]+3FD", B)
    set.byte("[[[[WorldPTR]+8]+VEH]+48]+3FE", G)
end

function p_color(R, G, B, Type)
    set.byte("[[[[[WorldPTR]+8]+VEH]+48]+20]+A4", R)
    set.byte("[[[[[WorldPTR]+8]+VEH]+48]+20]+A5", B)
    set.byte("[[[[[WorldPTR]+8]+VEH]+48]+20]+A6", G)
    set.byte("[[[[WorldPTR]+8]+VEH]+48]+3F6", Type)
end

function s_color(R, G, B, Type)
    set.byte("[[[[[WorldPTR]+8]+VEH]+48]+20]+A8", R)
    set.byte("[[[[[WorldPTR]+8]+VEH]+48]+20]+A9", B)
    set.byte("[[[[[WorldPTR]+8]+VEH]+48]+20]+AA", G)
    set.byte("[[[[WorldPTR]+8]+VEH]+48]+3F7", Type)
end
------------------------Function List------------------------------------------------
--[[function GAMEPLAY.SET_SUPER_JUMP_THIS_FRAME(Player)
    if Player then set.int(CPlayerInfo + 0x1F8,16384) end
end

function GAMEPLAY.SET_EXPLOSIVE_MELEE_THIS_FRAME(Player)
    if Player then set.int(CPlayerInfo + 0x1F8,8192) end
end

function GAMEPLAY.SET_FIRE_AMMO_THIS_FRAME(Player)
    if Player then set.int(CPlayerInfo + 0x1F8,4096) end
end

function GAMEPLAY.SET_EXPLOSIVE_AMMO_THIS_FRAME(Player)
    if Player then set.int(CPlayerInfo + 0x1F8,2048) end
end
]]

function frameFlagsOnTick(t)
    local SetFrame = 0
    if g_superJump then
        SetFrame = 1 << 14
    end
    if g_flamingFists then
        SetFrame = 1 << 13
    end
    if g_flamingAmmo then
        SetFrame = 1 << 12
    end
    if g_explosiveAmmo then
        SetFrame = 1 << 11
    end
    set.int(CPlayerInfo + 0x218, SetFrame) -- 0x1F8
end
if g_frameTimer == nil then
    g_frameTimer = createTimer(nil, false)
    g_frameTimer.Interval = 1
    g_frameTimer.setOnTimer(frameFlagsOnTick)
end
--------------------------------------------------------------

-- WEAPON.SET_PED_INFINITE_AMMO(Ped ped,Bool toogle,Hash weaponHash)
WEAPON.SET_PED_INFINITE_AMMO = function(activation)
    local f_based = get.Ptr(get.Memory(CInventory + 0x48))
    local TransitionStatus = SCRIPT.DOES_SCRIPT_EXIST('fm_maintain_transition_players')
    local inventory = get.Short(CInventory + 0x50)
    local solut = inventory - 1;
    for i = 0, solut, 1 do
        local inf_ammo = get.Ptr(f_based + 0x8 * i)
        if not inf_ammo or (inventory == 0) or (TransitionStatus == true) then
            break
        end
        -- printf("Address : 0x%X",get.Memory(inf_ammo + 0x24))
        set.bool(inf_ammo + 0x24, activation)
    end
end
-- WEAPON.ADD_AMMO_TO_PED(Ped ped,Bool toogle,Hash weaponHash)
WEAPON.ADD_AMMO_TO_PED = function(amount)
    local g_based = get.Ptr(getAddress(CInventory + 0x48))
    local inventory = get.Short(CInventory + 0x50)
    for i = inventory, 0, -1 do
        local inf_ammo = get.Ptr(g_based + 0x8 * i)
        if not inf_ammo then
            return false
        end
        if inventory == 0 then
            break
        end
        set.int(inf_ammo + 0x20, amount)
    end
end
-- WEAPON.GET_CURRENT_PED_WEAPON(Ped ped,Hash weaponHash,Bool p2)
function WEAPON.GET_CURRENT_PED_WEAPON(ped, weaponHash, p2)
    return get.Int(CAmmoType + 0x10)
end

function InfiniteAmmoLoop(Bool)
    InfinitAmmoRun = Bool
    local NewAsync = Asynchronous(function()
        while (InfinitAmmoRun) do
            Async();
            WEAPON.SET_PED_INFINITE_AMMO(TRUE)
            if not InfinitAmmoRun then
                WEAPON.SET_PED_INFINITE_AMMO(FALSE)
                break
            end
        end
    end)
    AsyncStart(NewAsync, 2000)
end

function RIDSpoofer()
    local RID = get.Long(RID_LIST[selected_player])
    local sc_asli = get.Long(RID_ASLI)
    local SessionState = get.Int(JOIN_STATUS)
    switch(SessionState, {
        [0] = function()
            set.long(CPlayerInfo + 0x90, sc_asli)
        end,
        [10] = function()
            set.long(CPlayerInfo + 0x90, sc_asli)
        end,
        [4] = function()
            local Transition = SCRIPT.HAS_SCRIPT_LOADED('fm_maintain_transition_players');
            local freemode = SCRIPT.HAS_SCRIPT_LOADED('freemode')
            if Transition == true or freemode == false then
                set.long(CPlayerInfo + 0x90, sc_asli)
            else
                set.long(CPlayerInfo + 0x90, RID)
            end
        end
    })
end

function ReturnRID()
    local scid_asli = get.Long(RID_ASLI)
    set.long(CPlayerInfo + 0x90, scid_asli)
    return scid_asli
end

---------------------------------------------------Business---------------------------------------------
function bunker_deliver(hasil)
    local new_thread = function()
        local duit = get.Int(get.Ptr("GTA5.exe+0260E010") + 0x128)
        local kargo = get.Int("[[GlobalPTR-128]+1180]+37C0")
        local data = hasil * kargo / duit
        set.int("[[GlobalPTR-128]+1180]+3F68", data)
        set.global(float, 262145 + 21045, 1)
        if get.Int("[[GlobalPTR-128]+1180]+3F68") > 0 and get.Global(float, 262145 + 21045) ~= 1.5 then
            set.global(int, 262145 + 21228, 1)
            set.global(int, 262145 + 21232, 1)
            set.global(int, 262145 + 21222, 1)
            set.global(int, 262145 + 21230, 1)
            set.global(int, 262145 + 21235, 1)
            set.global(int, 262145 + 21224, 1)
            SYSTEM.WAIT(500)
            set.global(float, 262145 + 21045, 1.5)
            set.global(int, 262145 + 21228, 1800000)
            set.global(int, 262145 + 21232, 900000)
            set.global(int, 262145 + 21222, 900000)
            set.global(int, 262145 + 21230, 900000)
            set.global(int, 262145 + 21235, 900000)
            set.global(int, 262145 + 21224, 900000)
        end
        LuaEngineLog(string.format("You Received $%i | Total Sent %i| 0x%X | 0x%X | 0x%X", hasil, total,
                         get.Memory("GTA5.exe+0260E010"), get.Memory("[[GlobalPTR-128]+1180]+37C0"),
                         get.Memory("[[GlobalPTR-128]+1180]+3F68")))
    end
    ExecuteThread(new_thread)
end

function SpecialCargo(amount)
    local new_thread = function()
        local REQ = get.Int(REQ_DEL_CARGO)
        set.global(int, 262145 + 15337, amount)
        set.int(TIMER_CARGO, 180000)
        if (REQ == 1) then
            set.int(DEL_CARGO, 1)
        elseif (REQ == 1) and get.Int(DEL_CARGO) == 1 then
            set.int(DEL_CARGO, 0)
            SYSTEM.WAIT(100)
            set.int(DEL_CARGO, 1)
        elseif (REQ == 3) then
            set.int(DEL_CARGO, 3)
        elseif (REQ == 3) and get.Int(DEL_CARGO) == 3 then
            set.int(DEL_CARGO, 0)
            SYSTEM.WAIT(100)
            set.int(DEL_CARGO, 1)
        elseif (REQ == 10) then
            set.int(DEL_CARGO, 10)
        elseif (REQ == 10) and get.Int(DEL_CARGO) == 10 then
            set.int(DEL_CARGO, 0)
            SYSTEM.WAIT(100)
            set.int(DEL_CARGO, 1)
        elseif (REQ == 15) then
            set.int(DEL_CARGO, 15)
        elseif (REQ == 15) and get.Int(DEL_CARGO) == 15 then
            set.int(DEL_CARGO, 0)
            SYSTEM.WAIT(100)
            set.int(DEL_CARGO, 1)
        else
            set.int(DEL_CARGO, 1)
        end
        SYSTEM.WAIT(500)
        set.global(int, 262145 + 15337, 10000)
        set.int(TIMER_CARGO, 1800000)
        LuaEngineLog(string.format("You Received $%i | Total %i | Memory 0x%X", amount, REQ, get.Memory(REQ_DEL_CARGO)))
    end
    ExecuteThread(new_thread)
end

function hangar(amount)
    local new_thread = function()
        local REQ = get.Int(REQ_DEL_CARGO)
        local cr = get.Global(int, 1409117 + 3445 + 6483)
        local ctr = get.Int(REQ_DEL_CARGO)
        local total = amount * ctr / 10000
        set.int(DEL_HANGAR, total)
        set.global(int, 262145 + 22300, 0)
        set.global(int, 262145 + 22337, 0)
        set.global(int, 262145 + 22339, 0)
        set.global(int, 262145 + 22341, 0)
        set.global(int, 262145 + 22343, 0)
        set.global(int, 262145 + 22345, 0)
        set.global(int, 262145 + 22347, 0)
        set.global(int, 262145 + 22349, 0)
        set.global(int, 262145 + 22351, 0)
        SYSTEM.WAIT(500)
        set.global(int, 262145 + 22300, 1800000)
        set.global(int, 262145 + 22337, 1800000)
        set.global(int, 262145 + 22339, 1800000)
        set.global(int, 262145 + 22341, 1800000)
        set.global(int, 262145 + 22343, 1800000)
        set.global(int, 262145 + 22345, 1800000)
        set.global(int, 262145 + 22347, 1800000)
        set.global(int, 262145 + 22349, 1800000)
        set.global(int, 262145 + 22351, 1800000)
        LuaEngineLog(string.format("You Received $%i | Total %i | Memory 0x%X", amount, REQ, get.Memory(REQ_DEL_CARGO)))
    end
    ExecuteThread(new_thread)
end

function bkr(amount)
    local new_thread = function()
        local REQ = get.Int(REQ_DEL_CARGO)
        set.global(int, 262145 + 16964, amount)
        set.global(int, 262145 + 16965, amount)
        set.global(int, 262145 + 16966, amount)
        set.global(int, 262145 + 16967, amount)
        set.global(int, 262145 + 16968, amount)
        set.global(float, 262145 + 18603, 1)
        set.int(DEL_CASH, REQ)
        set.int(DEL_COKE, REQ)
        set.int(DEL_DOC, REQ)
        set.int(DEL_WEED, REQ)
        set.int(DEL_FLY, REQ)
        SYSTEM.WAIT(500)
        set.global(int, 262145 + 16956, 1000)
        set.global(int, 262145 + 16957, 3500)
        set.global(int, 262145 + 16958, 20000)
        set.global(int, 262145 + 16959, 8500)
        set.global(int, 262145 + 16960, 1500)
        set.global(float, 262145 + 18603, 1.5)
        LuaEngineLog(string.format("You Received $%i | Total %i | Memory 0x%X", amount, REQ, get.Memory(REQ_DEL_CARGO)))
    end
    ExecuteThread(new_thread)
end

function RID_SPOOF(Backup)
    set.long(RID, Backup)
end

function LoadSession(id)
    if id == -1 then
        set.global(int, 1312443 + 2, -1)
        set.global(int, 1312443, 1)
        Sleep(200)
        set.global(int, 1312443, 0)
    else
        set.global(int, 1312854, id)
        set.global(int, 1312443, 1)
        Sleep(200)
        set.global(int, 1312443, 0)
    end
end

function GetCurrentSession()
    return get.Int(CURRENT_SESSION)
end

function PLAYER.GET_PLAYER_INDEX()
    local addr = get.Memory("PlayerCountPTR")
    local pCNetworkPlayerMgr = get.Ptr(addr)
    if not pCNetworkPlayerMgr then
        return
    end
    PLAYER_INDEX_ID = {}
    for i = 0, 32, 1 do
        local pCNetGamePlayer = get.Ptr(pCNetworkPlayerMgr + 0x180 + (i * 8))
        if not pCNetGamePlayer then
            goto continue
        end
        local Host = getAddress(GA(1630317 + 1 + (i * 595) + 10))
        local pCPlayerInfo = get.Ptr(pCNetGamePlayer + 0xA0)
        if not pCPlayerInfo then
            goto continue
        end
        local pCPed = get.Ptr(pCPlayerInfo + 0x01C8)
        if not pCPed then
            goto continue
        end
        local nameBuffer = getAddress(pCPlayerInfo + 0xA4)
        table.insert(PLAYER_INDEX_ID, {i, nameBuffer, pCPed})
        ::continue::
    end
end

function PLAYER.GET_PLAYER_INDEX_INFO()
    local addr = getAddress("PlayerCountPTR")
    local pCNetworkPlayerMgr = get.Ptr(addr)
    if not pCNetworkPlayerMgr then
        return
    end
    PLAYER_INDEX_INFO = {}
    Player_IP = {}
    Player_Lan = {}
    GlobalInfo = {}
    GlobalString = {}

    for i = 0, 31, 1 do
        local pCNetGamePlayer = get.Ptr(pCNetworkPlayerMgr + 0x180 + (i * 8))
        if not pCNetGamePlayer then
            goto continue
        end
        local totalMoney = getAddress(GA(1590682 + 1 + (i * 883 + 211) + 56))
        local money = getAddress(GA(1590682 + 1 + (i * 883 + 211) + 3))
        local level = getAddress(GA(1590682 + 1 + (i * 883) + 211 + 6))
        local Host = getAddress(GA(1630317 + 1 + (i * 595) + 10))
        local ListOrgName = getAddress(GA(1630317 + 1 + (i * 595) + 11 + 104))
        local CurEXP = getAddress(GA(1590682 + 1 + i * 883 + 211 + 1))
        local GlobalEXP = getAddress(GA(1590682 + 1 + i * 883 + 211 + 5))
        local OffRadar = getAddress(GA(2425869 + 1 + i * 443 + 204))
        local RevealRadar = getAddress(GA(2425869 + 1 + i * 443 + 207))

        local pCPlayerInfo = get.Ptr(pCNetGamePlayer + 0xB0)
        if not pCPlayerInfo then
            goto continue
        end

        local pCPed = get.Ptr(pCPlayerInfo + 0x01C8)
        if not pCPed then
            goto continue
        end

        local Lan1 = getAddress(pCPlayerInfo + 0x44)
        local Lan2 = getAddress(pCPlayerInfo + 0x45)
        local Lan3 = getAddress(pCPlayerInfo + 0x46)
        local Lan4 = getAddress(pCPlayerInfo + 0x47)
        local LanP = getAddress(pCPlayerInfo + 0x48)

        local IP1 = getAddress(pCPlayerInfo + 0x34)
        local IP2 = getAddress(pCPlayerInfo + 0x35)
        local IP3 = getAddress(pCPlayerInfo + 0x36)
        local IP4 = getAddress(pCPlayerInfo + 0x37)
        local IPP = getAddress(pCPlayerInfo + 0x38)

        local PedInfo = get.Ptr(pCPed + 0x10C8)
        if not PedInfo then
            goto continue
        end
        local Ragdoll = getAddress(pCPed + 0x10B8)
        local Godmode = getAddress(pCPed + 0x189)
        local WantedLevel = getAddress(PedInfo + 0x868)
        local SCID = getAddress(pCPlayerInfo + 0x70)
        local HP = getAddress(pCPed + 0x280)
        local MAX_HP = getAddress(pCPed + 0x2A0)
        local Armor = getAddress(pCPed + 0x14E0)
        table.insert(Player_Lan, {Lan1, Lan2, Lan3, Lan4, LanP})
        table.insert(Player_IP, {IP1, IP2, IP3, IP4, IPP})
        table.insert(GlobalInfo, {CurEXP, GlobalEXP, level, money, totalMoney, ListOrgName})
        table.insert(GlobalString, {OffRadar, RevealRadar})
        table.insert(PLAYER_INDEX_INFO, {SCID, Godmode, Ragdoll, WantedLevel, MAX_HP, HP, Armor})
        ::continue::
    end
end

function GetPlayerIndexCoord(pCPed)
    local addr = getAddress("PlayerCountPTR")
    local pCNetworkPlayerMgr = get.Ptr(addr)
    if not pCNetworkPlayerMgr then
        return
    end
    PLAYER_INDEX_NAV = {}
    for i = 0, 32, 1 do
        local pCNetGamePlayer = get.Ptr(pCNetworkPlayerMgr + 0x180 + (i * 8))
        if not pCNetGamePlayer then
            goto continue
        end
        local pCPlayerInfo = get.Ptr(pCNetGamePlayer + 0xB0)
        if not pCPlayerInfo then
            goto continue
        end
        local pCPed = get.Ptr(pCPlayerInfo + 0x01C8)
        if not pCPed then
            goto continue
        end
        local Nav = get.Ptr(pCPed + 0x30)
        local headx = getAddress(Nav + 20)
        local heady = getAddress(Nav + 24)
        local x = getAddress(Nav + 0x50)
        local y = getAddress(Nav + 0x54)
        local z = getAddress(Nav + 0x58)
        -- local newBuffer = nameBuffer .. ' ' .. tostring(healthBuffer)
        table.insert(PLAYER_INDEX_NAV, {x, y, z, headx, heady})
    end
    ::continue::
end

function TCOMP(T, C, ...)
    for K, V in pairs(C) do
        T[K] = V
    end
    if select('#', ...) > 0 then
        return TCOMP(T, ...)
    else
        return T
    end
end

function FindVehicleName(Hash)
    if not Hash or Hash == 0 then
        return false
    end
    for k, v in pairs(tbl_Vehicles) do
        if tonumber(Hash) == tonumber(joaat(v[1])) then
            return v[1]
        end
    end
    return false
end
function GetVehicleSlots()
    tbl_GSV = {}
    local max_slots = get.Global(int, 1323678)
    for i = 0, max_slots, 1 do
        local hash = get.Global(int, 1323678 + 1 + (i * 141) + 66)
        local name = FindVehicleName(hash)
        if name then
            table.insert(tbl_GSV, {i, name, hash, get.Global(str, 1323678 + 1 + (i * 141) + 1)})
        end
    end
end
function OpenForm_MiniGarageMod()

    local UDF1 = createForm(true)
    TCOMP(UDF1, {
        Caption = 'Personal Car Request',
        Width = 263,
        Height = 90,
        Position = 'poScreenCenter',
        BorderStyle = 'bsToolWindow',
        Align = 'alNone',
        Visible = true,
        Color = 0x000000
    })

    local CEComboBox1 = createComboBox(UDF1)
    TCOMP(CEComboBox1, {
        Left = 10,
        Top = 15,
        Width = 180,
        Height = 23,
        DropDownCount = 20,
        Align = 'alNone',
        Enabled = true,
        Visible = true,
        Anchors = '[akTop,akLeft]',
        BidiMode = 'bdLeftToRight',
        CharCase = 'ecNormal',
        Color = 536870912
    })
    CEComboBox1.Items.clear()
    CEComboBox1.items.add(0, "Garage Vehicle List")
    CEComboBox1.OnDropDown = function()
        CEComboBox1.Items.clear()
        CEComboBox1.items.add(0, "Garage Vehicle List")
        GetVehicleSlots()
        for k, v in pairs(tbl_GSV) do
            CEComboBox1.items.add(string.format('[%i] %s (%s)', v[1], v[2], v[4]))
        end
        CEComboBox1.ItemIndex = 0
    end

    local CEButton1 = createButton(UDF1)
    TCOMP(CEButton1, {
        Caption = 'Request',
        Left = 200,
        Top = 14,
        Width = 55,
        Height = 25,
        Enabled = true,
        Visible = true,
        Anchors = '[akTop,akLeft]',
        BidiMode = 'bdLeftToRight'
    })
    CEButton1.OnClick = function()
        local id = CEComboBox1.ItemIndex
        if id == -1 or id == 0 then
            return
        end
        set.global(int, 2540612 + 962, tbl_GSV[id][1])
        set.global(int, 2540612 + 959, 1)
        Sleep(700)
        set.global(int, 2409291 + 8, 1)
    end

    local CEComboBox2 = createComboBox(UDF1)
    TCOMP(CEComboBox2, {
        Left = 10,
        Top = 50,
        Width = 140,
        Height = 23,
        DropDownCount = 20,
        Align = 'alNone',
        Enabled = true,
        Visible = true,
        Anchors = '[akTop,akLeft]',
        BidiMode = 'bdLeftToRight',
        CharCase = 'ecNormal',
        Color = 536870912
    })
    CEComboBox2.items.add("Code Vehicle List")
    for k, v in pairs(tbl_Vehicles) do
        CEComboBox2.items.add(v[1])
    end
    CEComboBox2.ItemIndex = 0

    local CEButton2 = createButton(UDF1)
    TCOMP(CEButton2, {
        Caption = 'Change',
        Left = 200,
        Top = 51,
        Width = 55,
        Height = 25,
        Enabled = true,
        Visible = true,
        Anchors = '[akTop,akLeft]',
        BidiMode = 'bdLeftToRight'
    })
    CEButton2.OnClick = function()
        local id, id2 = CEComboBox1.ItemIndex, CEComboBox2.ItemIndex
        if id == -1 or id == 0 or id2 == -1 or id2 == 0 then
            return
        end
        set.global(int, 1323678 + 1 + (tbl_GSV[id][1] * 141) + 66, joaat(tbl_Vehicles[id2][1]))
    end
    UDF1.OnClose = function()
        UDF1.destroy()
    end
    UDF1.Show()
end

if tbl_ScriptEvents == nil then
    tbl_ScriptEvents = {};
    chk_firstload = true;
end

function f_GetScriptEvents()
    local event_addr = getAddress("ScriptEventPTR") + 16;
    local ic, _dis1, _dis2, _is1, _is2 = 1, '', '', 0, 0
    local function lf_Title(first, rest)
        return first:upper() .. rest:lower()
    end
    for i = -1, 100 do
        _dis1 = disassemble(event_addr + (i * 31))
        _dis2 = disassemble((event_addr + 7) + (i * 31))
        _is1 = string.find(_dis1, "lea r9,")
        _is2 = string.find(_dis2, "lea r8,")
        if _is1 ~= nil and _is2 ~= nil then
            local _status, l1, l2 = false, 0, 0
            local _address, _bytes, _opcode, _extra = '', '', '', ''
            _address, _bytes, _opcode, _extra = splitDisassembledString(_dis1)
            local _EventString = string.gsub(_address, "(%a)([%w']*)", lf_Title)
            if _address == nil then
                return
            end
            _EventString = string.gsub(_EventString, "_", " ")
            _EventString = string.sub(_EventString, 3, string.len(_EventString) - 2)
            _EventString = string.gsub(_EventString, " Event", "")
            _address, _bytes, _opcode, _extra = splitDisassembledString(_dis2)
            l1 = string.find(_bytes, "lea r8,")
            l2 = string.len(_bytes)
            local _EventAddress = string.sub(_bytes, l1 + 8, l2 - 1)
            if _EventAddress == nil then
                return
            end
            if get.Byte(_EventAddress) == 0x48 then
                _status = false
            elseif get.Byte(_EventAddress) == 0xC3 then
                _status = true
            else
                return
            end
            tbl_ScriptEvents[ic] = {_EventAddress, _EventString, _status}
            ic = ic + 1
        end
    end
end

function f_PrintScriptEvent(ID)
    if ID == nil then
        return
    end
    if string.lower(tostring(ID)) == 'all' then
        for i = 1, 81 do
            local tbl_SE, s = {}, ''
            tbl_SE = tbl_ScriptEvents[i]
            if tbl_SE ~= nil then
                local ev_addr = tbl_SE[1]
                if get.Byte(ev_addr) == 0x48 then
                    s = 'false'
                elseif get.Byte(ev_addr) == 0xC3 then
                    s = 'true'
                else
                    goto continue
                end
                PlayerData_CEListBox1.Items.clear()
                for k, v in pairs(tbl_ScriptEvents) do
                    PlayerData_CEListBox1.items.add(string.format('Event: %s | Protected: %s | Address: 0x%s', v[2], s,
                                                        v[1]))
                end
            end
            ::continue::
        end
    else
        local tbl_SE, s = {}, ''
        tbl_SE = tbl_ScriptEvents[ID]
        if tbl_SE ~= nil then
            local ev_addr = tbl_SE[1]
            if get.Byte(ev_addr) == 0x48 then
                s = 'false'
            elseif get.Byte(ev_addr) == 0xC3 then
                s = 'true'
            else
                goto continue
            end
            print(string.format('[%i]Event: %s\nProtected: %s\nAddress: 0x%s\n', ID, tbl_SE[2], s, tbl_SE[1]))
        end
        ::continue::
    end
end
--[[//f_PrintScriptEvent(7) or f_PrintScriptEvent('all')]]

function v_ProtectEvent(ID)
    if tbl_ScriptEvents == nil then
        return
    end
    if chk_firstload == true then
        chk_firstload = false;
        f_GetScriptEvents();
        Sleep(100);
    end
    local tbl_SE = tbl_ScriptEvents[ID]
    if tbl_SE == nil then
        return
    end
    if get.Byte(tbl_SE[1]) == 0x48 then
        set.byte(tbl_SE[1], 0xC3)
        tbl_ScriptEvents[ID][3] = true;
        Protection_EventIndicator.Text = string.format(
                                             'Activate Protection for :[%i]Event: %s | Protected: %s | Address: 0x%s',
                                             ID, tbl_SE[2], 'true', tbl_SE[1])
    elseif get.Byte(tbl_SE[1]) == 0xC3 then
        set.byte(tbl_SE[1], 0x48)
        tbl_ScriptEvents[ID][3] = false;
        Protection_EventIndicator.Text = string.format(
                                             'Deactivate Protection for :[%i]Event: %s | Protected: %s | Address: 0x%s',
                                             ID, tbl_SE[2], 'false', tbl_SE[1])
    else
        print(string.format('ERROR: Wrong Input..'))
    end
end
if SETimer == nil then
    SETimer = createTimer(nil, false)
    SETimer.Interval = 1
    SETimer.setOnTimer(v_ProtectEvent)
    SETimer.setOnTimer(Player_CheckListBox1ClickCheck)
end

function DisableEvent(ID, Executor)
    local Trigger = Executor
    if tbl_ScriptEvents == nil then
        return
    end
    local tbl_SE = tbl_ScriptEvents[ID]
    if tbl_SE == nil then
        return
    end
    if Trigger == true then
        set.byte(tbl_SE[1], 0xC3)
        tbl_ScriptEvents[ID][3] = true;
        MiscTab.EventStatus.Text = string.format('[%i]Event: %s | Status: %s | Address: 0x%s', ID, tbl_SE[2], 'true',
                                       tbl_SE[1])
        LuaEngineLog(string.format('[%i] Event: %s\nProtected: %s\nAddress: 0x%s\n', ID, tbl_SE[2], 'true', tbl_SE[1]))
    elseif Trigger == false then
        set.byte(tbl_SE[1], 0x48)
        tbl_ScriptEvents[ID][3] = false;
        MiscTab.EventStatus.Text = string.format('[%i]Event: %s | Status: %s | Address: 0x%s', ID, tbl_SE[2], 'false',
                                       tbl_SE[1])
        LuaEngineLog(string.format('[%i] Event: %s\nProtected: %s\nAddress: 0x%s\n', ID, tbl_SE[2], 'false', tbl_SE[1]))
    else
        LuaEngineLog(string.format('ERROR: Wrong Input..'))
    end
end

function EventLoader()
    if chk_firstload == true then
        chk_firstload = false;
        f_GetScriptEvents();
        Sleep(100);
        return false
    end
    return true
end

function _Str(Address, String, Size)
    local bt = stringToByteTable(String)
    if #bt > Size then
        LuaEngineLog("too many characters")
        return
    elseif #bt == Size then
        goto continue
    end
    for i = 1, Size - (#bt), 1 do
        bt[#bt + i] = 0x00
    end
    ::continue::
    set.byte(Address, bt)
end

function ChangePlayerName(String)
    set.char(Playername1, String, 16)
    set.char(Playername2, String, 16)
    set.char(Playername3, String, 16)
    set.char(Playername4, String, 16)
    set.char(Playername6, String, 16)
    set.char(Playername7, String, 16)
    set.char(Playername8, String, 16)
    set.char(Playername9, String, 16)
    set.char(CPlayerInfo + 0xA4, String, 16)
end

-- Bisnis
--[[
    1590535+1+(PLAYER_ID()*876)+274+183+1+(ID*12)
    ID 0-5
    0-4 ~ Meth,Weed,Cocaine,Cash,Documents
    5 = Bunker(Research)
 
    Offsets
    0 = Location
    1 = ProductCount
    2 = SupplyCount
    3 = _lastSupplyCount
    4 = unk_4
    5 = unk_5
    6 = unk_6
    7 = unk_7
    8 = ProductionProgress
    9 = ProductionFlags
    10 = unk_10
    11 = unk_11
    12 = ResearchProgress
    13 = ResearchFlags
]]
tbl_Business = { --[[Meth,Weed,Cocaine,Cash,Documents]] }
tbl_BusinessLocations = {{{1, "Paleto Bay"}, {6, "El Burro Heights"}, {11, "Grand Senora Desert"}, {16, "Terminal"}},
                         {{2, "Mount Chiliad"}, {7, "Downtown Vinewood"}, {12, "San Chianski"}, {17, "Elysian Island"}},
                         {{3, "Paleto Bay"}, {8, "Morningwood"}, {13, "Alamo Sea"}, {18, "Elysian Island"}},
                         {{4, "Paleto Bay"}, {9, "Vespucci Canals"}, {14, "Grand Senora Desert"}, {19, "Cypress Flats"}},
                         {{5, "Paleto Bay"}, {10, "Textile City"}, {15, "Grapeseed"}, {20, "Elysian Island"}}}
function RemoveBunkerSupplyDelay() -- default 600
    set.global(int, 262145 + 21090, 0)
end

function RemoveMCSupplyDelay() -- default 600
    set.global(int, 262145 + 18490, 0)
end

function GetBusinessIndex(ID) -- ID 0-5
    return 1590682 + 1 + (PLAYER_ID() * 883) + 274 + 183 + 1 + (ID * 12)
end

function GetSupplies()
    for i = 0, 5, 1 do
        if get.Global(int, GetBusinessIndex(i) + 2) < 100 then
            set.global(int, 2515394, i)
        end
    end
end -- Memory.Set_Bit(GA(2515394),i)

CheckBusiness = true
function CheckBusinessID()
    for i = 0, 4, 1 do
        for k, v in pairs(tbl_BusinessLocations) do
            for k2, v2 in pairs(v) do
                if get.Global(int, GetBusinessIndex(i)) == v2[1] then
                    tbl_Business[k] = i
                    goto continue
                end
            end
        end
        ::continue::
    end
end
if CheckBusiness then
    CheckBusinessID()
    CheckBusiness = false
end
function TriggerMethProduction() -- 1080000 flags 6,7,9,11,12,13,14,20
    if tbl_Business[1] == nil then
        return
    end
    local supplycount, productcount = get.Global(int, GetBusinessIndex(tbl_Business[1]) + 2),
        get.Global(int, GetBusinessIndex(tbl_Business[1]) + 1)
    if productcount == 20 then
        ShowPopUpMessage('Trigger Meth Production Function: ', 'Storage full with 20 Products!', 4500)
        return
    end
    if supplycount > 0 then
        set.global(int, GetBusinessIndex(tbl_Business[1]) + 9, 0)
    else
        ShowPopUpMessage('Trigger Meth Production Function: ', 'Supplies are empty! Buy Supplies!', 4500)
    end
end
function TriggerWeedProduction() -- 240000 flags 7,8,11,13,15,16,17
    if tbl_Business[2] == nil then
        return
    end
    local supplycount, productcount = get.Global(int, GetBusinessIndex(tbl_Business[2]) + 2),
        get.Global(int, GetBusinessIndex(tbl_Business[2]) + 1)
    if productcount == 80 then
        ShowPopUpMessage('Trigger Weed Production Function: ', 'Storage full with 80 Products!', 4500)
        return
    end
    if supplycount > 0 then
        set.global(int, GetBusinessIndex(tbl_Business[2]) + 9, 0)
    else
        ShowPopUpMessage('Trigger Weed Production Function: ', 'Supplies are empty! Buy Supplies!', 4500)
    end
end
function TriggerCocaineProduction() -- 900000/1800000 flags 5,7,8,9,11,12,13,15,16,18,19/6,8,9,10,12,13,14,16,17,19,20
    if tbl_Business[3] == nil then
        return
    end
    local supplycount, productcount = get.Global(int, GetBusinessIndex(tbl_Business[3]) + 2),
        get.Global(int, GetBusinessIndex(tbl_Business[3]) + 1)
    if productcount == 10 then
        ShowPopUpMessage('Trigger Weed Production Function: ', 'Storage full with 10 Products!', 4500)
        return
    end
    if supplycount > 0 then
        set.global(int, GetBusinessIndex(tbl_Business[3]) + 9, 0)
    else
        ShowPopUpMessage('Trigger Cocaine Production Function: ', 'Supplies are empty! Buy Supplies!', 4500)
    end
end
function TriggerCashProduction() -- 480000 flags 8,9,12,14,16,17,18
    if tbl_Business[4] == nil then
        return
    end
    local supplycount, productcount = get.Global(int, GetBusinessIndex(tbl_Business[4]) + 2),
        get.Global(int, GetBusinessIndex(tbl_Business[4]) + 1)
    if productcount == 40 then
        ShowPopUpMessage('Trigger Cash Production Function: ', 'Storage full with 40 Products!', 4500)
        return
    end
    if supplycount > 0 then
        set.global(int, GetBusinessIndex(tbl_Business[4]) + 9, 0)
    else
        ShowPopUpMessage('Trigger Cash Production Function: ', 'Supplies are empty! Buy Supplies!', 4500)
    end
end
function TriggerDocumentsProduction() -- 180000 flags 5,8,9,10,11,12,13,15,17
    if tbl_Business[5] == nil then
        return
    end
    local supplycount, productcount = get.Global(int, GetBusinessIndex(tbl_Business[5]) + 2),
        get.Global(int, GetBusinessIndex(tbl_Business[5]) + 1)
    if productcount == 60 then
        ShowPopUpMessage('Trigger Documents Production Function: ', 'Storage full with 60 Products!', 4500)
        return
    end
    if supplycount > 0 then
        set.global(int, GetBusinessIndex(tbl_Business[5]) + 9, 0)
    else
        ShowPopUpMessage('Trigger Documents Production Function: ', 'Supplies are empty! Buy Supplies!', 4500)
    end
end
function TriggerBunkerProduction() -- 420000 flags 5,7,11,13,14,17,18
    local supplycount, progress = get.Global(int, GetBusinessIndex(5) + 2), get.Global(int, GetBusinessIndex(5) + 1)
    if progress == 100 then
        ShowPopUpMessage('Trigger Bunker Production Function: ', 'Full Stock!', 4500)
        return
    end
    if supplycount > 0 then
        set.global(int, GetBusinessIndex(5) + 9, 0)
    else
        ShowPopUpMessage('Trigger Bunker Production Function: ', 'Supplies are empty! Buy Supplies!', 4500)
    end
end
function TriggerBunkerResearch() -- 210000 flags 4,6,10,12,13,16,17
    local supplycount, progress = get.Global(int, GetBusinessIndex(5) + 2), get.Global(int, GetBusinessIndex(5) + 12)
    if progress == 60 then
        ShowPopUpMessage('Trigger Bunker Research Function: ', 'Research Progress Done!', 4500)
        return
    end
    if supplycount > 0 then
        set.global(int, GetBusinessIndex(5) + 13, 0)
    else
        ShowPopUpMessage('Trigger Bunker Research Function: ', 'Supplies are empty! Buy Supplies!', 4500)
    end
end

---
autoAssemble([[
aobScan(LabelTextAddress,59 6F 75 20 68 61 76 65 20 62 65 65 6E 20 61 77 61 72 64 65 64 20 74 68 65 20 66 6F 6C 6C 6F 77 69 6E 67 20 6C 69 76 65 72 69 65 73 20 66 6F 72 20 74 68 65 20 7E 61 7E 3A)
registerSymbol(LabelTextAddress)
]])
bt_org_CREATOR_RSC = {0x52, 0x6F, 0x63, 0x6B, 0x73, 0x74, 0x61, 0x72, 0x00, 0x74, 0x68, 0x65}
bt_org_PIM_TIGC22 = {0x7E, 0x61, 0x7E, 0x20, 0x7E, 0x73, 0x7E, 0x59, 0x6F, 0x75, 0x72, 0x20, 0x52, 0x50, 0x20, 0x68,
                     0x61, 0x73, 0x20, 0x62, 0x65, 0x65, 0x6E, 0x20, 0x73, 0x65, 0x74, 0x20, 0x74, 0x6F, 0x20, 0x7E,
                     0x31, 0x7E, 0x20, 0x52, 0x50, 0x20, 0x66, 0x6F, 0x72, 0x20, 0x43, 0x68, 0x61, 0x72, 0x61, 0x63,
                     0x74, 0x65, 0x72, 0x20, 0x69, 0x6E, 0x20, 0x73, 0x6C, 0x6F, 0x74, 0x20, 0x7E, 0x31, 0x7E, 0x2E,
                     0x00, 0x59, 0x6F, 0x75, 0x20, 0x61, 0x72, 0x65, 0x20, 0x61, 0x6C, 0x72, 0x65, 0x61, 0x64, 0x79,
                     0x20, 0x75, 0x73, 0x69, 0x6E, 0x67, 0x20, 0x61, 0x20, 0x53, 0x70, 0x65, 0x63, 0x69, 0x61, 0x6C,
                     0x2F, 0x50, 0x65, 0x72, 0x73, 0x6F, 0x6E, 0x61, 0x6C, 0x20, 0x56, 0x65, 0x68, 0x69, 0x63, 0x6C,
                     0x65, 0x20, 0x6F, 0x72, 0x20, 0x41, 0x6E, 0x74, 0x69, 0x2D, 0x41, 0x69, 0x72, 0x63, 0x72, 0x61,
                     0x66, 0x74, 0x20, 0x54, 0x72, 0x61, 0x69, 0x6C, 0x65, 0x72, 0x2E, 0x00, 0x43, 0x75, 0x73, 0x74,
                     0x6F, 0x6D, 0x20, 0x72, 0x65, 0x61, 0x72, 0x20, 0x62, 0x75, 0x6D, 0x70, 0x65, 0x72, 0x73, 0x2E,
                     0x00, 0x47}
bt_org_ATTK_ILLICIT = {0x44, 0x65, 0x73, 0x74, 0x72, 0x6F, 0x79, 0x20, 0x50, 0x72, 0x6F, 0x64, 0x75, 0x63, 0x74, 0x20,
                       0x7E, 0x48, 0x55, 0x44, 0x5F, 0x43, 0x4F, 0x4C, 0x4F, 0x55, 0x52, 0x5F, 0x52, 0x45, 0x44, 0x7E,
                       0x7E, 0x42, 0x4C, 0x49, 0x50, 0x5F, 0x50, 0x41, 0x43, 0x4B, 0x41, 0x47, 0x45, 0x7E, 0x7E, 0x73,
                       0x7E, 0x20, 0x62, 0x65, 0x6C, 0x6F, 0x6E, 0x67, 0x69, 0x6E, 0x67, 0x20, 0x74, 0x6F, 0x20, 0x4D,
                       0x6F, 0x74, 0x6F, 0x72, 0x63, 0x79, 0x63, 0x6C, 0x65, 0x20, 0x43, 0x6C, 0x75, 0x62, 0x73, 0x20,
                       0x74, 0x6F, 0x20, 0x65, 0x61, 0x72, 0x6E, 0x20, 0x63, 0x61, 0x73, 0x68, 0x20, 0x61, 0x6E, 0x64,
                       0x20, 0x52, 0x50, 0x2E, 0x00, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x20, 0x61, 0x20, 0x6A,
                       0x6F, 0x62, 0x20, 0x66, 0x72, 0x6F, 0x6D, 0x20, 0x4D, 0x73, 0x2E, 0x20, 0x42, 0x61, 0x6B, 0x65,
                       0x72, 0x2E, 0x00, 0x42, 0x75, 0x7A, 0x7A, 0x61, 0x72, 0x64, 0x00, 0x41, 0x52, 0x43, 0x41, 0x44,
                       0x45, 0x20, 0x55, 0x50, 0x47, 0x52, 0x41, 0x44, 0x45, 0x20, 0x50, 0x55, 0x52, 0x43, 0x48, 0x41,
                       0x53, 0x45, 0x00, 0x4D, 0x73, 0x2E, 0x20, 0x42, 0x61, 0x6B, 0x65, 0x72, 0x00, 0x50, 0x6C, 0x61,
                       0x79, 0x20, 0x52, 0x61, 0x6E, 0x64, 0x6F, 0x6D, 0x20, 0x4A, 0x6F, 0x62, 0x00, 0x40, 0x6D, 0x61,
                       0x79, 0x62, 0x65, 0x6E, 0x65, 0x76, 0x65, 0x72, 0x31, 0x30, 0x20, 0x57, 0x68, 0x79, 0x20, 0x77,
                       0x6F, 0x75, 0x6C, 0x64, 0x20, 0x61, 0x6E, 0x79, 0x6F, 0x6E, 0x65, 0x20, 0x77, 0x61, 0x6E, 0x74,
                       0x20, 0x74, 0x6F, 0x20, 0x73, 0x74, 0x65, 0x61, 0x6C, 0x20, 0x54, 0x79, 0x6C, 0x65, 0x72, 0x20,
                       0x44, 0x69, 0x78, 0x6F, 0x6E, 0x27, 0x73, 0x20, 0x63, 0x6C, 0x6F, 0x74, 0x68, 0x65, 0x73, 0x3F,
                       0x20, 0x48, 0x65, 0x27, 0x73, 0x20, 0x6F, 0x6E, 0x6C, 0x79, 0x20, 0x66, 0x61, 0x6D, 0x6F, 0x75,
                       0x73, 0x20, 0x66, 0x6F, 0x72, 0x20, 0x62, 0x65, 0x69, 0x6E, 0x67, 0x20, 0x61, 0x20, 0x73, 0x68,
                       0x69, 0x74, 0x20, 0x62, 0x61, 0x63, 0x6B, 0x69, 0x6E, 0x67, 0x20, 0x64, 0x61, 0x6E, 0x63, 0x65,
                       0x72, 0x20, 0x77, 0x69, 0x74, 0x68, 0x20, 0x61, 0x20, 0x63, 0x72, 0x61, 0x63, 0x6B, 0x20, 0x68,
                       0x61, 0x62, 0x69, 0x74, 0x20, 0x77, 0x68, 0x6F, 0x20, 0x6D, 0x61, 0x72, 0x72, 0x69, 0x65, 0x64,
                       0x20, 0x43, 0x6C, 0x6F, 0x65, 0x20, 0x50, 0x61, 0x72, 0x6B, 0x65, 0x72, 0x20, 0x28, 0x61, 0x6E,
                       0x64, 0x20, 0x74, 0x68, 0x65, 0x6E, 0x20, 0x64, 0x69, 0x76, 0x6F, 0x72, 0x63, 0x65, 0x64, 0x20,
                       0x68, 0x65, 0x72, 0x20, 0x6C, 0x69, 0x6B, 0x65, 0x20, 0x61, 0x20, 0x77, 0x65, 0x65, 0x6B, 0x20,
                       0x6C, 0x61, 0x74, 0x65, 0x72, 0x29, 0x00, 0x41, 0x66, 0x74, 0x65, 0x72, 0x20, 0x48, 0x6F, 0x75,
                       0x72, 0x73, 0x00, 0x47, 0x61, 0x72, 0x61, 0x67, 0x65, 0x3A, 0x20, 0x45, 0x63, 0x6C, 0x69, 0x70,
                       0x73, 0x65, 0x20, 0x54, 0x6F, 0x77, 0x65, 0x72, 0x73, 0x20, 0x35, 0x00, 0x48, 0x61, 0x63, 0x6B,
                       0x20, 0x54, 0x61, 0x72, 0x67, 0x65, 0x74, 0x00, 0x4D, 0x61, 0x72, 0x69, 0x6E, 0x61, 0x00, 0x70,
                       0x61, 0x63, 0x6B, 0x61, 0x67, 0x65, 0x00, 0x43, 0x61, 0x72, 0x62, 0x6F, 0x6E, 0x20, 0x42, 0x6C,
                       0x61, 0x63, 0x6B, 0x00, 0x48, 0x65, 0x6C, 0x70, 0x20, 0x73, 0x74, 0x65, 0x61, 0x6C, 0x20, 0x74,
                       0x68, 0x65, 0x20, 0x7E, 0x61, 0x7E, 0x2E, 0x00, 0x49, 0x20, 0x6A, 0x75, 0x73, 0x74, 0x20, 0x68,
                       0x65, 0x61, 0x72, 0x64, 0x20, 0x61, 0x20, 0x72, 0x61, 0x64, 0x69, 0x6F, 0x20, 0x61, 0x64, 0x76,
                       0x65, 0x72, 0x74, 0x20, 0x61, 0x62, 0x6F, 0x75, 0x74, 0x20, 0x74, 0x68, 0x65, 0x20, 0x66, 0x6C,
                       0x79, 0x69, 0x6E, 0x67, 0x20, 0x73, 0x63, 0x68, 0x6F, 0x6F, 0x6C, 0x20, 0x69, 0x74, 0x73, 0x20,
                       0x69, 0x6E, 0x20, 0x4C, 0x6F, 0x73, 0x20, 0x53, 0x61, 0x6E, 0x74, 0x6F, 0x73, 0x20, 0x6E, 0x6F,
                       0x74, 0x20, 0x73, 0x61, 0x79, 0x69, 0x6E, 0x67, 0x20, 0x79, 0x6F, 0x75, 0x20, 0x6E, 0x65, 0x65,
                       0x64, 0x20, 0x74, 0x6F, 0x20, 0x6C, 0x65, 0x61, 0x72, 0x6E, 0x20, 0x6E, 0x65, 0x77, 0x20, 0x74,
                       0x68, 0x69, 0x6E, 0x67, 0x73, 0x20, 0x6A}
bt_org_UNLOCK_AWRD_SHIRT1 = {0x59, 0x6F, 0x75, 0x20, 0x63, 0x61, 0x6E, 0x20, 0x6E, 0x6F, 0x77, 0x20, 0x70, 0x75, 0x72,
                             0x63, 0x68, 0x61, 0x73, 0x65, 0x20, 0x74, 0x68, 0x65, 0x20, 0x72, 0x65, 0x74, 0x72, 0x6F,
                             0x20, 0x42, 0x69, 0x74, 0x63, 0x68, 0x27, 0x6E, 0x20, 0x44, 0x6F, 0x67, 0x20, 0x46, 0x6F,
                             0x6F, 0x64, 0x20, 0x54, 0x6F, 0x70, 0x20, 0x66, 0x72, 0x6F, 0x6D, 0x20, 0x61, 0x6E, 0x79,
                             0x20, 0x63, 0x6C, 0x6F, 0x74, 0x68, 0x65, 0x73, 0x20, 0x73, 0x74, 0x6F, 0x72, 0x65, 0x2E,
                             0x00, 0x49, 0x27, 0x6D, 0x20, 0x67, 0x6F, 0x6E, 0x6E, 0x61, 0x20, 0x70, 0x72, 0x65, 0x74,
                             0x65, 0x6E, 0x64, 0x20, 0x49, 0x20, 0x6E, 0x65, 0x76, 0x65, 0x72, 0x20, 0x73, 0x61, 0x77,
                             0x20, 0x74, 0x68, 0x61, 0x74, 0x00, 0x53, 0x61, 0x6E, 0x64, 0x79, 0x20, 0x53, 0x68, 0x6F,
                             0x72, 0x65, 0x73, 0x20, 0x48, 0x65, 0x6C, 0x69, 0x70, 0x61, 0x64, 0x00, 0x47, 0x72, 0x61,
                             0x79, 0x20, 0x43, 0x61, 0x74, 0x00, 0x42, 0x61, 0x6E, 0x67, 0x69, 0x6E, 0x67, 0x20, 0x54,
                             0x75, 0x6E, 0x65, 0x73, 0x20, 0x52, 0x69, 0x67, 0x68, 0x74, 0x00, 0x50, 0x69, 0x67, 0x74,
                             0x61, 0x69, 0x6C, 0x73, 0x20, 0x42, 0x6C, 0x61, 0x63, 0x6B, 0x00, 0x7E, 0x61, 0x7E, 0x7E,
                             0x48, 0x55, 0x44, 0x5F, 0x43, 0x4F, 0x4C, 0x4F, 0x55, 0x52, 0x5F, 0x57, 0x48, 0x49, 0x54,
                             0x45, 0x7E, 0x20, 0x64, 0x65, 0x76, 0x61, 0x73, 0x74, 0x61, 0x74, 0x65, 0x64, 0x20, 0x79,
                             0x6F, 0x75, 0x2E, 0x00, 0x4A, 0x6F, 0x69, 0x6E, 0x69, 0x6E, 0x67, 0x20, 0x47, 0x54, 0x41,
                             0x20, 0x4F, 0x6E, 0x6C, 0x69, 0x6E, 0x65, 0x20, 0x73, 0x65, 0x73, 0x73, 0x69, 0x6F, 0x6E,
                             0x73, 0x20, 0x68, 0x61, 0x73, 0x20, 0x62, 0x65, 0x65, 0x6E, 0x20, 0x64, 0x69, 0x73, 0x61,
                             0x62, 0x6C, 0x65, 0x64, 0x20, 0x77, 0x68, 0x69, 0x6C, 0x65, 0x20, 0x74, 0x68, 0x65, 0x20,
                             0x52, 0x6F, 0x63, 0x6B, 0x73, 0x74, 0x61, 0x72, 0x20, 0x45, 0x64, 0x69, 0x74, 0x6F, 0x72,
                             0x20, 0x69, 0x73, 0x20, 0x72, 0x75, 0x6E, 0x6E, 0x69, 0x6E, 0x67, 0x2E, 0x00, 0x47, 0x69,
                             0x76, 0x65, 0x20, 0x4C, 0x65, 0x73, 0x74, 0x65, 0x72, 0x20, 0x61, 0x20, 0x63, 0x61, 0x6C,
                             0x6C, 0x20, 0x74, 0x6F, 0x20, 0x70, 0x6C, 0x61, 0x63, 0x65, 0x20, 0x61, 0x20, 0x42, 0x6F,
                             0x75, 0x6E, 0x74, 0x79, 0x20, 0x6F, 0x6E, 0x20, 0x61, 0x6E, 0x6F, 0x74, 0x68, 0x65, 0x72,
                             0x20, 0x70, 0x6C, 0x61, 0x79, 0x65, 0x72, 0x27, 0x73, 0x20, 0x68, 0x65, 0x61, 0x64, 0x2E,
                             0x20, 0x49, 0x74, 0x20, 0x77, 0x69, 0x6C, 0x6C, 0x20, 0x63, 0x6F, 0x73, 0x74, 0x20, 0x74,
                             0x6F, 0x20, 0x70, 0x6C, 0x61, 0x63, 0x65, 0x20, 0x61, 0x6E, 0x64, 0x2C, 0x20, 0x77, 0x68,
                             0x65, 0x6E, 0x20, 0x70, 0x6C, 0x61, 0x63, 0x65, 0x64, 0x2C, 0x20, 0x61, 0x6C, 0x6C, 0x20,
                             0x6F, 0x74, 0x68, 0x65, 0x72, 0x20, 0x70, 0x6C, 0x61, 0x79, 0x65, 0x72, 0x73, 0x20, 0x77,
                             0x69, 0x6C, 0x6C, 0x20, 0x62, 0x65, 0x20, 0x69, 0x6E, 0x66, 0x6F, 0x72, 0x6D, 0x65, 0x64,
                             0x2E, 0x20, 0x54, 0x68, 0x65, 0x20, 0x6B, 0x69, 0x6C, 0x6C, 0x65, 0x72, 0x20, 0x6F, 0x66,
                             0x20, 0x74, 0x68, 0x65, 0x20, 0x42, 0x6F, 0x75, 0x6E, 0x74, 0x79, 0x20, 0x76, 0x69, 0x63,
                             0x74, 0x69, 0x6D, 0x20, 0x77, 0x69, 0x6C, 0x6C, 0x20, 0x62, 0x65, 0x20, 0x72, 0x65, 0x77,
                             0x61, 0x72, 0x64, 0x65, 0x64, 0x2E, 0x00, 0x27, 0x47, 0x72, 0x6F, 0x74, 0x74, 0x69, 0x27,
                             0x20, 0x54, 0x2D, 0x73, 0x68, 0x69, 0x72, 0x74, 0x00}
bt_org_UNLOCK_AWRD_SHIRT2 = {0x59, 0x6F, 0x75, 0x20, 0x63, 0x61, 0x6E, 0x20, 0x6E, 0x6F, 0x77, 0x20, 0x70, 0x75, 0x72,
                             0x63, 0x68, 0x61, 0x73, 0x65, 0x20, 0x74, 0x68, 0x65, 0x20, 0x72, 0x65, 0x74, 0x72, 0x6F,
                             0x20, 0x56, 0x69, 0x6E, 0x79, 0x6C, 0x20, 0x43, 0x6F, 0x75, 0x6E, 0x74, 0x64, 0x6F, 0x77,
                             0x6E, 0x20, 0x54, 0x6F, 0x70, 0x20, 0x66, 0x72, 0x6F, 0x6D, 0x20, 0x61, 0x6E, 0x79, 0x20,
                             0x63, 0x6C, 0x6F, 0x74, 0x68, 0x65, 0x73, 0x20, 0x73, 0x74, 0x6F, 0x72, 0x65, 0x2E, 0x00,
                             0x42, 0x65, 0x69, 0x67, 0x65, 0x20, 0x4F, 0x78, 0x66, 0x6F, 0x72, 0x64, 0x73, 0x00, 0x46,
                             0x72, 0x61, 0x6E, 0x6B, 0x6C, 0x69, 0x6E, 0x20, 0x69, 0x73, 0x20, 0x6E, 0x6F, 0x77, 0x20,
                             0x74, 0x61, 0x69, 0x6C, 0x69, 0x6E, 0x67, 0x20, 0x74, 0x68, 0x65, 0x20, 0x61, 0x72, 0x63,
                             0x68, 0x69, 0x74, 0x65, 0x63, 0x74, 0x2E, 0x20, 0x53, 0x57, 0x49, 0x54, 0x43, 0x48, 0x20,
                             0x74, 0x6F, 0x20, 0x46, 0x72, 0x61, 0x6E, 0x6B, 0x6C, 0x69, 0x6E, 0x20, 0x74, 0x6F, 0x20,
                             0x73, 0x65, 0x65, 0x20, 0x68, 0x6F, 0x77, 0x20, 0x68, 0x65, 0x27, 0x73, 0x20, 0x64, 0x6F,
                             0x69, 0x6E, 0x67, 0x2E, 0x00, 0x42, 0x72, 0x75, 0x74, 0x65, 0x20, 0x54, 0x65, 0x65, 0x00,
                             0x66, 0x6F, 0x78, 0x79, 0x6D, 0x61, 0x6D, 0x61, 0x32, 0x31, 0x7E, 0x6E, 0x7E, 0x34, 0x33,
                             0x7E, 0x6E, 0x7E, 0x42, 0x61, 0x6E, 0x67, 0x69, 0x6E, 0x67, 0x7E, 0x6E, 0x7E, 0x44, 0x65,
                             0x73, 0x74, 0x72, 0x75, 0x63, 0x74, 0x69, 0x76, 0x65, 0x6C, 0x79, 0x7E, 0x6E, 0x7E, 0x41,
                             0x6E, 0x79, 0x74, 0x68, 0x69, 0x6E, 0x67, 0x20, 0x67, 0x6F, 0x65, 0x73, 0x00, 0x56, 0x65,
                             0x68, 0x69, 0x63, 0x6C, 0x65, 0x3A, 0x20, 0x7E, 0x61, 0x7E, 0x7E, 0x6E, 0x7E, 0x56, 0x61,
                             0x6C, 0x75, 0x65, 0x3A, 0x20, 0x7E, 0x61, 0x7E, 0x7E, 0x6E, 0x7E, 0x50, 0x6C, 0x61, 0x74,
                             0x65, 0x3A, 0x20, 0x7E, 0x61, 0x7E, 0x20, 0x7E, 0x6E, 0x72, 0x74, 0x7E, 0x20, 0x3C, 0x69,
                             0x6D, 0x67, 0x20, 0x73, 0x72, 0x63, 0x3D, 0x27, 0x69, 0x6D, 0x67, 0x3A, 0x2F, 0x2F, 0x49,
                             0x45, 0x5F, 0x54, 0x45, 0x58, 0x54, 0x56, 0x45, 0x43, 0x48, 0x5F, 0x31, 0x36, 0x2F, 0x49,
                             0x45, 0x5F, 0x54, 0x45, 0x58, 0x54, 0x56, 0x45, 0x43, 0x48, 0x5F, 0x31, 0x36, 0x27, 0x20,
                             0x76, 0x73, 0x70, 0x61, 0x63, 0x65, 0x3D, 0x27, 0x30, 0x27, 0x20, 0x77, 0x69, 0x64, 0x74,
                             0x68, 0x3D, 0x27, 0x32, 0x35, 0x32, 0x27, 0x20, 0x68, 0x65, 0x69, 0x67, 0x68, 0x74, 0x3D,
                             0x27, 0x31, 0x35, 0x30, 0x27, 0x2F, 0x3E, 0x20, 0x7E, 0x6E, 0x72, 0x74, 0x7E, 0x00, 0x59,
                             0x6F, 0x75, 0x20, 0x61, 0x72, 0x65, 0x20, 0x75, 0x6E, 0x61, 0x62, 0x6C, 0x65, 0x20, 0x74,
                             0x6F, 0x20, 0x44, 0x69, 0x73, 0x6D, 0x69, 0x73, 0x73, 0x20, 0x61, 0x6E, 0x20, 0x41, 0x73,
                             0x73, 0x6F, 0x63, 0x69, 0x61, 0x74, 0x65, 0x20, 0x77, 0x68, 0x69, 0x6C, 0x65, 0x20, 0x6F,
                             0x6E, 0x20, 0x43, 0x45, 0x4F, 0x20, 0x57, 0x6F, 0x72, 0x6B, 0x2C, 0x20, 0x56, 0x49, 0x50,
                             0x20, 0x57, 0x6F, 0x72, 0x6B, 0x20, 0x6F, 0x72, 0x20, 0x61, 0x20, 0x43, 0x68, 0x61, 0x6C,
                             0x6C, 0x65, 0x6E, 0x67, 0x65, 0x2E, 0x00, 0x54, 0x68, 0x65, 0x20, 0x44, 0x69, 0x61, 0x6D,
                             0x6F, 0x6E, 0x64, 0x20, 0x43, 0x61, 0x73, 0x69, 0x6E, 0x6F, 0x20, 0x48, 0x65, 0x69, 0x73,
                             0x74, 0x20, 0xE2, 0x80, 0x93, 0x20, 0x41, 0x67, 0x67, 0x72, 0x65, 0x73, 0x73, 0x69, 0x76,
                             0x65, 0x00, 0x4C, 0x4F, 0x55, 0x44, 0x00, 0x6C, 0x61}
bt_org_UNLOCK_AWRD_SHIRT3 = {0x59, 0x6F, 0x75, 0x20, 0x63, 0x61, 0x6E, 0x20, 0x6E, 0x6F, 0x77, 0x20, 0x70, 0x75, 0x72,
                             0x63, 0x68, 0x61, 0x73, 0x65, 0x20, 0x74, 0x68, 0x65, 0x20, 0x72, 0x65, 0x74, 0x72, 0x6F,
                             0x20, 0x48, 0x6F, 0x6D, 0x69, 0x65, 0x73, 0x20, 0x53, 0x68, 0x61, 0x72, 0x70, 0x20, 0x54,
                             0x6F, 0x70, 0x20, 0x66, 0x72, 0x6F, 0x6D, 0x20, 0x61, 0x6E, 0x79, 0x20, 0x63, 0x6C, 0x6F,
                             0x74, 0x68, 0x65, 0x73, 0x20, 0x73, 0x74, 0x6F, 0x72, 0x65, 0x2E, 0x00, 0x54, 0x68, 0x69,
                             0x73, 0x20, 0x76, 0x65, 0x68, 0x69, 0x63, 0x6C, 0x65, 0x20, 0x63, 0x61, 0x6E, 0x20, 0x62,
                             0x65, 0x20, 0x72, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x65, 0x64, 0x20, 0x61, 0x67, 0x61,
                             0x69, 0x6E, 0x20, 0x69, 0x6E, 0x20, 0x7E, 0x61, 0x7E, 0x2E, 0x00, 0x48, 0x61, 0x77, 0x61,
                             0x69, 0x69, 0x61, 0x6E, 0x20, 0x53, 0x6E, 0x6F, 0x77, 0x20, 0x54, 0x61, 0x6E, 0x20, 0x53,
                             0x68, 0x61, 0x64, 0x65, 0x73, 0x00, 0x59, 0x6F, 0x75, 0x20, 0x6E, 0x65, 0x65, 0x64, 0x20,
                             0x74, 0x6F, 0x20, 0x68, 0x61, 0x76, 0x65, 0x20, 0x70, 0x6C, 0x61, 0x79, 0x65, 0x72, 0x20,
                             0x63, 0x6F, 0x6E, 0x74, 0x72, 0x6F, 0x6C, 0x20, 0x74, 0x6F, 0x20, 0x73, 0x74, 0x61, 0x72,
                             0x74, 0x20, 0x61, 0x6E, 0x20, 0x41, 0x76, 0x61, 0x69, 0x6C, 0x61, 0x62, 0x6C, 0x65, 0x20,
                             0x4A, 0x6F, 0x62, 0x2E, 0x00, 0x52, 0x65, 0x74, 0x72, 0x6F, 0x00, 0x54, 0x4F, 0x55, 0x52,
                             0x4E, 0x41, 0x4D, 0x45, 0x4E, 0x54, 0x00, 0x43, 0x6F, 0x6C, 0x6C, 0x65, 0x63, 0x74, 0x20,
                             0x63, 0x68, 0x65, 0x63, 0x6B, 0x70, 0x6F, 0x69, 0x6E, 0x74, 0x73, 0x20, 0x7E, 0x48, 0x55,
                             0x44, 0x5F, 0x43, 0x4F, 0x4C, 0x4F, 0x55, 0x52, 0x5F, 0x59, 0x45, 0x4C, 0x4C, 0x4F, 0x57,
                             0x7E, 0x7E, 0x42, 0x4C, 0x49, 0x50, 0x5F, 0x54, 0x45, 0x4D, 0x50, 0x5F, 0x32, 0x7E, 0x7E,
                             0x73, 0x7E, 0x20, 0x74, 0x6F, 0x20, 0x72, 0x65, 0x64, 0x75, 0x63, 0x65, 0x20, 0x74, 0x68,
                             0x65, 0x20, 0x6D, 0x69, 0x73, 0x73, 0x69, 0x6F, 0x6E, 0x20, 0x74, 0x69, 0x6D, 0x65, 0x72,
                             0x20, 0x62, 0x79, 0x20, 0x7E, 0x31, 0x7E, 0x20, 0x73, 0x65, 0x63, 0x6F, 0x6E, 0x64, 0x73,
                             0x2E, 0x00, 0x57, 0x69, 0x72, 0x65, 0x6C, 0x65, 0x73, 0x73, 0x20, 0x53, 0x74, 0x65, 0x72,
                             0x65, 0x6F, 0x20, 0x48, 0x65, 0x61, 0x64, 0x73, 0x65, 0x74, 0x20, 0x28, 0x43, 0x45, 0x43,
                             0x48, 0x59, 0x41, 0x2D, 0x30, 0x30, 0x38, 0x30, 0x29, 0x20, 0x50, 0x72, 0x6F, 0x66, 0x69,
                             0x6C, 0x65, 0x00, 0x50, 0x61, 0x72, 0x61, 0x63, 0x68, 0x75, 0x74, 0x65, 0x20, 0x64, 0x6F,
                             0x77, 0x6E, 0x20, 0x74, 0x6F, 0x20, 0x74, 0x68, 0x65, 0x20, 0x43, 0x61, 0x73, 0x69, 0x6E,
                             0x6F, 0x20, 0x72, 0x6F, 0x6F, 0x66, 0x74, 0x6F, 0x70, 0x2E, 0x20, 0x53, 0x74, 0x61, 0x79,
                             0x20, 0x63, 0x6C, 0x65, 0x61, 0x72, 0x20, 0x6F, 0x66, 0x20, 0x74, 0x68, 0x65, 0x20, 0x67,
                             0x75, 0x61, 0x72, 0x64, 0x73, 0x27, 0x20, 0x61, 0x6E, 0x64, 0x20, 0x63, 0x61, 0x6D, 0x65,
                             0x72, 0x61, 0x73, 0x27, 0x20, 0x6C, 0x69, 0x6E, 0x65, 0x73, 0x20, 0x6F, 0x66, 0x20, 0x73,
                             0x69, 0x67, 0x68, 0x74, 0x20, 0x77, 0x68, 0x65, 0x6E, 0x20, 0x79, 0x6F, 0x75, 0x20, 0x6C,
                             0x61, 0x6E, 0x64, 0x20, 0x74, 0x6F, 0x20, 0x61, 0x76, 0x6F, 0x69, 0x64, 0x20, 0x61, 0x6C,
                             0x65, 0x72, 0x74, 0x69, 0x6E, 0x67, 0x20, 0x74, 0x68, 0x65, 0x20, 0x67, 0x75, 0x61, 0x72,
                             0x64, 0x73, 0x2E, 0x00, 0x46, 0x69, 0x6E, 0x64, 0x20}
bt_org_FM_CREW_INV = {0x59, 0x6F, 0x75, 0x20, 0x68, 0x61, 0x76, 0x65, 0x20, 0x62, 0x65, 0x65, 0x6E, 0x20, 0x61, 0x77,
                      0x61, 0x72, 0x64, 0x65, 0x64, 0x20, 0x74, 0x68, 0x65, 0x20, 0x66, 0x6F, 0x6C, 0x6C, 0x6F, 0x77,
                      0x69, 0x6E, 0x67, 0x20, 0x6C, 0x69, 0x76, 0x65, 0x72, 0x69, 0x65, 0x73, 0x20, 0x66, 0x6F, 0x72,
                      0x20, 0x74, 0x68, 0x65, 0x20, 0x7E, 0x61, 0x7E, 0x3A, 0x7E, 0x6E, 0x7E, 0x7E, 0x61, 0x7E, 0x7E,
                      0x6E, 0x7E, 0x7E, 0x61, 0x7E, 0x7E, 0x6E, 0x7E, 0x7E, 0x61, 0x7E, 0x7E, 0x6E, 0x7E, 0x7E, 0x61,
                      0x7E, 0x7E, 0x6E, 0x7E, 0x7E, 0x61, 0x7E, 0x7E, 0x6E, 0x7E, 0x7E, 0x61, 0x7E, 0x7E, 0x6E, 0x7E,
                      0x7E, 0x61, 0x7E, 0x7E, 0x6E, 0x7E, 0x56, 0x69, 0x73, 0x69, 0x74, 0x20, 0x61, 0x6E, 0x20, 0x61,
                      0x70, 0x70, 0x72, 0x6F, 0x70, 0x72, 0x69, 0x61, 0x74, 0x65, 0x20, 0x6D, 0x6F, 0x64, 0x20, 0x73,
                      0x68, 0x6F, 0x70, 0x20, 0x6F, 0x72, 0x20, 0x76, 0x65, 0x68, 0x69, 0x63, 0x6C, 0x65, 0x20, 0x77,
                      0x6F, 0x72, 0x6B, 0x73, 0x68, 0x6F, 0x70, 0x20, 0x74, 0x6F, 0x20, 0x61, 0x70, 0x70, 0x6C, 0x79,
                      0x20, 0x74, 0x68, 0x65, 0x73, 0x65, 0x20, 0x6C, 0x69, 0x76, 0x65, 0x72, 0x69, 0x65, 0x73, 0x2E,
                      0x00, 0x51, 0x75, 0x69, 0x65, 0x74, 0x6C, 0x79, 0x20, 0x74, 0x61, 0x6B, 0x65, 0x20, 0x6F, 0x75,
                      0x74, 0x20, 0x74, 0x68, 0x65, 0x20, 0x7E, 0x61, 0x7E, 0x2E, 0x00, 0x53, 0x75, 0x73, 0x70, 0x65,
                      0x63, 0x74, 0x20, 0x69, 0x64, 0x65, 0x6E, 0x74, 0x69, 0x66, 0x69, 0x65, 0x64, 0x20, 0x61, 0x73,
                      0x20, 0x6B, 0x6E, 0x6F, 0x77, 0x6E, 0x20, 0x63, 0x72, 0x69, 0x6D, 0x69, 0x6E, 0x61, 0x6C, 0x20,
                      0x67, 0x6F, 0x69, 0x6E, 0x67, 0x20, 0x62, 0x79, 0x20, 0x74, 0x68, 0x65, 0x20, 0x73, 0x74, 0x72,
                      0x65, 0x65, 0x74, 0x6E, 0x61, 0x6D, 0x65, 0x20, 0x22, 0x7E, 0x61, 0x7E, 0x22, 0x2E, 0x00, 0x4D,
                      0x69, 0x6E, 0x69, 0x73, 0x75, 0x62, 0x00, 0x48, 0x56, 0x59, 0x20, 0x41, 0x70, 0x6F, 0x63, 0x61,
                      0x6C, 0x79, 0x70, 0x73, 0x65, 0x20, 0x53, 0x63, 0x61, 0x72, 0x61, 0x62, 0x20, 0x4C, 0x69, 0x76,
                      0x65, 0x72, 0x79, 0x20, 0x73, 0x65, 0x74, 0x00, 0x46, 0x6C, 0x65, 0x63, 0x6B, 0x74, 0x61, 0x72,
                      0x6E, 0x20, 0x54, 0x61, 0x63, 0x74, 0x69, 0x63, 0x61, 0x6C, 0x20, 0x53, 0x6B, 0x69, 0x00, 0x4D,
                      0x69, 0x73, 0x66, 0x69, 0x72, 0x69, 0x6E, 0x67, 0x20, 0x69, 0x6E, 0x20, 0x74, 0x68, 0x65, 0x20,
                      0x53, 0x68, 0x6F, 0x6F, 0x74, 0x69, 0x6E, 0x67, 0x20, 0x52, 0x61, 0x6E, 0x67, 0x65, 0x20, 0x63,
                      0x61, 0x75, 0x73, 0x65, 0x64, 0x20, 0x74, 0x68, 0x65, 0x20, 0x72, 0x6F, 0x75, 0x6E, 0x64, 0x20,
                      0x74, 0x6F, 0x20, 0x65, 0x6E, 0x64, 0x20, 0x61, 0x6E, 0x64, 0x20, 0x74, 0x68, 0x65, 0x20, 0x43,
                      0x6F, 0x70, 0x73, 0x20, 0x74, 0x6F, 0x20, 0x62, 0x65, 0x20, 0x61, 0x6C, 0x65, 0x72, 0x74, 0x65,
                      0x64, 0x2E, 0x00, 0x4C, 0x61, 0x6D, 0x61, 0x72, 0x00, 0x59, 0x6F, 0x75, 0x20, 0x64, 0x6F, 0x20,
                      0x6E, 0x6F, 0x74, 0x20, 0x68, 0x61, 0x76, 0x65, 0x20, 0x65, 0x6E, 0x6F, 0x75, 0x67, 0x68, 0x20,
                      0x6D, 0x6F, 0x6E, 0x65, 0x79, 0x20, 0x74, 0x6F, 0x20, 0x70, 0x75, 0x72, 0x63, 0x68, 0x61, 0x73,
                      0x65, 0x20, 0x74, 0x68, 0x69, 0x73, 0x20, 0x69, 0x6E, 0x74, 0x65, 0x72, 0x69, 0x6F, 0x72, 0x2E,
                      0x00, 0x7E, 0x31, 0x7E, 0x20, 0x6F, 0x66, 0x20, 0x7E, 0x31, 0x7E, 0x20, 0x73, 0x65, 0x63, 0x75,
                      0x72, 0x69, 0x74, 0x79, 0x20, 0x73, 0x68, 0x69}
-- Address_LabelText_CREATOR_RSC="LabelTextAddress+0x50983" 
Address_LabelText_CREATOR_RSC = "LabelTextAddress+0x553D7" -- // default: Rockstar (max. length ≈12)
-- Address_LabelText_PIM_TIGC22="LabelTextAddress+0x1F9541" 
Address_LabelText_PIM_TIGC22 = "LabelTextAddress+0x21508D" -- // default: ~a~ ~s~Your RP has been set to ~1~ RP for Character in slot ~1~. (max. length ≈162)
-- Address_LabelText_ATTK_ILLICIT="LabelTextAddress+0xBCCD5" 
Address_LabelText_ATTK_ILLICIT = "LabelTextAddress+0xC8104" -- // default: Destroy Product ~HUD_COLOUR_RED~~BLIP_PACKAGE~~s~ belonging to Motorcycle Clubs to earn cash and RP. (max. length ≈599)
-- Address_LabelText_UNLOCK_AWRD_SHIRT1="LabelTextAddress+0xB9C2C" 
Address_LabelText_UNLOCK_AWRD_SHIRT1 = "LabelTextAddress+0xC4CF3" -- // default: You can now purchase the retro Bitch'n Dog Food Top from any clothes store. (max. length ≈504)
-- Address_LabelText_UNLOCK_AWRD_SHIRT2="LabelTextAddress+0x49FAB" 
Address_LabelText_UNLOCK_AWRD_SHIRT2 = "LabelTextAddress+0x4E18E" -- // default: You can now purchase the retro Vinyl Countdown Top from any clothes store. (max. length ≈504)
-- Address_LabelText_UNLOCK_AWRD_SHIRT3="LabelTextAddress+0x69BA3" 
Address_LabelText_UNLOCK_AWRD_SHIRT3 = "LabelTextAddress+0x6FFF0" -- // default: You can now purchase the retro Homies Sharp Top from any clothes store. (max. length ≈504)
-- Address_LabelText_FM_CREW_INV="LabelTextAddress+0x18D77F" 
Address_LabelText_FM_CREW_INV = "LabelTextAddress+0x1A3673" -- // default: Someone has requested to join your crew! Go to the Crews menu to accept or decline it. (max. length ≈504)

function writeZeroBytes(Address, Size)
    for i = 0, Size - 1, 1 do
        set.byte(get.Memory(Address) + (i * 0x1), 0x00)
    end
end

NotificationPopUpMapRockstar_Active = false
function NotificationPopUpMapRockstar(Text_1, Text_2)
    if Text_1:len() > 12 then
        return
    elseif Text_2:len() > 162 then
        return
    end
    if NotificationPopUpMapRockstar_Active then
        local td = createTimer(nil, true)
        td.Interval = 15000
        td.OnTimer = function()
            NotificationPopUpMapRockstar(Text_1, Text_2)
            td.destroy()
        end
        return
    end
    NotificationPopUpMapRockstar_Active = true
    writeZeroBytes(Address_LabelText_CREATOR_RSC, 12)
    writeString(Address_LabelText_CREATOR_RSC, Text_1)
    writeZeroBytes(Address_LabelText_PIM_TIGC22, 162)
    writeString(Address_LabelText_PIM_TIGC22, Text_2)
    -- set.global(int,2462090+1,1)
    -- set.global(int,2463661+1,1)
    -- set.global(int,2463661+1,1)
    set.global(int, 2463889 + 1, 1)
    local t = createTimer(nil, true)
    t.Interval = 15000
    t.OnTimer = function()
        set.byte(Address_LabelText_CREATOR_RSC, bt_org_CREATOR_RSC)
        set.byte(Address_LabelText_PIM_TIGC22, bt_org_PIM_TIGC22)
        t.destroy()
        NotificationPopUpMapRockstar_Active = false
    end
end

NotificationPopUpMap_1_Active = false
NotificationPopUpMap_2_Active = false
NotificationPopUpMap_3_Active = false
NotificationPopUpMap_4_Active = false
function NotificationPopUpMap(Text)
    if Text:len() > 504 then
        return
    end
    if not NotificationPopUpMap_1_Active then
        NotificationPopUpMap_1_Active = true
        writeZeroBytes(Address_LabelText_FM_CREW_INV, 504)
        writeString(Address_LabelText_FM_CREW_INV, Text)
        -- set.global(int,1573941,1)
        set.global(int, 1574395, 1)
        local t = createTimer(nil, true)
        t.Interval = 15000
        t.OnTimer = function()
            set.byte(Address_LabelText_FM_CREW_INV, bt_org_FM_CREW_INV)
            NotificationPopUpMap_1_Active = false
            t.destroy()
        end
        return
    elseif not NotificationPopUpMap_2_Active then
        NotificationPopUpMap_2_Active = true
        writeZeroBytes(Address_LabelText_UNLOCK_AWRD_SHIRT1, 504)
        writeString(Address_LabelText_UNLOCK_AWRD_SHIRT1, Text)
        -- Memory.Set_Bit(GA(1574395),0)
        set.global(int, 1574395, 0)
        local t = createTimer(nil, true)
        t.Interval = 15000
        t.OnTimer = function()
            set.byte(Address_LabelText_UNLOCK_AWRD_SHIRT1, bt_org_UNLOCK_AWRD_SHIRT1)
            NotificationPopUpMap_2_Active = false
            t.destroy()
        end
        return
    elseif not NotificationPopUpMap_3_Active then
        NotificationPopUpMap_3_Active = true
        writeZeroBytes(Address_LabelText_UNLOCK_AWRD_SHIRT2, 504)
        writeString(Address_LabelText_UNLOCK_AWRD_SHIRT2, Text)
        -- Memory.Set_Bit(GA(1574395),1)
        set.global(int, 1574395, 1)
        local t = createTimer(nil, true)
        t.Interval = 15000
        t.OnTimer = function()
            set.byte(Address_LabelText_UNLOCK_AWRD_SHIRT2, bt_org_UNLOCK_AWRD_SHIRT2)
            NotificationPopUpMap_3_Active = false
            t.destroy()
        end
        return
    elseif not NotificationPopUpMap_4_Active then
        NotificationPopUpMap_4_Active = true
        writeZeroBytes(Address_LabelText_UNLOCK_AWRD_SHIRT3, 504)
        writeString(Address_LabelText_UNLOCK_AWRD_SHIRT3, Text)
        -- Memory.Set_Bit(GA(1574395),2)
        set.global(int, 1574395, 2)
        local t = createTimer(nil, true)
        t.Interval = 15000
        t.OnTimer = function()
            set.byte(Address_LabelText_UNLOCK_AWRD_SHIRT3, bt_org_UNLOCK_AWRD_SHIRT3)
            NotificationPopUpMap_4_Active = false
            t.destroy()
        end
        return
    else
        local td = createTimer(nil, true)
        td.Interval = 15000
        td.OnTimer = function()
            NotificationPopUpMap(Text)
            td.destroy()
        end
    end
end

NotificationPopUpTop_Active = false
function NotificationPopUpTop(Text)
    if Text:len() > 599 then
        return
    end
    if NotificationPopUpTop_Active then
        local td = createTimer(nil, true)
        td.Interval = 12000
        td.OnTimer = function()
            NotificationPopUpTop(Text)
            td.destroy()
        end
        return
    end
    NotificationPopUpTop_Active = true
    writeZeroBytes(Address_LabelText_ATTK_ILLICIT, 599)
    writeString(Address_LabelText_ATTK_ILLICIT, Text)
    -- Memory.Set_Bit(GA(2540384+5188+7+1+1),23)
    --set.global(int, 2540384 + 5188 + 7 + 1 + 1, 23)
    MEMORY.SET_BIT(GA(2540384 + 5188 + 7 + 1 + 1), 23)
    -- Memory.Clear_Bit(GA(2540384+1798),5)
    MEMORY.CLEAR_BIT(GA(2540384+1798), 5)
    --set.global(int, 2540384 + 1798, 5)
    local t = createTimer(nil, true)
    t.Interval = 12000
    t.OnTimer = function()
        set.byte(Address_LabelText_ATTK_ILLICIT, bt_org_ATTK_ILLICIT)
        t.destroy()
        NotificationPopUpTop_Active = false
    end
end

function f_CreateAmbientPickup(ObjectHash, Amount, pos_x, pos_y, pos_z, headingX, headingY, Distance, Height)
    set.int(PROP_HASH, ObjectHash)
    set.int(PROP_HASH2, ObjectHash)
    local HeadX = get.Float(headingX)
    local HeadY = get.Float(headingY)
    local x = get.Float(pos_x) - (HeadY * Distance)
    local y = get.Float(pos_y) + (HeadX * Distance)
    local z = get.Float(pos_z)
    z = z + Height
    set.global(float, 2515430 + 3, x)
    set.global(float, 2515430 + 4, y)
    set.global(float, 2515430 + 5, z)
    set.global(int, 2515430 + 1, Amount)
    local iParam = get.Global(int, 2515430)
    if iParam == nil then
        return
    end
    if iParam ~= 0 then
        iParam = 0
        set.global(int, 2515430, iParam)
    end
    set.global(int, 4264051 + 1 + (iParam * 85) + 66 + 2, 2)
    set.global(int, 2515436, 1)
end
---func_10(iParam0, iParam1, joaat("HOLD_UP_CASH_REWARD_CAP"), &(Global_262145.f_167), 1);
function ChangePickup(Hash)
    pCPickupInterface = get.Ptr("ReplayInterfacePTR") + 0x20
    iPickupCount = get.Int(get.Ptr(pCPickupInterface) + 0x110)
    local pPickupList = get.Ptr(pCPickupInterface) + 0x100
    if not pPickupList then
        return
    end
    for i = 0, iPickupCount, 1 do
        local p = get.Ptr(pPickupList) + (i * 0x10)
        if not p then
            goto continue
        end
        local PickupHash = get.Int(get.Ptr(p) + 0x488)
        if not PickupHash then
            goto continue
        end
        if PickupHash == GAMEPLAY.GET_HASH_KEY("PICKUP_MONEY_VARIABLE") then
            writeInteger(get.Ptr(p) + 0x488, Hash)
            LuaEngineLog("Hash Changed To" .. Hash)
            SystemLog(string.format("Hash : 0x%X", get.Int(get.Ptr(p) + 0x488)))
        end
        ::continue::
    end
end

function CheckPickups()
    pCPickupInterface = get.Ptr("ReplayInterfacePTR") + 0x20
    iPickupCount = get.Int(get.Ptr(pCPickupInterface) + 0x110)
    iMaxPickups = get.Int(get.Ptr(pCPickupInterface) + 0x108)
    local pPickupList = get.Ptr(pCPickupInterface) + 0x100
    if not pPickupList then
        return
    end
    -- print(iMaxPickups,iPickupCount)
    for i = 0, iMaxPickups, 1 do
        local p = get.Ptr(pPickupList) + (i * 0x10)
        if not p then
            goto continue
        end
        local PickupHash = get.Int(get.Ptr(p) + 0x488)
        if not PickupHash then
            goto continue
        end
        LuaEngineLog(PickupHash)
        if PickupHash == joaat("PICKUP_MONEY_VARIABLE") then
            LuaEngineLog("DANGER HASH IS PICKUP_MONEY_VARIABLE")
            PlaylistTab.PickupCheck.Text = "DANGER HASH IS PICKUP_MONEY_VARIABLE"
            return true
        else
            return false
        end
        ::continue::
    end
end

function RepairVehicle()
    local QueueJob = Asynchronous(function()
        if PED.IS_PED_IN_ANY_VEHICLE() then
            if ReadAct('Veh Godmodes') == true then LuaEngineLog("Godmode Must Be Deactivated") end
            if get.Global(int, 2540612 + 879) == 0 then
                set.global(int, 2540612 + 879, 1)
                VEHICLE.SET_VEHICLE_ENGINE_HEALTH(999)
                Async()
                local FixVehValue = get.Int("[PickupDataPTR]+220") -- pFixVeh = 0x220
                local BSTValue = get.Int("[PickupDataPTR]+160") -- pBST = 0x160

                local CPickupInterface = get.Ptr("ReplayInterfacePTR") + 0x20
                local PickupCount = get.Int(get.Ptr(CPickupInterface) + 0x110)
                local PickupList = get.Ptr(CPickupInterface) + 0X100
                if not PickupList then
                    return
                end
                for i = 0, PickupCount, 1 do
                    local p = get.Ptr(PickupList) + (i * 0x10)
                    if not p then
                        goto continue
                    end
                    local PickupValue = get.Int(get.Ptr(p) + 0x490) -- pDroppedPickupData = 0x490
                    if not PickupValue then
                        goto continue
                    end
                    if (PickupValue == BSTValue) then
                        set.int(get.Ptr(p) + 0x490, FixVehValue)
                    end
                    local x = get.Float(CVehicle + 0x90)
                    local y = get.Float(CVehicle + 0x94)
                    local z = get.Float(CVehicle + 0x98)
                    set.float(get.Ptr(p) + 0x90, x)
                    set.float(get.Ptr(p) + 0x94, y)
                    set.float(get.Ptr(p) + 0x98, z)
                    set.float("[[[WorldPTR]+8]+D30]+9F8" ,0)
                    Async()
                    if ReadMem('Veh Godmodes') then LuaEngineLog("Your Godmode is Not Active") end
                    if (get.Int("[GlobalPTR+0x48]+A5FD8") ~= 0) then 
                        set.int("[GlobalPTR+0x48]+A5FD8", -1) 
                    end
                end
            else
                local FixVehValue = get.Int("[PickupDataPTR]+220") -- pFixVeh = 0x220
                local BSTValue = get.Int("[PickupDataPTR]+160") -- pBST = 0x160

                local CPickupInterface = get.Ptr("ReplayInterfacePTR") + 0x20
                local PickupCount = get.Int(get.Ptr(CPickupInterface) + 0x110)
                local PickupList = get.Ptr(CPickupInterface) + 0X100
                if not PickupList then
                    return
                end
                for i = 0, PickupCount, 1 do
                    local p = get.Ptr(PickupList) + (i * 0x10)
                    if not p then
                        goto continue
                    end
                    local PickupValue = get.Int(get.Ptr(p) + 0x490) -- pDroppedPickupData = 0x490
                    if not PickupValue then
                        goto continue
                    end
                    if (PickupValue == BSTValue) then
                        set.int(get.Ptr(p) + 0x490, FixVehValue)
                    end
                    local x = get.Float(CVehicle + 0x90)
                    local y = get.Float(CVehicle + 0x94)
                    local z = get.Float(CVehicle + 0x98)
                    set.float(get.Ptr(p) + 0x90, x)
                    set.float(get.Ptr(p) + 0x94, y)
                    set.float(get.Ptr(p) + 0x98, z)
                    set.float("[[[WorldPTR]+8]+D30]+9F8" ,0)
                    Async()
                    if ReadMem('Veh Godmodes') then SetList('Veh Godmodes', true) end
                    if (get.Int("[GlobalPTR+0x48]+A5FD8") ~= 0) then 
                        set.int("[GlobalPTR+0x48]+A5FD8", -1) 
                    end
                end
            end
        else
            LuaEngineLog("You Must Be In Vehicle")
        end
        ::continue::
    end)
    AsyncStart(QueueJob,1800)
end

function RepairVehicleDrop()
    local NewThread = function()
        local LocalPlayer = PLAYER_ID() + 1
        OBJECT.CREATE_AMBIENT_PICKUP(GAMEPLAY.GET_HASH_KEY("PICKUP_VEHICLE_HEALTH_STANDARD"),
            GAMEPLAY.GET_HASH_KEY("prop_ld_health_pack"), 1, target_x[LocalPlayer], target_y[LocalPlayer],
            target_z[LocalPlayer], theading_x[LocalPlayer], theading_y[LocalPlayer], tonumber(PlaylistTab.Dist.Text),
            tonumber(PlaylistTab.Tinggi.Text))
        SYSTEM.WAIT(200)
        local FixVehValue = get.Int("[PickupDataPTR]+220") -- pFixVeh = 0x220
        local Dropper = get.Int("[PickupDataPTR]+100") -- pBST = 0x160
        local Unk = get.Int("[PickupDataPTR]+278")

        local CPickupInterface = get.Ptr("ReplayInterfacePTR") + 0x20
        local PickupCount = get.Int(get.Ptr(CPickupInterface) + 0x110)
        local PickupList = get.Ptr(CPickupInterface) + 0X100
        if not PickupList then
            return
        end
        for i = 0, PickupCount, 1 do
            local p = get.Ptr(PickupList) + (i * 0x10)
            if not p then
                goto continue
            end

            local PickupValue = get.Int(get.Ptr(p) + 0x490) -- pDroppedPickupData = 0x490
            if not PickupValue then
                goto continue
            end
            if (PickupValue == Dropper) then
                set.int(get.Ptr(p) + 0x490, FixVehValue)
            end
        end
        ::continue::
    end
    ExecuteThread(NewThread)
end

OBJECT = {
    CREATE_AMBIENT_PICKUP = function(PickupObj, ObjectHash, Amount, pos_x, pos_y, pos_z, headingX, headingY, Distance,
        Height)
        local new = function()
            f_CreateAmbientPickup(ObjectHash, Amount, pos_x, pos_y, pos_z, headingX, headingY, Distance, Height)
            sleep(100)
            ChangePickup(PickupObj)
            CheckPickups()
        end
        ExecuteThread(new)
    end
};

function BlockPhoneCalls()
    for k, v in pairs(tbl_BlacklistContacts) do
        if get.Global(int, 6671) == v[1] then
            set.global(int, 2543673 + 37, 1)
            set.global(int, 6671, 0)
        end
    end
end

function Kill_All_Ped(health)
    PedInterface = get.Ptr("ReplayInterfacePTR") + 0x18
    NPCCount = get.Int(get.Ptr(PedInterface) + 0x110)
    local Pedlist = get.Ptr(PedInterface) + 0x100
    if not Pedlist then
        return
    end
    for i = 0, NPCCount, 1 do
        NPCptr = get.Ptr(Pedlist) + (i * 0x10)
        if not NPCptr then
            goto continue
        end
        local npchealth = get.Float(get.Ptr(NPCptr) + 0x2A0)
        if not npchealth then
            goto continue
        end
        if npchealth ~= 328 then
            set.float(get.Ptr(NPCptr) + 0x280, health)
        end
        ::continue::
    end
end

function Kill_Police(health)
    PedInterface = get.Ptr("ReplayInterfacePTR") + 0x18
    NPCCount = get.Int(get.Ptr(PedInterface) + 0x110)
    local Pedlist = get.Ptr(PedInterface) + 0x100
    if not Pedlist then
        return
    end
    for i = 0, NPCCount, 1 do
        NPCptr = get.Ptr(Pedlist) + (i * 0x10)
        if not NPCptr then
            goto continue
        end
        local npchealth = get.Float(get.Ptr(NPCptr) + 0x2A0)
        if not npchealth then
            goto continue
        end
        if npchealth == 200 then
            set.float(get.Ptr(NPCptr) + 0x280, health)
        end
        ::continue::
    end
end

function Kill_Enemy(health)
    PedInterface = get.Ptr("ReplayInterfacePTR") + 0x18
    NPCCount = get.Int(get.Ptr(PedInterface) + 0x110)
    local Pedlist = get.Ptr(PedInterface) + 0x100
    if not Pedlist then
        return
    end
    for i = 0, NPCCount, 1 do
        NPCptr = get.Ptr(Pedlist) + (i * 0x10)
        if not NPCptr then
            goto continue
        end
        local npchealth = get.Float(get.Ptr(NPCptr) + 0x2A0)
        if not npchealth then
            goto continue
        end
        local hostility = get.Byte(get.Ptr(NPCptr) + 0x18C)
        if (hostility > 1) and (npchealth ~= 328) then
            set.float(get.Ptr(NPCptr) + 0x280, health)
        end
        ::continue::
    end
end
PED = {}

PED.IS_PED_IN_ANY_VEHICLE = function()
    local IsInsideVehicle = get.Byte(CPlayer + IN_VEH2)
    return IsInsideVehicle == 1 and true or false
end

-- PED.SET_PED_HEALTH(Ped pedGroup,Float health)
-- Ex:PED.SET_PED_HEALTH(enemy,0)
function PED.SET_PED_HEALTH(pedGroup, health)
    if pedGroup == enemy then
        Kill_Enemy(health)
    elseif pedGroup == police then
        Kill_Police(health)
    elseif pedGroup == all then
        Kill_All_Ped(health)
    end
end
function NoCollision(Value)
    set.float(PLAYER_COLLISION, Value)
end

function Destroy_All_Veh(health)
    VehInterface = get.Ptr("ReplayInterfacePTR") + 0x10
    VehCount = get.Int(get.Ptr(VehInterface) + 0x190)
    local Vehlist = get.Ptr(VehInterface) + 0x180
    if not Vehlist then
        return
    end
    for i = 0, VehCount, 1 do
        Vehptr = get.Ptr(Vehlist) + (i * 0x10)
        if not Vehptr then
            goto continue
        end
        local Vehhealth = get.Float(get.Ptr(Vehptr) + 0x2A0)
        if not Vehhealth then
            goto continue
        end
        local VehicleState = get.Byte(get.Ptr(Vehptr) + 0xD8)
        if not VehicleState then
            goto continue
        end
        set.float(get.Ptr(Vehptr) + 0x280, health)
        set.float(get.Ptr(Vehptr) + 0x844, health)
        set.float(get.Ptr(Vehptr) + 0x840, health)
        set.float(get.Ptr(Vehptr) + 0x908, health)
        if health == 1000 and VehicleState == 3 then
            set.byte(get.Ptr(Vehptr) + 0xD8, 2)
        end
        ::continue::
    end
end

function Destroy_Enemy_Veh(health)
    VehInterface = get.Ptr("ReplayInterfacePTR") + 0x10
    VehCount = get.Int(get.Ptr(VehInterface) + 0x190)
    local Vehlist = get.Ptr(VehInterface) + 0x180
    if not Vehlist then
        return
    end
    for i = 0, VehCount, 1 do
        Vehptr = get.Ptr(Vehlist) + (i * 0x10)
        if not Vehptr then
            goto continue
        end
        local Vehhealth = get.Float(get.Ptr(Vehptr) + 0x2A0)
        if not Vehhealth then
            goto continue
        end
        local Enemy = get.Byte(Vehptr + 0x18C)
        if Enemy > 1 then
            set.float(get.Ptr(Vehptr) + 0x280, health)
            set.float(get.Ptr(Vehptr) + 0x844, health)
            set.float(get.Ptr(Vehptr) + 0x840, health)
            set.float(get.Ptr(Vehptr) + 0x908, health)
        end
        ::continue::
    end
end

function Destroy_Npc_Veh(health)
    local PedInterface = get.Ptr("[ReplayInterfacePTR]+0x18")
    local count = get.Int(PedInterface + 0x110)
    local list = get.Ptr(PedInterface + 0x100)
    if not list then
        return
    end
    for i = 0, count, 1 do
        local Ped = get.Ptr(list + i * 0x10)
        if not Ped then
            goto continue
        end
        if get.Byte(Ped + 0x2B) == 156 then
            goto continue
        end
        local pedVeh = get.Ptr(Ped + 0xD30)
        if not pedVeh then
            goto continue
        end
        set.float(pedVeh + 0x280, health)
        set.float(pedVeh + 0x844, health)
        set.float(pedVeh + 0x840, health)
        set.float(pedVeh + 0x908, health)
        ::continue::
    end
end

function Kill_Enemy_Veh(health)
    local PedInterface = get.Ptr("[ReplayInterfacePTR]+0x18")
    local count = get.Int(PedInterface + 0x110)
    local list = get.Ptr(PedInterface + 0x100)
    if not list then
        return
    end
    for i = 0, count, 1 do
        local Ped = get.Ptr(list + i * 0x10)
        if not Ped then
            goto continue
        end
        if get.Byte(Ped + 0x2B) == 156 then
            goto continue
        end
        local pedVeh = get.Ptr(Ped + 0xD30)
        if not pedVeh then
            goto continue
        end
        local Check = get.Byte(pedVeh + 0x18C)
        if Check > 1 then
            set.float(pedVeh + 0x280, health)
            set.float(pedVeh + 0x844, health)
            set.float(pedVeh + 0x840, health)
            set.float(pedVeh + 0x908, health)
        end
        ::continue::
    end
end
-- PED.SET_PED_COORD(Float x,Float y,Float z,Ped ped)
function PED.SET_PED_COORD(pos_x, pos_y, pos_z, player)
    local x = get.Float(pos_x)
    local y = get.Float(pos_y)
    local z = get.Float(pos_z)
    if player == PLAYER.PLAYER_PED_ID() then
        x, y, z = PLAYER.PLAYER_PED_ID();
        pos_x, pos_y, pos_z = x, y, z
    elseif player == PLAYER.PLAYER_INDEX_ID(selected_player) then
        x, y, z = PLAYER.PLAYER_INDEX_ID(selected_player);
        pos_x, pos_y, pos_z = x, y, z
    end
    local PedInterface = get.Ptr("[ReplayInterfacePTR]+0x18")
    local count = get.Int(PedInterface + 0x110)
    local list = get.Ptr(PedInterface + 0x100)
    if not list then
        return
    end
    for i = 0, count, 1 do
        local Ped = get.Ptr(list + i * 0x10)
        if not Ped then
            goto continue
        end
        local pedPos = get.Ptr(Ped + 0x30)
        if not pedPos then
            goto continue
        end
        if get.Float(pedPos + 0x50) ~= get.Float(PLAYER_CORDX) and get.Float(pedPos + 0x54) ~= get.Float(PLAYER_CORDY) and
            get.Float(pedPos + 0x58) ~= get.Float(PLAYER_CORDZ) then
            set.float(pedPos + 0x50, x)
            set.float(pedPos + 0x54, y)
            set.float(pedPos + 0x58, z)
            set.float(Ped + 0x90, x)
            set.float(Ped + 0x94, y)
            set.float(Ped + 0x98, z)
        end
    end
    ::continue::
end

function blacklist_comparing(Bool)
    blacklist_comparing_loop = Bool
    local function ScanPlayerList()
        for k, v in pairs(CPLAYER_INDEX) do
            local user_id = get.Long(v[2])
            local nickname = get.String(v[1])
            if nickname ~= nil and user_id ~= nil then
                PlayerLog(string.format("Player Name : %s | SCID : %s", nickname, user_id))
            end
            if not user_id then
                user_id = 0
            end
            if not nickname then
                nickname = ""
            end
            for k2, v2 in pairs(blacklist_player) do
                -- printf('%s/%s | %s/%s',nickname,v2[1],user_id,v2[2]);
                PlayerData.AdminScanner.Caption = string.format('%s/%s | %s/%s', nickname, v2[1], user_id, v2[2]);
                if (user_id == v2[2]) or (nickname == v2[1]) then
                    LuaEngineLog(string.format("R* Employee is Here %s [%i]", nickname, user_id))
                    ShowMessage("R* Employee Come!")
                    SystemLog(string.format("R* Employee Has Come ID %s Name %s", v2[2], v2[1]))
                    LoadSession(10)
                end
                if not blacklist_comparing_loop then
                    break
                end
                Async();
            end
            Async();
        end
    end
    local NewAsync = Asynchronous(function()
        while (blacklist_comparing_loop) do
            Async()
            ScanPlayerList()
            if not blacklist_comparing_loop then
                break
            end
        end
    end)
    AsyncStart(NewAsync, 55)
end

function AutoClicker()
    mouse_event(MOUSEEVENTF_LEFTDOWN);
    SYSTEM.WAIT(100)
    mouse_event(MOUSEEVENTF_LEFTUP);
end

function AutoMouseHold(Boolean)
    AutoHoldActivator = Boolean
    local function AutoHold()
        while AutoHoldActivator == true do
            mouse_event(MOUSEEVENTF_LEFTDOWN);
            if AutoHoldActivator == false then
                break
            end
            SYSTEM.WAIT(100)
        end
    end
    ExecuteThread(AutoHold)
end

function CPHAutoLootMain()
    -- doKeyPress(VK_PRIOR)
    keyDown(VK_PRIOR)
end

function SpectatorCheck()
    local player_join = NETWORK.NETWORK_GET_NUM_CONNECTED_PLAYERS()
    switch(GetCurrentSession(), {
        [0] = function()
            if player_join == 31 then
                writeZeroBytes("LabelTextAddress+0xC4CF3", 504)
                set.string("Ada yang join Sesi Cuk")
                set.global(int, 1574395, 1)
                ShowMessage("Ada yang join Sesi Cuk")
                LuaEngineLog("Ada yang join Sesi Cuk")
            end
        end,
        [1] = function()
            if player_join ~= player_join then
                writeZeroBytes("LabelTextAddress+0xC4CF3", 504)
                set.string("Ada yang join Sesi Cuk")
                set.global(int, 1574395, 1)
                ShowMessage("Ada yang join Sesi Cuk")
                LuaEngineLog("Ada yang join Sesi Cuk")
            end
        end,
        [11] = function()
            if player_join ~= player_join then
                writeZeroBytes("LabelTextAddress+0xC4CF3", 504)
                set.string("Ada yang join Sesi Cuk")
                set.global(int, 1574395, 1)
                ShowMessage("Ada yang join Sesi Cuk")
                LuaEngineLog("Ada yang join Sesi Cuk")
            end
        end,
        [10] = function()
            if NETWORK.NETWORK_GET_NUM_CONNECTED_PLAYERS() > 1 then
                LuaEngineLog("Ada yang join Sesi Cuk")
                LoadSession(10)
            end
        end,
        [9] = function()
            if player_join ~= player_join then
                writeZeroBytes("LabelTextAddress+0xC4CF3", 504)
                set.string("Ada yang join Sesi Cuk")
                set.global(int, 1574395, 1)
                ShowMessage("Ada yang join Sesi Cuk")
                LuaEngineLog("Ada yang join Sesi Cuk")
            end
        end,
        [2] = function()
            if player_join ~= player_join then
                writeZeroBytes("LabelTextAddress+0xC4CF3", 504)
                set.string("Ada yang join Sesi Cuk")
                set.global(int, 1574395, 1)
                ShowMessage("Ada yang join Sesi Cuk")
                LuaEngineLog("Ada yang join Sesi Cuk")
            end
        end,
        [3] = function()
            if player_join ~= player_join then
                writeZeroBytes("LabelTextAddress+0xC4CF3", 504)
                set.string("Ada yang join Sesi Cuk")
                set.global(int, 1574395, 1)
                ShowMessage("Ada yang join Sesi Cuk")
                LuaEngineLog("Ada yang join Sesi Cuk")
            end
        end,
        [6] = function()
            if player_join ~= player_join then
                writeZeroBytes("LabelTextAddress+0xC4CF3", 504)
                set.string("Ada yang join Sesi Cuk")
                set.global(int, 1574395, 1)
                ShowMessage("Ada yang join Sesi Cuk")
                LuaEngineLog("Ada yang join Sesi Cuk")
            end
        end
    })
end

function AntiSpectate()
    local MissionLaunch = SCRIPT.DOES_SCRIPT_EXIST('fm_mission_controller')
    local MissionLaunchNew = SCRIPT.DOES_SCRIPT_EXIST('fm_mission_controller_2020')
    local TotalPlayer = NETWORK.NETWORK_GET_NUM_CONNECTED_PLAYERS()
    if (MissionLaunch == true) or (MissionLaunchNew == true) and TotalPlayer == 4 then
        if (TotalPlayer > 4) then
            LuaEngineLog("CheckPlayerList")
            playSound(findTableFile('Alarm.wav'))
        end
    end
end

function CasinoHeistCrewRemove(Bool)
    CrewRemoveLoop = Bool
    local start = Asynchronous(function()
        while (CrewRemoveLoop) do
            Async()
            if SCRIPT.DOES_SCRIPT_EXIST('fm_mission_controller') == true then
                set.global(int, 1701669 + 1 + (PLAYER.PLAYER_ID() * 68) + 18 + 14, 6)
                set.global(int, 1701669 + 1 + (PLAYER.PLAYER_ID() * 68) + 18 + 12, 6)
                set.global(int, 1701669 + 1 + (PLAYER.PLAYER_ID() * 68) + 18 + 10, 6)
            end
            if not CrewRemoveLoop then
                break
            end
        end
    end)
    AsyncStart(start, 1500)
end

function RemoveCrewCutToZero(Bool)
    CutToZero = Bool
    local start = Asynchronous(function()
        while CutToZero do
            Async()
            set.global(int, 262145 + 28100, 0)
            set.global(int, 262145 + 28101, 0)
            set.global(int, 262145 + 28102, 0)
            set.global(int, 262145 + 28103, 0)
            set.global(int, 262145 + 28104, 0)
            set.global(int, 262145 + 28110, 0)
            set.global(int, 262145 + 28111, 0)
            set.global(int, 262145 + 28112, 0)
            set.global(int, 262145 + 28113, 0)
            set.global(int, 262145 + 28114, 0)
            set.global(int, 262145 + 28105, 0)
            set.global(int, 262145 + 28106, 0)
            set.global(int, 262145 + 28107, 0)
            set.global(int, 262145 + 28108, 0)
            set.global(int, 262145 + 28109, 0)
            -- set.global(int,262145+28073,0)
            set.global(int, 2452907 + 6480, 85)
            if not CutToZero then
                set.global(int, 262145 + 28100, 5)
                set.global(int, 262145 + 28101, 9)
                set.global(int, 262145 + 28102, 7)
                set.global(int, 262145 + 28103, 10)
                set.global(int, 262145 + 28104, 8)
                set.global(int, 262145 + 28110, 3)
                set.global(int, 262145 + 28111, 7)
                set.global(int, 262145 + 28112, 5)
                set.global(int, 262145 + 28113, 10)
                set.global(int, 262145 + 28114, 9)
                set.global(int, 262145 + 28105, 5)
                set.global(int, 262145 + 28106, 7)
                set.global(int, 262145 + 28107, 9)
                set.global(int, 262145 + 28108, 6)
                set.global(int, 262145 + 28109, 10)
                break
            end
        end
    end)
    AsyncStart(start, 1500)
end

function AntiAFKLobby(Bool)
    AntiAFKTrigger = Bool
    local start = Asynchronous(function()
        while AntiAFKTrigger do
            Async();
            set.int(AFK1, MAX_INT)
            set.int(AFK2, MAX_INT)
            set.int(AFK3, MAX_INT)
            set.int(AFK4, MAX_INT)
            if not AntiAFKTrigger then
                set.int(AFK1, 120000)
                set.int(AFK2, 300000)
                set.int(AFK3, 600000)
                set.int(AFK4, 900000)
                break
            end
        end
    end)
    AsyncStart(start, 1500);
end

function AutoHealthPack(Bool, Delay, targets)
    AutoHealTrigger = Bool
    local function AutoHealDrop()
        if get.Float(PListHP[targets]) < get.Float(PLisMAXtHP[targets]) and not get.Bool(PInVeh[targets]) then
            OBJECT.CREATE_AMBIENT_PICKUP(GAMEPLAY.GET_HASH_KEY("PICKUP_HEALTH_STANDARD"),
                GAMEPLAY.GET_HASH_KEY("prop_ld_health_pack"), 1, target_x[targets], target_y[targets],
                target_z[targets], theading_x[targets], theading_y[targets], tonumber(PlaylistTab.Dist.Text),
                tonumber(PlaylistTab.Tinggi.Text))
            SYSTEM.WAIT(500)
            OBJECT.CREATE_AMBIENT_PICKUP(GAMEPLAY.GET_HASH_KEY("PICKUP_ARMOUR_STANDARD"),
                GAMEPLAY.GET_HASH_KEY("prop_armour_pickup"), 1, target_x[targets], target_y[targets], target_z[targets],
                theading_x[targets], theading_y[targets], tonumber(PlaylistTab.Dist.Text),
                tonumber(PlaylistTab.Tinggi.Text))
            SystemLog("Health Pack Spawned")
        elseif get.Float(PListHP[targets]) < get.Float(PLisMAXtHP[targets]) and get.Bool(PInVeh[targets]) then
            OBJECT.CREATE_AMBIENT_PICKUP(GAMEPLAY.GET_HASH_KEY("VEHICLE_PICKUP_HEALTH_STANDARD"),
                GAMEPLAY.GET_HASH_KEY("prop_ld_health_pack"), 1, target_x[targets], target_y[targets],
                target_z[targets], theading_x[targets], theading_y[targets], tonumber(PlaylistTab.Dist.Text),
                tonumber(PlaylistTab.Tinggi.Text))
            SYSTEM.WAIT(500)
            OBJECT.CREATE_AMBIENT_PICKUP(GAMEPLAY.GET_HASH_KEY("VEHICLE_PICKUP_ARMOUR_STANDARD"),
                GAMEPLAY.GET_HASH_KEY("prop_armour_pickup"), 1, target_x[targets], target_y[targets], target_z[targets],
                theading_x[targets], theading_y[targets], tonumber(PlaylistTab.Dist.Text),
                tonumber(PlaylistTab.Tinggi.Text))
            SystemLog("Health Pack Spawned")
        end
    end
    local CheckHPNeeded = function()
        while (AutoHealTrigger) do
            AutoHealDrop()
            if not AutoHealTrigger or not targets then
                break
            end
            SYSTEM.WAIT(Delay)
        end
    end
    ExecuteThread(CheckHPNeeded)
end

function AntiSpecAFK(Bool)
    AntiSpecAFKExecutor = Bool
    local NewThread = Asynchronous(function()
        while AntiSpecAFKExecutor do
            if GetCurrentSession() == 1 and NETWORK.NETWORK_GET_NUM_CONNECTED_PLAYERS() > 1 then
                LuaEngineLog('CheckSession')
                LoadSession(1)
            end
            if not AntiSpecAFKExecutor then
                break
            end
            Async()
        end
    end)
    AsyncStart(NewThread, 1000);
end

function ShowPlayerAvatar(id, Char)
    local NewThread = function()
        local Img1 = VSpawn.PlayerAvatar
        local Img2 = VSpawn.PlayerLayer
        local SC_ID = get.Long(RID_LIST[id])
        local Img1_address = string.format(
                                 'https://prod.ros.rockstargames.com/cloud/11/cloudservices/members/sc/%i/publish/gta5/mpchars/%i.png',
                                 SC_ID, Char);
        int = getInternet();
        local Img1_stream = int.getURL(Img1_address);
        int.destroy();
        local find_err = string.find(Img1_stream, "404 -");
        if find_err ~= nil then
            int = getInternet();
            Img1_stream = int.getURL('https://s.rsg.sc/sc/images/games/GTAV/nav/mug-freemode.png');
            int.destroy();
        end
        find_err = string.find(Img1_stream, "404 -");
        if find_err ~= nil then
            return
        end
        local Img1_SS = createStringStream(Img1_stream);
        Img1.Picture.LoadFromStream(Img1_SS);
        Img1_SS.destroy();

        int = getInternet();
        local Img2_stream = int.getURL('https://s.rsg.sc/sc/images/games/GTAV/nav/photo-bg.png');
        int.destroy();
        find_err = string.find(Img2_stream, "404 -");
        if find_err ~= nil then
            return
        end
        local Img2_SS = createStringStream(Img2_stream);
        Img2.Picture.LoadFromStream(Img2_SS);
        Img2_SS.destroy();
        Img1.BringToFront();
        Img2.SendToBack();
    end
    ExecuteThread(NewThread)
end

function ToggleChat()
    if get.Global(int, 1312896) == 0 then
        set.global(int, 1312896, 1)
        set.global(int, 30968, 1)
    else
        set.global(int, 30968, 0)
        set.global(int, 1312896, 0)
    end
end

function AllMissionLives(Bool)
    AllMissionLivesLoop = Bool
    local MissionLives = function()
        while AllMissionLivesLoop do
            if SCRIPT.DOES_SCRIPT_EXIST('fm_mission_controller') then
                set.locals(int, 'fm_mission_controller', 25438 + 1322 + 1, 9999)
            elseif SCRIPT.DOES_SCRIPT_EXIST('fm_mission_controller_2020') then
                set.locals(int, 'fm_mission_controller_2020', 40170 + 976 + 1, 9999)
            end
            if not AllMissionLivesLoop then
                break
            end
            SYSTEM.WAIT(1500)
        end
    end
    ExecuteThread(MissionLives)
end

function BLOCK_REPORTS(Bool) -- To Clean Report Automatically
    ReportCheckActivator = Bool
    local function ReportScan()
        for i, v in pairs(ReportStat) do
            MainTab.PatternScan.Text = string.format('%s : %s', v[1], STATS.STAT_GET_INT(v[1]))
            -- print(string.format("%s : %s [Hash : 0x%X]",v[1],STATS.STAT_GET_INT(v[1]),joaat(v[1])))
            if STATS.STAT_GET_INT(v[1]) >= v[2] then
                local name = get.String(CPlayerInfo + 0xA4)
                NotificationPopUpMapRockstar("Kepada :" .. name, [[~a~ ~s~Anda Telah Direport]]) -- STATS.STAT_SET_INT(v[1],0)
                SystemLog(string.format("%s : %s [Hash : 0x%X]", v[1], STATS.STAT_GET_INT(v[1]), joaat(v[1])))
                -- if messageDialog("You Got A Report By "..v[1],mtWarning, mbYes, mbNo) == mrYes then
                --     STATS.STAT_SET_INT(v[1],0)
                -- else
                --     messageDialog("Are You Sure Want Keep Your Report",mtWarning, mbYes, mbNo)
                -- end
            end
            if not ReportCheckActivator then
                break
            end
            Async();
        end
    end
    local new = Asynchronous(function()
        while (ReportCheckActivator) do
            Async()
            ReportScan()
            if not ReportCheckActivator then
                break
            end
        end
    end)
    AsyncStart(new, 1500)
end

function TotalEXPIndex(id)
    local CurrentLevel = get.Global(int, 1590682 + 1 + iVar0[id] * 883 + 211 + 6)
    local CurrentEXP = get.Global(int, 1590682 + 1 + iVar0[id] * 883 + 211 + 1)
    for i = 1, #level_data do
        local RealLevel = CurrentLevel + 1
        local NeedEXP = level_data[RealLevel] - CurrentEXP
        if CurrentEXP >= level_data[i] and CurrentEXP <= level_data[i + 1] then
            ActualLevel = i
        end
        LevelStatus = string.format([[%s/%s Actual Level:[%s] 
Needed EXP : %s]], CurrentEXP, level_data[RealLevel], ActualLevel, NeedEXP)
    end
    return LevelStatus
end

function LootIsLandCash(targets)
    for i = 1, 24, 1 do
        local Cash = get.Global(int, 1706031 + 1 + iVar0[targets] * 53 + 10 + 10)
        if Cash >= SecondaryLocation[i] and Cash < SecondaryLocation[i + 1] then
            TotalCash = i
        elseif Cash == 0 then
            return "0"
        end
    end
    return TotalCash
end

function LootIsLandWeed(targets)
    for i = 1, 24, 1 do
        local Weed = get.Global(int, 1706031 + 1 + iVar0[targets] * 53 + 10 + 11)
        if Weed >= SecondaryLocation[i] and Weed < SecondaryLocation[i + 1] then
            TotalWeed = i
        elseif Weed == 0 then
            return "0"
        end
    end
    return TotalWeed
end

function LootIsLandCoke(targets)
    for i = 1, 24, 1 do
        local Coke = get.Global(int, 1706031 + 1 + iVar0[targets] * 53 + 10 + 12)
        if Coke >= SecondaryLocation[i] and Coke < SecondaryLocation[i + 1] then
            TotalCoke = i
        elseif Coke == 0 then
            return "0"
        end
    end
    return TotalCoke
end

function LootIsLandGold(targets)
    for i = 1, 24, 1 do
        local Gold = get.Global(int, 1706031 + 1 + iVar0[targets] * 53 + 10 + 13)
        if Gold >= SecondaryLocation[i] and Gold < SecondaryLocation[i + 1] then
            TotalGold = i
            return TotalGold
        elseif Gold == 0 then
            return "0"
        end
    end
end

function LootCompoundCash(targets)
    for i = 1, 8, 1 do
        local CompoundCash = get.Global(int, 1706031 + 1 + iVar0[targets] * 53 + 10 + 18)
        if CompoundCash >= SecondaryLocation[i] and CompoundCash < SecondaryLocation[i + 1] then
            TotalCompoundCash = i
        elseif CompoundCash == 0 then
            TotalCompoundCash = "0"
        end
    end
    return TotalCompoundCash
end

function LootCompoundWeed(targets)
    for i = 1, 8, 1 do
        local CompoundWeed = get.Global(int, 1706031 + 1 + iVar0[targets] * 53 + 10 + 19)
        if CompoundWeed >= SecondaryLocation[i] and CompoundWeed < SecondaryLocation[i + 1] then
            TotalCompoundWeed = i
        elseif CompoundWeed == 0 then
            TotalCompoundWeed = "0"
        end
    end
    return TotalCompoundWeed
end

function LootCompoundCoke(targets)
    for i = 1, 8, 1 do
        local CompoundCoke = get.Global(int, 1706031 + 1 + iVar0[targets] * 53 + 10 + 20)
        if CompoundCoke >= SecondaryLocation[i] and CompoundCoke < SecondaryLocation[i + 1] then
            TotalCompoundCoke = i
        elseif CompoundCoke == 0 then
            TotalCompoundCoke = "0"
        end
    end
    return TotalCompoundCoke
end

function LootCompoundGold(targets)
    for i = 1, 8, 1 do
        local CompoundGold = get.Global(int, 1706031 + 1 + iVar0[targets] * 53 + 10 + 21)
        if CompoundGold >= SecondaryLocation[i] and CompoundGold < SecondaryLocation[i + 1] then
            TotalCompoundGold = i
        elseif CompoundGold == 0 then
            TotalCompoundGold = "0"
        end
    end
    return TotalCompoundGold
end

function LootCompoundPaint(targets)
    for i = 1, 8, 1 do
        local CompoundPaint = get.Global(int, 1706031 + 1 + iVar0[targets] * 53 + 10 + 23)
        if CompoundPaint >= SecondaryLocation[i] and CompoundPaint < SecondaryLocation[i + 1] then
            TotalCompoundPaint = i
        elseif CompoundPaint == 0 then
            TotalCompoundPaint = "0"
        end
    end
    return TotalCompoundPaint
end

function PrepWajib(targets)
    for i = 1, 9, 1 do
        local IDPrepWajib = get.Global(int, 1701669 + 1 + iVar0[selected_player] * 68 + 18 + 1)
        if IDPrepWajib >= SecondaryLocation[i] and IDPrepWajib < SecondaryLocation[i + 1] then
            PrepWajibStatus = i + 1
        elseif IDPrepWajib == 0 then
            PrepWajibStatus = "0"
        end
    end
    return PrepWajibStatus
end

function PrepOptional(targets)
    for i = 1, 20, 1 do
        local IDPrepOption = get.Global(int, 1701669 + 1 + iVar0[selected_player] * 68 + 18)
        if IDPrepOption >= SecondaryLocation[i] and IDPrepOption < SecondaryLocation[i + 1] then
            PrepOptionStatus = i + 1
        elseif IDPrepOption == 0 then
            PrepOptionStatus = "0"
        end
    end
    return PrepOptionStatus
end

function autoHeistcut(Bool)
    AutomateCutLoop = Bool
    local function CutData()
        if get.Int(CASINO_CUT_1) < 85 then
            set.int(CASINO_CUT_1, 85)
        elseif get.Int(CASINO_CUT_2) < 85 then
            set.int(CASINO_CUT_2, 85)
        elseif get.Int(CASINO_CUT_3) < 85 then
            set.int(CASINO_CUT_3, 85)
        elseif get.Int(CASINO_CUT_4) < 85 then
            set.int(CASINO_CUT_4, 85)
        elseif get.Int(CPERICO_1) < 85 then
            set.int(CPERICO_1, 85)
        elseif get.Int(CPERICO_2) < 85 then
            set.int(CPERICO_2, 85)
        elseif get.Int(CPERICO_3) < 85 then
            set.int(CPERICO_3, 85)
        elseif get.Int(CPERICO_4) < 85 then
            set.int(CPERICO_4, 85)
        elseif get.Int(DOOMSDAY_CUT_1) < 85 then
            set.int(DOOMSDAY_CUT_1, 85)
        elseif get.Int(DOOMSDAY_CUT_2) < 85 then
            set.int(DOOMSDAY_CUT_2, 85)
        elseif get.Int(DOOMSDAY_CUT_3) < 85 then
            set.int(DOOMSDAY_CUT_3, 85)
        elseif get.Int(DOOMSDAY_CUT_4) < 85 then
            set.int(DOOMSDAY_CUT_4, 85)
        elseif get.Int(APT_CUT_1) < 85 then
            set.int(APT_CUT_1, 85)
        elseif get.Int(APT_CUT_2) < 85 then
            set.int(APT_CUT_2, 85)
        elseif get.Int(APT_CUT_3) < 85 then
            set.int(APT_CUT_3, 85)
        elseif get.Int(APT_CUT_4) < 85 then
            set.int(APT_CUT_4, 85)
        end
        local sync = Asynchronous(function()
            while AutomateCutLoop do
                Async()
                CutData()
                if not AutomateCutLoop then
                    break
                end
            end
        end)
        AsyncStart(sync, 800)
    end
end

function SetAssistedAim(AssistAimTrigger)
    if AssistAimTrigger then
        set.int(AIM_STATUS, 0)
    elseif not AssistAimTrigger then
        set.int(AIM_STATUS, 3)
    end
end

function AutoHealPlayer(Bool)
    AutohealTrigger = Bool
    local HealthCheck = Asynchronous(function()
        while (AutohealTrigger) do
            Async()
            local health = get.Float(PLAYER_HP)
            local Maximum_Health = get.Float(PLAYER_MAX_HP)
            if health >= 1 and health <= 200 then
                set.float(PLAYER_HP, Maximum_Health)
                set.float(PLAYER_ARMOR, 50)
                set.float(DMG_TO_HP, 0.5)
            else
                set.float(DMG_TO_HP, 1)
            end
            if not AutohealTrigger then
                break
            end
        end
    end)
    AsyncStart(HealthCheck, 250)
end

function HealthRegeneration(Bool)
    HealthRegenTrigger = Bool
    local Regenerating = Asynchronous(function()
        local healthPointer = get.Memory(CPlayer + 0x280)
        local maxHealth = get.Memory(CPlayer + 0x2A0)
        local healthRegen = 15
        while (HealthRegenTrigger) do
            local curHealth = get.Float(healthPointer)
            if curHealth and curHealth < maxHealth then -- if successfully read and not full
                set.float(healthPointer, curHealth + healthRegen) -- increment health by 1
            end
            if not HealthRegenTrigger then
                break
            end
            Async()
        end
    end)
    AsyncStart(Regenerating, 1500)
end

function OffRadar(Bool, Type)
    set.global(bool, 2426097 + 1 + PLAYER.PLAYER_ID() * 443 + 204, Bool)
    set.global(int, 2440277 + 70, NETWORK.GET_NETWORK_TIME())
    if Type == Lester then
        set.global(int, 2540612 + 4625, 3)
    elseif Type == Org then
        set.global(int, 2540612 + 4625, 4)
    end
end

function RevealRadar(Bool)
    set.global(bool, 2426097 + 1 + PLAYER.PLAYER_ID() * 443 + 204, Bool)
    set.global(int, 2440277 + 71, NETWORK.GET_NETWORK_TIME() + 9999)
end

function BlindCops(Bool)
    set.global(bool, 2540612 + 4620, Bool)
    set.global(int, 2540612 + 4622, NETWORK.GET_NETWORK_TIME() + 9999)
    set.global(int, 2540612 + 4619, 5)
end

function ThermalVision(Bool)
    if Bool then
        if NETWORK.NETWORK_SESSION_IS_PRIVATE() == true then
            set.bool(PrivatePlayerID, TRUE)
            set.bool(Thermalvision, TRUE)
        elseif NETWORK.NETWORK_SESSION_IS_PRIVATE() == false then
            set.bool(PublicPlayerID, TRUE)
            set.bool(Thermalvision, TRUE)
        end
    else
        set.bool(PublicPlayerID, FALSE)
        set.bool(Thermalvision, FALSE)
        set.bool(PrivatePlayerID, FALSE)
    end
end

function NightVision(Boolean)
    if Boolean then
        if NETWORK.NETWORK_SESSION_IS_PRIVATE() == true then
            set.bool(PrivatePlayerID, TRUE)
            set.bool(Nightvision, TRUE)
        elseif NETWORK.NETWORK_SESSION_IS_PRIVATE() == false then
            set.bool(PublicPlayerID, TRUE)
            set.bool(Nightvision, TRUE)
        end
    else
        set.bool(PublicPlayerID, FALSE)
        set.bool(Nightvision, FALSE)
        set.bool(PrivatePlayerID, FALSE)
    end
end

function NoDamageToPlayer(Bool)
    local MaxHealth = get.Float(CPlayer + 0x2A0)
    local function Bulletproof()
        while Bool do
            set.float(PLAYER_HP, MaxHealth)
            set.float(PLAYER_ARMOR, 50)
            set.float(CPlayerInfo + HP_DMG, FALSE)
            set.float(CPlayerInfo + ARMOR_DMG, FALSE)
            set.float(PLAYER_RUN_SPD, 1.2)
            set.float(PLAYER_SWIM_SPD, 1.2)
            set.float(PLAYER_SNEAK_SPD, 1.2)
            if not Bool then
                set.float(CPlayerInfo + HP_DMG, TRUE)
                set.float(CPlayerInfo + ARMOR_DMG, TRUE)
                set.float(PLAYER_RUN_SPD, 1)
                set.float(PLAYER_SWIM_SPD, 1)
                set.float(PLAYER_SNEAK_SPD, 1)
                break
            end
            SYSTEM.WAIT(2000)
        end
    end 
    ExecuteThread(Bulletproof)
end

function UnlockAtomizer(Boolean)
    if Boolean then
        set.global(int, 101851, 90)
    else
        set.global(int, 101851, 0)
    end
end

function UnlockAtomizerTint(Boolean)
    if Boolean then
        set.global(int, 101852, 90)
    else
        set.global(int, 101852, 0)
    end
end

function ReturningPlayer(Bool)
    if Bool then
        set.global(int, 150693, 2)
    else
        set.global(int, 150693, 3)
    end
end

function DropItemLoop(Targets, Bool, Interval, PickupHash, PropHash)
    DropActivate = Bool
    local AsyncDropLoop = function()
        while (DropActivate) do
            -- set.global(int,262145+167,10000)
            OBJECT.CREATE_AMBIENT_PICKUP(tbl_pickup_hash[PickupHash], data_prop[PropHash], 1, target_x[Targets],
                target_y[Targets], target_z[Targets], theading_x[Targets], theading_y[Targets],
                tonumber(PlaylistTab.Dist.Text), tonumber(PlaylistTab.Tinggi.Text))
            if not DropActivate then
                break
            end
            SYSTEM.WAIT(Interval)
        end
    end
    ExecuteThread(AsyncDropLoop)
end

function VehicleSpammer(Targets, Bool, Interval, Hash)
    ActivateSpam = Bool
    local AsyncSpammer = function()
        while ActivateSpam do
            PlaylistTab.HashIndicator.Text = 'Spawn Vehicle Loop To True'.." [".. selected_player.."]"..get.Bool(NETWORK_HANDLER)..PlayerNicknames
            VEHICLE.CREATE_VEHICLE(tonumber(VehicleTab.Dist.Text), target_x[Targets], target_y[Targets],
                target_z[Targets], theading_x[Targets], theading_y[Targets], deactivate, Hash)
            if not ActivateSpam then
                PlaylistTab.HashIndicator.Text = 'Spawn Vehicle Loop To False'.." ["..selected_player.."]"..PlayerNicknames
                break
            end
            SYSTEM.WAIT(Interval)
        end
    end
    ExecuteThread(AsyncSpammer)
end

function DropWeaponInQueue(Targets, Interval)
    local start = function()
        for _, v in pairs(all_weapon_dropper) do
            PlaylistTab.HashIndicator.Text = 'Spawn All Weapon To '.." ["..selected_player.."] "..v[1]..' '..get.String(CPLAYER_NAME[selected_player])
            LuaEngineLog(string.format("Player Index [%s]\nPlayer Name : %s\nMemory Address 0x%X\nHash : 0x%X\nWeapon : 0x%X",selected_player, get.String(CPLAYER_NAME[selected_player]),get.Memory(CPLAYER_NAME[selected_player]), v[1], v[2]))
            OBJECT.CREATE_AMBIENT_PICKUP(v[1], v[2], 9999, target_x[Targets], target_y[Targets], target_z[Targets],
                theading_x[Targets], theading_y[Targets], tonumber(PlaylistTab.Dist.Text),
                tonumber(PlaylistTab.Tinggi.Text))
            if give_all_weapon_var == false then
                break
            end
            SYSTEM.WAIT(Interval)
        end
    end
    ExecuteThread(start)
end -- Global_2540612.f_298 Global_2426097[PLAYER::PLAYER_ID() /*443*/].f_38;

function RIDJoiner(RID, Activation)
    local Asm = f [[
        [ENABLE]
        alloc(RIDTarget,$1000,RIDJoinerPTR)

        label(code)
        label(return)

        RIDTarget:
        mov [rax],#{RID}
        code:
        lea rdi,[rsi+000000E0]
        mov rcx,rdi
        movups xmm0,[rax]
        mov eax,r12d
        jmp return

        RIDJoinerPTR:
        jmp RIDTarget
        return:

        [DISABLE]
        RIDJoinerPTR:
        db 48 8D BE E0 00 00 00
        dealloc(RIDTarget)
    ]]

    local function EnableScript()
        if not RIDJoinerActivate then
            RIDJoinerActivate, RIDJoinerDeactivate = set.assembly(Asm)
        end
    end

    local function DisableScript()
        if RIDJoinerActivate then
            if set.assembly(Asm, RIDJoinerDeactivate) then
                RIDJoinerActivate = false
            end
        end
    end

    if Activation then
        EnableScript()
        RIDJoinerScriptStatus = true
    else
        DisableScript()
        RIDJoinerScriptStatus = false
    end
end

function MemoryCheck(Address)
    if get.Memory(Address) then
        return true
    elseif not get.Memory(Address) then
        return false
    end
end

function DeveloperMode(Activation)
    local Asm = [[
    [ENABLE]
    alloc(Devmode,$1000,IS_DLC_PRESENT)

    label(code)
    label(return)
    
    Devmode:
    
    code:
    mov [rsp+08],rbx
    jmp return
    
    IS_DLC_PRESENT:
    mov al,01
    ret
    and al,08
    return:

    [DISABLE]
    IS_DLC_PRESENT:
    mov [rsp+08],rbx

    dealloc(Devmode)
    ]]
    local function EnableScript()
        if not DeveloperActivate then
            DeveloperActivate, DeveloperDeactivate = set.assembly(Asm)
        end
    end

    local function DisableScript()
        if DeveloperActivate then
            if set.assembly(Asm, DeveloperDeactivate) then
                DeveloperActivate = false
            end
        end
    end

    if Activation then
        EnableScript()
    else
        DisableScript()
    end
end

function CompactMode(Bool)
    if Bool then
        local function cycleFullCompact(sender,force)
            local state = not(compactmenuitem.Caption == 'Full View Mode'); 
            if force~=nil then state = not force end; 
            compactmenuitem.Caption = state and 'Full View Mode' or 'Standard View Mode'; 
            getMainForm().Splitter1.Visible = state; 
            getMainForm().Panel4.Visible    = state; 
            getMainForm().Panel5.Visible    = state; 
        end; 
        local function addCompactMenu() 
            if compactmenualreadyexists then 
                return 
            end; 
            local parent = getMainForm().Menu.Items; 
            compactmenuitem = createMenuItem(parent); 
            parent.add(compactmenuitem); 
            compactmenuitem.Caption = 'Compact View Mode'; 
            compactmenuitem.OnClick = cycleFullCompact; 
            compactmenualreadyexists = 'yes'; 
        end; 
            addCompactMenu(); 
            cycleFullCompact(nil,true)
    else
        cycleFullCompact(nil, false)
    end
end

function DefineReportStat()
    local function NewThread()
        MPPLY_EXPLOITS = MEMORY.COPY(ExploitStat, STATS.STAT_GET_INT("MPPLY_EXPLOITS"))
        SYSTEM.WAIT(1000)
        MPPLY_GAME_EXPLOITS = MEMORY.COPY(GameExploitStat, STATS.STAT_GET_INT("MPPLY_GAME_EXPLOITS"))
        SYSTEM.WAIT(1000)
        MPPLY_GRIEFING = MEMORY.COPY(GriefingStat, STATS.STAT_GET_INT("MPPLY_GRIEFING"))
        SYSTEM.WAIT(1000)
        MPPLY_VC_ANNOYINGME = MEMORY.COPY(VCStat, STATS.STAT_GET_INT("MPPLY_VC_ANNOYINGME"))
        SYSTEM.WAIT(1000)
        MPPLY_TC_HATE = MEMORY.COPY(TCStat, STATS.STAT_GET_INT("MPPLY_TC_HATE"))
        SYSTEM.WAIT(1000)
        MPPLY_OFFENSIVE_LANGUAGE = MEMORY.COPY(OffensiveLangStat, STATS.STAT_GET_INT("MPPLY_OFFENSIVE_LANGUAGE"))
        SYSTEM.WAIT(1000)
        MPPLY_OFFENSIVE_TAGPLATE = MEMORY.COPY(OffensiveTagStat, STATS.STAT_GET_INT("MPPLY_OFFENSIVE_TAGPLATE"))
        SYSTEM.WAIT(1000)
        MPPLY_OFFENSIVE_UGC = MEMORY.COPY(OffensiveUGCStat, STATS.STAT_GET_INT("MPPLY_OFFENSIVE_UGC"))
        SYSTEM.WAIT(1000)
        MPPLY_BAD_CREW_NAME = MEMORY.COPY(CrewName, STATS.STAT_GET_INT("MPPLY_BAD_CREW_NAME"))
        SYSTEM.WAIT(1000)
        MPPLY_BAD_CREW_MOTTO = MEMORY.COPY(Motto, STATS.STAT_GET_INT("MPPLY_BAD_CREW_MOTTO"))
        SYSTEM.WAIT(1000)
        MPPLY_BAD_CREW_STATUS = MEMORY.COPY(CrewStatus, STATS.STAT_GET_INT("MPPLY_BAD_CREW_STATUS"))
        SYSTEM.WAIT(1000)
        MPPLY_BAD_CREW_EMBLEM = MEMORY.COPY(CrewEmblem, STATS.STAT_GET_INT("MPPLY_BAD_CREW_EMBLEM"))
        SYSTEM.WAIT(1000)
        MPPLY_BECAME_BADSPORT_NUM = MEMORY.COPY(BadspotNum, STATS.STAT_GET_INT("MPPLY_BECAME_BADSPORT_NUM"))
        SYSTEM.WAIT(1000)
        MPPLY_BECAME_CHEATER_NUM = MEMORY.COPY(CheaterNum, STATS.STAT_GET_INT("MPPLY_BECAME_CHEATER_NUM"))
        SYSTEM.WAIT(1000)
        MPPLY_DESTROYED_PVEHICLES = MEMORY.COPY(DestroyVeh, STATS.STAT_GET_INT("MPPLY_DESTROYED_PVEHICLES"))
        SYSTEM.WAIT(1000)
        MPPLY_BADSPORT_MESSAGE = MEMORY.COPY(BadsportMessage, STATS.STAT_GET_INT("MPPLY_BADSPORT_MESSAGE"))
        SYSTEM.WAIT(1000)
        MPPLY_LAST_REPORT_PENALTY = MEMORY.COPY(LastReportPenalty, STATS.STAT_GET_INT("MPPLY_LAST_REPORT_PENALTY"))
        SYSTEM.WAIT(1000)
        MPPLY_LAST_REPORT_RESTORE = MEMORY.COPY(ReportRestore, STATS.STAT_GET_INT("MPPLY_LAST_REPORT_RESTORE"))
        SYSTEM.WAIT(1000)
        MPPLY_VOTED_OUT = MEMORY.COPY(VotedOut, STATS.STAT_GET_INT("MPPLY_VOTED_OUT"))
        SYSTEM.WAIT(1000)
        MPPLY_VOTED_OUT_QUIT = MEMORY.COPY(VotedQuit, STATS.STAT_GET_INT("MPPLY_VOTED_OUT_QUIT"))
        SYSTEM.WAIT(1000)
        MPPLY_IS_CHEATER_TIME = MEMORY.COPY(CheaterTime, STATS.STAT_GET_INT("MPPLY_IS_CHEATER_TIME"))
        SYSTEM.WAIT(1000)
        MPPLY_WAS_I_BAD_SPORT = MEMORY.COPY(WasIBadsport, STATS.STAT_GET_INT("MPPLY_WAS_I_BAD_SPORT"))
        SYSTEM.WAIT(1000)
        MPPLY_CHEATER_CLEAR_TIME = MEMORY.COPY(CheatClearTime, STATS.STAT_GET_INT('MP'..MPX..'_CHEAT_BITSET'))
        SYSTEM.WAIT(1000)
        MPPLY_BECAME_BADSPORT_NUM = MEMORY.COPY(BadsportNum, STATS.STAT_GET_INT('MP'..MPX..'_BAD_SPORT_BITSET'))
        SYSTEM.WAIT(1000)
    end
    ExecuteThread(NewThread)
end

