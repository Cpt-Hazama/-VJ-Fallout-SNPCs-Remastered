if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel					= "models/cpthazama/fallout/weapons/w_lincolnrifle.mdl"
SWEP.PrintName					= "Lincoln's Rifle"
SWEP.ID 						= 00000000
SWEP.AnimationType 				= "2hr_bolt"
SWEP.NPC_NextPrimaryFire 		= 1.75 -- Next time it can use primary fire
SWEP.NPC_CustomSpread	 		= 0.8
SWEP.NPC_TimeUntilFire	 		= 0 -- How much time until the bullet/projectile is fired?
SWEP.NPC_TimeUntilFireExtraTimers = {} -- Extra timers, which will make the gun fire again! | The seconds are counted after the self.NPC_TimeUntilFire!
SWEP.Primary.Damage				= 37 -- Damage
SWEP.Primary.ClipSize			= 15 -- Max amount of bullets per clip
SWEP.NPC_EquipSound 			= "vj_fallout/weapons/assaultrifle/rifleassault_equip.wav"
SWEP.NPC_UnequipSound 			= "vj_fallout/weapons/assaultrifle/rifleassault_unequip.wav"
SWEP.NPC_ReloadSound			= {"vj_fallout/weapons/lincoln/wpn_riflelincolns_reload.wav"}
SWEP.NPC_ExtraFireSound			= {"vj_fallout/weapons/lincoln/wpn_riflelincolns_chamber.wav"}
SWEP.NPC_ExtraFireSoundTime		= 0.55
SWEP.Primary.Sound				= {"vj_fallout/weapons/lincoln/wpn_riflelincolns_fire_2d.wav"}
SWEP.Primary.DistantSound		= {"vj_fallout/weapons/lincoln/wpn_riflelincolns_fire_3d.wav"}
SWEP.PrimaryEffects_MuzzleAttachment = "muzzle"
SWEP.Primary.TracerType 			= "vj_fo3_tracer"
SWEP.PrimaryEffects_MuzzleParticles = {"muzzleflash_1"}
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base 						= "weapon_vj_f3r_base"
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
SWEP.HoldType 					= "2hr_bolt"