AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.StartHealth = 425

ENT.BulletResistance = 0.65
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.tbl_Inventory = {}
	self:SetupInventory()
	self:SetSkin(2)
	self:SetCollisionBounds(Vector(50,50,60),Vector(-50,-50,0))
	local v1,v2 = self:GetCollisionBounds()
	self.Height = v2.z
	self.DefaultDistance = self.MeleeAttackDistance
	self.Glow = ents.Create("light_dynamic")
	self.Glow:SetKeyValue("brightness","1")
	self.Glow:SetKeyValue("distance","150")
	self.Glow:SetLocalPos(self:GetPos())
	self.Glow:SetLocalAngles(self:GetAngles())
	self.Glow:Fire("Color", "0 255 50")
	self.Glow:SetParent(self)
	self.Glow:Spawn()
	self.Glow:Activate()
	self.Glow:Fire("TurnOn","",0)
	self.Glow:FollowBone(self,self:LookupBone("Bip01 Spine"))
	self:DeleteOnRemove(self.Glow)
	self.atkData = {
		["left"] = {dmg=32,dist=145},
		["right"] = {dmg=32,dist=145},
		["leftpower"] = {dmg=48,dist=145},
		["rightpower"] = {dmg=48,dist=145},
		["power"] = {dmg=50,dist=180},
		["forwardpower"] = {dmg=50,dist=180},
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
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/