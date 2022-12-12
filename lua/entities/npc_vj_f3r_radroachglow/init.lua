AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/radroach.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 15
ENT.MeleeAttackDamage = 6
ENT.MeleeAttackDamageType = bit.bor(DMG_SLASH,DMG_RADIATION,DMG_POISON)
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetupInventory(opWep)
	if self.CustomInventory then self:CustomInventory() end
	self:SetSkin(2)
	self.Glow = ents.Create("light_dynamic")
	self.Glow:SetKeyValue("brightness","1")
	self.Glow:SetKeyValue("distance","70")
	self.Glow:SetLocalPos(self:GetPos() +self:OBBCenter())
	self.Glow:SetLocalAngles(self:GetAngles())
	self.Glow:Fire("Color", "0 255 50")
	self.Glow:SetParent(self)
	self.Glow:Spawn()
	self.Glow:Activate()
	self.Glow:Fire("TurnOn","",0)
	self.Glow:FollowBone(self,self:LookupBone("Bip01 Spine"))
	self:DeleteOnRemove(self.Glow)
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/