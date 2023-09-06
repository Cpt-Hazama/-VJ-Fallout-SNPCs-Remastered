AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/protectron.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_PROTECTRON","CLASS_METRO_PROTECTRON"}
ENT.PlayerFriendly = true

ENT.LaserDamage = 15
ENT.Skin = 4
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:ProtectronInit()
	self:SetBodygroup(1,5)
end
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/