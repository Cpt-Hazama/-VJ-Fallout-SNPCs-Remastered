AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 75
ENT.VJ_NPC_Class = {"CLASS_RAIDER"} -- NPCs with the same class with be allied to each other

ENT.Human_IsAggressive = true
ENT.HairColor = Color(math.random(0,255),math.random(0,255),math.random(0,255))
ENT.CantHaveHairWithApparel = true
ENT.SpawnWithApparelChance = 4
ENT.SpawnWithHairChance = 1
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:BeforeApparelSpawned()
	self.HairColor = Color(math.random(0,255),math.random(0,255),math.random(0,255))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomInit()
	local hp = math.random(self.StartHealth -10,self.StartHealth +10)
	self:SetHealth(hp)
	self:SetMaxHealth(hp)
	self.Gender = math.random(1,2)
	if self.Gender == 1 then
		self:SetModel("models/fallout/player/raider.mdl")
	else
		local tbl = {
			"models/fallout/player/female/raider01.mdl",
			"models/fallout/player/female/raider02.mdl",
			"models/fallout/player/female/raider03.mdl",
			"models/fallout/player/female/raider04.mdl",
		}
		self:SetModel(VJ_PICKRANDOMTABLE(tbl))
	end
	self:SetCollisionBounds(Vector(18,18,82),Vector(-18,-18,0))
	if self.Gender == 1 then
		self.tbl_HairModels = {
			"models/fallout/player/hair/hairraidermid.mdl",
			"models/fallout/player/hair/hairraiderside.mdl",
			"models/fallout/player/hair/hairraiderspike.mdl",
		}
		self.tbl_ApparelModels = {
			"models/fallout/headgear/helmetmetalarmor.mdl",
			"models/fallout/headgear/helmetraider02.mdl",
			"models/fallout/headgear/helmetraider03.mdl",
			"models/fallout/headgear/raiderarmor04_hat.mdl",
			"models/fallout/headgear/raiderarmorhelmet.mdl",
		}
	else
		self.tbl_HairModels = {
			"models/fallout/player/hair/hairbun.mdl",
			"models/fallout/player/hair/hairf01.mdl",
			"models/fallout/player/hair/hairf01b.mdl",
			"models/fallout/player/hair/hairf01c.mdl",
			"models/fallout/player/hair/hairf02.mdl",
			"models/fallout/player/hair/slippedtail01.mdl",
			"models/fallout/player/hair/slippedtail02.mdl",
			"models/fallout/player/hair/waves.mdl",
		}
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:AfterInit()
	self:SetVoice(self.Gender == 1 && (math.random(1,4) == 1 && "malefiend" or "maleraider") or "femaleraider")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDoKilledEnemy(argent,attacker,inflictor)
	if !IsValid(self:GetEnemy()) then
		if math.random(1,6) == 1 then
			self:VJ_ACT_PLAYACTIVITY(ACT_MP_GESTURE_VC_HANDMOUTH,true,false,true)
			VJ_EmitSound(self,self.SoundTbl_Laugh,82,100)
		end
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/