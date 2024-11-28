AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.VJ_NPC_Class = {"CLASS_RAIDER"}

ENT.PlayerFriendly = false

ENT.StartedEffects = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnThinkActive()
	self.RangeDistance = 325
	local parameter = self:GetPoseParameter("aim_yaw")
	if parameter != self.Turret_CurrentParameter then
		self.turret_turningsd = CreateSound(self,self.Turret_TurningSound) 
		self.turret_turningsd:SetSoundLevel(70)
		self.turret_turningsd:PlayEx(1,100)
	else
		VJ_STOPSOUND(self.turret_turningsd)
	end
	if self.StartedEffects then
		local enemy = self:GetEnemy()
		if !IsValid(enemy) or IsValid(enemy) && enemy:GetPos():Distance(self:GetPos()) > self.RangeDistance or !self.Sentry_HasLOS then
			self:StopParticles()
			VJ_STOPSOUND(self.FlameLoopSound)
			self.StartedEffects = false
		end
	end
	self.Turret_CurrentParameter = parameter
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomRangeAttackCode()
	if !self.StartedEffects then
		ParticleEffectAttach("flamer",PATTACH_POINT_FOLLOW,self,1)
		self.FlameLoopSound = CreateSound(self,"vj_fallout/weapons/flamer/flamer_fire_lp.wav")
		self.FlameLoopSound:Play()
		self.StartedEffects = true
	end
	local att = self:GetAttachment(1)
	self:DoFlameDamage(300,5,self,35,2,att.Pos,att.Ang:Forward())
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	VJ_STOPSOUND(self.turret_turningsd)
	VJ_STOPSOUND(self.FlameLoopSound)
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/