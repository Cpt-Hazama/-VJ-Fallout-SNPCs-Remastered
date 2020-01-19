AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/weapons/mininuke.mdl"} -- The models it should spawn with | Picks a random one from the table
ENT.DoesRadiusDamage = true -- Should it do a blast damage when it hits something?
ENT.RadiusDamageRadius = 850 -- How far the damage go? The farther away it's from its enemy, the less damage it will do | Counted in world units
ENT.RadiusDamage = 950 -- How much damage should it deal? Remember this is a radius damage, therefore it will do less damage the farther away the entity is from its enemy
ENT.RadiusDamageUseRealisticRadius = true -- Should the damage decrease the farther away the enemy is from the position that the projectile hit?
ENT.RadiusDamageType = DMG_BLAST -- Damage type
ENT.RadiusDamageForce = 350 -- Put the force amount it should apply | false = Don't apply any force
ENT.ShakeWorldOnDeath = true -- Should the world shake when the projectile hits something?
ENT.ShakeWorldOnDeathAmplitude = 16 -- How much the screen will shake | From 1 to 16, 1 = really low 16 = really high
ENT.ShakeWorldOnDeathRadius = 10000 -- How far the screen shake goes, in world units
ENT.ShakeWorldOnDeathtDuration = 8 -- How long the screen shake will last, in seconds
ENT.ShakeWorldOnDeathFrequency = 200 -- The frequency
ENT.DecalTbl_DeathDecals = {"Scorch"}
ENT.SoundTbl_Idle = {"weapons/rpg/rocket1.wav"}
ENT.SoundTbl_OnCollide = {"ambient/explosions/explode_8.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomPhysicsObjectOnInitialize(phys)
	phys:Wake()
	phys:SetMass(2)
	phys:EnableDrag(false)
	phys:SetBuoyancyRatio(0)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DeathEffects(data,phys)
	-- local tr = {}
	-- tr.start = self:GetPos() +Vector(0,0,32)
	-- tr.endpos = self:GetPos() -Vector(0,0,128)
	-- tr.Entity = self
	-- tr.mask = 16395
	-- local normal = util.TraceLine(tr).HitNormal

	-- local effectdata = EffectData()
	-- effectdata:SetOrigin(data.HitPos)
	-- effectdata:SetNormal(normal)
	-- effectdata:SetScale(1 ^0.65)
	-- util.Effect("vj_fo3_fatman",effectdata)

	for i = 1,math.random(2,5) do
		local rand = 20
		local effectdata = EffectData()
		effectdata:SetOrigin(data.HitPos +Vector(math.Rand(-(rand *i),rand *i),math.Rand(-(rand *i),rand *i),math.Rand(rand *i,rand *i)))
		util.Effect("VJ_Medium_Explosion1",effectdata)
		ParticleEffect("vj_explosion2",data.HitPos +Vector(math.Rand(-(rand *i),rand *i),math.Rand(-(rand *i),rand *i),math.Rand(rand *i,rand *i)),Angle(0,0,0),nil)
		ParticleEffect("vj_mininuke_explosion_fix",data.HitPos +Vector(math.Rand(-(rand *i),rand *i),math.Rand(-(rand *i),rand *i),math.Rand(rand *i,rand *i)),Angle(0,0,0),nil)
	end

	if CLIENT then
		surface.PlaySound("vj_fallout/explosion/explosion_nuke_small_3d.mp3")
	end
	self:EmitSound("vj_fallout/explosion/explosion_nuke_small_3d.mp3",150,100)

	self.ExplosionLight1 = ents.Create("light_dynamic")
	self.ExplosionLight1:SetKeyValue("brightness", "4")
	self.ExplosionLight1:SetKeyValue("distance", "800")
	self.ExplosionLight1:SetLocalPos(data.HitPos)
	self.ExplosionLight1:SetLocalAngles(self:GetAngles())
	self.ExplosionLight1:Fire("Color", "255 150 0")
	self.ExplosionLight1:SetParent(self)
	self.ExplosionLight1:Spawn()
	self.ExplosionLight1:Activate()
	self.ExplosionLight1:Fire("TurnOn", "", 0)
	self:DeleteOnRemove(self.ExplosionLight1)
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/