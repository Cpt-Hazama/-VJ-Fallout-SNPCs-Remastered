if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel							= "models/fallout/weapons/w_supersledge.mdl"
SWEP.PrintName							= "Super Sledge"
SWEP.AnimationType 						= "2hm"
SWEP.PHoldType 							= "melee2"
SWEP.Slot 								= (SWEP.AnimationType == "1gt" && 4 or SWEP.AnimationType == "1hm" && 0 or SWEP.AnimationType == "2hm" && 0 or SWEP.AnimationType == "2ha" && 2 or SWEP.AnimationType == "2hh" && 3 or SWEP.AnimationType == "2hl" && 4 or SWEP.AnimationType == "2hr" && 2 or SWEP.AnimationType == "1hp" && 1 or SWEP.AnimationType == "1md" && 4) or 1

SWEP.NPC_NextPrimaryFire 				= 0.8
SWEP.NPC_CustomSpread	 				= 0.8
SWEP.NPC_TimeUntilFire	 				= 0
SWEP.NPC_TimeUntilFireExtraTimers 		= {}

SWEP.Primary.Damage 					= 32
SWEP.Primary.HeavyDamage 				= 38
SWEP.Primary.DamageType 				= bit.bor(DMG_SLASH,DMG_CRUSH,DMG_CLUB)
SWEP.Primary.ClipSize					= 1
SWEP.Primary.TakeAmmo					= 0
SWEP.Primary.Delay 						= 0.8
SWEP.MeleeHitDistance 					= 165
SWEP.MeleeHitTimes 						= {["2hmattackleft_a"] = 0.25,["2hmattackleft_b"] = 0.25,["2hmattackright_a"] = 0.5,["2hmattackright_b"] = 0.5,["2hmattackpower"] = 0.5,["2hmattackforwardpower"] = 0.6}

SWEP.AnimTbl_Deploy 					= {"2hmequip"}
SWEP.AnimTbl_Idle 						= {"2hmaim"}
SWEP.AnimTbl_Melee_Left 				= {"2hmattackleft_a","2hmattackleft_a"}
SWEP.AnimTbl_Melee_Right 				= {"2hmattackright_a","2hmattackright_a"}
SWEP.AnimTbl_Melee_Power 				= "2hmattackpower"
SWEP.AnimTbl_Melee_PowerForward 		= "2hmattackforwardpower"

SWEP.NPC_BeforeFireSound 				= {
	"vj_fallout/weapons/melee/swing/fx_swing_large01.wav",
	"vj_fallout/weapons/melee/swing/fx_swing_large02.wav",
}
SWEP.NPC_EquipSound 					= "vj_fallout/weapons/melee/melee_back_equip.wav"
SWEP.NPC_UnequipSound 					= "vj_fallout/weapons/melee/melee_back_unequip.wav"
SWEP.Primary.Sound 						= {}
SWEP.SoundTbl_MeleeAttackMiss 			= SWEP.NPC_BeforeFireSound
SWEP.SoundTbl_MeleeAttackHitWorld 		= {"vj_fallout/weapons/melee/sledge/melee_sledge_wood01.wav","vj_fallout/weapons/melee/sledge/melee_sledge_wood02.wav"}
SWEP.SoundTbl_MeleeAttackHit 			= {
	"vj_fallout/weapons/melee/sledge/melee_sledge_flesh01.wav",
	"vj_fallout/weapons/melee/sledge/melee_sledge_flesh02.wav",
	"vj_fallout/weapons/melee/sledge/melee_sledge_flesh03.wav",
}
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
			owner.SoundTbl_MeleeAttack = self.SoundTbl_MeleeAttackHit
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnDoMeleeAttack(anim,time)
	local owner = self:GetOwner()
	if anim == "2hmattackforwardpower" then
		for i = 1,8 do
			timer.Simple(i *0.05,function()
				if IsValid(self) && IsValid(owner) && self:GetOwner() == owner && owner:GetActiveWeapon() == self then
					owner:SetVelocity(owner:GetForward() *250)
				end
			end)
		end
	end
end