AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/goregrenade.mdl"} -- The models it should spawn with | Picks a random one from the table
ENT.DoesRadiusDamage = true -- Should it do a blast damage when it hits something?
ENT.RadiusDamageRadius = 300 -- How far the damage go? The farther away it's from its enemy, the less damage it will do | Counted in world units
ENT.RadiusDamageUseRealisticRadius = true -- Should the damage decrease the farther away the enemy is from the position that the projectile hit?
ENT.RadiusDamage = 85 -- How much damage should it deal? Remember this is a radius damage, therefore it will do less damage the farther away the entity is from its enemy
ENT.RadiusDamageType = DMG_RADIATION -- Damage type
ENT.DecalTbl_DeathDecals = {"BeerSplash"}
ENT.SoundTbl_OnCollide = {"vj_fallout/ghoulferal/fx_fire_gas_high01.mp3","vj_fallout/ghoulferal/fx_fire_gas_high02.mp3"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomPhysicsObjectOnInitialize(phys)
	phys:Wake()
	phys:SetMass(1)
	phys:EnableDrag(false)
	phys:SetBuoyancyRatio(0)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnThinkActive()
	ParticleEffectAttach("antlion_gib_02_gas", PATTACH_ABSORIGIN_FOLLOW, self, 0)
	ParticleEffectAttach("blood_impact_green_01", PATTACH_ABSORIGIN_FOLLOW, self, 0)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetNoDraw(false)
	ParticleEffectAttach("goregrenade_splash",PATTACH_ABSORIGIN_FOLLOW,self,0)
	ParticleEffectAttach("antlion_gib_02_gas", PATTACH_ABSORIGIN_FOLLOW, self, 0)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DeathEffects(data,phys)
	for i = 1,math.random(40,70) do
		ParticleEffect("blood_impact_green_01", data.HitPos +self:GetUp() *math.Rand(-4 *i,4 *i) +self:GetForward() *math.Rand(-4 *i,4 *i) +self:GetRight() *math.Rand(-4 *i,4 *i),Angle(0,0,0),nil)
	end
	local max = 130
	local tbl = {}
	for i = 1,math.random(20,30) do
		local vec = data.HitPos +self:GetUp() *math.Rand(-50,max) +self:GetForward() *math.Rand(-max,max) +self:GetRight() *math.Rand(-max,max)
		ParticleEffect("antlion_gib_02_gas",vec, Angle(0,0,0), nil)
		table.insert(tbl,vec)
	end
	for i = 1,3 do
		timer.Simple(i *0.5,function()
			for i = 1,#tbl do
				ParticleEffect("antlion_gib_02_gas",tbl[i], Angle(0,0,0), nil)
			end
		end)
	end

	local radiation = ents.Create("point_vj_f3r_radiation")
	radiation:SetEntityOwner(self)
	radiation:SetEmissionDistance(200)
	radiation:SetRAD(6)
	radiation:SetLife(4)
	radiation:SetPos(self:GetPos())
	radiation:Spawn()
end
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/