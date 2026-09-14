if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel					= "models/fallout/weapons/w_plasmapistol.mdl"
SWEP.PrintName					= "Plasma Pistol"
SWEP.AnimationType 						= "1hp"
SWEP.PHoldType 							= "pistol"
SWEP.Slot 								= (SWEP.AnimationType == "1gt" && 4 or SWEP.AnimationType == "1hm" && 0 or SWEP.AnimationType == "2hm" && 0 or SWEP.AnimationType == "2ha" && 2 or SWEP.AnimationType == "2hh" && 3 or SWEP.AnimationType == "2hl" && 4 or SWEP.AnimationType == "2hr" && 2 or SWEP.AnimationType == "1hp" && 1 or SWEP.AnimationType == "1md" && 4) or 1
SWEP.ID 						= ITEM_VJ_PLASMAPISTOL
SWEP.NPC_NextPrimaryFire 		= 0.4 -- Next time it can use primary fire
SWEP.NPC_TimeUntilFire	 		= 0 -- How much time until the bullet/projectile is fired?
SWEP.NPC_TimeUntilFireExtraTimers = {} -- Extra timers, which will make the gun fire again! | The seconds are counted after the self.NPC_TimeUntilFire!
SWEP.Primary.Damage				= 25 -- Damage
SWEP.Primary.ClipSize			= 16 -- Max amount of bullets per clip
SWEP.Primary.Delay						= 0.4
SWEP.Primary.Automatic					= false

SWEP.AnimTbl_Deploy 					= {ACT_VM_DEPLOY_1}
SWEP.AnimTbl_Idle 						= {ACT_VM_IDLE_1}
SWEP.AnimTbl_PrimaryFire 				= {"1hpattackleft"}
SWEP.AnimTbl_Reload 					= {"1hpreloadh"}

SWEP.NPC_ReloadSound			= "vj_fallout/weapons/plasmapistol/pistolplasma_reload.wav"
SWEP.Primary.Sound				= {"vj_fallout/weapons/plasmapistol/pistolplasma_fire_2d.wav"}
SWEP.Primary.DistantSound				= {"vj_fallout/weapons/plasmapistol/pistolplasma_fire_3d.wav"}
SWEP.PrimaryEffects_MuzzleFlash = false
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.PrimaryEffects_SpawnDynamicLight = false
SWEP.Primary.DisableBulletCode	= true

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
function SWEP:CustomBulletSpawnPosition()
	local owner = self:GetOwner()
	local att = self:LookupAttachment("muzzle")
	if att != 0 then
		local data = self:GetAttachment(att)
		if data then return data.Pos end
	end
	return owner:GetShootPos() +owner:GetAimVector() *20
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnPrimaryAttack_BeforeShoot()
	if CLIENT then return end

	local owner = self:GetOwner()
	local projectile = ents.Create("obj_vj_f3r_plasma")
	projectile:SetPos(self:CustomBulletSpawnPosition())
	if owner:IsPlayer() then
		projectile:SetAngles(owner:GetAimVector():Angle())
	else
		local enemy = owner:GetEnemy()
		if !IsValid(enemy) then projectile:Remove() return true end
		projectile:SetAngles((enemy:BodyTarget(projectile:GetPos()) -projectile:GetPos()):Angle())
	end
	projectile:SetOwner(owner)
	projectile.DirectDamage = self.Primary.Damage
	projectile:Spawn()
	projectile:Activate()

	local phy = projectile:GetPhysicsObject()
	if IsValid(phy) then
		phy:Wake()
		if owner:IsPlayer() then
			phy:SetVelocity(owner:GetAimVector() *2000)
		else
			local enemy = owner:GetEnemy()
			phy:SetVelocity(owner:CalculateProjectile("Line", projectile:GetPos(), enemy:GetPos() +enemy:OBBCenter(), 1000))
		end
	end
end
