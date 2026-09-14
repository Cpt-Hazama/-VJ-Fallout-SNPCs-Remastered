if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel					= "models/fallout/weapons/w_sawedoffshotgun.mdl"
SWEP.PrintName					= "Sawed-Off Shotgun"
SWEP.AnimationType 						= "1hp"
SWEP.PHoldType 							= "pistol"
SWEP.Slot 								= (SWEP.AnimationType == "1gt" && 4 or SWEP.AnimationType == "1hm" && 0 or SWEP.AnimationType == "2hm" && 0 or SWEP.AnimationType == "2ha" && 2 or SWEP.AnimationType == "2hh" && 3 or SWEP.AnimationType == "2hl" && 4 or SWEP.AnimationType == "2hr" && 2 or SWEP.AnimationType == "1hp" && 1 or SWEP.AnimationType == "1md" && 4) or 1
SWEP.NPC_NextPrimaryFire 		= 0.5 -- Next time it can use primary fire
SWEP.NPC_CustomSpread	 		= 1.75
SWEP.NPC_TimeUntilFire	 		= 0 -- How much time until the bullet/projectile is fired?
SWEP.NPC_TimeUntilFireExtraTimers = {} -- Extra timers, which will make the gun fire again! | The seconds are counted after the self.NPC_TimeUntilFire!
SWEP.Primary.Damage				= 7 -- Damage
SWEP.Primary.ClipSize			= 2 -- Max amount of bullets per clip
SWEP.Primary.NumberOfShots		= 14
SWEP.Primary.Delay						= 0.5
SWEP.Primary.Automatic					= false

SWEP.AnimTbl_Deploy 					= {ACT_VM_DEPLOY_1}
SWEP.AnimTbl_Idle 						= {ACT_VM_IDLE_1}
SWEP.AnimTbl_PrimaryFire 				= {"1hpattack4"}
SWEP.AnimTbl_Reload 					= {"1hpreloadb"}

SWEP.NPC_EquipSound 			= "vj_fallout/weapons/combatshotgun/shotguncombat_equip.wav"
SWEP.NPC_UnequipSound 			= "vj_fallout/weapons/combatshotgun/wpn_shotguncombat_equip.wav"
SWEP.NPC_ReloadSound 			= {"vj_fallout/weapons/shotgunsawed/sawedoffshotgun_reloadpt2.wav"}
SWEP.Primary.Sound				= {"vj_fallout/weapons/shotgunsawed/sawedoffshotgun_fire_2d01.wav","vj_fallout/weapons/shotgunsawed/sawedoffshotgun_fire_2d02.wav"}
SWEP.Primary.DistantSound		= {"vj_fallout/weapons/shotgunsawed/sawedoffshotgun_fire_3d01.wav","vj_fallout/weapons/shotgunsawed/sawedoffshotgun_fire_3d02.wav"}
SWEP.PrimaryEffects_MuzzleAttachment = "muzzle"
SWEP.Primary.TracerType 			= "vj_fo3_tracer"
SWEP.PrimaryEffects_MuzzleParticles = {"muzzleflash_shotgun"}
---------------------------------------------------------------------------------------------------------------------------------------------

SWEP.WorldModel_CustomPositionAngle 	= Vector(80,5,270)
SWEP.WorldModel_CustomPositionOrigin 	= Vector(-3.6,0,-1.2)
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base 						= "weapon_vj_f3r_base"
SWEP.Author 					= "Cpt. Hazama"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players and NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "VJ Base - Fallout: Remastered"
SWEP.Spawnable 					= true
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnReload()
	self:PlayWeaponSoundTimed(self.NPC_ReloadSound,0)
end
