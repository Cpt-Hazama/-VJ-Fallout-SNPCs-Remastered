if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel							= "models/fallout/weapons/w_assaultrifle.mdl"
SWEP.PrintName							= "Chinese Assault Rifle"
SWEP.ID 								= ITEM_VJ_ASSAULTRIFLE
SWEP.AnimationType 						= "2ha"
SWEP.PHoldType 							= "ar2"

SWEP.WorldModel_CustomPositionAngle 	= Vector(80,5,270)
SWEP.WorldModel_CustomPositionOrigin 	= Vector(-3.6,0,-1.2)

SWEP.NPC_NextPrimaryFire 				= 0.1
SWEP.NPC_CustomSpread	 				= 0.8
SWEP.NPC_TimeUntilFire	 				= 0
SWEP.NPC_TimeUntilFireExtraTimers 		= {}

SWEP.Primary.Damage						= 4
SWEP.Primary.ClipSize					= 28

SWEP.AnimTbl_Deploy 					= {ACT_GESTURE_RANGE_ATTACK_HMG1}
SWEP.AnimTbl_Idle 						= {ACT_GESTURE_RANGE_ATTACK_AR2_GRENADE}
SWEP.AnimTbl_PrimaryFire 				= {ACT_GESTURE_RANGE_ATTACK_AR1}
SWEP.AnimTbl_Reload 					= {ACT_GESTURE_BARNACLE_STRANGLE}

SWEP.NPC_EquipSound 					= "vj_fallout/weapons/assaultrifle_chinese/wpn_rifleassault_equip.wav"
SWEP.NPC_UnequipSound 					= "vj_fallout/weapons/assaultrifle_chinese/wpn_rifleassault_unequip.wav"
SWEP.NPC_ReloadSound					= {"vj_fallout/weapons/assaultrifle/rifleassaultg3_reload_out.wav"}
SWEP.Primary.Sound						= {"vj_fallout/weapons/assaultrifle_chinese/wpn_rifleassault_fire_2d.wav"}
SWEP.Primary.DistantSound				= {"vj_fallout/weapons/assaultrifle_chinese/wpn_rifleassault_fire_3d.wav"}

SWEP.Primary.TracerType 				= "vj_fo3_tracer"
SWEP.PrimaryEffects_MuzzleParticles 	= {"muzzleflash_4"}

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
	self:PlayWeaponSoundTimed("vj_fallout/weapons/assaultrifle/rifleassaultg3_reload_out.wav",0.35)
	self:PlayWeaponSoundTimed("vj_fallout/weapons/assaultrifle/rifleassaultg3_reload_in.wav",1.4)
	self:PlayWeaponSoundTimed("vj_fallout/weapons/assaultrifle/rifleassaultg3_reload_chamber.wav",1.9)
end