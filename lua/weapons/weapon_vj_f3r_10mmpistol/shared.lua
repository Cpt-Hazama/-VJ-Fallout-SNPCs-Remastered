if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel							= "models/fallout/weapons/w_10mmpistol.mdl"
SWEP.PrintName							= "10mm Pistol"
SWEP.AnimationType 						= "1hp"
SWEP.PHoldType 							= "pistol"

SWEP.WorldModel_CustomPositionAngle 	= Vector(80,5,270)
SWEP.WorldModel_CustomPositionOrigin 	= Vector(-3.6,0,-1.2)

SWEP.NPC_NextPrimaryFire 				= 0.245
SWEP.NPC_CustomSpread	 				= 0.8
SWEP.NPC_TimeUntilFire	 				= 0
SWEP.NPC_TimeUntilFireExtraTimers 		= {}

SWEP.Primary.Damage						= 9
SWEP.Primary.ClipSize					= 12
SWEP.Primary.Automatic = false

SWEP.AnimTbl_Deploy 					= {ACT_VM_DEPLOY_1}
SWEP.AnimTbl_Idle 						= {ACT_VM_IDLE_1}
SWEP.AnimTbl_PrimaryFire 				= {"1hpattackright"}
SWEP.AnimTbl_Reload 					= {ACT_GESTURE_RELOAD_PISTOL}

SWEP.NPC_EquipSound 			= "vj_fallout/weapons/assaultrifle/rifleassault_equip.wav"
SWEP.NPC_UnequipSound 			= "vj_fallout/weapons/assaultrifle/rifleassault_unequip.wav"
SWEP.NPC_ReloadSound			= {"vj_fallout/weapons/10mmpistol/pistol10mm_reloadout.wav"}
SWEP.Primary.Sound				= {"vj_fallout/weapons/10mmpistol/pistol10mm_fire_2d.wav"}
SWEP.Primary.DistantSound		= {"vj_fallout/weapons/10mmpistol/pistol10mm_fire_3d.wav"}

SWEP.Primary.TracerType 				= "vj_fo3_tracer"
SWEP.PrimaryEffects_MuzzleParticles 	= {"muzzleflash_pistol"}

SWEP.PrimaryEffects_MuzzleAttachment 	= "muzzle"
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
	self:PlayWeaponSoundTimed("vj_fallout/weapons/10mmpistol/pistol10mm_reloadout.wav",0.1)
	self:PlayWeaponSoundTimed("vj_fallout/weapons/10mmpistol/pistol10mm_reloadin.wav",0.5)
	self:PlayWeaponSoundTimed("vj_fallout/weapons/10mmpistol/pistol10mm_reloadchamber.wav",0.7)
end