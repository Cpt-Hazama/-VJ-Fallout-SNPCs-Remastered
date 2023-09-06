if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel					= "models/fallout/weapons/w_teslacannonproto.mdl"
SWEP.PrintName					= "Tesla Cannon"
SWEP.HoldType 					= "2hl"
-- SWEP.ID 						= ITEM_VJ_10MMPISTOL
SWEP.AnimationType 				= SWEP.HoldType
SWEP.NPC_NextPrimaryFire 		= 3 -- Next time it can use primary fire
SWEP.NPC_CustomSpread	 		= 0
SWEP.NPC_TimeUntilFire	 		= 0 -- How much time until the bullet/projectile is fired?
SWEP.NPC_TimeUntilFireExtraTimers = {} -- Extra timers, which will make the gun fire again! | The seconds are counted after the self.NPC_TimeUntilFire!
SWEP.Primary.Damage				= 200 -- Damage
SWEP.Primary.ClipSize			= 1 -- Max amount of bullets per clip
SWEP.NPC_EquipSound 			= "vj_fallout/weapons/assaultrifle/rifleassault_equip.wav"
SWEP.NPC_UnequipSound 			= "vj_fallout/weapons/assaultrifle/rifleassault_unequip.wav"
SWEP.NPC_ReloadSound			= {"vj_fallout/weapons/teslacannon/teslacannon_jam.wav"}
SWEP.Primary.Sound				= {"vj_fallout/weapons/teslacannon/teslacannon_fire_2d01.wav","vj_fallout/weapons/teslacannon/teslacannon_fire_2d02.wav"}
SWEP.Primary.DistantSound		= {"vj_fallout/weapons/teslacannon/teslacannon_fire_3d01.wav","vj_fallout/weapons/teslacannon/teslacannon_fire_3d02.wav"}
SWEP.PrimaryEffects_MuzzleAttachment = "muzzle"
SWEP.Primary.TracerType			= "vj_fo3_tesla"
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base 						= "weapon_vj_f3r_base"
SWEP.Author 					= "Cpt. Hazama"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players and NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "VJ Base - Fallout: Remastered"
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.MadeForNPCsOnly 			= true -- Is tihs weapon meant to be for NPCs only?
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Force				= 1 -- Force applied on the object the bullet hits
SWEP.Primary.Ammo				= "Pistol" -- Ammo type
SWEP.PrimaryEffects_MuzzleFlash = false
SWEP.PrimaryEffects_SpawnShells = false