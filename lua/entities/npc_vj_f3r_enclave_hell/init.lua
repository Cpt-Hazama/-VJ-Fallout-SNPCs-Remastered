AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.SpawnWithApparelChance = 1
ENT.tbl_ApparelModels = {"models/fallout/headgear/hellfirehelm.mdl"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GenderInit()
	self:SetModel(self.Gender == 1 && "models/fallout/player/hellfire.mdl" or "models/fallout/player/female/hellfire.mdl")
	self:SetCollisionBounds(Vector(18,18,82),Vector(-18,-18,0))

	self:SetBodygroup(3,2)
	-- self:SetBodygroup(4,1)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup)
	VJ_EmitSound(self,"vj_impact_metal/bullet_metal/metalsolid"..math.random(1,10)..".wav",70)
	if (dmginfo:IsBulletDamage()) then
		dmginfo:ScaleDamage(0.55)
	elseif dmginfo:GetDamageType() != DMG_GENERIC then
		dmginfo:ScaleDamage(0.7)
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/