AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/props_junk/watermelon01_chunk02c.mdl"} -- The models it should spawn with | Picks a random one from the table
ENT.DoesDirectDamage = true -- Should it do a direct damage when it hits something?
ENT.DirectDamage = 18 -- How much damage should it do when it hits something
ENT.DirectDamageType = DMG_PLASMA -- Damage type
ENT.DecalTbl_DeathDecals = {"Scorch"}
-- ENT.SoundTbl_OnCollide = {"player/general/sonic_damage.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomPhysicsObjectOnInitialize(phys)
	phys:Wake()
	phys:SetMass(1)
	phys:EnableDrag(false)
	phys:EnableGravity(false)
	phys:SetBuoyancyRatio(0)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:DrawShadow(false)
	ParticleEffectAttach("plasma_projectile_trail",PATTACH_ABSORIGIN_FOLLOW,self,0)

	self.StartLight1 = ents.Create("light_dynamic")
	self.StartLight1:SetKeyValue("brightness", "5")
	self.StartLight1:SetKeyValue("distance", "60")
	self.StartLight1:SetLocalPos(self:GetPos())
	self.StartLight1:SetLocalAngles(self:GetAngles())
	self.StartLight1:Fire("Color", "0 200 0 100")
	self.StartLight1:SetParent(self)
	self.StartLight1:Spawn()
	self.StartLight1:Activate()
	self.StartLight1:Fire("TurnOn", "", 0)
	self:DeleteOnRemove(self.StartLight1)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetVelocity(self:GetAngles():Forward() *4000)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DeathEffects(data,phys)
	self.StartLight1:SetKeyValue("brightness","8")
	self.StartLight1:SetKeyValue("distance","100")
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/