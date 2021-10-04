AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
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

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
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
	self.Glow:SetLocalPos(self:GetPos() +self:OBBCenter())
	self.Glow:SetLocalAngles(self:GetAngles())
	self.Glow:Fire("Color", "255 125 0")
	self.Glow:SetParent(self)
	self.Glow:Spawn()
	self.Glow:Activate()
	self.Glow:Fire("TurnOn","",0)
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
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/