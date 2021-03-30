--[[
  require ("config.setting")
  @Credit : Shirabrixx82,ApacheTech,DarkByte,Corroder,mgr.inz.Player
  Special Thanks to UC in Reversal Thread especially to Kiddion and ScriptKiddy1337
  Compiler : Ellohim a.k.a vladi023
  ]]
function ProcessChecks()
    if not openProcess('GTA5.exe') then
        sleep(250)
        if getOpenedProcessID() == 0 then
            getAutoAttachList().add('GTA5.exe')
            sleep(250)
        else
            closeCE()
        end
    end
end
ProcessChecks()

function ConsoleLog(Message)
    console = getLuaEngine()
    console.GroupBox1.Caption = 'This Is Console Log Output'
    LogOutput = console.mOutput
    console.Color = '0x000000'
    LogOutput.Color = '0x000000'
    LogOutput.Font.Color = '1030655'
    console.show()
    print(Message)
end

function sendMsg(cmd, msg, fpath)
    local output = cmd .. " " .. msg .. " > " .. fpath
    print(output)
    os.execute(output)
end

function getAppsPath()
    FilePath = '';
    if TrainerOrigin ~= nil then
        FilePath = TrainerOrigin
    else
        FilePath = getCheatEngineDir();
    end
    return FilePath
end

function SystemLog(Message)
    local new = function()
        LogMessage = Message
        if getAppsPath() then
            f = io.open(string.format("%s/Log-System.log", FilePath), "a+")
            f:write(LogMessage .. " | " .. os.date() .. "\n")
            f:close()
        end
    end
    createNativeThread(new)
end

function LuaEngineLog(Message) -- console.mOutput.Lines.Text
    PlayerInformationLog = Message
    DebugController.ConsoleOutput.append(Message)
    if getAppsPath() then
        LuaLogs = io.open(string.format("%s/Lua-Log.log", FilePath), "a+")
        LuaLogs:write(PlayerInformationLog .. " | " .. os.date() .. "\n")
        LuaLogs:close()
    end
end

function Pointer(options)
    local _ptr = {
        Options = options,
        Scan = function()
            -- DEBUG: 
            ConsoleLog(string.format("Register Pointer : %s", options.Name))
            ConsoleLog(string.format("Pattern Scan : %s", options.Pattern))
            ConsoleLog(string.format('Scan Method:%s | Sig Offset:%s | Target Offset:%s', options.ScanMethod,
                           options.SigOffset, options.TargetOffset))
            LuaEngineLog("Signature Scanning:  " .. options.Pattern);
            LuaEngineLog("Registering Pointer: " .. options.Name);
            LuaEngineLog(string.format('Scan Method:%s | Sig Offset:%s | Target Offset:%s', options.ScanMethod,
                             options.SigOffset, options.TargetOffset));

            autoAssemble([[
                aobscanmodule(]] .. options.Name .. [[,]] .. process .. [[,]] .. options.Pattern .. [[)
                registersymbol(]] .. options.Name .. [[)
            ]]);

            if (options.ScanMethod == 1) then
                local _addr = getAddress(options.Name) + options.SigOffset;
                _addr = _addr + readInteger(_addr) + options.TargetOffset;
                unregisterSymbol(options.Name);
                registerSymbol(options.Name, _addr, true);
            elseif (options.ScanMethod == 2) then
                local _addr = getAddress(options.Name) + options.SigOffset;
                _addr = getAddress(process) + readInteger(_addr);
                unregisterSymbol(options.Name);
                registerSymbol(options.Name, _addr, true);
            elseif (options.ScanMethod == 3) then
                local _addr = getAddress(options.Name) - options.SigOffset;
                _addr = _addr + readInteger(_addr);
                unregisterSymbol(options.Name);
                registerSymbol(options.Name, _addr, true);
            elseif (options.ScanMethod == 4) then
                local _addr = getAddress(options.Name) + options.SigOffset;
                _addr = _addr + readInteger(_addr);
                unregisterSymbol(options.Name);
                registerSymbol(options.Name, _addr, true);
            elseif (options.ScanMethod == 5) then
                local _addr = getAddress(options.Name) - options.SigOffset;
                _addr = _addr + readInteger(_addr) + options.TargetOffset;
                unregisterSymbol(options.Name);
                registerSymbol(options.Name, _addr, true);
            end
            LuaEngineLog(string.format("Address: 0x%X", getAddressSafe(options.Name)));
            SystemLog(string.format(
                          "Registered Pointer : %s | Address : 0x%X | Scan Method:%s | Sig Offset:%s | Target Offset:%s",
                          options.Name, getAddressSafe(options.Name), options.ScanMethod, options.SigOffset,
                          options.TargetOffset))

            return _ptr;
        end,

        Release = function()
            -- DEBUG: print("Unregistering "..options.Name.." Symbol");
            unregisterSymbol(options.Name);
            return _ptr;
        end,

        BaseAddress = function()
            return getAddress(options.Name);
        end,

        HeapAddress = function()
            return readPointer(options.Name);
        end,

        Exists = function()
            local _exists, err = pcall(function()
                local a = getAddress(options.Name)
            end);
            return _exists;
        end
    };
    table.insert(Pointers, _ptr);
    return _ptr;
end

Pointers = {};
WorldPTR = Pointer({
    Name = 'WorldPTR',
    Pattern = '48 8B 05 ? ? ? ? 45 ? ? ? ? 48 8B 48 08 48 85 C9 74 07',
    ScanMethod = 1,
    SigOffset = 3,
    TargetOffset = 4
});
WorldPTR.Scan();

GlobalPTR = Pointer({
    Name = 'GlobalPTR',
    Pattern = '4C 8D 05 ? ? ? ? 4D 8B 08 4D 85 C9 74 11',
    ScanMethod = 1,
    SigOffset = 3,
    TargetOffset = 4
});
GlobalPTR.Scan();

BlipPTR = Pointer({
    Name = 'BlipPTR',
    Pattern = '4C 8D 05 ? ? ? ? 0F B7 C1',
    ScanMethod = 1,
    SigOffset = 3,
    TargetOffset = 4
});
BlipPTR.Scan();

PlayerCountPTR = Pointer({
    Name = 'PlayerCountPTR',
    Pattern = '48 8B 0D ? ? ? ? E8 ? ? ? ? 48 8B C8 E8 ? ? ? ? 48 8B CF',
    ScanMethod = 1,
    SigOffset = 3,
    TargetOffset = 4
});
PlayerCountPTR.Scan();

GetPointerAddressA = Pointer({
    Name = 'GetPointerAddressA',
    Pattern = '4D 89 B4 F7 xx xx xx xx 48 8B 74 24',
    ScanMethod = 2,
    SigOffset = 4,
    TargetOffset = 6
});
GetPointerAddressA.Scan();

LocalScriptsPTR = Pointer({
    Name = 'LocalScriptsPTR',
    Pattern = '48 8B 05 ? ? ? ? 8B CF 48 8B 0C C8 39 59 68',
    ScanMethod = 1,
    SigOffset = 3,
    TargetOffset = 4
});
LocalScriptsPTR.Scan();

PlayerNamePTR_1 = Pointer({
    Name = 'PlayerNamePTR_1',
    Pattern = '48 8D 0D ? ? ? ? E8 ? ? ? ? 48 8D 0D ? ? ? ? 83',
    ScanMethod = 1,
    SigOffset = 3,
    TargetOffset = 0x68
});
PlayerNamePTR_1.Scan();

-- Pointers = { };
-- PlayerNamePTR_2 = Pointer({
-- Name = 'PlayerNamePTR_2',
-- Pattern = '48 8D 05 ? ? ? ? 48 8D 54 24 28 49 8B FE',
-- ScanMethod = 1,
-- SigOffset = 3,
-- TargetOffset = 0x68
-- });
-- PlayerNamePTR_2.Scan();

-- Pointers = { };
-- PlayerNamePTR_2 = Pointer({
-- Name = 'PlayerNamePTR_2',
-- Pattern = '48 8D ? ? ? ? ? 48 8D ? ? ? 48 8D ? ? 41 B8 ? ? ? ? 48 89 ? ? ? 48 89',
-- ScanMethod = 1,
-- SigOffset = 3,
-- TargetOffset = 0x68
-- });
-- PlayerNamePTR_2.Scan();

-- Pointers = { };
-- PlayerNamePTR_3 = Pointer({
-- Name = 'PlayerNamePTR_3',
-- Pattern = '4C 8B 05 ? ? ? ? 4D 85 C0 74 E4',
-- ScanMethod = 1,
-- SigOffset = 3,
-- TargetOffset = 0x68
-- });
-- PlayerNamePTR_3.Scan();

LampPTR = Pointer({
    Name = 'LampPTR',
    Pattern = '8B 0D ? ? ? ? E8 ? ? ? ? 48 8B ? E8 ? ? ? ? B2'
});
LampPTR.Scan();

SubGlobalPTR = Pointer({
    Name = 'SubGlobalPTR',
    Pattern = '48 8D ? ? ? ? ? E8 ? ? ? ? 0F B7 ? ? ? ? ? 33 FF 8B DF',
    ScanMethod = 1,
    SigOffset = 3,
    TargetOffset = 4
});
SubGlobalPTR.Scan();

UnknownPatternPTR = Pointer({
    Name = 'UnknownPatternPTR',
    Pattern = '48 8B ? ? ? ? ? 48 89 ? 0F B7 ? ? ? ? ? FF 05 ? ? ? ? 48 89 ? ? ? ? ? 3B F8',
    ScanMethod = 1,
    SigOffset = 3,
    TargetOffset = 4
});
UnknownPatternPTR.Scan();

GunLockerPTR = Pointer({
    Name = 'GunLockerPTR',
    Pattern = '4C 8D ? ? ? ? ? 48 8D ? ? ? 49 8B ? E9 ? ? ? ? 48 89',
    ScanMethod = 1,
    SigOffset = 3,
    TargetOffset = 4
});
GunLockerPTR.Scan();

SubWorldPTR = Pointer({
    Name = 'SubWorldPTR',
    Pattern = '48 8B ? ? ? ? ? E9 ? ? ? ? F3 44 ? ? ? ? F3 0F',
    ScanMethod = 1,
    SigOffset = 3,
    TargetOffset = 4
});
SubWorldPTR.Scan();

ReplayInterfacePTR = Pointer({
    Name = 'ReplayInterfacePTR',
    Pattern = '48 8D 0D ? ? ? ? 48 8B D7 E8 ? ? ? ? 48 8D 0D ? ? ? ? 8A D8 E8 ? ? ? ? 84 DB 75 13 48 8D 0D ? ? ? ?',
    ScanMethod = 1,
    SigOffset = 3,
    TargetOffset = 4
});
ReplayInterfacePTR.Scan();

GetEventDataPTR = Pointer({
    Name = 'GetEventDataPTR',
    Pattern = '48 89 5C 24 ? 57 48 83 EC ? 49 8B F8 4C 8D 05'
});
GetEventDataPTR.Scan();

SendNetToLobby = Pointer({
    Name = 'SendNetToLobby',
    Pattern = '44 8D 47 70 48 8D 54 24 ? 48 8B CB E8',
    ScanMethod = 1,
    SigOffset = 0xD,
    TargetOffset = 4
});
SendNetToLobby.Scan();

ScriptEventPTR = Pointer({
    Name = 'ScriptEventPTR',
    Pattern = '48 83 EC 28 E8 ? ? ? ? 48 8B 0D ? ? ? ? 4C 8D 0D ? ? ? ? 4C 8D 05 ? ? ? ? BA 03'
});
ScriptEventPTR.Scan();

RIDJoinerPTR = Pointer({
    Name = 'RIDJoinerPTR',
    Pattern = '48 8D BE ? ? ? ? 48 8B CF 0F 10 00 41 8B C4'
});
RIDJoinerPTR.Scan();

IS_DLC_PRESENT = Pointer({
    Name = 'IS_DLC_PRESENT',
    Pattern = '48 89 5C 24 08 57 48 83 EC 20 81 F9'
});
IS_DLC_PRESENT.Scan();

-- Pointers = { };
-- ModelHashPTR = Pointer({
-- Name = 'ModelHashPTR',
-- Pattern = '4C 8B 15 ? ? ? ? 49 8B 04 D2 44 39 40 08',
-- ScanMethod = 1,
-- SigOffset = 3,
-- TargetOffset = 4
-- });
-- ModelHashPTR.Scan();

VehPTR = Pointer({
    Name = 'VehPTR',
    Pattern = '48 39 3D ? ? ? ? 75 2D',
    ScanMethod = 1,
    SigOffset = 3,
    TargetOffset = 4
});
VehPTR.Scan();

PickupDataPTR = Pointer({
    Name = 'PickupDataPTR',
    Pattern = '48 8B 05 ? ? ? ? 48 8B 1C F8 8B',
    ScanMethod = 1,
    SigOffset = 3,
    TargetOffset = 4
});
PickupDataPTR.Scan();

GamestatePTR = Pointer({
    Name = 'GamestatePTR',
    Pattern = '83 3D ? ? ? ? ? 75 17 8B 42 20 25',
    ScanMethod = 1,
    SigOffset = 2,
    TargetOffset = 4
});
GamestatePTR.Scan();

NativeHandlersPTR = Pointer({
    Name = 'NativeHandlersPTR',
    Pattern = '83 3D ? ? ? ? ? 75 17 8B 42 20 25',
    ScanMethod = 1,
    SigOffset = 12,
    TargetOffset = 4
});
NativeHandlersPTR.Scan();

NativeRegistrationPTR = Pointer({
    Name = 'NativeRegistrationPTR',
    Pattern = '83 3D ? ? ? ? ? 75 17 8B 42 20 25',
    ScanMethod = 1,
    SigOffset = 3,
    TargetOffset = 4
});
NativeRegistrationPTR.Scan();

IsSessionStartedPTR = Pointer({
    Name = 'IsSessionStartedPTR',
    Pattern = '83 3D ? ? ? ? ? 75 17 8B 42 20 25',
    ScanMethod = 1,
    SigOffset = 3,
    TargetOffset = 4
});
IsSessionStartedPTR.Scan();

ScriptProgramsPTR = Pointer({
    Name = 'ScriptProgramsPTR',
    Pattern = '44 8B 0D ? ? ? ? 4C 8B 1D ? ? ? ? 48 8B 1D ? ? ? ? 41 83 F8 FF 74 3F 49 63 C0 42 0F B6 0C 18 81 E1',
    ScanMethod = 1,
    SigOffset = 17,
    TargetOffset = 4
});
ScriptProgramsPTR.Scan();

ScriptThreadPTR = Pointer({
    Name = 'ScriptThreadPTR',
    Pattern = '45 33 F6 8B E9 85 C9 B8',
    ScanMethod = 1,
    SigOffset = -4,
    TargetOffset = 4 - 8
});
ScriptThreadPTR.Scan();

RunScriptThreadPTR = Pointer({
    Name = 'RunScriptThreadPTR',
    Pattern = '45 33 F6 8B E9 85 C9 B8',
    ScanMethod = 3,
    SigOffset = -0x1F
});
RunScriptThreadPTR.Scan();

--[[Pointers = { };
LabelTextAddress = Pointer({
Name = 'LabelTextAddress',
Pattern = '59 6F 75 20 68 61 76 65 20 62 65 65 6E 20 61 77 61 72 64 65 64 20 74 68 65 20 66 6F 6C 6C 6F 77 69 6E 67 20 6C 69 76 65 72 69 65 73 20 66 6F 72 20 74 68 65 20 7E 61 7E 3A',
});
LabelTextAddress.Scan();
]]

Global_ = function(index, ...)
    local GlobalScript = get.Memory("GlobalPTR");
    if not GlobalScript then
        return
    end
    local StringIndex = type(index)
    if StringIndex == "string" then
        local FirstIndex,SecondIndex = StringIndex:match("Global_([^,]+).f_"),StringIndex:match(".f_([^,]+)")
        local ConcatIndex = tonumber(FirstIndex) + tonumber(SecondIndex)
        index = ConcatIndex
    end
    for i = 1, select('#', ...) do
        index = index + select(i, ...);
    end
    local Handler = get.Long
    local ScriptHandle = get.Ptr(GlobalScript + (8 * (index >> 0x12 & 0x3F))) + (8 * (index & 0x3FFFF));
    return ScriptHandle, Handler(ScriptHandle);
end

GA = Global_
script_handler = Global_

LA = function(Index, ScriptName)
    return readQword(getAddress(ScriptName .. "_ptr")) + (8 * Index)
end

function PLAYER_ID()
    return readInteger(GA(2440277))
end

function SetWindowName(Name)
    getMainForm().Caption = tostring(Name)
    getApplication().Title = tostring(Name)
end

function Asynchronous(func)
    return coroutine.create(func)
end

function AsyncStart(thread, interval)
    local timer = createTimer();
    timer.Interval = interval;
    timer.OnTimer = function(t)
        local status = coroutine.status(thread);
        if (thread ~= nil and status ~= 'dead') then
            coroutine.resume(thread);
        else
            t.destroy();
        end
    end
end

function Async()
    return coroutine.yield()
end

function GG(Type, Index) -- // Get Global
    local case = {}

    case["i"] = function() -- case 1 :
        return readInteger(GA(Index)) -- code block
    end -- break statement

    case["f"] = function() -- case 'add' :
        return readFloat(GA(Index)) -- code block
    end -- break statement

    case["s"] = function() -- case '+' :
        return readString(GA(Index)) -- code block
    end -- break statement

    case["b"] = function() -- case '+' :
        return readBytes(GA(Index)) -- code block
    end -- break statement

    case["int64"] = function() -- case '+' :
        return readQword(GA(Index)) -- code block
    end -- break statement

    case["d"] = function() -- case '+' :
        return readDouble(GA(Index)) -- code block
    end -- break statement

    case["w"] = function() -- case '+' :
        return readSmallInteger(GA(Index)) -- code block
    end -- break statement

    case["default"] = function() -- default case
        return ShowMessage("NULL")
    end -- u cant exclude end hear :-P
    -- execution section
    if case[Type] then
        return case[Type]()
    else
        case["default"]()
    end
end

function SG(Type, Index, Value)
    switch(Type, {
        ["i"] = function() -- case 1 :
            return writeInteger(GA(Index), Value) -- code block
        end,
        ["f"] = function() -- case 'add' :
            return writeFloat(GA(Index), Value) -- code block
        end,
        ["s"] = function() -- case '+' :
            return writeString(GA(Index), Value) -- code block
        end,
        ["b"] = function() -- case '+' :
            return writeBytes(GA(Index), Value) -- code block
        end,
        ["int64"] = function() -- case '+' :
            return writeQword(GA(Index), Value) -- code block
        end,
        ["d"] = function() -- case '+' :
            return writeDouble(GA(Index), Value) -- code block
        end,
        ["w"] = function() -- case '+' :
            return writeSmallInteger(GA(Index), Value) -- code block
        end,
        ["default"] = function() -- default case
            return ShowMessage("NULL")
        end
    })
end

SET = function(Type, Address, Value)
    local case = {}

    case["i"] = function() -- case 1 :
        return writeInteger(Address, Value) -- code block
    end -- break statement

    case["f"] = function() -- case 'add' :
        return writeFloat(Address, Value) -- code block
    end -- break statement

    case["s"] = function() -- case '+' :
        return writeString(Address, Value) -- code block
    end -- break statement

    case["b"] = function() -- case '+' :
        return writeBytes(Address, Value) -- code block
    end -- break statement

    case["int64"] = function() -- case '+' :
        return writeQword(Address, Value) -- code block
    end -- break statement

    case["d"] = function() -- case '+' :
        return writeDouble(Address, Value) -- code block
    end -- break statement

    case["w"] = function() -- case '+' :
        return writeSmallInteger(Address, Value) -- code block
    end
    -- break statement
    case["p"] = function() -- case '+' :
        return writePointer(Address, Value) -- code block
    end -- break statement

    case["default"] = function() -- default case
        return ShowMessage("NULL")
    end -- u cant exclude end hear :-P
    -- execution section
    if case[Type] then
        case[Type]()
    else
        case["default"]()
    end

end
function set_global(Index, Type, Value) -- // Set Global
    if Type == int32 then
        return writeInteger(GA(Index), Value)
    elseif Type == float then
        return writeFloat(GA(Index), Value)
    elseif Type == str then
        return writeString(GA(Index), Value)
    elseif Type == bool then
        return writeBytes(GA(Index), Value)
    elseif Type == int64 then
        return writeQword(GA(Index), Value)
    elseif Type == double then
        return writeDouble(GA(Index), Value)
    elseif Type == int16 then
        return writeSmallInteger(GA(Index), Value)
    else
        return NULL
    end
end

Get = function(Type, Address)
    if Type == "i" then
        return readInteger(Address)
    elseif Type == "f" then
        return readFloat(Address)
    elseif Type == "s" then
        return readString(Address)
    elseif Type == "b" then
        return readBytes(Address)
    elseif Type == "int64" then
        return readQword(Address)
    elseif Type == "d" then
        return readDouble(Address)
    elseif Type == "ptr" then
        return readPointer(Address)
    elseif Type == "w" then
        return readSmallInteger(Address)
    elseif Type == "p" then
        return readPointer(Address)
    elseif Type == "a" then
        return getAddress(Address)
    else
        return "NULL"
    end
end

local protected = {}
function const(key, value)
    if _G[key] then
        protected[key] = _G[key]
        _G[key] = nil
    else
        protected[key] = value
    end
end
local meta = {
    __index = protected,
    __newindex = function(tbl, key, value)
        if protected[key] then
            error("attempting to overwrite constant " .. tostring(key) .. " to " .. tostring(value), 2)
        end
        rawset(tbl, key, value)
    end
}
setmetatable(_G, meta)

------------------------DATA WRITING CHANGER-----------------------------
SET_FLOAT = function(Address, Value)
    writeFloat(Address, Value)
end
SET_BOOL = function(Address, Value)
    writeBytes(Address, Value)
end
SET_BYTE = function(Address, Value)
    writeBytes(Address, Value)
end
SET_INT = function(Address, Value)
    writeInteger(Address, Value)
end
SET_INT64 = function(Address, Value)
    writeQword(Address, Value)
end
SET_STR = function(Address, Value)
    writeString(Address, Value)
end
set_float = function(Address, Value)
    writeFloat(Address, Value)
end
set_bool = function(Address, Value)
    writeBytes(Address, Value)
end
set_byte = function(Address, Value)
    writeBytes(Address, Value)
end
set_int = function(Address, Value)
    writeInteger(Address, Value)
end
set_int64 = function(Address, Value)
    writeQword(Address, Value)
end
set_str = function(Address, Value)
    writeString(Address, Value)
end
function int(address, value)
    return writeInteger(address, value)
end
function float(address, value)
    return writeFloat(address, value)
end
function bool(address, value)
    return writeBytes(address, value)
end
function str(address, value)
    return writeString(address, value)
end

sptr = writePointer
activate = 1
deactivate = 0
-------------------------GET_VALUE-------------------------------------------------------------
function get_float(Address)
    return readFloat(Address)
end
function get_bool(Address)
    return readBytes(Address)
end
function get_byte(Address)
    return readBytes(Address)
end
function get_int(Address)
    return readInteger(Address)
end
function get_int64(Address)
    return readQword(Address)
end
function get_str(Address)
    return readString(Address)
end
function GET_FLOAT(Address)
    return readFloat(Address)
end
function GET_BOOL(Address)
    return readBytes(Address)
end
function GET_BYTE(Address)
    return readBytes(Address)
end
function GET_INT(Address)
    return readInteger(Address)
end
function GET_INT64(Address)
    return readQword(Address)
end
function GET_STR(Address)
    return readString(Address)
end
POINTERS = function(address)
    return readPointer(address)
end
function ExecuteThread(func)
    createNativeThread(func)
end

function EXCEPT_CLAUSE(what)
    return what[1]
end

function TRY_CLAUSE(what)
    status, result = pcall(what[1])
    if not status then
        what[2](result)
    end
    return result
end

_G.switch = function(param, case_table)
    local case = case_table[param]
    if case then
        return case()
    end
    local def = case_table['default']
    return def and def() or nil
end

function PlayerLog(Message)
    PlayerInformationLog = Message
    if getAppsPath() then
        f = io.open(string.format("%s/Log-Player.log", FilePath), "a+")
        f:write(PlayerInformationLog .. " | " .. os.date() .. "\n")
        f:close()
    end
end

function Hexadecimal(num)
    if num == 0 then
        return '0'
    end
    local neg = false
    if num < 0 then
        neg = true
        num = num * -1
    end
    local hexstr = "0123456789ABCDEF"
    local result = ""
    while num > 0 do
        local n = math.mod(num, 16)
        result = string.sub(hexstr, n + 1, n + 1) .. result
        num = math.floor(num / 16)
    end
    if neg then
        result = '-' .. result
    end
    return result
end

function MemoryCopy(MemoryAllocation, Memory)
    local orig_type = type(Memory)
    local MemoryAllocation
    if orig_type == 'table' then
        MemoryAllocation = {}
        for orig_key, orig_value in next, Memory, nil do
            MemoryAllocation[MemoryCopy(orig_key)] = MemoryCopy(orig_value)
        end
        setmetatable(MemoryAllocation, MemoryCopy(getmetatable(Memory)))
    else -- number, string, boolean, etc
        MemoryAllocation = Memory
    end
    return MemoryAllocation
end

function CleanNils(t)
    local ans = {}
    for _, v in pairs(t) do
        ans[#ans + 1] = v
    end
    return ans
end

function show(t)
    for _, v in ipairs(t) do
        print(v)
    end
    print(('='):rep(20))
end

function GDMClean(t)
    Tbl_GDM = {}
    for k, v in ipairs(t) do
        if (get.Byte(v) ~= nil) then
            table.insert(Tbl_GDM, v)
        end
    end
    return Tbl_GDM
end

function cleaner(t)
    cleanTable = {}
    for k, v in ipairs(t) do
        if (get.String(v[1]) ~= nil) and (get.Long(v[2]) ~= nil) then
            table.insert(cleanTable, {v[1], v[2]})
        end
    end
    return cleanTable
end

function CleanFloat(t)
    cleanedfloat = {}
    for k, v in ipairs(t) do
        if (get.Float(v[1]) ~= nil) and (get.Float(v[2]) ~= nil) and (get.Float(v[3]) ~= nil) then
            table.insert(cleanedfloat, {v[1], v[2], v[3]})
        end
    end
    return cleanedfloat
end

createTimer_old = createTimer_old or createTimer

timer_hook_mt = {
    __index = function(self, k)
        return self.rawtimer[k];
    end,
    __newindex = function(self, k, v)
        if string.lower(k) == 'ontimer' then
            self.rawtimer.OnTimer = function(...)
                local success, msg = pcall(v, ...);
                if not success then
                    self.rawtimer.Enabled = false;
                    -- error(msg);
                end
            end
        else
            self.rawtimer[k] = v;
        end
    end
};

createTimer = function(...)
    return setmetatable({
        rawtimer = createTimer_old(...)
    }, timer_hook_mt);
end

--[[try {
   function()
      error('oops')
   end,

   catch {
      function(error)
         print('caught error: ' .. error)
      end
   }
}]]
