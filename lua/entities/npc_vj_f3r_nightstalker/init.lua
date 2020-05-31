AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/nightstalker.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 120
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_NIGHTSTALKER"} -- NPCs with the same class with be allied to each other
ENT.PlayerFriendly = false

ENT.MeleeAttackDamage = 70
ENT.MeleeAttackDamageType = bit.bor(DMG_SLASH,DMG_RADIATION,DMG_ACID,DMG_POISON)

ENT.SoundTbl_FootStep = {
	"vj_fallout/nightstalker/foot/nightstalker_foot01.mp3",
	"vj_fallout/nightstalker/foot/nightstalker_foot02.mp3",
	"vj_fallout/nightstalker/foot/nightstalker_foot03.mp3",
	"vj_fallout/nightstalker/foot/nightstalker_foot04.mp3",
	"vj_fallout/nightstalker/foot/nightstalker_foot05.mp3",
	"vj_fallout/nightstalker/foot/nightstalker_foot06.mp3",
}
ENT.SoundTbl_Idle = {
	"vj_fallout/nightstalker/nightstalker_growl01.mp3",
	"vj_fallout/nightstalker/nightstalker_growl02.mp3",
	"vj_fallout/nightstalker/nightstalker_growl03.mp3",
	"vj_fallout/nightstalker/nightstalker_growl04.mp3",
	"vj_fallout/nightstalker/nightstalker_growl05.mp3",
	"vj_fallout/nightstalker/nightstalker_growl06.mp3",
}
ENT.SoundTbl_Alert = {
	"vj_fallout/nightstalker/nightstalker_chase01.mp3",
	"vj_fallout/nightstalker/nightstalker_chase02.mp3",
	"vj_fallout/nightstalker/nightstalker_chase03.mp3",
	"vj_fallout/nightstalker/nightstalker_chase04.mp3",
	"vj_fallout/nightstalker/nightstalker_chase05.mp3",
}
ENT.SoundTbl_BeforeMeleeAttack = {
	"vj_fallout/nightstalker/nightstalker_atk01.mp3",
	"vj_fallout/nightstalker/nightstalker_atk02.mp3",
	"vj_fallout/nightstalker/nightstalker_atk03.mp3",
	"vj_fallout/nightstalker/nightstalker_atk04.mp3",
	"vj_fallout/nightstalker/nightstalker_atk05.mp3",
	"vj_fallout/nightstalker/nightstalker_atk06.mp3",
	"vj_fallout/nightstalker/nightstalker_bite01.mp3",
	"vj_fallout/nightstalker/nightstalker_bite02.mp3",
	"vj_fallout/nightstalker/nightstalker_bite03.mp3",
	"vj_fallout/nightstalker/nightstalker_bite04.mp3",
	"vj_fallout/nightstalker/nightstalker_bite05.mp3",
	"vj_fallout/nightstalker/nightstalker_bite06.mp3",
}
ENT.SoundTbl_MeleeAttack = {
	"vj_fallout/nightstalker/nightstalker_bite_atk01.mp3",
	"vj_fallout/nightstalker/nightstalker_bite_atk02.mp3",
	"vj_fallout/nightstalker/nightstalker_bite_atk03.mp3",
	"vj_fallout/nightstalker/nightstalker_bite_atk04.mp3",
}
ENT.SoundTbl_Pain = {
	"vj_fallout/dog/dog_injured01.mp3",
	"vj_fallout/dog/dog_injured02.mp3",
	"vj_fallout/dog/dog_injured03.mp3",
	"vj_fallout/dog/dog_injured04.mp3",
	"vj_fallout/dog/dog_injured05.mp3",
	"vj_fallout/dog/dog_injured06.mp3",
}
ENT.SoundTbl_Death = {
	"vj_fallout/nightstalker/nightstalker_death01.mp3",
	"vj_fallout/nightstalker/nightstalker_death02.mp3",
	"vj_fallout/nightstalker/nightstalker_death03.mp3",
	"vj_fallout/nightstalker/nightstalker_death04.mp3",
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DogInit()

end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()

end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/