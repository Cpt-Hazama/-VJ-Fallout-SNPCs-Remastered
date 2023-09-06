if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel					= "models/fallout/weapons/w_fatman.mdl"
SWEP.PrintName					= "Fatman"
SWEP.ID 						= ITEM_VJ_FATMAN
SWEP.AnimationType 				= "2hl"
SWEP.NPC_NextPrimaryFire 		= math.Rand(8,12) -- Next time it can use primary fire
SWEP.NPC_CustomSpread	 		= 0.8
SWEP.NPC_TimeUntilFire	 		= 0 -- How much time until the bullet/projectile is fired?
SWEP.NPC_TimeUntilFireExtraTimers = {} -- Extra timers, which will make the gun fire again! | The seconds are counted after the self.NPC_TimeUntilFire!
SWEP.Primary.Damage				= 4 -- Damage
SWEP.Primary.ClipSize			= 1 -- Max amount of bullets per clip
SWEP.NPC_ReloadSound			= "vj_fallout/weapons/fatman/fatman_reload.wav"
SWEP.Primary.Sound				= {"vj_fallout/weapons/fatman/fatman_fire.wav"}
SWEP.PrimaryEffects_MuzzleFlash = false
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base 						= "weapon_vj_f3r_base"
SWEP.Author 					= "Cpt. Hazama"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players and NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "VJ Base - Fallout: Remastered"
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.MadeForNPCsOnly 			= true -- Is tihs weapon meant to be for NPCs only?
	-- World Model ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel_UseCustomPosition = false -- Should the gun use custom position? This can be used to fix guns that are in the crotch
SWEP.WorldModel_CustomPositionAngle = Vector(-10,0,180)
SWEP.WorldModel_CustomPositionOrigin = Vector(-1,11.3,1)
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Force				= 1 -- Force applied on the object the bullet hits
SWEP.Primary.Ammo				= "Pistol" -- Ammo type
SWEP.PrimaryEffects_SpawnShells = false
SWEP.PrimaryEffects_SpawnDynamicLight = false
SWEP.HoldType 					= "2hl"
SWEP.Primary.DisableBulletCode	= true
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomBulletSpawnPosition()
	return self.Owner:EyePos()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnPrimaryAttack_BeforeShoot()
	if (CLIENT) then return end
	local projectile = ents.Create("obj_vj_f3r_mininuke")
	projectile:SetPos(self:GetOwner():GetPos() +self:GetOwner():OBBCenter() +self:GetUp() *50 +self:GetForward() *65)
	projectile:SetAngles(self.Owner:GetAngles())
	projectile:SetOwner(self.Owner)
	projectile:Activate()
	projectile:Spawn()

	local phy = projectile:GetPhysicsObject()
	if phy:IsValid() then
		phy:ApplyForceCenter(((self.Owner:GetEnemy():GetPos() - self.Owner:GetPos()) * 5000 +self.Owner:GetUp() *10000))
	end
end