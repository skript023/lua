require("STATS")
require("EXP_TABLE")
require("ptr_string")
SystemCall ={}

function SystemCall.Admin_Set_Rank(iParam0)
    local MPX = get.Global(int,1312763)
    STATS.STAT_SET_INT("MP"..MPX.."_CHAR_SET_RP_GIFT_ADMIN",iParam0)
    print(string.format("Player Rank Have Been Changed To %s",iParam0))
end

SystemCall.Take_All = function (iParam0)
    set.int(TAKE_ALL,iParam0)
end

SystemCall.All_Cut = function (iParam0)
    set.int(CASINO_CUT_1,iParam0)
    set.int(CASINO_CUT_2,iParam0)
    set.int(CASINO_CUT_3,iParam0)
    set.int(CASINO_CUT_4,iParam0)
    set.int(DOOMSDAY_CUT_1,iParam0)
    set.int(DOOMSDAY_CUT_2,iParam0)
    set.int(DOOMSDAY_CUT_3,iParam0)
    set.int(DOOMSDAY_CUT_4,iParam0)
    set.int(APT_CUT_1,iParam0)
    set.int(APT_CUT_2,iParam0)
    set.int(APT_CUT_3,iParam0)
    set.int(APT_CUT_4,iParam0)
    set.int(CPERICO_1,iParam0)
    set.int(CPERICO_2,iParam0)
    set.int(CPERICO_3,iParam0)
    set.int(CPERICO_4,iParam0)
end

SystemCall.Entity_Invincible = function (bParam0)
    local Trigger = bParam
    if bParam == true then
        PLAYERS.SET_PLAYER_INVINCIBLE(true)
        print("Entity Invincible : True")
    elseif bParam == false then
        PLAYERS.SET_PLAYER_INVINCIBLE(false)
        print("Entity Invincible : False")
    else
        print("Wrong Parameter!")
    end
end

SystemCall.Nc_Popularity = function (iParam0)
    local MPX = get.Global(int,1312763)
    STATS.STAT_SET_INT("MP"..MPX.."_CLUB_POPULARITY",iParam0)
    print("Nightclub Popularity Have Increase By:",iParam0)
end

function SystemCall.Change_Gender()
    STATS.STAT_SET_INT('MP'..MPX..'_ALLOW_GENDER_CHANGE',52)
    print("Change Your Appearance!")
end

SystemCall.Mc_Delivery = function (iParam1)
    set.int(DEL_CASH,iParam1)
    set.int(DEL_COKE,iParam1)
    set.int(DEL_DOC,iParam1)
    set.int(DEL_WEED,iParam1)
    set.int(DEL_FLY,iParam1)
end

SystemCall.Ceo_Delivery = function (iParam1)
    set.int(DEL_CARGO,iParam1)
end

SystemCall.Bkr_Delivery = function (iParam1)
    set.int("[[GlobalPTR-128]+1180]+3F68", iParam1)
end

SystemCall.Hangar_Delivery = function (iParam1)
    set.int(DEL_HANGAR, iParam1)
end

