AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/molerat.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 40
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_MOLERAT"} -- NPCs with the same class with be allied to each other

ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDistance = 80
ENT.MeleeAttackDamageDistance = 110
ENT.MeleeAttackDamage = 15

	-- ====== File Path Variables ====== --
	-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {
	"vj_fallout/molerat/foot/molerat_foot_l01.mp3",
	"vj_fallout/molerat/foot/molerat_foot_l02.mp3",
	"vj_fallout/molerat/foot/molerat_foot_l03.mp3",
	"vj_fallout/molerat/foot/molerat_foot_r01.mp3",
	"vj_fallout/molerat/foot/molerat_foot_r02.mp3",
}
ENT.SoundTbl_Idle = {
	"vj_fallout/molerat/molerat_idle01.mp3",
	"vj_fallout/molerat/molerat_idle02.mp3",
	"vj_fallout/molerat/molerat_idle03.mp3",
}
ENT.SoundTbl_Alert = {
	"vj_fallout/molerat/molerat_hiss01.mp3",
	"vj_fallout/molerat/molerat_hiss02.mp3",
	"vj_fallout/molerat/molerat_hiss03.mp3",
	"vj_fallout/molerat/molerat_alarmcry.mp3",
}
ENT.SoundTbl_BeforeMeleeAttack = {
	"vj_fallout/molerat/molerat_attack01.mp3",
	"vj_fallout/molerat/molerat_attack02.mp3",
	"vj_fallout/molerat/molerat_attack03.mp3",
}
ENT.SoundTbl_Pain = {
	"vj_fallout/molerat/molerat_injured01.mp3",
	"vj_fallout/molerat/molerat_injured02.mp3",
	"vj_fallout/molerat/molerat_injured03.mp3",
}
ENT.SoundTbl_Death = {
	"vj_fallout/molerat/molerat_death01.mp3",
	"vj_fallout/molerat/molerat_death02.mp3",
	"vj_fallout/molerat/molerat_death03.mp3",
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetupInventory(opWep)
	if self.CustomInventory then self:CustomInventory() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.tbl_Inventory = {}
	self:SetupInventory()
	self:SetCollisionBounds(Vector(20,20,45),Vector(-20,-20,0))
	local v1,v2 = self:GetCollisionBounds()
	self.Height = v2.z
	self.DefaultDistance = self.MeleeAttackDistance
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == string.find(key,"event_emit Foot") then
		VJ_EmitSound(self,self.SoundTbl_FootStep,self.FootStepSoundLevel,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
	elseif string.find(key,"event_mattack") then
		local atk = string.Replace(key,"event_mattack ","")
		self:MeleeAttackCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	local idle = self.Alerted && {ACT_IDLE_ANGRY,ACT_IDLE_AGITATED} or {ACT_IDLE,ACT_IDLE_RELAXED}
	local walk = ACT_WALK
	local run = ACT_RUN
	if (self:Health() <= self:GetMaxHealth() *0.5) then idle = {ACT_IDLE}; walk = ACT_WALK_HURT; run = ACT_RUN_HURT end
	self.AnimTbl_IdleStand = idle
	self.AnimTbl_Walk = {walk}
	self.AnimTbl_Run = {run}
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	local time = self:GetPathTimeToGoal()
	if !(self:Health() <= self:GetMaxHealth() *0.5) && self.NearestPointToEnemyDistance > self.DefaultDistance && time > 0.5 && time < 1.5 then
		self.MeleeAttackDistance = self.DefaultDistance *2
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK2}
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