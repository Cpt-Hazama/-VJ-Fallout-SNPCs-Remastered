AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.StartHealth = 600
ENT.RangeAttackEntityToSpawn = "obj_vj_f3r_spit"

ENT.IsKing = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.tbl_Inventory = {}
	self:SetupInventory()
	self:SetSkin(1)
	self:SetCollisionBounds(Vector(26,26,80),Vector(-26,-26,0))
	local v1,v2 = self:GetCollisionBounds()
	self.Height = v2.z
	self.DefaultDistance = self.MeleeAttackDistance
	self.atkData = {
		["leftjab"] = {dmg=35,dist=120},
		["rightjab"] = {dmg=35,dist=120},
		["leftslice"] = {dmg=35,dist=120},
		["rightslice"] = {dmg=35,dist=120},
		["backhand"] = {dmg=45,dist=120},
		["forward"] = {dmg=45,dist=140},
	}
	self.sndData = {
		["Attack"] = {
			tbl={
				"vj_fallout/mirelurkking/mirelurkking_attack01.mp3",
				"vj_fallout/mirelurkking/mirelurkking_attack02.mp3",
				"vj_fallout/mirelurkking/mirelurkking_attack03.mp3",
			},
			vol=75,
			pitch=100
		},
		["MeleePower"] = {
			tbl={
				"vj_fallout/mirelurkking/mirelurkking_attack03.mp3",
			},
			vol=75,
			pitch=100
		},
		["MeleePowerRun"] = {
			tbl={
				"vj_fallout/mirelurkking/mirelurkking_attack03.mp3"
			},
			vol=75,
			pitch=100
		},
		["IdleAngry"] = {
			tbl={
				"vj_fallout/mirelurkking/mirelurkking_equip.mp3",
			},
			vol=82,
			pitch=100
		}
	}
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/