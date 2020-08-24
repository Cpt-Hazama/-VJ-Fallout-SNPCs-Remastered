if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel					= "models/fallout/weapons/w_plasmacaster.mdl"
SWEP.PrintName					= "Plasma Caster"
-- SWEP.ID 						= ITEM_VJ_PLASMARIFLE
SWEP.HoldType 					= "2hh"
SWEP.NPC_NextPrimaryFire 		= 0.3 -- Next time it can use primary fire
SWEP.NPC_TimeUntilFire	 		= 0 -- How much time until the bullet/projectile is fired?
SWEP.NPC_TimeUntilFireExtraTimers = {} -- Extra timers, which will make the gun fire again! | The seconds are counted after the self.NPC_TimeUntilFire!
SWEP.Primary.Damage				= 65 -- Damage
SWEP.Primary.ClipSize			= 10 -- Max amount of bullets per clip
SWEP.NPC_ReloadSound			= "vj_fallout/weapons/plasmarifle/plasmarifle_reload.wav"
SWEP.Primary.Sound				= {
									"vj_fallout/weapons/plasmacaster/plasmacaster_fire_2d01.wav",
									"vj_fallout/weapons/plasmacaster/plasmacaster_fire_2d02.wav",
									"vj_fallout/weapons/plasmacaster/plasmacaster_fire_2d03.wav",
								}
SWEP.Primary.DistantSound		= {
									"vj_fallout/weapons/plasmacaster/plasmacaster_fire_3d01.wav",
									"vj_fallout/weapons/plasmacaster/plasmacaster_fire_3d02.wav",
									"vj_fallout/weapons/plasmacaster/plasmacaster_fire_3d03.wav",
								}
SWEP.PrimaryEffects_MuzzleFlash = false
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
SWEP.PrimaryEffects_SpawnDynamicLight = false
SWEP.Primary.DisableBulletCode	= true
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomBulletSpawnPosition()
	return self.Owner:EyePos()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnPrimaryAttack_BeforeShoot()
	if (CLIENT) then return end
	local projectile = ents.Create("obj_vj_f3r_plasma")
	projectile:SetPos(self:GetAttachment(1).Pos)
	projectile:SetAngles((self.Owner:GetEnemy():GetPos() -self.Owner:GetPos()):Angle())
	projectile:SetOwner(self.Owner)
	projectile:Spawn()
	projectile:Activate()
	projectile.DirectDamage = self.Primary.Damage

	local phy = projectile:GetPhysicsObject()
	if phy:IsValid() then
		phy:SetVelocity(self:GetOwner():CalculateProjectile("Line", projectile:GetPos(), self:GetOwner():GetEnemy():GetPos() + self:GetOwner():GetEnemy():OBBCenter(), 1000))
	end
end