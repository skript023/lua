require("STATS")
require("mobil")

StatTab = Protection
MainTab = Player
VehicleTab = VehOp
PlaylistTab = VSpawn
ManualTab = PlayerData
MiscTab = Struct
------------------------------------------HEIST OPTION----------------------------------------------------------

----------------------------------------------HEIST OPTION END--------------------------------------------------
--MainSliderInput = CEEdit2
--ListSlider = CEListBox1
--InputLevel = CEEdit3
--RIDSpooferInput = CEEdit4
--RIDSpooferSet = CEEdit8
--ScriptEventData = CheckListBox1

local function LoopForever()
    local start = script.create(function()
        while (true) do
            local id = VehicleTab.S_WheelType.itemIndex;
            set.global(int,2462286+27+69,id)
            WheelSelection()
            SpawnerPrimaryColour()
            SpawnerXenon()
        script.yield()
        end
    end)
    start_yield(start,1000)
end
LoopForever()