AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.StartHealth = 110
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:ModelInit()
	self.Gender = 1
	self:SetModel("models/fallout/player/powerarmortribal.mdl")
	self:SetCollisionBounds(Vector(18,18,82),Vector(-18,-18,0))
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
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup)
	if (dmginfo:IsBulletDamage()) then
		local bScale = 0.685
		dmginfo:ScaleDamage(bScale)
		if bScale <= 0.8 then VJ_EmitSound(self,"vj_impact_metal/bullet_metal/metalsolid"..math.random(1,10)..".wav",70) end
	elseif dmginfo:GetDamageType() != DMG_GENERIC then
		local oScale = 0.725
		dmginfo:ScaleDamage(oScale)
		if oScale <= 0.8 then VJ_EmitSound(self,"vj_impact_metal/bullet_metal/metalsolid"..math.random(1,10)..".wav",70) end
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/