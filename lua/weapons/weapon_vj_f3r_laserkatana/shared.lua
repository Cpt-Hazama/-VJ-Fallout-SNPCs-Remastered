if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.PrintName = "Laser Katana"

SWEP.WorldModel 				= "models/fallout/weapons/w_laserkatana.mdl"
SWEP.ID 						= 00000817
SWEP.AnimationType 				= "1hm"

SWEP.NPC_NextPrimaryFire 		= 0.8
SWEP.NPC_BeforeFireSound 		= {}

SWEP.Primary.Damage = 16
SWEP.Primary.HeavyDamage = 34
SWEP.Primary.Sound = {}
SWEP.HeavyAttackChance = 4
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Author = "Cpt. Hazama"
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.Instructions = ""
SWEP.Base = "weapon_vj_f3r_melee_base"
SWEP.HoldType = SWEP.AnimationType
SWEP.MadeForNPCsOnly = true
SWEP.NPC_TimeUntilFire = 0
SWEP.IsMeleeWeapon = true
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnOnit()
	self.LaserEffect = VJ_PICK({"vj_f3r_laserkatana_red","vj_f3r_laserkatana_blue","vj_f3r_laserkatana_green"})

	timer.Simple(0,function()
		self:GetOwner().MeleeAttackDamageType = bit.bor(DMG_SLASH,DMG_BURN,DMG_DISSOLVE)
		self:GetOwner().SoundTbl_MeleeAttack = {"vj_fallout/weapons/hit/bladeflesh/wpn_hit_bladeflesh_01.wav","vj_fallout/weapons/hit/bladeflesh/wpn_hit_bladeflesh_02.wav","vj_fallout/weapons/hit/bladeflesh/wpn_hit_bladeflesh_03.wav"}
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:StartParticles()
	if CLIENT then return end
	for i = 1,25 do
		ParticleEffectAttach(self.LaserEffect,PATTACH_POINT_FOLLOW,self,i)
	end
end