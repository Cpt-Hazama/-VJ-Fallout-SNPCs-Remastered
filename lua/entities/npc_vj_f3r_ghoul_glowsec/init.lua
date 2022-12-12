AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/ghoulferal_vaultarmor.mdl"}
ENT.StartHealth = 175

ENT.Skin = {[1]=2,[2]=2}
ENT.CanUseRadAttack = true
ENT.RadiationAttackDistance = 200
ENT.RadStrength = 0.8
ENT.RadDamage = 10
ENT.NextRadAttackT = CurTime() +5
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomInitialize()
	self:SetSkin(math.random(self.Skin[1],self.Skin[2]))
	self.Glow = ents.Create("light_dynamic")
	self.Glow:SetKeyValue("brightness","1")
	self.Glow:SetKeyValue("distance","150")
	self.Glow:SetLocalPos(self:GetPos() +self:OBBCenter())
	self.Glow:SetLocalAngles(self:GetAngles())
	self.Glow:Fire("Color", "127 255 0")
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