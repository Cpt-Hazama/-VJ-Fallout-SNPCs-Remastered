if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel					= "models/fallout/weapons/w_alienblaster.mdl"
SWEP.PrintName					= "Alien Blaster"
SWEP.AnimationType 						= "1hp"
SWEP.PHoldType 							= "pistol"

SWEP.NPC_NextPrimaryFire 				= 0.5
SWEP.NPC_CustomSpread	 				= 0.8
SWEP.NPC_TimeUntilFire	 				= 0
SWEP.NPC_TimeUntilFireExtraTimers 		= {}

SWEP.Primary.ClipSize					= 10
SWEP.Primary.Delay 						= 0.25
SWEP.Primary.Automatic = false

SWEP.AnimTbl_Deploy 					= {ACT_VM_DEPLOY_1}
SWEP.AnimTbl_Idle 						= {ACT_VM_IDLE_1}
SWEP.AnimTbl_PrimaryFire 				= {"1hpattackleft"}
SWEP.AnimTbl_Reload 					= {"1hpreloadh"}

SWEP.NPC_EquipSound 			= "vj_fallout/weapons/assaultrifle/rifleassault_equip.wav"
SWEP.NPC_UnequipSound 			= "vj_fallout/weapons/assaultrifle/rifleassault_unequip.wav"
SWEP.NPC_ReloadSound			= "vj_fallout/weapons/alienblaster/alienblaster_reload.wav"
SWEP.Primary.Sound				= {"vj_fallout/weapons/alienblaster/alienblaster_fire_2d.wav"}
SWEP.Primary.DistantSound		= {"vj_fallout/weapons/alienblaster/alienblaster_fire_3d.wav"}

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
	self:PlayWeaponSoundTimed("vj_fallout/weapons/alienblaster/alienblaster_reload.wav",0)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomBulletSpawnPosition()
	local att = self:LookupAttachment("muzzle")
	local owner = self:GetOwner()
	return att != 0 && self:GetAttachment(att).Pos or owner:GetShootPos()// +owner:GetRight() *5 +owner:GetUp() *-5
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnPrimaryAttack_BeforeShoot()
	if (CLIENT) then return end

	local owner = self:GetOwner()
	if owner:IsPlayer() then
		local proj = ents.Create("obj_vj_f3r_alien")
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

	local projectile = ents.Create("obj_vj_f3r_alien")
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