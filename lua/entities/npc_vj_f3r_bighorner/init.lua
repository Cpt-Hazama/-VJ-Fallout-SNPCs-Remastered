AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/bighorner.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 100
ENT.HullType = HULL_HUMAN
ENT.Behavior = VJ_BEHAVIOR_NEUTRAL
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_BIGHORNER"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDistance = 80
ENT.MeleeAttackDamageDistance = 110
ENT.MeleeAttackDamage = 40
ENT.DisableFootStepSoundTimer = true

	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 12 -- Chance of it flinching from 1 to x | 1 will make it always flinch
ENT.NextMoveAfterFlinchTime = "LetBaseDecide" -- How much time until it can move, attack, etc. | Use this for schedules or else the base will set the time 0.6 if it sees it's a schedule!
ENT.HasHitGroupFlinching = true -- It will flinch when hit in certain hitgroups | It can also have certain animations to play in certain hitgroups
ENT.HitGroupFlinching_DefaultWhenNotHit = false -- If it uses hitgroup flinching, should it do the regular flinch if it doesn't hit any of the specified hitgroups?
ENT.HitGroupFlinching_Values = {
	{
		HitGroup = {101},
		Animation = {ACT_FLINCH_HEAD}
	},
	{
		HitGroup = {102,103},
		Animation = {ACT_FLINCH_CHEST}
	},
}

	-- ====== File Path Variables ====== --
	-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_Chew = {
	"vj_fallout/bighorner/bighorner_chew01.mp3",
	"vj_fallout/bighorner/bighorner_chew02.mp3",
	"vj_fallout/bighorner/bighorner_chew03.mp3",
	"vj_fallout/bighorner/bighorner_chew04.mp3",
	"vj_fallout/bighorner/bighorner_chew05.mp3",
	"vj_fallout/bighorner/bighorner_chew06.mp3",
}
ENT.SoundTbl_FootStepL = {
	"vj_fallout/bighorner/foot/bighorner_foot_l01.mp3",
	"vj_fallout/bighorner/foot/bighorner_foot_l02.mp3",
	"vj_fallout/bighorner/foot/bighorner_foot_l03.mp3",
}
ENT.SoundTbl_FootStepR = {
	"vj_fallout/bighorner/foot/bighorner_foot_r01.mp3",
	"vj_fallout/bighorner/foot/bighorner_foot_r02.mp3",
	"vj_fallout/bighorner/foot/bighorner_foot_r03.mp3",
}
ENT.SoundTbl_Idle = {
	"vj_fallout/bighorner/bighorner_breathe01.mp3",
	"vj_fallout/bighorner/bighorner_breathe02.mp3",
	"vj_fallout/bighorner/bighorner_breathe03.mp3",
	"vj_fallout/bighorner/bighorner_breathe04.mp3",
	"vj_fallout/bighorner/bighorner_breathe05.mp3",
	"vj_fallout/bighorner/bighorner_breathe06.mp3",
	"vj_fallout/bighorner/bighorner_snort01.mp3",
	"vj_fallout/bighorner/bighorner_snort02.mp3",
	"vj_fallout/bighorner/bighorner_snort03.mp3",
	"vj_fallout/bighorner/bighorner_snort04.mp3",
}
ENT.SoundTbl_Alert = {
	"vj_fallout/bighorner/bighorner_react01.mp3",
	"vj_fallout/bighorner/bighorner_react02.mp3",
}
ENT.SoundTbl_BeforeMeleeAttack = {
	"vj_fallout/bighorner/bighorner_charge_vox01.mp3",
	"vj_fallout/bighorner/bighorner_charge_vox02.mp3",
	"vj_fallout/bighorner/bighorner_charge_vox03.mp3",
}
ENT.SoundTbl_Pain = {
	"vj_fallout/bighorner/bighorner_impact01.mp3",
	"vj_fallout/bighorner/bighorner_impact02.mp3",
	"vj_fallout/bighorner/bighorner_impact03.mp3",
	"vj_fallout/bighorner/bighorner_impact04.mp3",
}
ENT.SoundTbl_Death = {
	"vj_fallout/bighorner/bighorner_death01.mp3",
	"vj_fallout/bighorner/bighorner_death02.mp3",
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetupInventory(opWep)
	if self.CustomInventory then self:CustomInventory() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.tbl_Inventory = {}
	self:SetupInventory()
	self:SetCollisionBounds(Vector(26,26,65),Vector(-26,-26,0))
	local v1,v2 = self:GetCollisionBounds()
	self.Height = v2.z
	self.DefaultDistance = self.MeleeAttackDistance
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "event_emit FootLeft" then
		VJ_EmitSound(self,self.SoundTbl_FootStepL,self.FootStepSoundLevel,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
	elseif key == "event_emit FootRight" then
		VJ_EmitSound(self,self.SoundTbl_FootStepR,self.FootStepSoundLevel,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
	elseif key == "event_emit Chew" then
		VJ_EmitSound(self,self.SoundTbl_Chew,self.FootStepSoundLevel,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
	elseif string.find(key,"event_mattack") then
		local atk = string.Replace(key,"event_mattack ","")
		self:MeleeAttackCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	local time = self:GetPathTimeToGoal()
	if self.NearestPointToEnemyDistance > self.DefaultDistance && time > 0.5 && time < 1.5 && math.random(1,20) == 1 then
		self.MeleeAttackDistance = self.DefaultDistance *2
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK2}
		self.HasMeleeAttackKnockBack = true
		self.MeleeAttackKnockBack_Forward1 = 270
		self.MeleeAttackKnockBack_Forward2 = 290
		self.MeleeAttackKnockBack_Up1 = self.Height +(self.Height *0.8)
		self.MeleeAttackKnockBack_Up2 = self.Height +(self.Height *0.9)
	else
		self.MeleeAttackDistance = self.DefaultDistance
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}
		self.HasMeleeAttackKnockBack = false
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,GetCorpse)
	GetCorpse.tbl_Inventory = self.tbl_Inventory
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/