AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/mantis.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 50
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_GIANTMANTIS"} -- NPCs with the same class with be allied to each other

ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDistance = 80
ENT.MeleeAttackDamageDistance = 110
ENT.MeleeAttackDamage = 10

	-- ====== File Path Variables ====== --
	-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {
	"vj_fallout/mantis/foot/mantis_foot01.mp3",
	"vj_fallout/mantis/foot/mantis_foot02.mp3",
	"vj_fallout/mantis/foot/mantis_foot03.mp3",
	"vj_fallout/mantis/foot/mantis_foot04.mp3",
	"vj_fallout/mantis/foot/mantis_foot05.mp3",
	"vj_fallout/mantis/foot/mantis_foot06.mp3",
	"vj_fallout/mantis/foot/mantis_foot07.mp3",
}
ENT.SoundTbl_Idle = {
	"vj_fallout/mantis/mantis_chase_vox01.mp3",
	"vj_fallout/mantis/mantis_chase_vox02.mp3",
	"vj_fallout/mantis/mantis_chase_vox03.mp3",
	"vj_fallout/mantis/mantis_chase_vox04.mp3",
}
ENT.SoundTbl_Alert = {
	"vj_fallout/mantis/mantis_hiss01.mp3",
	"vj_fallout/mantis/mantis_hiss02.mp3",
	"vj_fallout/mantis/mantis_hiss03.mp3",
	"vj_fallout/mantis/mantis_hiss04.mp3",
	"vj_fallout/mantis/mantis_hiss05.mp3",
	"vj_fallout/mantis/mantis_hiss06.mp3",
}
ENT.SoundTbl_BeforeMeleeAttack = {
	"vj_fallout/mantis/mantis_armattack01.mp3",
	"vj_fallout/mantis/mantis_armattack02.mp3",
	"vj_fallout/mantis/mantis_armattack03.mp3",
	"vj_fallout/mantis/mantis_armattack04.mp3",
	"vj_fallout/mantis/mantis_armattack05.mp3",
	"vj_fallout/mantis/mantis_armattack06.mp3",
}
ENT.SoundTbl_Death = {
	"vj_fallout/mantis/mantis_death01.mp3",
	"vj_fallout/mantis/mantis_death02.mp3",
	"vj_fallout/mantis/mantis_death03.mp3",
	"vj_fallout/mantis/mantis_death04.mp3",
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
	local idle = self.Alerted && ACT_IDLE_ANGRY or ACT_IDLE
	local walk = ACT_WALK
	local run = ACT_RUN
	if (self:Health() <= self:GetMaxHealth() *0.5) then idle = ACT_IDLE; walk = ACT_WALK_HURT; run = ACT_WALK_HURT end
	self.AnimTbl_IdleStand = {idle}
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