if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
/*--------------------------------------------------
	*** Copyright (c) 2012-2022 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
function EFFECT:Init(data)
	local ent = data:GetEntity()
	if !IsValid(ent) then return end

	local owner = ent:GetOwner()
	if !IsValid(owner) then return end

	local muzEnt = ((owner != LocalPlayer()) or owner:ShouldDrawLocalPlayer()) && ent or ent.VJ_CModel or owner:GetViewModel()

	ParticleEffectAttach(VJ.PICK(ent.PrimaryEffects_MuzzleParticles), PATTACH_POINT, muzEnt, 1)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function EFFECT:Think()
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function EFFECT:Render()
end
