AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/spitball_small.mdl"} -- The models it should spawn with | Picks a random one from the table
ENT.DoesDirectDamage = true -- Should it do a direct damage when it hits something?
ENT.DirectDamage = 12 -- How much damage should it do when it hits something
ENT.DirectDamageType = DMG_RADIATION -- Damage type
ENT.DecalTbl_DeathDecals = {"BeerSplash"}
ENT.SoundTbl_OnCollide = {"vj_flesh/alien_flesh1.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomPhysicsObjectOnInitialize(phys)
	phys:Wake()
	phys:SetMass(1)
	phys:EnableDrag(false)
	phys:SetBuoyancyRatio(0)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	ParticleEffectAttach("antlion_gib_02_gas", PATTACH_ABSORIGIN_FOLLOW, self, 0)
	ParticleEffectAttach("antlion_gib_02_gas", PATTACH_ABSORIGIN_FOLLOW, self, 0)
	self:NextThink(CurTime()+(0.069696968793869+FrameTime()))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetNoDraw(true)
	self:DrawShadow(false)
	ParticleEffectAttach("centaur_spit",PATTACH_ABSORIGIN_FOLLOW,self,0)
	ParticleEffectAttach("antlion_spit_trail", PATTACH_ABSORIGIN_FOLLOW, self, 0)
	timer.Simple(0.02,function()
		if IsValid(self) then
			if self:GetOwner():GetClass() == "npc_vj_f3r_mirelurkswampque" then ParticleEffectAttach("fo3_mirelurk_pulse",PATTACH_ABSORIGIN_FOLLOW,self,0) end
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DeathEffects(data,phys)
	ParticleEffect("blood_impact_green_01",data.HitPos,Angle(0,0,0),nil)
	ParticleEffect("antlion_gib_02_gas", data.HitPos, Angle(0,0,0), nil)
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/