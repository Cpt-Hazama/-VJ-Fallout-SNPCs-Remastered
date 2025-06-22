AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/fallout/mirelurk_hunter.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 400
ENT.GeneralSoundPitch1 = 65
ENT.GeneralSoundPitch2 = 75
ENT.FootStepPitch = VJ_Set(50, 60)

ENT.Immune_Fire = true
ENT.MeleeAttackSetEnemyOnFireTime = 4

ENT.HasRangeAttack = false -- Should the SNPC have a range attack?
ENT.RangeAttackEntityToSpawn = "obj_vj_f3r_heavyflame" -- The entity that is spawned when range attacking
ENT.AnimTbl_RangeAttack = {"vjseq_idle_feed"} -- Range Attack Animations
ENT.RangeDistance = 800 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 500 -- How close does it have to be until it uses melee?
ENT.RangeAttackAngleRadius = 60 -- What is the attack angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
ENT.TimeUntilRangeAttackProjectileRelease = 0.8 -- How much time until the projectile code is ran?
ENT.RangeAttackReps = 3
ENT.NextRangeAttackTime = 8 -- How much time until it can use a range attack?
ENT.RangeUseAttachmentForPos = true -- Should the projectile spawn on a attachment?
ENT.RangeUseAttachmentForPosID = "attach_head"

ENT.BulletResistance = 0.2
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_AfterChecks(hitEnt, isProp)
	hitEnt:Ignite(self.MeleeAttackSetEnemyOnFireTime)
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackCode_GetShootPos(TheProjectile)
	return self:CalculateProjectile("Curve",TheProjectile:GetPos(),self:GetEnemy():GetPos() +self:GetEnemy():OBBCenter(),700)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.tbl_Inventory = {}
	self:SetupInventory()
	self:SetCollisionBounds(Vector(30,30,100),Vector(-30,-30,0))
	self.MeleeAttackDamageType = bit.bor(DMG_SLASH,DMG_BURN)
	self:SetMaterial("models/fallout/mirelurk/firelurk")
	local v1,v2 = self:GetCollisionBounds()
	self.Height = v2.z
	self.DefaultDistance = self.MeleeAttackDistance
	self:SetSkin(1)
	self.Glow = ents.Create("light_dynamic")
	self.Glow:SetKeyValue("brightness","1")
	self.Glow:SetKeyValue("distance","250")
	self.Glow:SetLocalPos(self:GetPos())
	self.Glow:SetLocalAngles(self:GetAngles())
	self.Glow:Fire("Color", "255 125 0")
	self.Glow:SetParent(self)
	self.Glow:Spawn()
	self.Glow:Activate()
	self.Glow:Fire("TurnOn","",0)
	self.Glow:FollowBone(self,self:LookupBone("Bip01 Spine"))
	self:DeleteOnRemove(self.Glow)
	self.atkData = {
		["left"] = {dmg=41,dist=135},
		["right"] = {dmg=41,dist=135},
		["leftpower"] = {dmg=55,dist=135},
		["rightpower"] = {dmg=55,dist=135},
		["power"] = {dmg=84,dist=135},
		["forwardpower"] = {dmg=84,dist=155},
	}
	self.sndData = {
		["Melee"] = {
			tbl={
				"vj_fallout/mirelurk/mirelurk_attack01.mp3",
				"vj_fallout/mirelurk/mirelurk_attack02.mp3",
			},
			vol=75,
			pitch=90
		},
		["MeleePower"] = {
			tbl={
				"vj_fallout/mirelurk/mirelurk_attackpower01.mp3",
			},
			vol=75,
			pitch=90
		},
		["MeleePowerRun"] = {
			tbl={
				"vj_fallout/mirelurk/mirelurk_attackpowerforward01.mp3",
				"vj_fallout/mirelurk/mirelurk_attackpowerrun01.mp3"
			},
			vol=75,
			pitch=90
		},
		["IdleAngry"] = {
			tbl={
				"vj_fallout/mirelurk/mirelurk_warning.mp3",
			},
			vol=75,
			pitch=100
		}
	}
	
	self.FlameLP = CreateSound(self,"vj_fallout/giantant/flamerant_fire_lp.wav")
	self.FlameLP:ChangeVolume(78)

	self.InFlameAttack = false
	self.NextCanFlameAttackT = 0
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:ResetFlameCode()
	self.FlameLP:Stop()
	self:StopParticles()
	self.InFlameAttack = false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:FlameAttackCode(cont)
	if CurTime() < self.NextCanFlameAttackT then return end
	if !self.InFlameAttack then
		self.InFlameAttack = true
		self.FlameLP:Play()
		ParticleEffectAttach("flame_gargantua", PATTACH_POINT_FOLLOW, self, 1)
		ParticleEffectAttach("flame_gargantua", PATTACH_POINT_FOLLOW, self, 2)
		self.NextCanFlameAttackT = CurTime() +(VJ_GetSequenceDuration(self, ACT_ARM) +VJ_GetSequenceDuration(self, ACT_DISARM)) +(cont && 0 or math.random(6,12))
		self:VJ_ACT_PLAYACTIVITY(ACT_ARM,true,false,true,0,{OnFinish=function(interrupted,anim)
			if interrupted then
				self:ResetFlameCode()
				return
			end

			self:VJ_ACT_PLAYACTIVITY(ACT_DISARM,true,false,true,0,{OnFinish=function(interrupted,anim)
				self:ResetFlameCode()
			end})
		end})
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnThink()
	if self.InFlameAttack then
		local att1 = self:GetAttachment(1)
		local att2 = self:GetAttachment(2)
		self:DoFlameDamage(225,2,self,30,1,att1.Pos,att1.Ang:Forward())
		self:DoFlameDamage(225,2,self,30,1,att2.Pos,att2.Ang:Forward())
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomAttack(ent, entVisible)
	local dist = self.EnemyData.DistanceNearest
	local cont = self.VJ_TheController

	if IsValid(cont) then
		if cont:KeyDown(IN_ATTACK2) then
			self:FlameAttackCode(true)
		end
		return
	end

	if IsValid(ent) && dist <= 200 && entVisible then
		if !self:IsBusy() then
			self:FlameAttackCode()
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	self.FlameLP:Stop()
end
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/