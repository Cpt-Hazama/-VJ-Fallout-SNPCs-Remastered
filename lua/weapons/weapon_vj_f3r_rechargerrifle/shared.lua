if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel					= "models/fallout/weapons/w_rechargerrifle.mdl"
SWEP.PrintName					= "Recharger Rifle"
SWEP.AnimationType 						= "2hr"
SWEP.PHoldType 							= "ar2"
SWEP.Slot 								= (SWEP.AnimationType == "1gt" && 4 or SWEP.AnimationType == "1hm" && 0 or SWEP.AnimationType == "2hm" && 0 or SWEP.AnimationType == "2ha" && 2 or SWEP.AnimationType == "2hh" && 3 or SWEP.AnimationType == "2hl" && 4 or SWEP.AnimationType == "2hr" && 2 or SWEP.AnimationType == "1hp" && 1 or SWEP.AnimationType == "1md" && 4) or 1
SWEP.NPC_NextPrimaryFire 		= 0.25 -- Next time it can use primary fire
SWEP.NPC_CustomSpread	 		= 0.4
SWEP.NPC_TimeUntilFire	 		= 0 -- How much time until the bullet/projectile is fired?
SWEP.NPC_TimeUntilFireExtraTimers = {} -- Extra timers, which will make the gun fire again! | The seconds are counted after the self.NPC_TimeUntilFire!
SWEP.Primary.Damage				= 12 -- Damage
SWEP.Primary.ClipSize			= 7 -- Max amount of bullets per clip
SWEP.Primary.Delay						= 0.25
SWEP.Primary.Automatic					= false

SWEP.AnimTbl_Deploy 					= {"2hrequip"}
SWEP.AnimTbl_Idle 						= {ACT_GESTURE_RANGE_ATTACK_AR2_GRENADE}
SWEP.AnimTbl_PrimaryFire 				= {"2hrattack4"}
SWEP.AnimTbl_Reload 					= {}

SWEP.NPC_EquipSound 			= "vj_fallout/weapons/assaultrifle/rifleassault_equip.wav"
SWEP.NPC_UnequipSound 			= "vj_fallout/weapons/assaultrifle/rifleassault_unequip.wav"
SWEP.NPC_ReloadSound			= {"vj_fallout/weapons/laserpistol/pistollaser_reload.wav"}
SWEP.Primary.Sound				= {"vj_fallout/weapons/riflerecharger/rechargerrifle_fire_2d01.wav","vj_fallout/weapons/riflerecharger/rechargerrifle_fire_2d02.wav"}
SWEP.Primary.DistantSound		= {"vj_fallout/weapons/riflerecharger/rechargerrifle_fire_3d01.wav","vj_fallout/weapons/riflerecharger/rechargerrifle_fire_3d02.wav"}
SWEP.PrimaryEffects_MuzzleAttachment = "muzzle"
SWEP.Primary.TracerType			= "vj_fo3_laser"
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
	util.Effect("vj_fo3_laserhit",vjeffectmuz)
	dmginfo:SetDamageType(bit.bor(DMG_BULLET,DMG_BURN,DMG_DISSOLVE))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnInit()
	self.RechargeT = 0
	local owner = self:GetOwner()
	if IsValid(owner) && owner:IsNPC() then
		owner.VJ_F3R_OriginalAllowWeaponReloading = owner.AllowWeaponReloading
		owner.AllowWeaponReloading = false
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:WeaponThink()
	if self:Clip1() < 7 && CurTime() > (self.RechargeT or 0) then
		self:SetClip1(math.min(self:Clip1() +1,7))
		self.RechargeT = CurTime() +1
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnPrimaryAttack_AfterShoot()
	self.RechargeT = CurTime() +1
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:Reload()
	
end
---------------------------------------------------------------------------------------------------------------------------------------------
local function RestoreNPCReloading(self)
	local owner = self:GetOwner()
	if IsValid(owner) && owner:IsNPC() && owner.VJ_F3R_OriginalAllowWeaponReloading != nil then
		owner.AllowWeaponReloading = owner.VJ_F3R_OriginalAllowWeaponReloading
		owner.VJ_F3R_OriginalAllowWeaponReloading = nil
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:WeaponHolstered(newWep)
	RestoreNPCReloading(self)
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnRemove()
	RestoreNPCReloading(self)
end
