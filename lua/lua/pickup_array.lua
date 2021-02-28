require("joaat")
WEP_LIST = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,
36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55}
tbl_pickup_hash = {
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_ADVANCEDRIFLE"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_APPISTOL"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_ASSAULTRIFLE"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_ASSAULTRIFLE_MK2"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_ASSAULTSHOTGUN"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_ASSAULTSMG"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_BALL"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_BAT"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_BATTLEAXE"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_BOTTLE"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_BULLPUPRIFLE"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_BULLPUPRIFLE_MK2"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_BULLPUPSHOTGUN"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_BZGAS"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_CARBINERIFLE"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_CARBINERIFLE_MK2"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_COMBATMG"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_COMBATMG_MK2"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_COMBATPDW"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_COMBATPISTOL"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_COMPACTLAUNCHER"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_COMPACTRIFLE"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_CROWBAR"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_DAGGER"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_DOUBLEACTION"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_FIREEXTINGUISHER"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_FIREWORK"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_FLARE"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_FLAREGUN"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_FLASHLIGHT"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_GOLFCLUB"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_GRENADE"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_GRENADELAUNCHER"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_GRENADELAUNCHER_SMOKE"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_GUSENBERG"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_HAMMER"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_HATCHET"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_HEAVYPISTOL"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_HEAVYSHOTGUN"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_HEAVYSNIPER"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_HEAVYSNIPER_MK2"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_HOMINGLAUNCHER"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_KNIFE"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_KNUCKLE"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_MACHETE"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_LASSO"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_LOUDHAILER"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_MACHINEPISTOL"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_MARKSMANPISTOL"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_MARKSMANRIFLE"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_MARKSMANRIFLE_MK2"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_MG"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_MICROSMG"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_MINIGUN"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_MINISMG"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_MOLOTOV"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_MUSKET"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_NIGHTSTICK"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_PETROLCAN"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_PIPEBOMB"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_PISTOL50"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_PISTOL"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_PISTOL_MK2"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_POOLCUE"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_PROXMINE"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_PUMPSHOTGUN"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_PUMPSHOTGUN_MK2"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_RAILGUN"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_RAYCARBINE"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_RAYPISTOL"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_RAYMINIGUN"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_REVOLVER"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_REVOLVER_MK2"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_RPG"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_SAWNOFFSHOTGUN"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_SMG"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_SMG_MK2"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_SMOKEGRENADE"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_SNIPERRIFLE"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_SNOWBALL"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_SNSPISTOL"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_SNSPISTOL_MK2"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_SPECIALCARBINE"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_SPECIALCARBINE_MK2"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_STICKYBOMB"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_STINGER"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_STONE_HATCHET"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_STUNGUN"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_SWITCHBLADE"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_UNARMED"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_VINTAGEPISTOL"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_WRENCH"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_MILITARYRIFLE"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_COMBATSHOTGUN"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_GADGETPISTOL"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_PARACHUTE"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_ARMOUR_STANDARD"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_HEALTH_STANDARD"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_VEHICLE_WEAPON_PISTOL"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_VEHICLE_WEAPON_COMBATPISTOL"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_VEHICLE_WEAPON_APPISTOL"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_VEHICLE_WEAPON_MICROSMG"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_VEHICLE_WEAPON_SMG"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_VEHICLE_WEAPON_SAWNOFF"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_VEHICLE_WEAPON_GRENADE"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_VEHICLE_WEAPON_MOLOTOV"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_VEHICLE_WEAPON_SMOKEGRENADE"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_VEHICLE_WEAPON_STICKYBOMB"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_VEHICLE_HEALTH_STANDARD"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_VEHICLE_ARMOUR_STANDARD"),
}
--[[    GAMEPLAY.GET_HASH_KEY("PICKUP_MONEY_CASE"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_MONEY_DEP_BAG"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_MONEY_MED_BAG"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_MONEY_PAPER_BAG"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_PORTABLE_CRATE_UNFIXED"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_PORTABLE_PACKAGE"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_MONEY_CASE"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_AMMO_BULLET_MP"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_AMMO_MISSILE_MP"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_CAMERA"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_CUSTOM_SCRIPT"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_HANDCUFF_KEY"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_HEALTH_SNACK"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_MONEY_PURSE"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_MONEY_SECURITY_CASE"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_MONEY_VARIABLE"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_MONEY_WALLET"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_SUBMARINE"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_TYPE_INVALID"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_MONEY_WALLET"),
    GAMEPLAY.GET_HASH_KEY("PICKUP_VEHICLE_CUSTOM_SCRIPT"),]]
all_weapon_dropper = {
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_ADVANCEDRIFLE"),GAMEPLAY.GET_HASH_KEY("w_ar_advancedrifle")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_APPISTOL"),GAMEPLAY.GET_HASH_KEY("w_pi_appistol")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_ASSAULTRIFLE"),GAMEPLAY.GET_HASH_KEY("w_ar_assaultrifle")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_ASSAULTRIFLE_MK2"),GAMEPLAY.GET_HASH_KEY("w_ar_assaultrifle")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_ASSAULTSHOTGUN"),GAMEPLAY.GET_HASH_KEY("w_sg_assaultshotgun")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_ASSAULTSMG"),GAMEPLAY.GET_HASH_KEY("w_sb_assaultsmg")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_BALL"),GAMEPLAY.GET_HASH_KEY("w_am_baseball")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_BAT"),GAMEPLAY.GET_HASH_KEY("w_me_bat")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_BATTLEAXE"),GAMEPLAY.GET_HASH_KEY("w_am_brfcase")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_BOTTLE"),GAMEPLAY.GET_HASH_KEY("w_me_bottle")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_BULLPUPRIFLE"),GAMEPLAY.GET_HASH_KEY("w_ar_bullpuprifle")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_BULLPUPRIFLE_MK2"),GAMEPLAY.GET_HASH_KEY("w_ar_bullpuprifle")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_BULLPUPSHOTGUN"),GAMEPLAY.GET_HASH_KEY("w_sg_bullpupshotgun")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_BZGAS"),GAMEPLAY.GET_HASH_KEY("w_ex_grenadesmoke")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_CARBINERIFLE"),GAMEPLAY.GET_HASH_KEY("w_ar_carbinerifle")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_CARBINERIFLE_MK2"),GAMEPLAY.GET_HASH_KEY("w_ar_carbinerifle")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_COMBATMG"),GAMEPLAY.GET_HASH_KEY("w_mg_combatmg")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_COMBATMG_MK2"),GAMEPLAY.GET_HASH_KEY("w_mg_combatmg")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_COMBATPDW"),GAMEPLAY.GET_HASH_KEY("w_am_brfcase")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_COMBATPISTOL"),GAMEPLAY.GET_HASH_KEY("w_pi_combatpistol")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_COMPACTLAUNCHER"),GAMEPLAY.GET_HASH_KEY("w_am_brfcase")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_COMPACTRIFLE"),GAMEPLAY.GET_HASH_KEY("w_am_brfcase")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_CROWBAR"),GAMEPLAY.GET_HASH_KEY("w_me_crowbar")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_DAGGER"),GAMEPLAY.GET_HASH_KEY("w_me_dagger")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_DOUBLEACTION"),GAMEPLAY.GET_HASH_KEY("w_am_brfcase")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_FIREEXTINGUISHER"),GAMEPLAY.GET_HASH_KEY("w_am_fire_exting")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_FIREWORK"),GAMEPLAY.GET_HASH_KEY("w_lr_firework")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_FLARE"),GAMEPLAY.GET_HASH_KEY("w_am_flare")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_FLAREGUN"),GAMEPLAY.GET_HASH_KEY("w_pi_flaregun")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_FLASHLIGHT"),GAMEPLAY.GET_HASH_KEY("w_me_flashlight")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_GOLFCLUB"),GAMEPLAY.GET_HASH_KEY("w_me_gclub")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_GRENADE"),GAMEPLAY.GET_HASH_KEY("w_ex_grenadefrag")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_GRENADELAUNCHER"),GAMEPLAY.GET_HASH_KEY("w_lr_grenadelauncher")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_GRENADELAUNCHER_SMOKE"),GAMEPLAY.GET_HASH_KEY("w_lr_grenadelauncher")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_GUSENBERG"),GAMEPLAY.GET_HASH_KEY("w_sb_gusenberg")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_HAMMER"),GAMEPLAY.GET_HASH_KEY("w_me_hammer")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_HATCHET"),GAMEPLAY.GET_HASH_KEY("w_me_hatchet")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_HEAVYPISTOL"),GAMEPLAY.GET_HASH_KEY("w_pi_heavypistol")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_HEAVYSHOTGUN"),GAMEPLAY.GET_HASH_KEY("w_sg_heavyshotgun")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_HEAVYSNIPER"),GAMEPLAY.GET_HASH_KEY("w_sr_heavysniper")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_HEAVYSNIPER_MK2"),GAMEPLAY.GET_HASH_KEY("w_sr_heavysniper")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_HOMINGLAUNCHER"),GAMEPLAY.GET_HASH_KEY("w_lr_homing")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_KNIFE"),GAMEPLAY.GET_HASH_KEY("w_me_knife_01")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_KNUCKLE"),GAMEPLAY.GET_HASH_KEY("w_am_brfcase")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_MACHETE"),GAMEPLAY.GET_HASH_KEY("prop_ld_w_me_machette")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_MACHINEPISTOL"),GAMEPLAY.GET_HASH_KEY("w_sb_machinepistol")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_MARKSMANPISTOL"),GAMEPLAY.GET_HASH_KEY("w_pi_marksmanpistol")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_MARKSMANRIFLE"),GAMEPLAY.GET_HASH_KEY("w_sr_marksmanrifle")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_MARKSMANRIFLE_MK2"),GAMEPLAY.GET_HASH_KEY("w_sr_marksmanrifle")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_MG"),GAMEPLAY.GET_HASH_KEY("w_mg_mg")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_MICROSMG"),GAMEPLAY.GET_HASH_KEY("w_sb_microsmg")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_MINIGUN"),GAMEPLAY.GET_HASH_KEY("w_mg_minigun")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_MINISMG"),GAMEPLAY.GET_HASH_KEY("w_sb_minismg")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_MOLOTOV"),GAMEPLAY.GET_HASH_KEY("w_ex_molotov")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_MUSKET"),GAMEPLAY.GET_HASH_KEY("w_ar_musket")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_NIGHTSTICK"),GAMEPLAY.GET_HASH_KEY("w_me_nightstick")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_PETROLCAN"),GAMEPLAY.GET_HASH_KEY("w_am_jerrycan")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_PIPEBOMB"),GAMEPLAY.GET_HASH_KEY("w_ex_pipebomb")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_PISTOL50"),GAMEPLAY.GET_HASH_KEY("w_pi_pistol50")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_PISTOL"),GAMEPLAY.GET_HASH_KEY("w_pi_pistol")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_PISTOL_MK2"),GAMEPLAY.GET_HASH_KEY("w_pi_pistol")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_POOLCUE"),GAMEPLAY.GET_HASH_KEY("w_am_brfcase")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_PROXMINE"),GAMEPLAY.GET_HASH_KEY("w_ex_apmine")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_PUMPSHOTGUN"),GAMEPLAY.GET_HASH_KEY("w_sg_pumpshotgun")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_PUMPSHOTGUN_MK2"),GAMEPLAY.GET_HASH_KEY("w_sg_pumpshotgun")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_RAILGUN"),GAMEPLAY.GET_HASH_KEY("w_ar_railgun")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_RAYCARBINE"),GAMEPLAY.GET_HASH_KEY("prop_space_pistol")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_RAYPISTOL"),GAMEPLAY.GET_HASH_KEY("w_am_brfcase")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_RAYMINIGUN"),GAMEPLAY.GET_HASH_KEY("prop_space_rifle")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_REVOLVER"),GAMEPLAY.GET_HASH_KEY("w_pi_revolver")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_REVOLVER_MK2"),GAMEPLAY.GET_HASH_KEY("w_pi_revolver")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_RPG"),GAMEPLAY.GET_HASH_KEY("w_lr_rpg")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_SAWNOFFSHOTGUN"),GAMEPLAY.GET_HASH_KEY("w_sg_sawnoff")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_SMG"),GAMEPLAY.GET_HASH_KEY("w_sb_smg")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_SMG_MK2"),GAMEPLAY.GET_HASH_KEY("w_sb_smg")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_SMOKEGRENADE"),GAMEPLAY.GET_HASH_KEY("w_ex_grenadesmoke")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_SNIPERRIFLE"),GAMEPLAY.GET_HASH_KEY("w_sr_sniperrifle")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_SNOWBALL"),GAMEPLAY.GET_HASH_KEY("w_ex_snowball")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_SNSPISTOL"),GAMEPLAY.GET_HASH_KEY("w_pi_sns_pistol")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_SNSPISTOL_MK2"),GAMEPLAY.GET_HASH_KEY("w_pi_sns_pistol")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_SPECIALCARBINE"),GAMEPLAY.GET_HASH_KEY("w_ar_specialcarbine")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_SPECIALCARBINE_MK2"),GAMEPLAY.GET_HASH_KEY("w_ar_specialcarbine")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_STICKYBOMB"),GAMEPLAY.GET_HASH_KEY("w_ex_pe")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_STINGER"),GAMEPLAY.GET_HASH_KEY("w_am_brfcase")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_STONE_HATCHET"),GAMEPLAY.GET_HASH_KEY("w_am_brfcase")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_STUNGUN"),GAMEPLAY.GET_HASH_KEY("w_pi_stungun")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_SWITCHBLADE"),GAMEPLAY.GET_HASH_KEY("w_am_brfcase")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_UNARMED"),GAMEPLAY.GET_HASH_KEY("w_am_brfcase")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_VINTAGEPISTOL"),GAMEPLAY.GET_HASH_KEY("w_pi_vintage_pistol")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_WRENCH"),GAMEPLAY.GET_HASH_KEY("w_am_brfcase")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_ARMOUR_STANDARD"),GAMEPLAY.GET_HASH_KEY("prop_armour_pickup")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_HEALTH_STANDARD"),GAMEPLAY.GET_HASH_KEY("prop_ld_health_pack")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_PARACHUTE"),GAMEPLAY.GET_HASH_KEY("prop_parachute")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_HEALTH_SNACK"),GAMEPLAY.GET_HASH_KEY("w_am_brfcase")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_CUSTOM_SCRIPT"),GAMEPLAY.GET_HASH_KEY("w_am_brfcase")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_MILITARYRIFLE"),GAMEPLAY.GET_HASH_KEY("w_am_brfcase")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_COMBATSHOTGUN"),GAMEPLAY.GET_HASH_KEY("w_am_brfcase")},
    {GAMEPLAY.GET_HASH_KEY("PICKUP_WEAPON_GADGETPISTOL"),GAMEPLAY.GET_HASH_KEY("w_am_brfcase")},
}