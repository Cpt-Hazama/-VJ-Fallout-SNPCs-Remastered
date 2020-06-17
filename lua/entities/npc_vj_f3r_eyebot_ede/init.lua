AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/eyebot_ede.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 100
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY"} -- NPCs with the same class with be allied to each other
ENT.PlayerFriendly = true
ENT.Behavior = VJ_BEHAVIOR_AGGRESSIVE

ENT.SoundTbl_Idle = {
	"vj_fallout/eyebot/ede/ede_laugh01.mp3",
	"vj_fallout/eyebot/ede/ede_laugh02.mp3",
	"vj_fallout/eyebot/ede/ede_seeking.mp3",
}
ENT.SoundTbl_CallForHelp = {
	"vj_fallout/eyebot/ede/ede_homingbeep.mp3",
}
ENT.SoundTbl_Alert = {
	"vj_fallout/eyebot/ede/ede_anger01.mp3",
	"vj_fallout/eyebot/ede/ede_anger02.mp3",
}
ENT.SoundTbl_Investigate = {
	"vj_fallout/eyebot/ede/ede_curious.mp3",
	"vj_fallout/eyebot/ede/ede_sonarbeep.mp3",
}
ENT.SoundTbl_FollowPlayer = {
	"vj_fallout/eyebot/ede/ede_confirmed01.mp3",
	"vj_fallout/eyebot/ede/ede_confirmed02.mp3",
	"vj_fallout/eyebot/ede/ede_happy.mp3",
}
ENT.SoundTbl_UnFollowPlayer = {
	"vj_fallout/eyebot/ede/ede_denied.mp3",
	"vj_fallout/eyebot/ede/ede_goodbye_sad01.mp3",
	"vj_fallout/eyebot/ede/ede_goodbye_sad02.mp3",
	"vj_fallout/eyebot/ede/ede_goodbye_happy01.mp3",
	"vj_fallout/eyebot/ede/ede_goodbye_happy02.mp3",
	"vj_fallout/eyebot/ede/ede_sad01.mp3",
	"vj_fallout/eyebot/ede/ede_sad02.mp3",
}
ENT.SoundTbl_OnKilledEnemy = {
	"vj_fallout/eyebot/ede/ede_triumphant.mp3",
}
ENT.SoundTbl_Pain = {
	"vj_fallout/eyebot/ede/ede_alert_lowhealth.mp3",
}
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/