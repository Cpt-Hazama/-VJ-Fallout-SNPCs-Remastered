AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/player/leatherarmor.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 60

ENT.PlayerFriendly = false
ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY","CLASS_COA"} -- NPCs with the same class with be allied to each other

ENT.SpawnWithApparelChance = 0
ENT.SpawnWithHairChance = 2
ENT.SpawnWithBeardChance = 0

local defHair_Male = {
	"models/fallout/player/hair/hairmessy01.mdl",
	"models/fallout/player/hair/hairbalding.mdl",
}

local defHair_Female = {
	"models/fallout/player/hair/haircurly.mdl",
}

ENT.HairColors = {
	["m"] = {
		Color(196,197,135),
		Color(48,47,47),
		Color(143,143,143),
	},
	["f"] = {
		Color(196,197,135),
		Color(48,47,47),
		Color(143,143,143),
	},
}

ENT.Data = {
	["m"] = {
		{mdl={
			"models/fallout/player/wastelandclothing.mdl"},
			hp=60,
			b_scale=1,
			o_scale=1,
			hair=true,
			hairchance=false,
			beards=true,
			beardchance=false,
			apparel=defApparel_Male,
			apparelchance=false
		},
	},
	["f"] = {
		{mdl={
			"models/fallout/player/female/wastelandclothing05.mdl"},
			hp=60,
			b_scale=1,
			o_scale=1,
			hair=true,
			hairchance=false,
			apparel=defApparel_Female,
			apparelchance=false
		},
	}
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:BeforeApparelSpawned()
	self.HairColor = self.Gender == 1 && VJ_PICK(self.HairColors["m"]) or VJ_PICK(self.HairColors["f"])
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomInit()
	self.Gender = math.random(1,2)
	self.SpawnData = self.Gender == 1 && VJ_PICK(self.Data["m"]) or VJ_PICK(self.Data["f"])

	local hp = math.random(self.SpawnData.hp -10,self.SpawnData.hp +10)
	self:SetHealth(hp)
	self:SetMaxHealth(hp)

	self:SetModel(VJ_PICK(self.SpawnData.mdl))
	self:SetCollisionBounds(Vector(18,18,82),Vector(-18,-18,0))

	if self.SpawnData.hair then
		-- self.SpawnWithHairChance = self.SpawnData.hairchance or 1
		if self.SpawnData.hair == true then
			self.tbl_HairModels = self.Gender == 1 && defHair_Male or defHair_Female
		else
			self.tbl_HairModels = self.SpawnData.hair
		end
	end
	if self.SpawnData.apparel then
		self.SpawnWithApparelChance = self.SpawnData.apparelchance or 8
		if self.SpawnData.apparel == true then
			self.tbl_ApparelModels = {
				"models/fallout/headgear/bandana.mdl",
				"models/fallout/glasses/glassesreading.mdl",
				"models/fallout/headgear/cowboyhat.mdl",
				"models/fallout/headgear/cowboyhat2.mdl",
				"models/fallout/headgear/cowboyhat3.mdl",
				"models/fallout/headgear/cowboyhat4.mdl",
				"models/fallout/headgear/cowboyhat5.mdl",
			}
		else
			self.tbl_ApparelModels = self.SpawnData.apparel
		end
	end
	if self.SpawnData.beards then
		self.SpawnWithBeardChance = self.SpawnData.beardchance or (self.Gender == 2 && 0 or 5)
		if self.SpawnData.beards == true then
			self.tbl_BeardModels = {
				"models/fallout/player/beards/beardchincurtain.mdl",
				"models/fallout/player/beards/beardchinwide.mdl",
				"models/fallout/player/beards/beardcircle.mdl",
				"models/fallout/player/beards/beardmustache.mdl",
				"models/fallout/player/beards/beardside.mdl",
				"models/fallout/player/beards/beardthin.mdl",
			}
		else
			self.tbl_BeardModels = self.SpawnData.beards
		end
	end

	if self:GetModel() == "models/fallout/player/wastelandclothing.mdl" then
		self:SetBodygroup(0,4)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:AfterInit()
	self:SetVoice(self.Gender == 1 && "maledefault" or "femaledefault")
end
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/