/*--------------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
AddCSLuaFile()
if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end

ENT.Type 			= "anim"
ENT.Base 			= "obj_vj_projectile_base"
ENT.PrintName		= "Mini-Nuke"
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Information		= "Projectiles for my addons"
ENT.Category		= "Projectiles"

if (CLIENT) then
	local Name = "Mini-Nuke"
	local LangName = "obj_vj_f3r_mininuke_prime"
	language.Add(LangName, Name)
	killicon.Add(LangName,"HUD/killicons/default",Color(255,80,0,255))
	language.Add("#"..LangName, Name)
	killicon.Add("#"..LangName,"HUD/killicons/default",Color(255,80,0,255))

	net.Receive("VJ_F3R_NukeSound",function(len,ply)
		local self = net.ReadEntity()
		local ent = LocalPlayer()
		surface.PlaySound("vj_fallout/explosion/nuke_start.wav")
		if IsValid(ent) then
			local time = math.Clamp((((self:GetPos() -ent:GetPos()):Length() /16) /343) *0.9,0,8)
			timer.Simple(time,function()
				if IsValid(ent) then
					ent:EmitSound("vj_fallout/explosion/nuke_end.wav",150,100)
				end
			end)
		end
	end)
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if !SERVER then return end

util.AddNetworkString("VJ_F3R_NukeSound")

ENT.Model = {"models/fallout/mininuke.mdl"} -- The models it should spawn with | Picks a random one from the table
ENT.DoesRadiusDamage = true -- Should it do a blast damage when it hits something?
ENT.RadiusDamageRadius = 5000 -- How far the damage go? The farther away it's from its enemy, the less damage it will do | Counted in world units
ENT.RadiusDamage = 15000 -- How much damage should it deal? Remember this is a radius damage, therefore it will do less damage the farther away the entity is from its enemy
ENT.RadiusDamageUseRealisticRadius = true -- Should the damage decrease the farther away the enemy is from the position that the projectile hit?
ENT.RadiusDamageType = DMG_BLAST -- Damage type
ENT.RadiusDamageForce = 12000 -- Put the force amount it should apply | false = Don't apply any force
ENT.ShakeWorldOnDeath = true -- Should the world shake when the projectile hits something?
ENT.ShakeWorldOnDeathAmplitude = 16 -- How much the screen will shake | From 1 to 16, 1 = really low 16 = really high
ENT.ShakeWorldOnDeathRadius = 20000 -- How far the screen shake goes, in world units
ENT.ShakeWorldOnDeathDuration = 15 -- How long the screen shake will last, in seconds
ENT.ShakeWorldOnDeathtDuration = 15 -- How long the screen shake will last, in seconds
ENT.ShakeWorldOnDeathFrequency = 230 -- The frequency
ENT.DecalTbl_DeathDecals = {"Scorch"}
-- ENT.SoundTbl_OnCollide = {"vj_fallout/explosion/explosion_nuke_small_3d.mp3"}
---------------------------------------------------------------------------------------------------------------------------------------------
local defAngle = Angle(0, 0, 0)
--
function ENT:DeathEffects(data,phys)
	-- local effectdata = EffectData()
	-- effectdata:SetOrigin(data.HitPos)
	-- util.Effect("Explosion", effectdata)
	-- util.Effect("VJ_Small_Explosion1", effectdata)
	-- ParticleEffect("vj_explosion3", data.HitPos, defAngle)
	-- ParticleEffect("mininuke_explosion", data.HitPos, defAngle)
	-- ParticleEffect("fo4_mininuke_explosion", data.HitPos, defAngle)
	ParticleEffect("nuke_explosion_core", data.HitPos, defAngle)

	self:EmitSound("vj_fallout/explosion/nuke_start.wav",180,100,1,CHAN_STATIC)
	net.Start("VJ_F3R_NukeSound")
		net.WriteEntity(self)
	net.Broadcast()

	local radiation = ents.Create("point_vj_f3r_radiation")
	radiation:SetEntityOwner(self)
	radiation:SetEmissionDistance(self.RadiusDamageRadius *2.15)
	radiation:SetRAD(50)
	radiation:SetLife(30)
	radiation:SetPos(self:GetPos() +Vector(0,0,5))
	radiation:Spawn()

	local pos = self:GetPos()
	local rad = self.RadiusDamageRadius
	local force = self.RadiusDamageForce
	local count = 25

	for i = 1,count do
		timer.Simple(i *0.125,function()
			local ent = ents.FindInSphere(pos,rad)
			for k,v in pairs(ent) do
				if IsValid(v) then
					local force = (pos -(v:GetPos() +v:OBBCenter())):GetNormalized() *(force *(1 -(i /count)))
					local phys = v:GetPhysicsObject()
					if IsValid(phys) then
						phys:EnableMotion(true)
						phys:Wake()
						constraint.RemoveConstraints(v,"Weld")
						phys:ApplyForceCenter(force)
					else
						v:SetGroundEntity(NULL)
						v:SetVelocity(force)
					end
				end
			end
		end)
	end

	local explosionLight = ents.Create("light_dynamic")
	explosionLight:SetKeyValue("brightness", "10")
	explosionLight:SetKeyValue("distance", "2000")
	explosionLight:SetLocalPos(data.HitPos)
	explosionLight:SetLocalAngles(self:GetAngles())
	explosionLight:Fire("Color", "255 150 0")
	explosionLight:SetParent(self)
	explosionLight:Spawn()
	explosionLight:Activate()
	explosionLight:Fire("TurnOn", "", 0)
	timer.Simple(12,function()
		if IsValid(explosionLight) then
			explosionLight:Fire("Kill", "", 0)
		end
	end)
	-- self:DeleteOnRemove(explosionLight)
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/