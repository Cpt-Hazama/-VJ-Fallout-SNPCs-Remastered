AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/player/chinesestealth.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 65

ENT.VJ_NPC_Class = {"CLASS_CHINA"} -- NPCs with the same class with be allied to each other
ENT.Human_IsSoldier = true

ENT.SpawnWithApparelChance = 1
ENT.tbl_ApparelModels = {"models/fallout/headgear/chinesestealthhelmf.mdl"}
-- ENT.SpawnWithHairChance = 1
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:BeforeApparelSpawned()
	self.HairColor = VJ_PICK({Color(0,0,0),Color(61,30,0)})
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomInit()
	local hp = math.random(self.StartHealth -10,self.StartHealth +10)
	self:SetHealth(hp)
	self:SetMaxHealth(hp)

	self.Gender = math.random(1,15) == 1 && 2 or 1
	self:SetModel(self.Gender == 1 && "models/fallout/player/chinesestealth.mdl" or "models/fallout/player/female/chinesestealth.mdl")
	self:SetCollisionBounds(Vector(18,18,82),Vector(-18,-18,0))
	
	self:SetBodygroup(3,2)

	-- if self.Gender == 1 then
	-- 	self.tbl_HairModels = {
	-- 		"models/fallout/player/hair/haircurly.mdl",
	-- 	}
	-- else
	-- 	self.tbl_HairModels = {
	-- 		"models/fallout/player/hair/hairbun.mdl",
	-- 		"models/fallout/player/hair/haircurly.mdl",
	-- 	}
	-- end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:AfterInit()
	self:SetVoice(self.Gender == 2 && "femaledefault" or "maledefault")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomInventory()
	self:AddToInventory(ITEM_VJ_STIMPACK,nil,math.random(12,15))
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/