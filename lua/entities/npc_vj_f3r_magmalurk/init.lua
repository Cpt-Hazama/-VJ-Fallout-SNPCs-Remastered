AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/fallout/magmalurk.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 3500
ENT.HullType = HULL_LARGE
ENT.MeleeAttackDistance = 150
ENT.Immune_AcidPoisonRadiation = true
ENT.Immune_Physics = true
ENT.Immune_Fire = true
ENT.AllowIgnition = false
ENT.MeleeAttackSetEnemyOnFire = true -- Sets the enemy on fire when it does the melee attack
ENT.MeleeAttackSetEnemyOnFireTime = 15

ENT.SoundTbl_FootStepL = {
	"vj_fallout/magmalurk/foot/mirelurk_foot_l01.mp3",
	"vj_fallout/magmalurk/foot/mirelurk_foot_l02.mp3",
}
ENT.SoundTbl_FootStepR = {
	"vj_fallout/magmalurk/foot/mirelurk_foot_r01.mp3",
	"vj_fallout/magmalurk/foot/mirelurk_foot_r02.mp3",
}
ENT.SoundTbl_Idle = {
	"vj_fallout/magmalurk/mirelurk_idle01.mp3",
	"vj_fallout/magmalurk/mirelurk_idle02.mp3",
	"vj_fallout/magmalurk/mirelurk_idle03.mp3",
}
ENT.SoundTbl_Pain = {
	"vj_fallout/magmalurk/mirelurk_injured01.mp3",
	"vj_fallout/magmalurk/mirelurk_injured02.mp3",
}
ENT.SoundTbl_Death = {
	"vj_fallout/magmalurk/mirelurk_death01.mp3",
	"vj_fallout/magmalurk/mirelurk_death02.mp3",
}
ENT.BulletResistance = 0.25
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.tbl_Inventory = {}
	self:SetupInventory()
	self:SetCollisionBounds(Vector(53,53,150),Vector(-53,-53,0))
	local v1,v2 = self:GetCollisionBounds()
	self.Height = v2.z
	self.DefaultDistance = self.MeleeAttackDistance
	self.Glow = ents.Create("light_dynamic")
	self.Glow:SetKeyValue("brightness","1")
	self.Glow:SetKeyValue("distance","350")
	self.Glow:SetLocalPos(self:GetPos() +self:OBBCenter())
	self.Glow:SetLocalAngles(self:GetAngles())
	self.Glow:Fire("Color", "255 50 0")
	self.Glow:SetParent(self)
	self.Glow:Spawn()
	self.Glow:Activate()
	self.Glow:Fire("TurnOn","",0)
	self:DeleteOnRemove(self.Glow)
	self.tbl_Flames = {}
	for i = 1, 8 do self.tbl_Flames[i] = {nextEmit = CurTime() +math.Rand(0,14), emitting = false} end
	self.atkData = {
		["left"] = {dmg=125,dist=210},
		["right"] = {dmg=125,dist=210},
		["leftpower"] = {dmg=185,dist=210},
		["rightpower"] = {dmg=185,dist=210},
		["power"] = {dmg=260,dist=210},
		["forwardpower"] = {dmg=260,dist=235},
	}
	self.sndData = {
		["Melee"] = {
			tbl={
				"vj_fallout/magmalurk/mirelurk_attack01.mp3",
				"vj_fallout/magmalurk/mirelurk_attack02.mp3",
			},
			vol=84,
			pitch=100
		},
		["MeleePower"] = {
			tbl={
				"vj_fallout/magmalurk/mirelurk_attackpower01.mp3",
			},
			vol=84,
			pitch=100
		},
		["MeleePowerRun"] = {
			tbl={
				"vj_fallout/magmalurk/mirelurk_attackpowerforward01.mp3",
				"vj_fallout/magmalurk/mirelurk_attackpowerrun01.mp3"
			},
			vol=84,
			pitch=100
		},
		["IdleAngry"] = {
			tbl={
				"vj_fallout/magmalurk/mirelurk_warning.mp3",
			},
			vol=84,
			pitch=100
		}
	}
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Particle(att,delay)
	if self.tbl_Flames[att].emitting then return end
	local prt = ents.Create("info_particle_system")
	prt:SetKeyValue("start_active","1")
	prt:SetKeyValue("effect_name","magmalurk_flame")
	prt:SetParent(self)
	prt:Spawn()
	prt:Activate()
	self:DeleteOnRemove(prt)
	prt:Fire("SetParentAttachment","flame" .. att,0)
	
	local csp = CreateSound(prt,"vj_fallout/magmalurk/magmalurk_flame_lp.wav")
	csp:SetSoundLevel(90)
	csp:Play()
	self:StopSoundOnDeath(csp)
	self.tbl_Flames[att].csp = csp
	self.tbl_Flames[att].nextStop = CurTime() +(delay || math.Rand(0.6,2))
	self.tbl_Flames[att].prt = prt
	self.tbl_Flames[att].emitting = true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:StopSoundOnDeath(csp)
	if !self.remove then self.remove = {} end
	table.insert(self.remove,csp)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	if !self.remove then self.remove = {} end
	for _,v in pairs(self.remove) do v:Stop() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	local idle = self.Alerted && ACT_IDLE_STIMULATED or ACT_IDLE
	local walk = self.Alerted && ACT_WALK_AIM or ACT_WALK
	local run = self.Alerted && ACT_RUN_AIM or ACT_RUN
	if (self:Health() <= self:GetMaxHealth() *0.35) then idle = ACT_IDLE; walk = ACT_WALK_HURT; run = ACT_RUN_HURT end
	self.AnimTbl_IdleStand = {idle}
	self.AnimTbl_Walk = {walk}
	self.AnimTbl_Run = {run}

	for i,data in pairs(self.tbl_Flames) do
		if !data.emitting then
			if CurTime() >= data.nextEmit then
				self:Particle(i,nil)
			end
		elseif CurTime() >= data.nextStop then
			local rand
			if IsValid(self:GetEnemy()) then
				rand = math.Rand(1,4)
			else
				rand = math.Rand(2,14)
			end
			data.csp:Stop()
			VJ_EmitSound(self,"vj_fallout/magmalurk/magmalurk_flame_end.wav",85,100)
			if IsValid(data.prt) then
				data.prt:Remove()
			end
			self.tbl_Flames[i].emitting = false
			self.tbl_Flames[i].nextEmit = CurTime() +rand
		end
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/