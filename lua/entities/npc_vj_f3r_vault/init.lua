AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/player/vaultsuit.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 65

ENT.PlayerFriendly = true
ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY","CLASS_VAULT101"} -- NPCs with the same class with be allied to each other

ENT.CantHaveHairWithApparel = false
ENT.SpawnWithApparelChance = 0
ENT.SpawnWithHairChance = 1
ENT.SpawnWithBeardChance = 0

ENT.VaultGuard = false

ENT.HairColors = {
	["m"] = {
		Color(196,197,135),
		Color(61,30,0),
		Color(0,0,0),
		Color(48,47,47),
		Color(143,143,143),
	},
	["f"] = {
		Color(196,197,135),
		Color(61,30,0),
		Color(0,0,0),
		Color(48,47,47),
		Color(143,143,143),
		Color(83,0,0),
		Color(17,12,41),
	},
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:BeforeApparelSpawned()
	self.HairColor = self.Gender == 1 && VJ_PICK(self.HairColors["m"]) or VJ_PICK(self.HairColors["f"])
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomInit()
	local hp = math.random(self.StartHealth -10,self.StartHealth +10)
	self:SetHealth(hp)
	self:SetMaxHealth(hp)

	self.Gender = math.random(1,2)
	if self.Gender == 1 then
		self:SetModel(self.VaultGuard && "models/fallout/player/vaultsecurity.mdl" or "models/fallout/player/vaultsuit.mdl")
		self.SpawnWithBeardChance = 2
	else
		self:SetModel(self.VaultGuard && "models/fallout/player/female/vaultsecurity.mdl" or "models/fallout/player/female/vaultsuit.mdl")
	end
	self:SetCollisionBounds(Vector(18,18,82),Vector(-18,-18,0))
	if self.VaultGuard then
		self.SpawnWithApparelChance = 1
		self.tbl_ApparelModels = {"models/fallout/headgear/vaultsecurityhelmet.mdl"}
	end
	if self.Gender == 1 then
		self.tbl_HairModels = {
			"models/fallout/player/hair/hairbuzzcut.mdl",
			"models/fallout/player/hair/haircombover.mdl",
			"models/fallout/player/hair/haircurly.mdl",
			"models/fallout/player/hair/hairda.mdl",
			"models/fallout/player/hair/hairmessy01.mdl",
			"models/fallout/player/hair/hairmessy02.mdl",
			"models/fallout/player/hair/hairmessy03.mdl",
			"models/fallout/player/hair/hairbalding.mdl",
			"models/fallout/player/hair/hairspikey.mdl",
			"models/fallout/player/hair/hairwastelandm.mdl",
			"models/fallout/player/hair/hairwavy.mdl"
		}
		self.tbl_BeardModels = {
			"models/fallout/player/beards/beardchincurtain.mdl",
			"models/fallout/player/beards/beardchinwide.mdl",
			"models/fallout/player/beards/beardcircle.mdl",
			"models/fallout/player/beards/beardmustache.mdl",
			"models/fallout/player/beards/beardside.mdl",
			"models/fallout/player/beards/beardthin.mdl",
		}
	else
		self.tbl_HairModels = {
			"models/fallout/player/hair/hairbun.mdl",
			"models/fallout/player/hair/haircurly.mdl",
			"models/fallout/player/hair/hairf01.mdl",
			"models/fallout/player/hair/hairf01b.mdl",
			"models/fallout/player/hair/hairf01c.mdl",
			"models/fallout/player/hair/hairf02.mdl",
			"models/fallout/player/hair/slippedtail01.mdl",
			"models/fallout/player/hair/slippedtail02.mdl",
			"models/fallout/player/hair/waves.mdl",
			"models/fallout/player/hair/coolhair/cool42.mdl",
			"models/fallout/player/hair/coolhair/cool45.mdl",
			"models/fallout/player/hair/coolhair/cool51.mdl",
			"models/fallout/player/hair/coolhair/cool56.mdl",
			"models/fallout/player/hair/coolhair/cool60.mdl",
			"models/fallout/player/hair/coolhair/cool65.mdl",
			"models/fallout/player/hair/coolhair/cool73.mdl",
			"models/fallout/player/hair/coolhair/cool77.mdl",
			"models/fallout/player/hair/coolhair/cool82.mdl",
			"models/fallout/player/hair/coolhair/cool84.mdl",
			"models/fallout/player/hair/coolhair/cool85.mdl",
			"models/fallout/player/hair/coolhair/cool93.mdl"
		}
		if self.VaultGuard then
			self.tbl_HairModels = {
				"models/fallout/player/hair/hairf01.mdl",
				"models/fallout/player/hair/hairf01b.mdl",
				"models/fallout/player/hair/hairf02.mdl",
			}
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:AfterInit()
	self:SetVoice(self.Gender == 1 && "maledefault" or "femaledefault")
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/