AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/player/skeletonspacesuit.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 150

ENT.PlayerFriendly = false
ENT.VJ_NPC_Class = {"CLASS_TRAUMASKELETON"} -- NPCs with the same class with be allied to each other

ENT.SpawnWithApparelChance = 0
ENT.SpawnWithHairChance = 0
ENT.SpawnWithBeardChance = 0
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomInit()
	local hp = math.random(self.StartHealth -10,self.StartHealth +10)
	self:SetHealth(hp)
	self:SetMaxHealth(hp)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:AfterInit()
	self:SetVoice(false)
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/