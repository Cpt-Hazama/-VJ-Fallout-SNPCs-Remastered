AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/weapons/mininuke.mdl"} -- The models it should spawn with | Picks a random one from the table
ENT.DoesRadiusDamage = true -- Should it do a blast damage when it hits something?
ENT.RadiusDamageRadius = 100 -- How far the damage go? The farther away it's from its enemy, the less damage it will do | Counted in world units
ENT.RadiusDamage = 35 -- How much damage should it deal? Remember this is a radius damage, therefore it will do less damage the farther away the entity is from its enemy
ENT.RadiusDamageUseRealisticRadius = true -- Should the damage decrease the farther away the enemy is from the position that the projectile hit?
ENT.RadiusDamageType = bit.bor(DMG_BLAST,DMG_BURN) -- Damage type
ENT.RadiusDamageForce = 50 -- Put the force amount it should apply | false = Don't apply any force
ENT.ShakeWorldOnDeath = true -- Should the world shake when the projectile hits something?
ENT.ShakeWorldOnDeathAmplitude = 8 -- How much the screen will shake | From 1 to 16, 1 = really low 16 = really high
ENT.ShakeWorldOnDeathRadius = 150 -- How far the screen shake goes, in world units
ENT.ShakeWorldOnDeathtDuration = 0.3 -- How long the screen shake will last, in seconds
ENT.ShakeWorldOnDeathFrequency = 100 -- The frequency
ENT.DecalTbl_DeathDecals = {"Scorch"}
ENT.SoundTbl_Idle = {"ambient/fire/fire_big_loop1.wav"}
ENT.SoundTbl_OnCollide = {"ambient/fire/ignite.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomPhysicsObjectOnInitialize(phys)
	phys:Wake()
	phys:SetMass(2)
	phys:EnableDrag(false)
	phys:SetBuoyancyRatio(0)
	
	self:SetNoDraw(true)

	ParticleEffectAttach("flame_particle01",PATTACH_ABSORIGIN_FOLLOW,self,0)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DeathEffects(data,phys)
	local effectdata = EffectData()
	effectdata:SetOrigin(data.HitPos)
	util.Effect("HelicopterMegaBomb",effectdata)

	self.ExplosionLight1 = ents.Create("light_dynamic")
	self.ExplosionLight1:SetKeyValue("brightness", "4")
	self.ExplosionLight1:SetKeyValue("distance", "300")
	self.ExplosionLight1:SetLocalPos(data.HitPos)
	self.ExplosionLight1:SetLocalAngles(self:GetAngles())
	self.ExplosionLight1:Fire("Color", "255 150 0")
	self.ExplosionLight1:SetParent(self)
	self.ExplosionLight1:Spawn()
	self.ExplosionLight1:Activate()
	self.ExplosionLight1:Fire("TurnOn", "", 0)
	self:DeleteOnRemove(self.ExplosionLight1)

	if data.HitEntity == Entity(0) then
		local tr = util.TraceLine({
			start = tr.HitPos,
			endpos = tr.HitPos -Vector(0,0,80),
			mask = CONTENTS_SOLID
		})
		if tr.HitWorld then
			local flame = ents.Create("info_particle_system")
			flame:SetKeyValue("effect_name","env_fire_large")
			flame:SetPos(data.HitPos)
			flame:Spawn()
			flame:Activate() 
			flame:Fire("Start","",0)
			flame:Fire("Kill","",math.random(5,20))
		end
	else
		data.HitEntity:Ignite(5)
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/