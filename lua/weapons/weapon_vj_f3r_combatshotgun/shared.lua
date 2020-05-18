if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel					= "models/fallout/weapons/w_combatshotgun.mdl"
SWEP.PrintName					= "Combat Shotgun"
SWEP.ID 						= ITEM_VJ_COMBATSHOTGUN
SWEP.AnimationType 				= "2ha"
SWEP.NPC_NextPrimaryFire 		= 0.85 -- Next time it can use primary fire
SWEP.NPC_CustomSpread	 		= 1.75
SWEP.NPC_TimeUntilFire	 		= 0 -- How much time until the bullet/projectile is fired?
SWEP.NPC_TimeUntilFireExtraTimers = {} -- Extra timers, which will make the gun fire again! | The seconds are counted after the self.NPC_TimeUntilFire!
SWEP.Primary.Damage				= 3 -- Damage
SWEP.Primary.ClipSize			= 12 -- Max amount of bullets per clip
SWEP.Primary.NumberOfShots		= 8
SWEP.NPC_EquipSound 			= "vj_fallout/weapons/combatshotgun/shotguncombat_equip.wav"
SWEP.NPC_UnequipSound 			= "vj_fallout/weapons/combatshotgun/wpn_shotguncombat_equip.wav"
SWEP.NPC_ReloadSound 			= {"vj_fallout/weapons/combatshotgun/shotguncombat_reload.wav"}
SWEP.Primary.Sound				= {"vj_fallout/weapons/combatshotgun/shotguncombat_fire_2d.wav"}
SWEP.Primary.DistantSound		= {"vj_fallout/weapons/combatshotgun/shotguncombat_fire_3d.wav"}
SWEP.PrimaryEffects_MuzzleAttachment = "muzzle"
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base 						= "weapon_vj_base"
SWEP.Author 					= "Cpt. Hazama"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players and NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "VJ Base - Fallout: Remastered"
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.MadeForNPCsOnly 			= true -- Is tihs weapon meant to be for NPCs only?
	-- World Model ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel_UseCustomPosition = false -- Should the gun use custom position? This can be used to fix guns that are in the crotch
SWEP.WorldModel_CustomPositionAngle = Vector(-10,0,180)
SWEP.WorldModel_CustomPositionOrigin = Vector(-1,11.3,1)
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Force				= 1 -- Force applied on the object the bullet hits
SWEP.Primary.Ammo				= "Pistol" -- Ammo type
SWEP.PrimaryEffects_SpawnShells = false
SWEP.HoldType 					= "2ha"