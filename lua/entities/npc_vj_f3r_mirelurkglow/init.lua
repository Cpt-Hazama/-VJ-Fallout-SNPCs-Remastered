AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/fallout/mirelurk_hunter.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 350
ENT.GeneralSoundPitch1 = 90
ENT.GeneralSoundPitch2 = 90

ENT.BulletResistance = 0.2
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.tbl_Inventory = {}
	self:SetupInventory()
	self:SetCollisionBounds(Vector(30,30,100),Vector(-30,-30,0))
	self.MeleeAttackDamageType = bit.bor(DMG_SLASH,DMG_RADIATION)
	self:SetMaterial("models/fallout/mirelurk/glowlurk")
	self:SetBodygroup(1,1)
	local v1,v2 = self:GetCollisionBounds()
	self.Height = v2.z
	self.DefaultDistance = self.MeleeAttackDistance
	self:SetSkin(1)
	self.Glow = ents.Create("light_dynamic")
	self.Glow:SetKeyValue("brightness","1")
	self.Glow:SetKeyValue("distance","250")
	self.Glow:SetLocalPos(self:GetPos() +self:OBBCenter())
	self.Glow:SetLocalAngles(self:GetAngles())
	self.Glow:Fire("Color", "0 255 50")
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
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/