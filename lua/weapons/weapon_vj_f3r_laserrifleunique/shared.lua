if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel					= "models/fallout/weapons/w_laserrifleunique.mdl"
SWEP.PrintName					= "AER14 Prototype"
SWEP.HoldType 					= "2hr"
-- SWEP.ID 						= ITEM_VJ_10MMPISTOL
SWEP.AnimationType 				= SWEP.HoldType
SWEP.NPC_NextPrimaryFire 		= 0.4 -- Next time it can use primary fire
SWEP.NPC_CustomSpread	 		= 0.0225
SWEP.NPC_TimeUntilFire	 		= 0 -- How much time until the bullet/projectile is fired?
SWEP.NPC_TimeUntilFireExtraTimers = {} -- Extra timers, which will make the gun fire again! | The seconds are counted after the self.NPC_TimeUntilFire!
SWEP.Primary.Damage				= 35 -- Damage
SWEP.Primary.ClipSize			= 24 -- Max amount of bullets per clip
SWEP.NPC_EquipSound 			= "vj_fallout/weapons/assaultrifle/rifleassault_equip.wav"
SWEP.NPC_UnequipSound 			= "vj_fallout/weapons/assaultrifle/rifleassault_unequip.wav"
SWEP.NPC_ReloadSound			= {"vj_fallout/weapons/laserrifle/wpn_riflelaser_reloadinout.wav"}
SWEP.Primary.Sound				= {"vj_fallout/weapons/laserrifle/wpn_rifle_laser_fire_2d.wav"}
SWEP.Primary.DistantSound		= {"vj_fallout/weapons/laserrifle/wpn_rifle_laser_fire_2d.wav"}
SWEP.PrimaryEffects_MuzzleAttachment = "muzzle"
SWEP.Primary.TracerType			= "vj_fo3_laser_green"
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base 						= "weapon_vj_f3r_base"
SWEP.Author 					= "Cpt. Hazama"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players and NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "VJ Base - Fallout: Remastered"
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.MadeForNPCsOnly 			= true -- Is tihs weapon meant to be for NPCs only?
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Force				= 1 -- Force applied on the object the bullet hits
SWEP.Primary.Ammo				= "Pistol" -- Ammo type
SWEP.PrimaryEffects_SpawnShells = false
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnPrimaryAttack_BulletCallback(attacker,tr,dmginfo)
	local vjeffectmuz = EffectData()
	vjeffectmuz:SetOrigin(tr.HitPos)
	util.Effect("vj_fo3_laserhit_green",vjeffectmuz)
	dmginfo:SetDamageType(bit.bor(DMG_BULLET,DMG_BURN,DMG_DISSOLVE))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:PrimaryAttackEffects()
	local customeffects = self:CustomOnPrimaryAttackEffects()
	if customeffects != true then return end

	if self.PrimaryEffects_MuzzleFlash == true && GetConVarNumber("vj_wep_nomuszzleflash") == 0 then
		local muzzleattach = self.PrimaryEffects_MuzzleAttachment
		if isnumber(muzzleattach) == false then muzzleattach = self:LookupAttachment(muzzleattach) end
		local vjeffectmuz = EffectData()
		vjeffectmuz:SetOrigin(self.Owner:GetShootPos())
		vjeffectmuz:SetEntity(self)
		vjeffectmuz:SetStart(self.Owner:GetShootPos())
		vjeffectmuz:SetNormal(self.Owner:GetAimVector())
		vjeffectmuz:SetAttachment(muzzleattach)
		util.Effect("vj_fo3_muzzle_gatlinglaser",vjeffectmuz)
	end

	if SERVER && self.PrimaryEffects_SpawnDynamicLight == true && GetConVarNumber("vj_wep_nomuszzleflash") == 0 && GetConVarNumber("vj_wep_nomuszzleflash_dynamiclight") == 0 then
		local FireLight1 = ents.Create("light_dynamic")
		FireLight1:SetKeyValue("brightness", self.PrimaryEffects_DynamicLightBrightness)
		FireLight1:SetKeyValue("distance", self.PrimaryEffects_DynamicLightDistance)
		if self.Owner:IsPlayer() then FireLight1:SetLocalPos(self.Owner:GetShootPos() +self:GetForward()*40 + self:GetUp()*-10) else FireLight1:SetLocalPos(self:GetAttachment(1).Pos) end
		FireLight1:SetLocalAngles(self:GetAngles())
		FireLight1:Fire("Color", self.PrimaryEffects_DynamicLightColor.r.." "..self.PrimaryEffects_DynamicLightColor.g.." "..self.PrimaryEffects_DynamicLightColor.b)
		FireLight1:SetParent(self)
		FireLight1:Spawn()
		FireLight1:Activate()
		FireLight1:Fire("TurnOn","",0)
		FireLight1:Fire("Kill","",0.07)
		self:DeleteOnRemove(FireLight1)
	end
end