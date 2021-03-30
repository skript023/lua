require("joaat")

GlobalScript = function(Offset)
    local p = getAddress('GlobalPTR')
    if not p then
        return
    end
    return readQword(p + (8 * (Index >> 0x12 & 0x3F))) + (8 * (Index & 0x3FFFF));
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

function Test(Registration, Script, Activation)
    if Activation then
        Registration = Script
    else
        Registration = "Disable"
    end
    return Registration
end

function ReturnTest(Activation, Test)
    if Activation == 1 then
        Power = 1
    end
    return (Activation == 1 or Test == 1 and Power == 1) and true or false
end

x = Test(LocalPlayer, "LocalPlayer", true)
z = Test(Test, "Test", true)
print(z)
print(x)
print(z)
x = Test(LocalPlayer, false)
print(x)
print(x)
x = Test(LocalPlayer, "LocalPlayer", true)
print(x)
print(z)
print(x)
y = Test(Adder, joaat("PutriNovita"), true)
print(x)
print(y)
b = joaat("PutriNovita")
w = MemoryCopy(Global_1, "Test")
c = MemoryCopy(Global_2, "Test2")
print(c)
print(w)
print(w)
print(c)
r = ReturnTest(0, 1)
print(r)
s = GlobalScript(262145 + 1190)
print(s)
