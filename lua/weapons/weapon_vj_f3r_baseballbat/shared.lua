if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.PrintName = "Baseball Bat"

SWEP.WorldModel 				= "models/cpthazama/fallout/weapons/w_baseballbat.mdl"
SWEP.ID 						= 00000000
SWEP.AnimationType 				= "2hm"

SWEP.NPC_NextPrimaryFire 		= 0.8
SWEP.NPC_BeforeFireSound 		= {
	"vj_fallout/weapons/melee/swing/fx_swing_medium01.wav",
	"vj_fallout/weapons/melee/swing/fx_swing_medium02.wav",
	"vj_fallout/weapons/melee/swing/fx_swing_medium03.wav",
	"vj_fallout/weapons/melee/swing/fx_swing_medium04.wav",
}

SWEP.Primary.Damage = 12
SWEP.Primary.HeavyDamage = 18
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
			"vj_fallout/weapons/hit/bluntflesh/wpn_hit_bluntflesh_01.wav",
			"vj_fallout/weapons/hit/bluntflesh/wpn_hit_bluntflesh_02.wav",
			"vj_fallout/weapons/hit/bluntflesh/wpn_hit_bluntflesh_03.wav",
			"vj_fallout/weapons/hit/bluntflesh/wpn_hit_bluntflesh_04.wav",
		}
	end)
end