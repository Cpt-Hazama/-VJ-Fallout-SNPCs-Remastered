if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.PrintName = "Combat Knife"

SWEP.WorldModel 				= "models/fallout/weapons/w_combatknife.mdl"
SWEP.ID 						= 00000000
SWEP.AnimationType 				= "1hm"

SWEP.NPC_NextPrimaryFire 		= 0.8
SWEP.NPC_BeforeFireSound 		= {
	"vj_fallout/weapons/melee/swing/fx_swing_knife01.wav",
	"vj_fallout/weapons/melee/swing/fx_swing_knife02.wav",
	"vj_fallout/weapons/melee/swing/fx_swing_knife03.wav",
}

SWEP.Primary.Damage = 8
SWEP.Primary.HeavyDamage = 12
SWEP.Primary.Sound = {}
SWEP.HeavyAttackChance = 8
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
		self:GetOwner().MeleeAttackDamageType = DMG_SLASH
		self:GetOwner().SoundTbl_MeleeAttack = {
			"vj_fallout/weapons/knife/fx_melee_knife_flesh01.wav",
			"vj_fallout/weapons/knife/fx_melee_knife_flesh02.wav",
			"vj_fallout/weapons/knife/fx_melee_knife_flesh03.wav",
		}
	end)
end