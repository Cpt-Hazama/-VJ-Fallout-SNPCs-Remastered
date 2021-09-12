if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.PrintName = "Shishkebab"

SWEP.WorldModel 				= "models/fallout/weapons/w_shishkebab.mdl"
SWEP.ID 						= 00000000
SWEP.AnimationType 				= "1hm"

SWEP.NPC_NextPrimaryFire 		= 0.8
SWEP.NPC_BeforeFireSound 		= {
	"vj_fallout/weapons/shishkebab/wpn_shishkebab_fire01.wav",
	"vj_fallout/weapons/shishkebab/wpn_shishkebab_fire02.wav",
	"vj_fallout/weapons/shishkebab/wpn_shishkebab_fire03.wav",
}

SWEP.Primary.Damage = 20
SWEP.Primary.HeavyDamage = 28
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
	timer.Simple(0,function()
		self:GetOwner().MeleeAttackDamageType = bit.bor(DMG_BURN,DMG_SLASH)
		self:GetOwner().SoundTbl_MeleeAttack = {"vj_fallout/weapons/hit/bladeflesh/wpn_hit_bladeflesh_01.wav","vj_fallout/weapons/hit/bladeflesh/wpn_hit_bladeflesh_02.wav","vj_fallout/weapons/hit/bladeflesh/wpn_hit_bladeflesh_03.wav"}
	end)
end