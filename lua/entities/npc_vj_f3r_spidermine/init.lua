AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/spidermine.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 15
ENT.HullType = HULL_TINY

ENT.SightDistance = 600
ENT.SightAngle = 180
ENT.DisableWandering = true
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_CHINA"} -- NPCs with the same class with be allied to each other
ENT.Bleeds = false

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {} -- Melee Attack Animations
ENT.TimeUntilMeleeAttackDamage = 0 -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDistance = 50
ENT.DisableDefaultMeleeAttackDamageCode = true

ENT.HasDeathRagdoll = false

	-- ====== File Path Variables ====== --
	-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStepL = {
	"vj_fallout/spidermine/foot/minespider_foot_l01.mp3",
	"vj_fallout/spidermine/foot/minespider_foot_l02.mp3",
}
ENT.SoundTbl_FootStepR = {
	"vj_fallout/spidermine/foot/minespider_foot_r01.mp3",
	"vj_fallout/spidermine/foot/minespider_foot_r02.mp3",
	"vj_fallout/spidermine/foot/minespider_foot_r03.mp3",
}
ENT.SoundTbl_Breath = {"vj_fallout/spidermine/minespider_idle01_lp.wav","vj_fallout/spidermine/minespider_idle02_lp.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetupInventory(opWep)
	if self.CustomInventory then self:CustomInventory() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.tbl_Inventory = {}
	self:SetupInventory()
	self:SetCollisionBounds(Vector(4,4,4),Vector(-4,-4,0))
	local v1,v2 = self:GetCollisionBounds()
	self.Height = v2.z
	self.DefaultDistance = self.MeleeAttackDistance
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_BeforeChecks()
	self.GodMode = false
	self:SetHealth(0)
	self:TakeDamage(999999999,self,self)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnKilled(dmginfo,hitgroup)
	local pos,ang = self:GetBonePosition(0)
	VJ_EmitSound(self,"vj_mili_tank/tank_death2.wav",100,100)
	util.BlastDamage(self,self,pos,200,90)
	util.ScreenShake(pos,100,200,1,2500)
	if self.HasGibDeathParticles == true then ParticleEffect("vj_explosion2",pos,Angle(0,0,0),nil) end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "event_emit FootLeft" then
		VJ_EmitSound(self,self.SoundTbl_FootStepL,self.FootStepSoundLevel,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
	elseif key == "event_emit FootRight" then
		VJ_EmitSound(self,self.SoundTbl_FootStepR,self.FootStepSoundLevel,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
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