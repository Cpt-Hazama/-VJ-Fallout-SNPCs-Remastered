if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel					= "models/fallout/weapons/w_heavyincinerator.mdl"
SWEP.PrintName					= "Heavy Incinerator"
SWEP.HoldType 					= "2hh"
-- SWEP.ID 						= ITEM_VJ_10MMPISTOL
SWEP.AnimationType 				= SWEP.HoldType
SWEP.NPC_NextPrimaryFire 		= 0.25 -- Next time it can use primary fire
-- SWEP.NPC_CustomSpread	 		= 0.8
SWEP.NPC_TimeUntilFire	 		= 0 -- How much time until the bullet/projectile is fired?
SWEP.NPC_TimeUntilFireExtraTimers = {} -- Extra timers, which will make the gun fire again! | The seconds are counted after the self.NPC_TimeUntilFire!
-- SWEP.Primary.Damage				= 9 -- Damage
SWEP.Primary.ClipSize			= 24 -- Max amount of bullets per clip
SWEP.NPC_EquipSound 			= "vj_fallout/weapons/minigun/minigun_equip.wav"
SWEP.NPC_UnequipSound 			= "vj_fallout/weapons/minigun/minigun_unequip.wav"
SWEP.NPC_ReloadSound			= {"vj_fallout/weapons/incinerator/incinerator_reload.wav"}
SWEP.Primary.Sound				= {"vj_fallout/weapons/incinerator/incinerator_fire_2d.wav"}
SWEP.Primary.DistantSound		= {"vj_fallout/weapons/incinerator/incinerator_fire_3d.wav"}
SWEP.PrimaryEffects_MuzzleAttachment = "muzzle"
SWEP.Primary.DisableBulletCode	= true
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base 						= "weapon_vj_base"
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
function SWEP:CustomBulletSpawnPosition()
	return self:GetAttachment(1).Pos
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnPrimaryAttack_BeforeShoot()
	if (CLIENT) then return end
	local projectile = ents.Create("obj_vj_f3r_heavyflame")
	projectile:SetPos(self:CustomBulletSpawnPosition())
	projectile:SetAngles(self.Owner:GetAngles())
	projectile:SetOwner(self.Owner)
	projectile:Activate()
	projectile:Spawn()

	local phy = projectile:GetPhysicsObject()
	if phy:IsValid() then
		phy:SetVelocity(self:GetOwner():CalculateProjectile("Line", projectile:GetPos(), self:GetOwner():GetEnemy():GetPos() + self:GetOwner():GetEnemy():OBBCenter(), 8000) +projectile:GetUp() *400 +projectile:GetForward() *math.Rand(-150,150) +projectile:GetRight() *math.Rand(-50,50))
	end
end