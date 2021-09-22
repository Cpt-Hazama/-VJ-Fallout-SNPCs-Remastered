AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/centaur_thing.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 235
ENT.HullType = HULL_HUMAN
ENT.HasDeathRagdoll = false
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_FEV_MUTANT","CLASS_FEV_MUTANT_EAST"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = false -- Should the SNPC have a melee attack?
ENT.GibOnDeathDamagesTable = {"All"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.Explode = CurTime()
	self:SetCollisionBounds(Vector(26,26,45),Vector(-26,-26,0))
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
	elseif string.find(key,"event_mattack") then
		local atk = string.Replace(key,"event_mattack ","")
		self:MeleeAttackCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
	self:Gibs()
	util.VJ_SphereDamage(self,self,self:GetPos(),350,90,DMG_RADIATION,false,true)
	VJ_EmitSound(self,"physics/flesh/flesh_bloody_break.wav",95,100)
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Gibs()
	local bloodeffect = EffectData()
	bloodeffect:SetOrigin(self:GetPos() +self:OBBCenter())
	bloodeffect:SetColor(VJ_Color2Byte(Color(255,221,35)))
	bloodeffect:SetScale(300)
	util.Effect("VJ_Blood1",bloodeffect)
	
	local bloodspray = EffectData()
	bloodspray:SetOrigin(self:GetPos() +self:OBBCenter())
	bloodspray:SetScale(75)
	bloodspray:SetFlags(3)
	bloodspray:SetColor(1)
	util.Effect("bloodspray",bloodspray)
	util.Effect("bloodspray",bloodspray)
	for i = 1,math.random(8,12) do
		self:CreateGibEntity("obj_vj_gib","UseHuman_Big")
	end
	for i = 1,math.random(8,12) do
		self:CreateGibEntity("obj_vj_gib","UseHuman_Small")
	end
	for i = 1,math.random(8,12) do
		self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	end
	for i = 1,math.random(8,12) do
		self:CreateGibEntity("obj_vj_gib","UseAlien_Small")
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:ExplodeEf()
	self:Gibs()
	util.VJ_SphereDamage(self,self,self:GetPos(),350,90,DMG_RADIATION,false,true)
	VJ_EmitSound(self,"physics/flesh/flesh_bloody_break.wav",95,100)
	self:Remove()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	if GetConVarNumber("ai_disabled") == 1 then return end
	if IsValid(self:GetEnemy()) then
		local enemy = self:GetEnemy()
		local dist = self:VJ_GetNearestPointToEntityDistance(enemy)
		if dist <= 85 && CurTime() > self.Explode then
			self:VJ_ACT_PLAYACTIVITY("vjseq_h2haim",true,nil,false)
			VJ_EmitSound(self,"vj_gib/gibbing" .. math.random(1,3) .. ".wav",85,100)
			timer.Simple(1,function() if IsValid(self) then self:ExplodeEf() end end)
			self.Explode = CurTime() +15
		end
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/