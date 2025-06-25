if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.ViewModelB							= "models/fallout/weapons/c_heavyincinerator.mdl"
SWEP.WorldModel							= "models/fallout/weapons/w_heavyincinerator.mdl"
SWEP.PrintName							= "Heavy Incinerator"
SWEP.AnimationType 						= "2hh"
SWEP.PHoldType 							= "crossbow"
SWEP.Slot 								= (SWEP.AnimationType == "1gt" && 4 or SWEP.AnimationType == "1hm" && 0 or SWEP.AnimationType == "2hm" && 0 or SWEP.AnimationType == "2ha" && 2 or SWEP.AnimationType == "2hh" && 3 or SWEP.AnimationType == "2hl" && 4 or SWEP.AnimationType == "2hr" && 2 or SWEP.AnimationType == "1hp" && 1 or SWEP.AnimationType == "1md" && 4) or 1
SWEP.Weights = {
	WalkSpeed = 0.75,
	RunSpeed = 0.75,
	CrouchSpeed = 0.75,
	ClimbSpeed = 0.75,
	JumpPower = 0.75,
}

SWEP.WorldModel_CustomPositionAngle 	= Vector(80,5,270)
SWEP.WorldModel_CustomPositionOrigin 	= Vector(-3.6,0,-1.2)

SWEP.NPC_NextPrimaryFire 				= 0.25
-- SWEP.NPC_CustomSpread	 				= 0.5
SWEP.NPC_TimeUntilFire	 				= 0

SWEP.Primary.ClipSize					= 24
SWEP.Primary.Delay						= 0.25
SWEP.Primary.Automatic = true

SWEP.AnimTbl_Deploy 					= {ACT_VM_DEPLOY_4}
SWEP.AnimTbl_Idle 						= {ACT_VM_IDLE_5}
SWEP.AnimTbl_PrimaryFire 				= {ACT_SLAM_DETONATOR_DRAW}
SWEP.AnimTbl_Reload 					= {ACT_SLAM_DETONATOR_DETONATE}

SWEP.NPC_EquipSound 			= "vj_fallout/weapons/minigun/minigun_equip.wav"
SWEP.NPC_UnequipSound 			= "vj_fallout/weapons/minigun/minigun_unequip.wav"
SWEP.NPC_ReloadSound			= {"vj_fallout/weapons/incinerator/incinerator_reload.wav"}
SWEP.Primary.Sound				= {"vj_fallout/weapons/incinerator/incinerator_fire_2d.wav"}
SWEP.Primary.DistantSound		= {"vj_fallout/weapons/incinerator/incinerator_fire_3d.wav"}

SWEP.PrimaryEffects_MuzzleParticles 	= nil
SWEP.PrimaryEffects_MuzzleFlash 	= false

SWEP.PrimaryEffects_MuzzleAttachment 	= "muzzle"
SWEP.Primary.DisableBulletCode	= true
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
	self:PlayWeaponSoundTimed("vj_fallout/weapons/incinerator/incinerator_reload.wav",0)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomBulletSpawnPosition()
	local owner = self:GetOwner()
	local aimVec  = owner:GetAimVector()
	return owner:GetShootPos() +owner:GetRight() *5 +owner:GetUp() *-10 +aimVec *20
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnPrimaryAttack_BeforeShoot()
	if (CLIENT) then return end

	local owner = self:GetOwner()
	if owner:IsPlayer() then
		local proj = ents.Create("obj_vj_f3r_heavyflame")
		proj:SetPos(self:CustomBulletSpawnPosition())
		proj:SetAngles(owner:GetAimVector():Angle())
		proj:SetOwner(owner)
		proj:Spawn()
		proj:Activate()
		local phys = proj:GetPhysicsObject()
		if IsValid(phys) then
			phys:Wake()
			phys:SetVelocity(owner:GetAimVector() * 2000)
		end
		return
	end

	local projectile = ents.Create("obj_vj_f3r_heavyflame")
	projectile:SetPos(self:GetAttachment(1).Pos)
	projectile:SetAngles(owner:GetAngles())
	projectile:SetOwner(owner)
	projectile:Activate()
	projectile:Spawn()

	local phy = projectile:GetPhysicsObject()
	if phy:IsValid() then
		phy:SetVelocity(self:GetOwner():CalculateProjectile("Line", projectile:GetPos(), self:GetOwner():GetEnemy():GetPos() + self:GetOwner():GetEnemy():OBBCenter(), 8000) +projectile:GetUp() *400 +projectile:GetForward() *math.Rand(-150,150) +projectile:GetRight() *math.Rand(-50,50))
	end
end