AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/barkscorpion.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 85
ENT.MeleeAttackDistance = 50
ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.tbl_Inventory = {}
	self:SetupInventory()
	self:SetSkin(1)
	self:SetCollisionBounds(Vector(25,25,35),Vector(-25,-25,0))
	local v1,v2 = self:GetCollisionBounds()
	self.Height = v2.z
	self.DefaultDistance = self.MeleeAttackDistance
	self.atkData = {
		["left"] = {dmg=8,dist=100},
		["right"] = {dmg=8,dist=100},
		["leftpower"] = {dmg=15,dist=100},
		["rightpower"] = {dmg=15,dist=100},
		["power"] = {dmg=20,dist=120},
		["forwardpower"] = {dmg=20,dist=120},
	}
	self.sndData = {
		["Melee"] = {
			tbl={
				"vj_fallout/radscorpion/radscorpion_attack01.mp3",
				"vj_fallout/radscorpion/radscorpion_attack02.mp3",
				"vj_fallout/radscorpion/radscorpion_attack03.mp3",
			},
			vol=65,
			pitch=115
		},
		["MeleePower"] = {
			tbl={
				"vj_fallout/radscorpion/radscorpion_attacktail01.mp3",
			},
			vol=65,
			pitch=115
		},
		["MeleePowerRun"] = {
			tbl={
				"vj_fallout/radscorpion/radscorpion_attacktail01.mp3"
			},
			vol=65,
			pitch=115
		},
		["AttackSting"] = {
			tbl={
				"vj_fallout/radscorpion/radscorpion_attackstingvox01.mp3",
				"vj_fallout/radscorpion/radscorpion_attackstingvox02.mp3",
				"vj_fallout/radscorpion/radscorpion_attackstingvox03.mp3",
				"vj_fallout/radscorpion/radscorpion_attackstingvox04.mp3",
			},
			vol=65,
			pitch=115
		},
		["Strike"] = {
			tbl={
				"vj_fallout/radscorpion/radscorpion_strikevox01.mp3",
				"vj_fallout/radscorpion/radscorpion_strikevox02.mp3",
				"vj_fallout/radscorpion/radscorpion_strikevox03.mp3",
				"vj_fallout/radscorpion/radscorpion_strikevox04.mp3",
			},
			vol=65,
			pitch=115
		},
		["IdleAngry"] = {
			tbl={
				"vj_fallout/radscorpion/radscorpion_aware.mp3",
			},
			vol=65,
			pitch=115
		}
	}
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/