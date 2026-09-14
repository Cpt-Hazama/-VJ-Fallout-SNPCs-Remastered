if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel					= "models/cpthazama/fallout/weapons/w_lincolnrifle.mdl"
SWEP.PrintName					= "Lincoln's Rifle"
SWEP.AnimationType 						= "2hr"
SWEP.PHoldType 							= "ar2"
SWEP.Slot 								= (SWEP.AnimationType == "1gt" && 4 or SWEP.AnimationType == "1hm" && 0 or SWEP.AnimationType == "2hm" && 0 or SWEP.AnimationType == "2ha" && 2 or SWEP.AnimationType == "2hh" && 3 or SWEP.AnimationType == "2hl" && 4 or SWEP.AnimationType == "2hr" && 2 or SWEP.AnimationType == "1hp" && 1 or SWEP.AnimationType == "1md" && 4) or 1
SWEP.HoldType 							= "2hr_bolt"
SWEP.ID 						= 00000000
SWEP.NPC_NextPrimaryFire 		= 1.75 -- Next time it can use primary fire
SWEP.NPC_CustomSpread	 		= 0.8
SWEP.NPC_TimeUntilFire	 		= 0 -- How much time until the bullet/projectile is fired?
SWEP.NPC_TimeUntilFireExtraTimers = {} -- Extra timers, which will make the gun fire again! | The seconds are counted after the self.NPC_TimeUntilFire!
SWEP.Primary.Damage				= 37 -- Damage
SWEP.Primary.ClipSize			= 15 -- Max amount of bullets per clip
SWEP.Primary.Delay						= 1
SWEP.Primary.Automatic					= false

SWEP.AnimTbl_Deploy 					= {"2hrequip"}
SWEP.AnimTbl_Idle 						= {ACT_GESTURE_RANGE_ATTACK_AR2_GRENADE}
SWEP.AnimTbl_PrimaryFire 				= {"2hrattack5"}
SWEP.AnimTbl_Reload 					= {"2hrreloadn"}

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
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnPrimaryAttack_AfterShoot()
	local owner = self:GetOwner()
	if !owner:IsPlayer() then return end
	timer.Simple(self.NPC_ExtraFireSoundTime or 0.55,function()
		if IsValid(self) && IsValid(owner) && self:GetOwner() == owner then
			owner:EmitSound(VJ.PICK(self.NPC_ExtraFireSound),70,100)
		end
	end)
end
