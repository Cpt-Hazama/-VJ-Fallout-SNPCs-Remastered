AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.VJ_NPC_Class = {"CLASS_ENCLAVE"}

ENT.NextRangeAttackTime = 0.7 -- How much time until it can use a range attack?
ENT.NextAnyAttackTime_Range = 0.7 -- How much time until it can use any attack again? | Counted in Seconds
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomRangeAttackCode()
	local start = self:GetAttachment(1).Pos

	local projectile = ents.Create("obj_vj_f3r_plasma")
	projectile:SetPos(start)
	projectile:SetAngles(((self:GetEnemy():GetPos() -start)):Angle())
	projectile:SetOwner(self)
	projectile:Spawn()
	projectile:Activate()
	projectile.DirectDamage = 20

	local phy = projectile:GetPhysicsObject()
	if phy:IsValid() then
		phy:ApplyForceCenter(((self:GetEnemy():GetPos() -start)))
	end
	
	local FireLight1 = ents.Create("light_dynamic")
	FireLight1:SetKeyValue("brightness", "4")
	FireLight1:SetKeyValue("distance", "120")
	FireLight1:SetPos(start)
	FireLight1:SetLocalAngles(self:GetAngles())
	FireLight1:Fire("Color", "0 255 0")
	FireLight1:SetParent(self)
	FireLight1:Spawn()
	FireLight1:Activate()
	FireLight1:Fire("TurnOn","",0)
	FireLight1:Fire("Kill","",0.07)
	self:DeleteOnRemove(FireLight1)
	
	VJ_EmitSound(self,"vj_fallout/weapons/plasmapistol/pistolplasma_fire_2d.wav",85)
	VJ_EmitSound(self,"vj_fallout/weapons/plasmapistol/pistolplasma_fire_3d.wav",110)
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/