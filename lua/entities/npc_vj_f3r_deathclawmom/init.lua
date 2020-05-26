AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/deathclaw_mother.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 700
ENT.VJ_NPC_Class = {"CLASS_DEATHCLAW"}

ENT.MeleeAttackDamage = 275

ENT.GeneralSoundPitch1 = 80
ENT.GeneralSoundPitch2 = 85
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.tbl_Inventory = {}
	self:SetupInventory()
	self:SetCollisionBounds(Vector(40,40,120),Vector(-40,-40,0))
	local v1,v2 = self:GetCollisionBounds()
	self.Height = v2.z
	self.DefaultDistance = self.MeleeAttackDistance
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/