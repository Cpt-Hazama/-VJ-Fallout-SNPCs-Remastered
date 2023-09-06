AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/streettrog.mdl"}
ENT.StartHealth = 50

ENT.VJ_NPC_Class = {"CLASS_TROG"}

ENT.BloodColor = "Red"

ENT.MeleeAttackDamage = 16

ENT.SoundTbl_FootStep = {
	"vj_fallout/streettrog/foot/trog_footrun_l01.mp3",
	"vj_fallout/streettrog/foot/trog_footrun_l02.mp3",
	"vj_fallout/streettrog/foot/trog_footrun_l03.mp3",
	"vj_fallout/streettrog/foot/trog_footrun_r01.mp3",
	"vj_fallout/streettrog/foot/trog_footrun_r02.mp3",
	"vj_fallout/streettrog/foot/trog_footrun_r03.mp3",
}
ENT.SoundTbl_Death = {
	"vj_fallout/streettrog/trog_death01.mp3",
	"vj_fallout/streettrog/trog_death02.mp3",
}

ENT.Glow = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetupInventory(opWep)
	if self.CustomInventory then self:CustomInventory() end
	
	self.IdleLP = CreateSound(self,"vj_fallout/streettrog/trog_idle_lp.wav")
	self.IdleLP:SetSoundLevel(70)
	self.IdleLP:Play()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	self.IdleLP:Stop()
end
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/