if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel							= "models/cpthazama/fallout/weapons/w_baseballbat.mdl"
SWEP.PrintName							= "Baseball Bat"
SWEP.AnimationType 						= "2hm"
SWEP.PHoldType 							= "melee2"

SWEP.NPC_NextPrimaryFire 				= 0.8
SWEP.NPC_CustomSpread	 				= 0.8
SWEP.NPC_TimeUntilFire	 				= 0
SWEP.NPC_TimeUntilFireExtraTimers 		= {}

SWEP.Primary.Damage 					= 12
SWEP.Primary.HeavyDamage 				= 26
SWEP.Primary.DamageType 				= DMG_CLUB
SWEP.Primary.ClipSize					= 1
SWEP.Primary.TakeAmmo					= 0
SWEP.Primary.Delay 						= 0.8
SWEP.MeleeHitDistance 					= 165
SWEP.MeleeHitTimes 						= {["2hmattackleft_a"] = 0.25,["2hmattackleft_b"] = 0.25,["2hmattackright_a"] = 0.5,["2hmattackright_b"] = 0.5,["2hmattackpower"] = 0.5}

SWEP.AnimTbl_Deploy 					= {"2hmequip"}
SWEP.AnimTbl_Idle 						= {"2hmaim"}
SWEP.AnimTbl_Melee_Left 				= {"2hmattackleft_a","2hmattackleft_a"}
SWEP.AnimTbl_Melee_Right 				= {"2hmattackright_a","2hmattackright_a"}
SWEP.AnimTbl_Melee_Power 				= {"2hmattackpower"}

SWEP.NPC_BeforeFireSound 				= {"vj_fallout/weapons/melee/swing/fx_swing_medium01.wav","vj_fallout/weapons/melee/swing/fx_swing_medium02.wav","vj_fallout/weapons/melee/swing/fx_swing_medium03.wav","vj_fallout/weapons/melee/swing/fx_swing_medium04.wav",}
SWEP.NPC_EquipSound 					= "vj_fallout/weapons/melee/melee_back_equip.wav"
SWEP.NPC_UnequipSound 					= "vj_fallout/weapons/melee/melee_back_unequip.wav"
SWEP.Primary.Sound 						= {}
SWEP.SoundTbl_MeleeAttackMiss 			= SWEP.NPC_BeforeFireSound
SWEP.SoundTbl_MeleeAttackHitWorld 		= {"vj_fallout/weapons/melee/sledge/melee_sledge_wood01.wav","vj_fallout/weapons/melee/sledge/melee_sledge_wood02.wav"}
SWEP.SoundTbl_MeleeAttackHit 			= {"vj_fallout/weapons/melee/sledge/melee_sledge_flesh01.wav","vj_fallout/weapons/melee/sledge/melee_sledge_flesh02.wav","vj_fallout/weapons/melee/sledge/melee_sledge_flesh03.wav",}

SWEP.HeavyAttackChance 					= 5
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base 						= "weapon_vj_f3r_melee_base"
SWEP.Author 					= "Cpt. Hazama"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players and NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "VJ Base - Fallout: Remastered"
SWEP.Spawnable 					= true
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:MeleeInit()
	local owner = self:GetOwner()
	if owner:IsNPC() then
		timer.Simple(0,function()
			owner.MeleeAttackDamageType = bit.bor(DMG_SLASH,DMG_CRUSH,DMG_CLUB)
			owner.SoundTbl_MeleeAttack = {
				"vj_fallout/weapons/hit/bluntflesh/wpn_hit_bluntflesh_01.wav",
				"vj_fallout/weapons/hit/bluntflesh/wpn_hit_bluntflesh_02.wav",
				"vj_fallout/weapons/hit/bluntflesh/wpn_hit_bluntflesh_03.wav",
				"vj_fallout/weapons/hit/bluntflesh/wpn_hit_bluntflesh_04.wav",
			}
		end)
	end
end