AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/player/t-45dpowerarmor.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 120

ENT.PlayerFriendly = true
ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY","CLASS_BOS"} -- NPCs with the same class with be allied to each other
ENT.Human_IsSoldier = true

ENT.FlinchChance = 12 -- Chance of it flinching from 1 to x | 1 will make it always flinch
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomInit()
	local hp = math.random(self.StartHealth -10,self.StartHealth +10)
	self:SetHealth(hp)
	self:SetMaxHealth(hp)

	self.Gender = math.random(1,4) == 1 && 2 or 1
	self:SetModel(self.Gender == 1 && "models/fallout/player/t-45dpowerarmor.mdl" or "models/fallout/player/female/t-45dpowerarmor.mdl")
	self:SetCollisionBounds(Vector(18,18,82),Vector(-18,-18,0))

	-- if self.Gender == 1 then
	-- 	self:SetBodygroup(2,2)
	-- 	self:SetBodygroup(3,2)
	-- else
		self:SetBodygroup(4,2)
		self:SetBodygroup(5,2)
	-- end

	self.DeathCorpseSubMaterials = {}

	for k, v in ipairs(self:GetMaterials()) do
		local trueValue = k -1
		if VJ_HasValue(self.VJ_NPC_Class,"CLASS_OUTCASTS") then
			if v == "models/fallout/armor/powerarmor/powerarmorbody" then
				table.insert(self.DeathCorpseSubMaterials,trueValue)
				self:SetSubMaterial(trueValue,"models/fallout/armor/powerarmor/powerarmorbodyoutcast")
			end
			if v == "models/fallout/armor/powerarmor/powerarmorhelmet" then
				table.insert(self.DeathCorpseSubMaterials,trueValue)
				self:SetSubMaterial(trueValue,"models/fallout/armor/powerarmor/powerarmoroutcasthelmet")
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:AfterInit()
	self:SetVoice(self.Gender == 1 && "male08" or "female07")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup)
	VJ_EmitSound(self,"vj_impact_metal/bullet_metal/metalsolid"..math.random(1,10)..".wav",70)
	if (dmginfo:IsBulletDamage()) then
		dmginfo:ScaleDamage(0.7)
	elseif dmginfo:GetDamageType() != DMG_GENERIC then
		dmginfo:ScaleDamage(0.8)
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/