if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel							= "models/fallout/weapons/w_laserrifle.mdl"
SWEP.PrintName							= "AER9 Laser Rifle"
SWEP.AnimationType 						= "2ha"
SWEP.PHoldType 							= "ar2"
SWEP.Slot 								= (SWEP.AnimationType == "1gt" && 4 or SWEP.AnimationType == "1hm" && 0 or SWEP.AnimationType == "2hm" && 0 or SWEP.AnimationType == "2ha" && 2 or SWEP.AnimationType == "2hh" && 3 or SWEP.AnimationType == "2hl" && 4 or SWEP.AnimationType == "2hr" && 2 or SWEP.AnimationType == "1hp" && 1 or SWEP.AnimationType == "1md" && 4) or 1

SWEP.WorldModel_CustomPositionAngle 	= Vector(80,5,270)
SWEP.WorldModel_CustomPositionOrigin 	= Vector(-3.6,0,-1.2)

SWEP.NPC_NextPrimaryFire 				= 0.35
SWEP.NPC_CustomSpread	 				= 0.025
SWEP.NPC_TimeUntilFire	 				= 0
SWEP.NPC_TimeUntilFireExtraTimers 		= {}

SWEP.Primary.Damage						= 22
SWEP.Primary.ClipSize					= 24

SWEP.AnimTbl_Deploy 					= {"2hrequip"}
SWEP.AnimTbl_Idle 						= {ACT_GESTURE_RANGE_ATTACK_AR2_GRENADE}
SWEP.AnimTbl_PrimaryFire 				= {"2hrattack4"}
SWEP.AnimTbl_Reload 					= {"2hrreloadb"}

SWEP.NPC_EquipSound 					= "vj_fallout/weapons/assaultrifle_chinese/wpn_rifleassault_equip.wav"
SWEP.NPC_UnequipSound 					= "vj_fallout/weapons/assaultrifle_chinese/wpn_rifleassault_unequip.wav"
SWEP.NPC_ReloadSound			= {"vj_fallout/weapons/laserrifle/wpn_riflelaser_reloadinout.wav"}
SWEP.Primary.Sound				= {"vj_fallout/weapons/laserrifle/laserrifle_fire_2d01.wav","vj_fallout/weapons/laserrifle/laserrifle_fire_2d02.wav"}
SWEP.Primary.DistantSound		= {"vj_fallout/weapons/laserrifle/laserrifle_fire_3d01.wav","vj_fallout/weapons/laserrifle/laserrifle_fire_3d02.wav"}

SWEP.Primary.TracerType 				= "vj_fo3_laser"
SWEP.PrimaryEffects_MuzzleParticles 	= nil
SWEP.PrimaryEffects_MuzzleFlash 	= false
SWEP.Primary.Automatic 	= false

SWEP.PrimaryEffects_MuzzleAttachment 	= "muzzle"
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base 						= "weapon_vj_f3r_base"
SWEP.Author 					= "Cpt. Hazama"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players and NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "VJ Base - Fallout: Remastered"
SWEP.Spawnable 					= true
SWEP.ViewModelFOV 				= 65
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnPrimaryAttack_BulletCallback(attacker,tr,dmginfo)
	local vjeffectmuz = EffectData()
	vjeffectmuz:SetOrigin(tr.HitPos)
	util.Effect("vj_fo3_laserhit",vjeffectmuz)
	dmginfo:SetDamageType(bit.bor(DMG_BULLET,DMG_BURN,DMG_DISSOLVE))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnReload()
	self:PlayWeaponSoundTimed(self.NPC_ReloadSound,0)
end