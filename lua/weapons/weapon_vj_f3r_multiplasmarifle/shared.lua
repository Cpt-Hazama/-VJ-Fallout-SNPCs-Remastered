if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel					= "models/fallout/weapons/w_multiplasrifle.mdl"
SWEP.PrintName					= "Multi-Plasma Rifle"
SWEP.AnimationType 						= "2hr"
SWEP.PHoldType 							= "ar2"
SWEP.Slot 								= (SWEP.AnimationType == "1gt" && 4 or SWEP.AnimationType == "1hm" && 0 or SWEP.AnimationType == "2hm" && 0 or SWEP.AnimationType == "2ha" && 2 or SWEP.AnimationType == "2hh" && 3 or SWEP.AnimationType == "2hl" && 4 or SWEP.AnimationType == "2hr" && 2 or SWEP.AnimationType == "1hp" && 1 or SWEP.AnimationType == "1md" && 4) or 1
SWEP.NPC_NextPrimaryFire 		= 0.5 -- Next time it can use primary fire
SWEP.NPC_TimeUntilFire	 		= 0 -- How much time until the bullet/projectile is fired?
SWEP.NPC_TimeUntilFireExtraTimers = {} -- Extra timers, which will make the gun fire again! | The seconds are counted after the self.NPC_TimeUntilFire!
SWEP.Primary.Damage				= 34 -- Damage
SWEP.Primary.ClipSize			= 12 -- Max amount of bullets per clip
SWEP.Primary.Delay						= 0.5
SWEP.Primary.Automatic					= false

SWEP.AnimTbl_Deploy 					= {"2hrequip"}
SWEP.AnimTbl_Idle 						= {ACT_GESTURE_RANGE_ATTACK_AR2_GRENADE}
SWEP.AnimTbl_PrimaryFire 				= {"2hrattack4"}
SWEP.AnimTbl_Reload 					= {"2hrreloadb"}

SWEP.NPC_ReloadSound			= "vj_fallout/weapons/plasmarifle/plasmarifle_reload.wav"
SWEP.Primary.Sound				= {"vj_fallout/weapons/multiplasrifle/multiplasrifle_fire_2d01.wav","vj_fallout/weapons/multiplasrifle/multiplasrifle_fire_2d02.wav"}
SWEP.Primary.DistantSound				= {"vj_fallout/weapons/multiplasrifle/multiplasrifle_fire_3d01.wav","vj_fallout/weapons/multiplasrifle/multiplasrifle_fire_3d02.wav"}
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
	local baseDir
	if owner:IsPlayer() then
		baseDir = owner:GetAimVector()
	else
		local enemy = owner:GetEnemy()
		if !IsValid(enemy) then return true end
		baseDir = (enemy:BodyTarget(self:CustomBulletSpawnPosition()) -self:CustomBulletSpawnPosition()):GetNormalized()
	end

	for i = 1,3 do
		local projectile = ents.Create("obj_vj_f3r_plasma")
		projectile:SetPos(self:CustomBulletSpawnPosition())
		-- Apply a small random spread relative to the actual aim direction.
		local dir = (baseDir +VectorRand() *0.025):GetNormalized()
		projectile:SetAngles(dir:Angle())
		projectile:SetOwner(owner)
		projectile.DirectDamage = self.Primary.Damage
		projectile:Spawn()
		projectile:Activate()
		local phy = projectile:GetPhysicsObject()
		if IsValid(phy) then
			phy:Wake()
			phy:SetVelocity(dir *2000)
		end
	end
end
