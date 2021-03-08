--[[Hotkey Setting]]
hotkey1=createHotkey(function() ENTITY.SET_CORD('o') end, VK_DELETE)
hotkey2=createHotkey(function() ENTITY.SET_CORD('w') end, VK_END)
hotkey3=createHotkey(function() set.global(int,2409291+8,1) end, VK_LCONTROL,VK_F)
hotkey4=createHotkey(function() 
    set.int(CASINO_CUT_1,85) 
    set.int(CASINO_CUT_2,85) 
    set.int(CASINO_CUT_3,85) 
    set.int(CASINO_CUT_4,85)
    set.int(CPERICO_1,85) 
    set.int(CPERICO_2,85) 
    set.int(CPERICO_3,85) 
    set.int(CPERICO_4,85)
end, VK_MULTIPLY)

hotkey5 = createHotkey(function() PLAYER.SET_PLAYER_WANTED_LEVEL(0) end, VK_NEXT)
hotkey6 = createHotkey(function() Player.AutoClick.Checked = false AutoMouseHold(false) end, VK_LCONTROL,VK_TAB)
hotkey7 = createHotkey(function() Player.AutoClick.Checked = true end, VK_LCONTROL,VK_1)
hotkey8 = createHotkey(function() THREAD.NATIVE_LOOP(CPHAutoLootMain,TRUE,1000) end, VK_LCONTROL,VK_2)
hotkey9 = createHotkey(function() THREAD.NATIVE_LOOP(CPHAutoLootMain,FALSE,1000) end, VK_LCONTROL,VK_3)
hotkey10 = createHotkey(function() AutoMouseHold(true) end, VK_NUMPAD1 ,VK_NUMPAD2)
hotkey11 = createHotkey(function() AutoMouseHold(false) end, VK_NUMPAD1,VK_NUMPAD3)


