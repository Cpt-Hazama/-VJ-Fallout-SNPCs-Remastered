if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel							= "models/fallout/weapons/w_shishkebab.mdl"
SWEP.PrintName							= "Shishkebab"
SWEP.AnimationType 						= "1hm"
SWEP.PHoldType 							= "melee"
SWEP.Slot 								= (SWEP.AnimationType == "1gt" && 4 or SWEP.AnimationType == "1hm" && 0 or SWEP.AnimationType == "2hm" && 0 or SWEP.AnimationType == "2ha" && 2 or SWEP.AnimationType == "2hh" && 3 or SWEP.AnimationType == "2hl" && 4 or SWEP.AnimationType == "2hr" && 2 or SWEP.AnimationType == "1hp" && 1 or SWEP.AnimationType == "1md" && 4) or 1

SWEP.NPC_NextPrimaryFire 				= 0.8
SWEP.NPC_CustomSpread	 				= 0.8
SWEP.NPC_TimeUntilFire	 				= 0
SWEP.NPC_TimeUntilFireExtraTimers 		= {}

SWEP.Primary.Damage 					= 20
SWEP.Primary.HeavyDamage 				= 28
SWEP.Primary.DamageType 				= bit.bor(DMG_BURN,DMG_SLASH)
SWEP.Primary.ClipSize					= 1
SWEP.Primary.TakeAmmo					= 0
SWEP.Primary.Delay 						= 0.8
SWEP.MeleeHitDistance 					= 120
SWEP.MeleeHitTimes 						= {["1hmattackleft_a"] = 0.15,["1hmattackleft_b"] = 0.15,["1hmattackright_a"] = 0.15,["1hmattackright_b"] = 0.15,["1hmattackpower"] = 0.5,["1hmattackforwardpower"] = 0.6}

SWEP.AnimTbl_Deploy 					= {"1hmequip"}
SWEP.AnimTbl_Idle 						= {"1hmaim"}
SWEP.AnimTbl_Melee_Left 				= {"1hmattackleft_a","1hmattackleft_a"}
SWEP.AnimTbl_Melee_Right 				= {"1hmattackright_a","1hmattackright_a"}
SWEP.AnimTbl_Melee_Power 				= "1hmattackpower"
SWEP.AnimTbl_Melee_PowerForward 		= "1hmattackforwardpower"

SWEP.NPC_BeforeFireSound 				= {
	"vj_fallout/weapons/shishkebab/wpn_shishkebab_fire01.wav",
	"vj_fallout/weapons/shishkebab/wpn_shishkebab_fire02.wav",
	"vj_fallout/weapons/shishkebab/wpn_shishkebab_fire03.wav",
}
SWEP.NPC_EquipSound 					= "vj_fallout/weapons/melee/melee_back_equip.wav"
SWEP.NPC_UnequipSound 					= "vj_fallout/weapons/melee/melee_back_unequip.wav"
SWEP.Primary.Sound 						= {}
SWEP.SoundTbl_MeleeAttackMiss 			= SWEP.NPC_BeforeFireSound
SWEP.SoundTbl_MeleeAttackHitWorld 		= {
	"vj_fallout/weapons/knife/fx_melee_knife_other01.wav",
	"vj_fallout/weapons/knife/fx_melee_knife_other02.wav",
}
SWEP.SoundTbl_MeleeAttackHit 			= {
	"vj_fallout/weapons/knife/fx_melee_knife_flesh01.wav",
	"vj_fallout/weapons/knife/fx_melee_knife_flesh02.wav",
	"vj_fallout/weapons/knife/fx_melee_knife_flesh03.wav",
}

SWEP.HeavyAttackChance 					= 4
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
			owner.MeleeAttackDamageType = bit.bor(DMG_BURN,DMG_SLASH)
			owner.SoundTbl_MeleeAttack = self.SoundTbl_MeleeAttackHit
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnDoMeleeAttack(anim,time)
	local owner = self:GetOwner()
	if anim == "1hmattackforwardpower" then
		for i = 1,8 do
			timer.Simple(i *0.05,function()
				if IsValid(self) && IsValid(owner) && self:GetOwner() == owner && owner:GetActiveWeapon() == self then
					owner:SetVelocity(owner:GetForward() *250)
				end
			end)
		end
	end
	timer.Simple(time,function()
		if IsValid(self) && IsValid(owner) && self:GetOwner() == owner && owner:GetActiveWeapon() == self then
			VJ_EmitSound(self, self.NPC_BeforeFireSound, 75)
		end
	end)
end