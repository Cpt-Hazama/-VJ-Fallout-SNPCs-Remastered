if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel					= "models/fallout/weapons/w_25mmgrndlnchr.mdl"
SWEP.ViewModelB					= "models/fallout/weapons/c_25mmgrndlnchr.mdl"
SWEP.PrintName					= "25mm Grenade Machine Gun"
SWEP.AnimationType 						= "2hh"
SWEP.PHoldType 							= "crossbow"

SWEP.NPC_NextPrimaryFire 				= 0.3
SWEP.NPC_CustomSpread	 				= 0.8
SWEP.NPC_TimeUntilFire	 				= 0
SWEP.NPC_TimeUntilFireExtraTimers 		= {}

SWEP.Primary.ClipSize					= 30
SWEP.Primary.Delay 						= 0.3

SWEP.AnimTbl_Deploy 					= {ACT_VM_DEPLOY_4}
SWEP.AnimTbl_Idle 						= {ACT_VM_IDLE_5}
SWEP.AnimTbl_PrimaryFire 				= {ACT_SLAM_DETONATOR_DRAW}
SWEP.AnimTbl_Reload 					= {"2hhreloadg"}

SWEP.NPC_EquipSound 			= "vj_fallout/weapons/minigun/minigun_equip.wav"
SWEP.NPC_UnequipSound 			= "vj_fallout/weapons/minigun/minigun_unequip.wav"
SWEP.NPC_ReloadSound			= {"vj_fallout/weapons/grenademachinegun/grnde_mgun_jam.wav"}
SWEP.Primary.Sound				= {
									"vj_fallout/weapons/grenademachinegun/grnde_mgun_fire_2d01.wav",
									"vj_fallout/weapons/grenademachinegun/grnde_mgun_fire_2d02.wav",
								}
SWEP.Primary.DistantSound		= {
									"vj_fallout/weapons/grenademachinegun/grnde_mgun_fire_3d01.wav",
									"vj_fallout/weapons/grenademachinegun/grnde_mgun_fire_3d02.wav",
								}

SWEP.PrimaryEffects_MuzzleParticles 	= {"muzzleflash_pistol"}

SWEP.PrimaryEffects_MuzzleAttachment 	= "muzzle"
SWEP.Primary.DisableBulletCode	= true

SWEP.ViewModelAdjust = {
	Pos = {Right = 0,Forward = 0,Up = -35},
	Ang = {Right = 0,Up = 0,Forward = 0}
}
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
	self:PlayWeaponSoundTimed("vj_fallout/weapons/grenademachinegun/grnde_mgun_reloadpt1.wav",0)
	self:PlayWeaponSoundTimed("vj_fallout/weapons/grenademachinegun/grnde_mgun_reloadpt2.wav",1.6)
	self:PlayWeaponSoundTimed("vj_fallout/weapons/grenademachinegun/grnde_mgun_reloadpt3.wav",2.6)
	self:PlayWeaponSoundTimed("vj_fallout/weapons/grenademachinegun/grnde_mgun_reloadpt4.wav",2.8)
	self:PlayWeaponSoundTimed("vj_fallout/weapons/grenademachinegun/grnde_mgun_reloadpt5.wav",3)
	self:PlayWeaponSoundTimed("vj_fallout/weapons/grenademachinegun/grnde_mgun_reloadpt6.wav",3.2)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomBulletSpawnPosition()
	return self:GetAttachment(1).Pos
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:ShouldForceViewModelPosition()
	local owner = self:GetOwner()
	if !IsValid(owner) then return false end
	if !owner:IsPlayer() then return false end

	local vm = owner:GetViewModel()
	if vm:GetSequenceName(vm:GetSequence()) == "2hhreloadg" then
		return true
	end
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnPrimaryAttack_BeforeShoot()
	if (CLIENT) then return end

	local owner = self:GetOwner()
	if owner:IsPlayer() then
		local proj = ents.Create("obj_vj_grenade_rifle")
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

	local projectile = ents.Create("obj_vj_grenade_rifle")
	projectile:SetPos(self:CustomBulletSpawnPosition())
	projectile:SetAngles(owner:GetAngles())
	projectile:SetOwner(owner)
	projectile:Activate()
	projectile:Spawn()

	local phy = projectile:GetPhysicsObject()
	if phy:IsValid() then
		phy:SetVelocity(self:GetOwner():CalculateProjectile("Line", projectile:GetPos(), self:GetOwner():GetEnemy():GetPos() + self:GetOwner():GetEnemy():OBBCenter(), 8000) +projectile:GetUp() *400 +projectile:GetForward() *math.Rand(-150,150) +projectile:GetRight() *math.Rand(-50,50))
	end
end