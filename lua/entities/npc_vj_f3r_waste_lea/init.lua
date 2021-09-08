AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/player/female/leatherarmor.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 80
ENT.PlayerFriendly = true
ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY"} -- NPCs with the same class with be allied to each other

ENT.HairColor = Color(math.random(0,255),math.random(0,255),math.random(0,255))
ENT.CantHaveHairWithApparel = true
ENT.SpawnWithApparelChance = 4
ENT.SpawnWithHairChance = 1
ENT.SpawnWithBeardChance = 3
ENT.tbl_HairModels = {
	"models/fallout/player/hair/hairraidermid.mdl",
	"models/fallout/player/hair/hairraiderside.mdl",
	"models/fallout/player/hair/hairraiderspike.mdl",
}
ENT.tbl_ApparelModels = {
	"models/fallout/headgear/helmetmetalarmor.mdl",
	"models/fallout/headgear/helmetraider02.mdl",
	"models/fallout/headgear/helmetraider03.mdl",
	"models/fallout/headgear/raiderarmor04_hat.mdl",
	"models/fallout/headgear/raiderarmorhelmet.mdl",
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:BeforeApparelSpawned()
	self.HairColor = Color(math.random(0,255),math.random(0,255),math.random(0,255))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomInit()
	local hp = math.random(self.StartHealth -10,self.StartHealth +10)
	self:SetHealth(hp)
	self:SetMaxHealth(hp)
	
	self:SetVoice("female01")
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/