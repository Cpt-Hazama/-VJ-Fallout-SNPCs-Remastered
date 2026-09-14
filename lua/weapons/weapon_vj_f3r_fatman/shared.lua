if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel					= "models/fallout/weapons/w_fatman.mdl"
SWEP.PrintName					= "Fatman"
SWEP.AnimationType 						= "2hl"
SWEP.PHoldType 							= "rpg"
SWEP.Slot 								= (SWEP.AnimationType == "1gt" && 4 or SWEP.AnimationType == "1hm" && 0 or SWEP.AnimationType == "2hm" && 0 or SWEP.AnimationType == "2ha" && 2 or SWEP.AnimationType == "2hh" && 3 or SWEP.AnimationType == "2hl" && 4 or SWEP.AnimationType == "2hr" && 2 or SWEP.AnimationType == "1hp" && 1 or SWEP.AnimationType == "1md" && 4) or 1
SWEP.ID 						= ITEM_VJ_FATMAN
SWEP.NPC_NextPrimaryFire 		= math.Rand(8,12) -- Next time it can use primary fire
SWEP.NPC_CustomSpread	 		= 0.8
SWEP.NPC_TimeUntilFire	 		= 0 -- How much time until the bullet/projectile is fired?
SWEP.NPC_TimeUntilFireExtraTimers = {} -- Extra timers, which will make the gun fire again! | The seconds are counted after the self.NPC_TimeUntilFire!
SWEP.Primary.Damage				= 4 -- Damage
SWEP.Primary.ClipSize			= 1 -- Max amount of bullets per clip
SWEP.Primary.Delay						= 1
SWEP.Primary.Automatic					= false

SWEP.AnimTbl_Deploy 					= {"2hlequip"}
SWEP.AnimTbl_Idle 						= {"2hlaim"}
SWEP.AnimTbl_PrimaryFire 				= {"2hlattack3"}
SWEP.AnimTbl_Reload 					= {"2hlreloada"}

SWEP.NPC_ReloadSound			= "vj_fallout/weapons/fatman/fatman_reload.wav"
SWEP.Primary.Sound				= {"vj_fallout/weapons/fatman/fatman_fire.wav"}
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
	local projectile = ents.Create("obj_vj_f3r_mininuke")
	local dir
	if owner:IsPlayer() then
		dir = owner:GetAimVector()
		projectile:SetPos(owner:GetShootPos() +dir *45 +owner:GetUp() *-6)
	else
		local enemy = owner:GetEnemy()
		if !IsValid(enemy) then projectile:Remove() return true end
		dir = (enemy:BodyTarget(owner:GetPos()) -owner:GetPos()):GetNormalized()
		projectile:SetPos(owner:GetPos() +owner:OBBCenter() +owner:GetUp() *50 +owner:GetForward() *65)
	end
	projectile:SetAngles(dir:Angle())
	projectile:SetOwner(owner)
	projectile:Spawn()
	projectile:Activate()

	local phy = projectile:GetPhysicsObject()
	if IsValid(phy) then
		phy:Wake()
		if owner:IsPlayer() then
			phy:SetVelocity(dir *1500 +owner:GetUp() *100)
		else
			local enemy = owner:GetEnemy()
			phy:ApplyForceCenter((enemy:GetPos() -owner:GetPos()) *5000 +owner:GetUp() *10000)
		end
	end
end
