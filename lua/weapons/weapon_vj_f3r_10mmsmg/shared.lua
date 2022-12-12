if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel					= "models/fallout/weapons/w_10mmsubmachinegun.mdl"
SWEP.PrintName					= "10mm Sub-Machine Gun"
SWEP.AnimationType 						= "1hp"
SWEP.PHoldType 							= "pistol"

SWEP.NPC_NextPrimaryFire 				= 0.1
SWEP.NPC_CustomSpread	 				= 0.8
SWEP.NPC_TimeUntilFire	 				= 0
SWEP.NPC_TimeUntilFireExtraTimers 		= {}

SWEP.Primary.Damage						= 7
SWEP.Primary.ClipSize					= 30
SWEP.Primary.Delay 						= 0.1

SWEP.AnimTbl_Deploy 					= {ACT_VM_DEPLOY_1}
SWEP.AnimTbl_Idle 						= {ACT_VM_IDLE_1}
SWEP.AnimTbl_PrimaryFire 				= {"1hpattackright"}
SWEP.AnimTbl_Reload 					= {"1hpreloadg"}

SWEP.NPC_EquipSound 			= "vj_fallout/weapons/assaultrifle/rifleassault_equip.wav"
SWEP.NPC_UnequipSound 			= "vj_fallout/weapons/assaultrifle/rifleassault_unequip.wav"
SWEP.NPC_ReloadSound			= {"vj_fallout/weapons/10mmsmg/riflesmg_reload.wav"}
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
	self:PlayWeaponSoundTimed("vj_fallout/weapons/10mmsmg/riflesmg_reload.wav",0)
end