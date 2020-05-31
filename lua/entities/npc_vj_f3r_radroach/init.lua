AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/radroach.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 12
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_RADROACH"} -- NPCs with the same class with be allied to each other

ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDistance = 80
ENT.MeleeAttackDamageDistance = 110
ENT.MeleeAttackDamage = 5

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
	"vj_fallout/radroach/roach_idle01.mp3",
	"vj_fallout/radroach/roach_idle02.mp3",
	"vj_fallout/radroach/roach_idle03.mp3",
}
ENT.SoundTbl_BeforeMeleeAttack = {
	"vj_fallout/radroach/roach_attack01.mp3",
	"vj_fallout/radroach/roach_attack02.mp3",
	"vj_fallout/radroach/roach_attack03.mp3",
}
ENT.SoundTbl_Death = {
	"vj_fallout/radroach/roach_death01.mp3",
	"vj_fallout/radroach/roach_death02.mp3",
	"vj_fallout/radroach/roach_death03.mp3",
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetupInventory(opWep)
	if self.CustomInventory then self:CustomInventory() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.tbl_Inventory = {}
	self:SetupInventory()
	self:SetCollisionBounds(Vector(18,18,30),Vector(-18,-18,0))
	local v1,v2 = self:GetCollisionBounds()
	self.Height = v2.z
	self.DefaultDistance = self.MeleeAttackDistance
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if string.find(key,"Foot") then
		VJ_EmitSound(self,self.SoundTbl_FootStep,self.FootStepSoundLevel,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
	elseif key == "event_Play Wings" then
		VJ_EmitSound(self,"vj_fallout/radroach/roach_wings0" .. math.random(1,3) .. ".mp3")
	elseif string.find(key,"event_mattack") then
		local atk = string.Replace(key,"event_mattack ","")
		self:MeleeAttackCode()
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