AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/player/vaultsuit.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 75
ENT.VJ_NPC_Class = {"CLASS_GARY"} -- NPCs with the same class with be allied to each other

ENT.HairColor = Color(127,111,63)
ENT.SpawnWithHairChance = 1
ENT.tbl_HairModels = {
	"models/fallout/player/hair/hairdefaultfacegen.mdl"
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:AfterInit()
	self:SetVoice("maleclone")
end
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/