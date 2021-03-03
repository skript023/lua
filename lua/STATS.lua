require("joaat")
require("CPH")
require("instant_heist_array")

STATS = {
	STAT_GET_INT = function(joaat_hash) --Return value to function
    set.global(int,2551832+3269,GAMEPLAY.GET_HASH_KEY(joaat_hash))
    set.global(int,2551832+3270,GAMEPLAY.GET_HASH_KEY(joaat_hash))
    set.global(int,1377236+1136,15)
    return get.Global(int,2551544+276)
end;

STAT_GET_BOOL = function(joaat_hash)
  set.global(int,2587834+617,GAMEPLAY.GET_HASH_KEY(joaat_hash))
  set.global(int,2587834+618,GAMEPLAY.GET_HASH_KEY(joaat_hash))
  return get.Bool(STAT_BOOL)
end;

STAT_SET_INT = function(joaat_hash,value) --Set Stat From Hash Key As Int
  set.global(int,1388013+4,GAMEPLAY.GET_HASH_KEY(joaat_hash))
  set.global(int,939452+5526,value)
  set.global(int,1377236+1139,3)
end;

STAT_SET_BOOL = function(joaat_hash,bool) --Set Stat From Hash Key As Bool
  local start = function()
    set.global(int,2587834+617,GAMEPLAY.GET_HASH_KEY(joaat_hash))
    set.global(int,2587834+618,GAMEPLAY.GET_HASH_KEY(joaat_hash))
    SYSTEM.WAIT(1500)
    set.bool(STAT_BOOL,bool)
  end
  ExecuteThread(start);
end;

STAT_LOOP_INT = function(ArrayName) --Set Stat Group In Loop
  local start = function()
    local c = 0
    for _ in pairs(ArrayName) do c=c+1 end
    for i,v in pairs(ArrayName)
    do
      STATS.STAT_SET_INT(v[1],v[2])    
      Protection_ImportView.Text =  string.format("Apply: %s/%s",i,c)
      Protection_joaat.Text = string.format("%s",v[1])
      Protection_stat_value.Text = string.format("%s",v[2])
      SYSTEM.WAIT(100)
    end -- Coroutine has completed, it will be marked as dead after this print..
  end
  ExecuteThread(start)
end;


STAT_LOOP_BOOL = function(ArrayName) --Set Stat Group In Loop
  local start = function()
    local c = 0
    for _ in pairs(ArrayName) do c=c+1 end
    for i,v in pairs(ArrayName)
    do
      STATS.STAT_SET_BOOL(v[1],v[2])
      Protection_ImportView.Text = string.format("Apply: %s/%s",i,c)
      Protection_joaat.Text = string.format("%s",v[1])
      Protection_stat_value.Text = string.format("%s",v[2])
      SYSTEM.WAIT(3000)
    end
  end
  ExecuteThread(start);
end;

STAT_LOADER_BOOL = function ()
  local tbl_Stats={}
  FileName=tostring(Protection.FileName.Text)
  if FileName==nil or FileName=='' then return end
  local fs=assert(io.open(string.format('%s/%s.txt',_MyFilePath,FileName), "r"));
  local k,bool=1,false
  for c=1,200,1 do
    local line=fs:read("*line")
    if line==nil or line=='' then goto continue end
    if line=="BOOL" then bool = true goto bool end
    if c%2==1 and bool==false then
       tbl_Stats[k] = {line}
    elseif c%2==0 and bool==true then
       tbl_Stats[k] = {line}
    else
       tbl_Stats[k][2] = line
       k=k+1
    end
    ::bool::
  end
  ::continue::
  fs:close();
  return tbl_Stats
end;

RUN_LOADER_BOOL = function ()
  local start = function()
    local MPX = tostring(get.Global(int,1312763))
    local tbl_Stats = STATS.STAT_LOADER_BOOL()
    if tbl_Stats == nil then goto continue end
    local i = 0
    for _ in pairs(tbl_Stats) do i=i+1 end
    for c,k in pairs(tbl_Stats) do
       if k[1]:match("$") then k[1]=k[1]:match("$([^,]+)") end
          k[1]=k[1]:sub(1,2)..MPX..k[1]:sub(4)
       Protection_ImportView.Text = string.format("Apply: %s/%s",c,i)
       Protection_joaat.Text = string.format("%s",k[1])
       Protection_stat_value.Text = string.format("%s",k[2])
       STATS.STAT_SET_BOOL(k[1],k[2])
       SYSTEM.WAIT(1000)
    end
    ::continue::
  end
  ExecuteThread(start);
end;

STAT_LOADER_INT = function ()
  local tbl_Stats={}
  FileName=tostring(Protection.FileName.Text)
  if FileName==nil or FileName=='' then return end
  local fs=assert(io.open(string.format('%s/%s.txt',_MyFilePath,FileName), "r"));
  local k,int32=1,false
  for c=1,200,1 do
    local line=fs:read("*line")
    if line==nil or line=='' then goto continue end
    if line=="INT32" then int32 = true goto int end
    if c%2==1 and int32==false then
       tbl_Stats[k] = {line}
    elseif c%2==0 and int32==true then
       tbl_Stats[k] = {line}
    else
       tbl_Stats[k][2] = line
       k=k+1
    end
    ::int::
  end
  ::continue::
  fs:close();
  return tbl_Stats
end;

RUN_LOADER_INT = function ()
  local start = function()
    local MPX = tostring(get.Global(int,1312763))
    local tbl_Stats = STATS.STAT_LOADER_INT()
    if tbl_Stats == nil then goto continue end
    local i = 0
    for _ in pairs(tbl_Stats) do i=i+1 end
    for c,k in pairs(tbl_Stats) do
       if k[1]:match("$") then k[1]=k[1]:match("$([^,]+)") end
          k[1]=k[1]:sub(1,2)..MPX..k[1]:sub(4)
       Protection_ImportView.Text = string.format("Apply: %s/%s",c,i)
       Protection_joaat.Text = string.format("%s",k[1])
       Protection_stat_value.Text = string.format("%s",k[2])
       STATS.STAT_SET_INT(k[1],k[2])
       SYSTEM.WAIT(210)
    end
    ::continue::
  end
  ExecuteThread(start);
end;


};

SCRIPT = {
  REQUEST_SCRIPT = function(ScriptName)
      local script_address = GetLocalScript(ScriptName)
      --print("Scanning Local Script: "..ScriptName)
      Protection.ScriptLoop.Caption = "Scanning Local Script: "..ScriptName;
      if not script_address then
        Protection.RunningStatus.Caption = 'Not Running';
        unregisterSymbol(ScriptName.."_ptr")
        return FALSE;
      else
        unregisterSymbol(ScriptName.."_ptr")
        registerSymbol(ScriptName.."_ptr",script_address,true)
        Protection.RunningStatus.Caption = 'Running';
        return TRUE;
      end
  end;

  HAS_SCRIPT_LOADED = function(Scriptname)
    local get_script = GetLocalScript(Scriptname)
    if not get_script then
      return false
    else
      return true
    end
  end;

  DOES_SCRIPT_EXIST = function(Scriptname)
    if (not get.Memory(Scriptname.."_ptr")) then
      return false
    else
      return true
    end
  end;

  SET_SCRIPT_AS_NO_LONGER_NEEDED = function (Scriptname)
    local script_address = GetLocalScript(Scriptname)
    if not script_address then
      return
    else
      unregisterSymbol(Scriptname.."_ptr")
    end
  end;


}

PLAYER = 
{
	SET_PLAYER_WANTED_LEVEL = function (value)
		set.int(PLAYER_WANTED_LEVEL, value)
    return value
	end;

	SET_PLAYER_INVINCIBLE = function (Trigger)
  local Activation = Trigger
	 if Trigger == true then
      set.bool(PLAYER_GOD, TRUE)
		  set.float(DMG_TO_HP, FALSE) 
		  set.float(DMG_TO_ARMOR,FALSE)
		  set.float(PLAYER_RUN_SPD,1.2)
		  set.float(PLAYER_SWIM_SPD,1.2)
		  set.float(PLAYER_SNEAK_SPD,1.2)
	 elseif Trigger == false then
      set.bool(PLAYER_GOD, FALSE)
		  set.float(DMG_TO_HP,TRUE) 
		  set.float(DMG_TO_ARMOR,TRUE)
		  set.float(PLAYER_RUN_SPD,1)
		  set.float(PLAYER_SWIM_SPD,1)
		  set.float(PLAYER_SNEAK_SPD,1)
	 end
    set.float(PLAYER_HP, 328)
    set.float(PLAYER_ARMOR, 50)
    return Activation
	end;

  SET_PLAYER_INVISIBLE = function (Trigger)
    local Activation = Trigger
    local turn_off = 47  
      if Activation == true then set.int(CPlayer + 0x2C,1)
      elseif Activation == false then set.int(CPlayer + 0x2C,turn_off)
      elseif (1 == get.Bool(CPlayer + 0x52, 1, false)) and (Activation == true) then set.int(CVehicle + 0x2C,1)
      elseif (1 == get.Bool(CPlayer + 0x52, 1, false)) and (Activation == false) then set.int(CVehicle + 0x2C,turn_off)
    end
    return Activation
  end;

  SET_PLAYER_NO_RAGDOLL = function (Boolean)
    local Trigger = Boolean
    if Trigger==true then set.int(CPlayer + 0x10B8,1)
    elseif Trigger==false then set.int(CPlayer + 0x10B8,32)
    end
    return Trigger
  end;

  GODMODE_RESISTANCE = function (Activation)
    local Trigger = Activation
    if Trigger == true then set.float(CPlayerInfo + 0xCAC,-999)
    elseif Trigger == false then set.float(CPlayerInfo + 0xCAC,1)
    end
    return Trigger
  end;

  PLAYER_PED_ID = function()
    local x = readFloat(PLAYER_CORDX)
    local y = readFloat(PLAYER_CORDY)
    local z = readFloat(PLAYER_CORDZ)
    return x,y,z
  end;

  --PLAYER.PLAYER_INDEX_ID(selected_player)
  PLAYER_INDEX_ID = function (selected_player)
    local x = get.Float(target_x[selected_player])
    local y = get.Float(target_y[selected_player])
    local z = get.Float(target_z[selected_player])
    return x,y,z
  end;

  SET_PLAYER_MAX_HEALTH = function (health)
    set.int(CPlayer + 0x2A0,health)
  end,
  PLAYER_ID = function()
    return PLAYER_ID()
  end;
}

VEHICLE =
{
   SET_VEHICLE_ENGINE_HEALTH = function(FLOAT)
    set.float(CVehicle + VEH_HP1, FLOAT)
    set.float(CVehicle + VEH_HP2, FLOAT)
	  set.float(CVehicle + VEH_HP3, FLOAT)
	  set.float(CVehicle + HP, FLOAT)
   end;

   EXPLODE_LAST_VEHICLE = function()
   	set.float(CVehicle + VEH_HP1, -999)
	  set.float(CVehicle + VEH_HP2, -999)
	  set.float(CVehicle + VEH_HP3, -999)
	  set.float(CVehicle + HP, -999)
   end;
   IS_VEHICLE_MODEL = function(hash)
      local Hash = get.Ptr(CVehicle + 0x20)
      if get.Int(Hash + 0x18) == hash then
        return true
      else 
        return false
      end
   end;

  CREATE_VEHICLE = function (Dist,cord_x,cord_y,cord_z,Heading_X,Heading_Y,pegasus,Hash)
    local spawner_z = get.Float(cord_z)      
    local head = get.Float(Heading_X)
    local head2 = get.Float(Heading_Y)
    local spawner_x = get.Float(cord_x)-(head2*Dist)
    local spawner_y = get.Float(cord_y)+(head*Dist)

    set.global(float,2462286+7+0, spawner_x)
    set.global(float,2462286+7+1, spawner_y)
    set.global(float,2462286+7+2, spawner_z)
    set.int(VEH_LIST, RAGE_JOAAT(Hash))
    set.global(bool,2462286+27+28, 1) --weaponised ownerflag
    set.int(BYPASS_VEH_1, 14) --ownerflag
    set.int(BYPASS_VEH_2, 2) --personal car ownerflag
    set.global(bool,2462286+5,1)         ---SET('i',CarSpawn+0x1168, 1)  --can spawn flag must be odd
    set.global(bool,2462286+2,1)         ---SET('i',CarSpawn+0x1180, 1) --spawn toggle gets reset to 0 on car spawn
    set.global(bool,2462286+3,pegasus)
    set.global(int,2462286+27+74, 1) --Red Neon Amount 1-255 100%-0%
    set.global(int,2462286+27+75, 1) --Green Neon Amount 1-255 100%-0%
    set.global(int,2462286+27+76, 0) --Blue Neon Amount 1-255 100%-0%
    set.global(int,2462286+27+77, 4030726305) --landinggear/vehstate
    --set.global(int,2462286+27+5, -1)  --default paintjob primary -1 auto 120
    --set.global(int,2462286+27+6, -1)  --default paintjob secondary -1 auto 120
    set.global(int,2462286+27+7, -1)
    set.global(int,2462286+27+8, -1)
    set.global(int,2462286+27+19,4)
    set.global(int,2462286+27+60,1)
    --set.global(int,2462286+27+20,1)
    set.global(int,2462286+27+21,3)
    set.global(int,2462286+27+22,6)
    set.global(int,2462286+27+23,9)
    set.global(int,2462286+27+24,58)
    set.global(int,2462286+27+25,13)
    set.global(int,2462286+27+26,18)
    set.global(int,2462286+27+27,1)
    --set.global(int,2462286+27+69,8) ---Wheel type
    --set.global(int,2462286+27+33,217) --Wheel Selection
  end;
  
  _SET_VEHICLE_UNK_DAMAGE_MULTIPLIER = function(Vehicle,Float)
    local damage = get.Ptr(CVehicle + 0x938)
    local Vehiclehash = VEHICLE.IS_VEHICLE_MODEL(Vehicle)
    if Vehiclehash == true then
      set.float(damage + 0xF0,Float) 
      set.float(damage + 0xF4,Float)
      set.float(damage + 0xF8,Float)
      set.float(damage + 0xFC,Float)
    else 
      return false
    end
  end;

    MODIFY_VEHICLE_TOP_SPEED = function(Value)
        Value=tonumber(Value)
        local m=(Value+100)*0.01
        writeFloat('[[[WorldPTR]+8]+D30]+AC0',Value) -- __EngineMultiplier
     
        local fInitialDragCoeff=readFloat('[[[[WorldPTR]+8]+D30]+938]+10')
        fInitialDragCoeff=fInitialDragCoeff/m
        if fInitialDragCoeff==nil or fInitialDragCoeff==0.0 then return end
        fInitialDragCoeff=tonumber(string.format('%.5f',fInitialDragCoeff))
        writeFloat('[[[WorldPTR]+8]+D30]+A48',fInitialDragCoeff)
     
        local fInitialDriveForce=readFloat('[[[[WorldPTR]+8]+D30]+938]+60')
        fInitialDriveForce=fInitialDriveForce*m
        if fInitialDriveForce==nil or fInitialDriveForce==0.0 then return end
        fInitialDriveForce=tonumber(string.format('%.5f',fInitialDriveForce))
        writeFloat('[[[WorldPTR]+8]+D30]+8A4',fInitialDriveForce)
     
        local fDriveMaxFlatVel=readFloat('[[[[WorldPTR]+8]+D30]+938]+64')
        fDriveMaxFlatVel=fDriveMaxFlatVel*m
        if fDriveMaxFlatVel==nil or fDriveMaxFlatVel==0.0 then return end
        fDriveMaxFlatVel=tonumber(string.format('%.5f',fDriveMaxFlatVel))
        writeFloat('[[[WorldPTR]+8]+D30]+8AC',fDriveMaxFlatVel)
     
        local fInitialDriveMaxFlatVel=readFloat('[[[[WorldPTR]+8]+D30]+938]+68')
        fInitialDriveMaxFlatVel=fInitialDriveMaxFlatVel*m
        if fInitialDriveMaxFlatVel==nil or fInitialDriveMaxFlatVel==0.0 then return end
        fInitialDriveMaxFlatVel=tonumber(string.format('%.5f',fInitialDriveMaxFlatVel))
        writeFloat('[[[WorldPTR]+8]+D30]+8A8',fInitialDriveMaxFlatVel)
    end;
}

FORM =
{
ADD_LOCAL = function (formname,arrayname,Item1)
  formname.Items.clear()
  formname.items.add(Item1)
  for n,l in ipairs(arrayname) do 
    local ScriptStatus = 'Killed'
    if SCRIPT.HAS_SCRIPT_LOADED(l) == true then 
      ScriptStatus = 'Running' 
    end
    formname.items.add(string.format('[%i]%s :%s',n,l,ScriptStatus))
  end
  formname.ItemIndex=0
end;

ADD_STD = function (formname,arrayname)
  formname.Items.clear()
  for k,v in pairs(arrayname) do formname.items.add(v) end
  formname.ItemIndex=0
end;

ADD_STD_2 = function (ObjeName,Arrayname,Item1)
  ObjeName.Items.clear()
  ObjeName.items.add(Item1)
  for k,v in pairs(Arrayname) do ObjeName.items.add(v) end
  ObjeName.ItemIndex=0
end;

ADD_LOOP = function (ObjeName,Arrayname,iVar)
  ObjeName.Items.clear()
  for k,v in pairs(Arrayname) do ObjeName.items.add(v[iVar]) end
  ObjeName.ItemIndex=0
end;

ADD_LOOP_2 = function (ObjeName,Arrayname,iVar,Item1)
  ObjeName.Items.clear()
  ObjeName.items.add(Item1)
  for k,v in pairs(Arrayname) do ObjeName.items.add(v[iVar]) end
  ObjeName.ItemIndex=0
end;

ADD_LOOP_3 = function (ObjeName,Arrayname,Item1)
  ObjeName.Items.clear()
  ObjeName.items.add(Item1)
  for k,v in pairs(Arrayname) do ObjeName.items.add(string.format('%s (%s)',v[2],v[4])) end
  ObjeName.ItemIndex=0
end;

ADD_ADDRESS = function(Address,Description)
  local list = getAddressList()
  local rec = list.createMemoryRecord()
  rec.setAddress(Address)
  rec.setDescription(Description)
end;

}
    
THREAD = {

func_1 = function(funcName,boolean,interval)
local isRunning = boolean;
local func = Asynchronous(function()
    while (isRunning == true) do
        funcName()
        if isRunning == false then
          isRunning = false
          break
        end
        Async();
    end
end);
AsyncStart(func,interval)
end;

YIELD = function(funcName,Trigger,Value,interval)
yield_looper = Trigger
local yielder = Asynchronous(function()
    while (yield_looper == true) do
        funcName(Value)
        if yield_looper == false then
          funcName(Value)
          yield_looper = false
          break
        end
        Async();
    end
end)
AsyncStart(yielder,interval)
end;

YIELD2 = function(funcName,Trigger,Value1,Value2,interval)
yield2 = Trigger
local yielder2 = Asynchronous(function()
    while (yield2 == true) do
        funcName(Value1,Value2)
        if yield2 == false then
          yield2 = false
          break
        end
        Async();
    end
end)
AsyncStart(yielder2,interval)
end;

LOOPING = function(funcName,Trigger,Value,interval)
  loop_running = Trigger
  local looping = Asynchronous(function()
      while (loop_running == true) do
          funcName(Value)
          if loop_running == false then
            loop_running = false
            break
          end
          Async();
      end
  end)
    AsyncStart(looping,interval)
  end;

  FUNC_1 = function(funcName,Trigger,interval)
    loop_FUNC_1 = Trigger
    local co1 = Asynchronous(function()
        while (loop_FUNC_1 == true) do
            funcName()
            if loop_FUNC_1 == false then
              loop_FUNC_1 = false
              break
            end
            Async();
        end
    end)
    AsyncStart(co1,interval)
end;

NATIVE_LOOP = function (funcName,Boolean,Interval)
    LoopStarter = Boolean
    LoopBreaker=Boolean
      function LoopRunner()
        while (LoopStarter == TRUE) do
          SYSTEM.WAIT(Interval);
           funcName()
    	    if LoopBreaker==FALSE then
            LoopStarter = FALSE
    	    break
    	  end
      end
  end
  ExecuteThread(LoopRunner);
end;

NATIVE_LOOP_2 = function (funcName,Value,Boolean,Interval)
  NATIVE_LOOP_2_Starter = Boolean
  NATIVE_LOOP_2_Breaker=Boolean
    local function NewThread()
      while (NATIVE_LOOP_2_Starter == TRUE) do
        SYSTEM.WAIT(Interval);
         funcName(Value)
        if NATIVE_LOOP_2_Breaker==FALSE then
          NATIVE_LOOP_2_Starter = FALSE
        break
      end
    end
end
ExecuteThread(NewThread);
end;

SPECIAL_NATIVE = function(func,Value,Boolean,Interval)
  SPECIAL_Starter = Boolean
  SPECIAL_Breaker=Boolean
    local function ThreadStart()
      while (SPECIAL_Starter == TRUE) do
        SYSTEM.WAIT(Interval);
         funcName(Value)
        if SPECIAL_Breaker==FALSE then
          SPECIAL_Starter = FALSE
        break
      end
    end
end
ExecuteThread(ThreadStart)
end;

SPECIAL_YIELD = function(funcName,Value,Trigger,interval)
  loop_s = Trigger
  local co1 = Asynchronous(function()
      while (loop_s == true) do
          funcName(Value)
          if loop_s == false then
            loop_s = false
            break
          end
          Async();
      end
  end);
  AsyncStart(co1,interval)
end;
};

SYSTEM = {
  WAIT = function (milisecond)
    local ntime = os.clock() + milisecond/1000
    repeat until os.clock() > ntime
  end;
}

ENTITY = {}
ENTITY.SET_ENTITY_HEALTH = function(health)
  set.float(CPlayer + 0x280, health)
end

ENTITY.GET_PLAYER_COORD = function ()
  local x = readFloat(PLAYER_CORDX)
  local y = readFloat(PLAYER_CORDY)
  local z = readFloat(PLAYER_CORDZ)
  return x,y,z
end

ENTITY.SET_ENTITY_INVINCIBLE = function (activation)
    if activation == TRUE then FLOAT = 0
    elseif activation == FALSE then FLOAT = 1 
    end
    if activation == TRUE then BELT = 0xC9
    elseif activation == FALSE then BELT = 0xC8
    end
      set.bool("[[[PED_FACTORY]+CPED]+VEH]+GOD", activation)
      set.byte(CPlayer + SEATBELT,BELT)
      set.float("[[[[PED_FACTORY]+CPED]+VEH]+HANDLING]+COL",FLOAT)
      set.float("[[[[PED_FACTORY]+CPED]+VEH]+HANDLING]+WEP_COL",FLOAT)
      set.float("[[[[PED_FACTORY]+CPED]+VEH]+HANDLING]+VEH_COL",FLOAT)
      set.float("[[[[PED_FACTORY]+CPED]+VEH]+HANDLING]+ENGINE_COL",FLOAT)
      set.float("[[[PED_FACTORY]+CPED]+VEH]+HP","1000")
      set.float("[[[PED_FACTORY]+CPED]+VEH]+VEH_HP1","1000")
      set.float("[[[PED_FACTORY]+CPED]+VEH]+VEH_HP2","1000")
      set.float("[[[PED_FACTORY]+CPED]+VEH]+VEH_HP3","1000")
    end


ENTITY.f_Round = function(float,digits) 
  return string.format("%."..digits.."f",float);
end


ENTITY.GET_ENTITY_COORD = function(digits)
    local coord = digits
    local arr_coord = {}
    if coord == PLAYER.PLAYER_PED_ID() then
      return ENTITY.GET_ENTITY_COORD(3)
    end
    local CPlayer = get.Ptr(get.Ptr("WorldPTR") + 0x8)
    local Nav = get.Ptr(CPlayer + 0x30)
    local x=ENTITY.f_Round(get.Float(Nav + 0x50),digits)
    local y=ENTITY.f_Round(get.Float(Nav + 0x54),digits)
    local z=ENTITY.f_Round(get.Float(Nav + 0x58),digits)
    return x,y,z
end --[[//print(f_GetCoords(2))]]


ENTITY.SET_ENTITY_COORD = function(x,y,z) 

    local CPlayer = get.Ptr(get.Ptr("WorldPTR")+ 0x8)
    if (2 == get.Int(CPlayer + 0x148C))
    then
      CPlayer = get.Ptr(CPlayer + 0xD30)
    end
    local Nav = get.Ptr(CPlayer+0x30)

    set.float(Nav + 0x50,x)
    set.float(Nav + 0x54,y)
    set.float(Nav + 0x58,z)
    set.float(CPlayer + 0x90,x)
    set.float(CPlayer + 0x94,y)
    set.float(CPlayer + 0x98,z)
end



_MyFilePath='';
if TrainerOrigin~=nil then 
  _MyFilePath=TrainerOrigin 
else 
  _MyFilePath=getCheatEngineDir();
end

ENTITY.SAVE_ENTITY_CORD = function ()
  local x,y,z,LocationName,vtbl='','','','',''
  LocationName=tostring(Struct.SaveTeleportName.Text)
  --inputQuery('Save Teleport Location','Enter Location Name','')
  if LocationName==nil or LocationName=='' then return end
  x,y,z=ENTITY.GET_ENTITY_COORD(PLAYER.PLAYER_PED_ID())
  local fs=assert(io.open(string.format('%s/Teleport Locations.txt',_MyFilePath), "a+"));
  vtbl=string.format('%s x:%s, y:%s, z:%s\n',LocationName,x,y,z)
  fs:write(vtbl);
  fs:close();
end


 function ENTITY.GET_LOCATION()
  local x,y,z,LocationName,vtbl,tbl_Locations='','','','','',{}
  local fs=assert(io.open(string.format('%s/Teleport Locations.txt',_MyFilePath), "r"));
  for c=1,200,1 do
    local line=fs:read("*line")
    if line==nil or line=='' then goto continue; end
    local ls1,ls2=string.find(line,' x:')
    local ls3,ls4=string.find(line,', y:')
    local ls5,ls6=string.find(line,', z:')
    local sbn,sbx,sby,sbz=string.sub(line,1,ls1-1),string.sub(line,ls2+1,ls3-1),string.sub(line,ls4+1,ls5-1),string.sub(line,ls6+1,string.len(line))
    table.insert(tbl_Locations,c,{sbn,sbx,sby,sbz})
  end
  ::continue::
  fs:close();
    return tbl_Locations
end

function READ_POS()
  local x,y,z,LocationName,vtbl,cord_arr='','','','','',{}
  local tdata=assert(io.open(string.format('%s/coordinates.vpl',_MyFilePath), "r"));
  for c=1,200,1 do
    local line=tdata:read("*line")
    if line==nil or line=='' then goto continue; end
    local ls1,ls2=string.find(line,' x:')
    local ls3,ls4=string.find(line,', y:')
    local ls5,ls6=string.find(line,', z:')
    local sbn,sbx,sby,sbz=string.sub(line,1,ls1-1),string.sub(line,ls2+1,ls3-1),string.sub(line,ls4+1,ls5-1),string.sub(line,ls6+1,string.len(line))
    table.insert(cord_arr,c,{sbn,sbx,sby,sbz})
  end
  ::continue::
  tdata:close();
    return cord_arr
end



function ENTITY.SET_CORD(to,x,y,z,yaw)
   local a = hook.GET("BlipPTR")
   -- Waypoint
   if to == 'w' then
   for i = 2000, 1, -1
   do
     local n = get.Ptr(a + (i * 8))
     if (n > 0) and (8 == get.Int(n + 0x40)) and (84 == get.Int(n + 0x48))
     then
        local x = get.Float(n + 0x10)
        local y = get.Float(n + 0x14)
        local p = get.Ptr(get.Ptr(hook.GET("WorldPTR")) + CPED)
        if (1 == get.Bool(p + IN_VEH2, 1, false))
        then
          p = get.Ptr(p + VEH)
        end
        local v = get.Ptr(p + 0x30)
        set.float(v + 0x50, x)
        set.float(v + 0x54, y)
        set.float(v + 0x58, -255)
        set.float(p + 0x90, x)
        set.float(p + 0x94, y)
        set.float(p + 0x98, -255)
     end
   end
end
   -- Objective
   if to == 'o' then
   for i = 2000, 1, -1
   do
    local n = get.Ptr(a + (i * 8))
    if (n > 0) and (1 == get.Int(n + 0x40)) and ((5 == get.Int(n + 0x48)) or (60 == get.Int(n + 0x48)) or (66 == get.Int(n + 0x48)))
      then
      local x = get.Float(n + 0x10)
      local y = get.Float(n + 0x14)
      local z = get.Float(n + 0x18) + 0.1
      local p = get.Ptr(get.Ptr(hook.GET("WorldPTR")) + CPED)
      if (1 == get.Bool(p + IN_VEH2, 1, false))
      then
        p = get.Ptr(p + VEH)
      end
      local v = get.Ptr(p + POS)
      set.float(v + CORDX, x)
      set.float(v + CORDY, y)
      set.float(v + CORDZ, z)
      set.float(p + VECX, x)
      set.float(p + VECY, y)
      set.float(p + VECZ, z)
      break
    end
  end
end
  -- Blip NORTH = ENTITY.SET_CORD('i',7)
  if to == 'i' then
   for i = 2000, 1, -1
   do
    local n = get.Ptr(a + (i * 8))
    if (n > 0) and (x == get.Int(n + 0x40)) then
      local x = get.Float(n + 0x10)
      local y = get.Float(n + 0x14)
      local z = get.Float(n + 0x18) + 0.1
      local p = get.Ptr(get.Ptr(hook.GET("WorldPTR")) + CPED)
      if (1 == get.Bool(p + IN_VEH2, 1, false))
      then
        p = get.Ptr(p + VEH)
      end
      local v = get.Ptr(p + POS)
      set.float(v + CORDX, x)
      set.float(v + CORDY, y)
      set.float(v + CORDZ, z)
      set.float(p + VECX, x)
      set.float(p + VECY, y)
      set.float(p + VECZ, z)
      break
    end
  end
end
  -- Custom Coords
  if to == 'c' then
    local z = z + 0.03
    local p = get.Ptr(get.Ptr(hook.GET("WorldPTR")) + CPED)
    if (1 == get.Bool(p + IN_VEH2, 1, false)) then
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
  -- Forward
  if to == 'f' then
    local p = get.Ptr(get.Ptr(hook.GET("WorldPTR")) + CPED)
    if (1 == get.Bool(p + IN_VEH2, 1, false)) then
      p = get.Ptr(p + VEH)
    end
    local v = get.Ptr(p + POS)
    local head = get.Float(v + HEADX)
    local head2 = get.Float(v + HEADY)
    local x = get.Float(v + CORDX)
    local y = get.Float(v + CORDY)
    local newx = x -(head2*3)
    local newy = y +(head*3)
    set.float(v + CORDX, newx)
    set.float(v + CORDY, newy)
    set.float(p + VECX, newx)
    set.float(p + VECY, newy)
  end
  -- Last Vehicle
  if to == 'v' then
    local p = get.Ptr(get.Ptr(hook.GET("WorldPTR")) + CPED)
    local v = get.Ptr(p + POS)
    local CVehicle = get.Ptr(p + VEH)
    local CVNavigation = get.Ptr(CVehicle + POS)
    local x = get.Float(CVNavigation + CORDX)
    local y = get.Float(CVNavigation + CORDY)
    local z = get.Float(CVNavigation + CORDZ) + 0.5
    set.float(v + CORDX, x)
    set.float(v + CORDY, y)
    set.float(v + CORDZ, z)
    set.float(p + VECX, x)
    set.float(p + VECY, y)
    set.float(p + VECZ, z)
  end
end
------------------ENTITY PART END---------------------------------------------------------------------------------

function hooking(Name,Location,Boolean)
  registerSymbol(Name,Location,Boolean)
end

function CleanLocalScript(t)
  cleanedlocals = {}
  for k, v in pairs(t)do
      if (SCRIPT.HAS_SCRIPT_LOADED(v) == true) then
          table.insert(cleanedlocals, v)
      end
      SYSTEM.WAIT(15)
  end
  return cleanedlocals
end

--return ReadMemory<DWORD64>(phandle, (Base + GlobalPTR) + (8 * (AtIndex >> 0x12 & 0x3F))) + (8 * (AtIndex & 0x3FFFF));




