if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.PrintName = "Super Sledge"

SWEP.WorldModel 				= "models/fallout/weapons/w_supersledge.mdl"
SWEP.ID 						= 00000000
SWEP.AnimationType 				= "2hm"

SWEP.NPC_NextPrimaryFire 		= 0.8
SWEP.NPC_BeforeFireSound 		= {
	"vj_fallout/weapons/melee/swing/fx_swing_large01.wav",
	"vj_fallout/weapons/melee/swing/fx_swing_large02.wav",
}

SWEP.Primary.Damage = 24
SWEP.Primary.HeavyDamage = 38
SWEP.Primary.Sound = {}
SWEP.HeavyAttackChance = 5
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
	timer.Simple(0,function()
		self:GetOwner().MeleeAttackDamageType = bit.bor(DMG_SLASH,DMG_CRUSH,DMG_CLUB)
		self:GetOwner().SoundTbl_MeleeAttack = {
			"vj_fallout/weapons/melee/sledge/melee_sledge_flesh01.wav",
			"vj_fallout/weapons/melee/sledge/melee_sledge_flesh02.wav",
			"vj_fallout/weapons/melee/sledge/melee_sledge_flesh03.wav",
		}
	end)
end