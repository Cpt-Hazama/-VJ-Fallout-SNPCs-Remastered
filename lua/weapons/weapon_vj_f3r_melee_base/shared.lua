if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.PrintName = "None"

SWEP.WorldModel 				= "models/error.mdl"
SWEP.ID 						= 00000000
SWEP.AnimationType 				= "1hm"

SWEP.NPC_NextPrimaryFire 		= 1
SWEP.NPC_BeforeFireSound 		= {}

SWEP.Primary.Damage = 1
SWEP.Primary.HeavyDamage = 2
SWEP.Primary.Sound = {}
SWEP.HeavyAttackChance = 4
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Author = "Cpt. Hazama"
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.Instructions = ""
SWEP.Base = "weapon_vj_f3r_base"
SWEP.HoldType = SWEP.AnimationType
SWEP.MadeForNPCsOnly = true
SWEP.NPC_TimeUntilFire = 0
SWEP.IsMeleeWeapon = true
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:MeleeInit()
	self.HasEffects = false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:MeleeThink()
	if CLIENT then return end
	local noDraw = self:GetNoDraw()
	if noDraw then
		if self.HasEffects then
			self:StopParticles()
			self.HasEffects = false
		end
	else
		if !self.HasEffects then
			if self.StartParticles then self:StartParticles() end
			self.HasEffects = true
		end
	end

	if self.OnThink then self:OnThink(noDraw) end
end