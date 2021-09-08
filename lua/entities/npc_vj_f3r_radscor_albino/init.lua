AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/albinoradscorpion.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 950

ENT.BulletResistance = 0.5
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.tbl_Inventory = {}
	self:SetupInventory()
	self:SetCollisionBounds(Vector(50,50,60),Vector(-50,-50,0))
	local v1,v2 = self:GetCollisionBounds()
	self.Height = v2.z
	self.DefaultDistance = self.MeleeAttackDistance
	self.atkData = {
		["left"] = {dmg=48,dist=145},
		["right"] = {dmg=48,dist=145},
		["leftpower"] = {dmg=55,dist=145},
		["rightpower"] = {dmg=55,dist=145},
		["power"] = {dmg=65,dist=180},
		["forwardpower"] = {dmg=65,dist=180},
	}
	self.sndData = {
		["Melee"] = {
			tbl={
				"vj_fallout/radscorpion/radscorpion_attack01.mp3",
				"vj_fallout/radscorpion/radscorpion_attack02.mp3",
				"vj_fallout/radscorpion/radscorpion_attack03.mp3",
			},
			vol=75,
			pitch=100
		},
		["MeleePower"] = {
			tbl={
				"vj_fallout/radscorpion/radscorpion_attacktail01.mp3",
			},
			vol=75,
			pitch=100
		},
		["MeleePowerRun"] = {
			tbl={
				"vj_fallout/radscorpion/radscorpion_attacktail01.mp3"
			},
			vol=75,
			pitch=100
		},
		["AttackSting"] = {
			tbl={
				"vj_fallout/radscorpion/radscorpion_attackstingvox01.mp3",
				"vj_fallout/radscorpion/radscorpion_attackstingvox02.mp3",
				"vj_fallout/radscorpion/radscorpion_attackstingvox03.mp3",
				"vj_fallout/radscorpion/radscorpion_attackstingvox04.mp3",
			},
			vol=75,
			pitch=100
		},
		["Strike"] = {
			tbl={
				"vj_fallout/radscorpion/radscorpion_strikevox01.mp3",
				"vj_fallout/radscorpion/radscorpion_strikevox02.mp3",
				"vj_fallout/radscorpion/radscorpion_strikevox03.mp3",
				"vj_fallout/radscorpion/radscorpion_strikevox04.mp3",
			},
			vol=75,
			pitch=100
		},
		["IdleAngry"] = {
			tbl={
				"vj_fallout/radscorpion/radscorpion_aware.mp3",
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