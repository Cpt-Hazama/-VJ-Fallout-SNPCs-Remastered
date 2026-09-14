if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel					= "models/fallout/weapons/w_laserrifleunique.mdl"
SWEP.PrintName					= "AER14 Prototype"
SWEP.AnimationType 						= "2ha"
SWEP.PHoldType 							= "ar2"
SWEP.Slot 								= (SWEP.AnimationType == "1gt" && 4 or SWEP.AnimationType == "1hm" && 0 or SWEP.AnimationType == "2hm" && 0 or SWEP.AnimationType == "2ha" && 2 or SWEP.AnimationType == "2hh" && 3 or SWEP.AnimationType == "2hl" && 4 or SWEP.AnimationType == "2hr" && 2 or SWEP.AnimationType == "1hp" && 1 or SWEP.AnimationType == "1md" && 4) or 1
SWEP.NPC_NextPrimaryFire 		= 0.4 -- Next time it can use primary fire
SWEP.NPC_CustomSpread	 		= 0.0225
SWEP.NPC_TimeUntilFire	 		= 0 -- How much time until the bullet/projectile is fired?
SWEP.NPC_TimeUntilFireExtraTimers = {} -- Extra timers, which will make the gun fire again! | The seconds are counted after the self.NPC_TimeUntilFire!
SWEP.Primary.Damage				= 35 -- Damage
SWEP.Primary.ClipSize			= 24 -- Max amount of bullets per clip
SWEP.Primary.Delay						= 0.4
SWEP.Primary.Automatic					= false

SWEP.AnimTbl_Deploy 					= {"2hrequip"}
SWEP.AnimTbl_Idle 						= {ACT_GESTURE_RANGE_ATTACK_AR2_GRENADE}
SWEP.AnimTbl_PrimaryFire 				= {"2hrattack4"}
SWEP.AnimTbl_Reload 					= {"2hrreloadb"}

SWEP.NPC_EquipSound 			= "vj_fallout/weapons/assaultrifle/rifleassault_equip.wav"
SWEP.NPC_UnequipSound 			= "vj_fallout/weapons/assaultrifle/rifleassault_unequip.wav"
SWEP.NPC_ReloadSound			= {"vj_fallout/weapons/laserrifle/wpn_riflelaser_reloadinout.wav"}
SWEP.Primary.Sound				= {"vj_fallout/weapons/laserrifle/wpn_rifle_laser_fire_2d.wav"}
SWEP.Primary.DistantSound		= {"vj_fallout/weapons/laserrifle/wpn_rifle_laser_fire_2d.wav"}
SWEP.PrimaryEffects_MuzzleAttachment = "muzzle"
SWEP.Primary.TracerType			= "vj_fo3_laser_green"
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.PrimaryEffects_MuzzleFlash 	= false

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
SWEP.ViewModelFOV 				= 65
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnPrimaryAttack_BulletCallback(attacker,tr,dmginfo)
	local vjeffectmuz = EffectData()
	vjeffectmuz:SetOrigin(tr.HitPos)
	util.Effect("vj_fo3_laserhit_green",vjeffectmuz)
	dmginfo:SetDamageType(bit.bor(DMG_BULLET,DMG_BURN,DMG_DISSOLVE))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnReload()
	self:PlayWeaponSoundTimed(self.NPC_ReloadSound,0)
end
