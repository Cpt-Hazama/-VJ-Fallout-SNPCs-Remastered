if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel					= "models/fallout/weapons/w_alienblaster.mdl"
SWEP.PrintName					= "Alien Blaster"
-- SWEP.ID 						= ITEM_VJ_PLASMAPISTOL
SWEP.AnimationType 				= "1hp"
SWEP.HoldType 					= "1hp"
SWEP.NPC_NextPrimaryFire 		= 0.5 -- Next time it can use primary fire
SWEP.NPC_TimeUntilFire	 		= 0 -- How much time until the bullet/projectile is fired?
SWEP.NPC_TimeUntilFireExtraTimers = {} -- Extra timers, which will make the gun fire again! | The seconds are counted after the self.NPC_TimeUntilFire!
SWEP.Primary.Damage				= 75 -- Damage
SWEP.Primary.ClipSize			= 10 -- Max amount of bullets per clip
SWEP.NPC_ReloadSound			= "vj_fallout/weapons/alienblaster/alienblaster_reload.wav"
SWEP.Primary.Sound				= {"vj_fallout/weapons/alienblaster/alienblaster_fire_2d.wav"}
SWEP.Primary.DistantSound		= {"vj_fallout/weapons/alienblaster/alienblaster_fire_3d.wav"}
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
	return self:GetAttachment(1).Pos
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnPrimaryAttack_BeforeShoot()
	if (CLIENT) then return end
	local projectile = ents.Create("obj_vj_f3r_alien")
	projectile:SetPos(self:GetAttachment(1).Pos)
	projectile:SetAngles(((self.Owner:GetEnemy():GetPos() -self.Owner:GetPos())):Angle())
	projectile:SetOwner(self.Owner)
	projectile:Spawn()
	projectile:Activate()
	projectile.DirectDamage = self.Primary.Damage

	local phy = projectile:GetPhysicsObject()
	if phy:IsValid() then
		phy:ApplyForceCenter(((self.Owner:GetEnemy():GetPos() -self.Owner:GetPos())))
	end
end