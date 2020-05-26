AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/gojira.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 8000

ENT.MeleeAttackDistance = 80
ENT.MeleeAttackDamageDistance = 210
ENT.MeleeAttackDamage = 115
ENT.MeleeAttackDamageType = bit.bor(DMG_SLASH,DMG_ALWAYSGIB)

ENT.HasFlameAttack = true
ENT.FlameParticle = "flame_gojira"
ENT.FlameDamage = 25
ENT.RangeDistance = 650

ENT.GeneralSoundPitch1 = 75
ENT.GeneralSoundPitch2 = 85
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GeckoInit()
	self:SetSkin(4)
	self:SetBodygroup(6,1)
	self:SetBodygroup(7,1)

	self:SetCollisionBounds(Vector(45,45,175),Vector(-45,-45,0))
	local v1,v2 = self:GetCollisionBounds()
	self.Height = v2.z
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/