AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/player/vaultsuit.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 75
ENT.VJ_NPC_Class = {"CLASS_GARY"} -- NPCs with the same class with be allied to each other
	-- ====== File Path Variables ====== --
	-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_Idle = {}
ENT.SoundTbl_Investigate = {
	"vj_fallout/human/maleadult01/vault108_alertidle01.wav",
	"vj_fallout/human/maleadult01/vault108_alertidle02.wav",
	"vj_fallout/human/maleadult01/vault108_normaltoalert01.wav"
}
ENT.SoundTbl_Suppressing = {
	"vj_fallout/human/maleadult01/vault108_attack01.wav",
	"vj_fallout/human/maleadult01/vault108_attack02.wav",
}
ENT.SoundTbl_Alert = {
	"vj_fallout/human/maleadult01/vault108_alerttocombat01.wav",
	"vj_fallout/human/maleadult01/vault108_alerttocombat02.wav",
	"vj_fallout/human/maleadult01/vault108_alerttocombat03.wav",
	"vj_fallout/human/maleadult01/vault108_losttocombat01.wav",
	"vj_fallout/human/maleadult01/vault108_losttocombat02.wav",
	"vj_fallout/human/maleadult01/vault108_normaltocombat01.wav",
}
ENT.SoundTbl_LostEnemy = {
	"vj_fallout/human/maleadult01/vault108_alerttonormal01.wav",
	"vj_fallout/human/maleadult01/vault108_alerttonormal02.wav",
	"vj_fallout/human/maleadult01/vault108_combattolost01.wav",
	"vj_fallout/human/maleadult01/vault108_lostidle01.wav",
	"vj_fallout/human/maleadult01/vault108_lostidle02.wav",
	"vj_fallout/human/maleadult01/vault108_losttonormal01.wav",
}
ENT.SoundTbl_OnKilledEnemy = {
	"vj_fallout/human/maleadult01/vault108_combattonormal01.wav",
	"vj_fallout/human/maleadult01/vault108_combattonormal02.wav",
	"vj_fallout/human/maleadult01/vault108_combattonormal03.wav",
}
ENT.SoundTbl_OnGrenadeSight = {"vj_fallout/human/maleadult01/vault108_avoidthreat01.wav"}
ENT.SoundTbl_IdleDialogue = {
	"vj_fallout/human/maleadult01/vault108_combattonormal02.wav",
	"vj_fallout/human/maleadult01/vault108_losttocombat02.wav",
	"vj_fallout/human/maleadult01/vault108_normaltoalert01.wav",
}
ENT.SoundTbl_IdleDialogueAnswer = {
	"vj_fallout/human/maleadult01/vault108_alerttocombat02.wav",
	"vj_fallout/human/maleadult01/vault108_alerttocombat03.wav",
	"vj_fallout/human/maleadult01/vault108_combattonormal01.wav",
}
ENT.SoundTbl_OnRecieveOrder = {"vj_fallout/human/maleadult01/vault108_startcombatresp01.wav"}
ENT.SoundTbl_CallForHelp = {"vj_fallout/human/maleadult01/vault108_startcombatresp01.wav"}
ENT.SoundTbl_Pain = {
	"vj_fallout/player/player_hit1.mp3",
	"vj_fallout/player/player_hit2.mp3",
	"vj_fallout/player/player_hit3.mp3",
	"vj_fallout/player/player_hit4.mp3",
	"vj_fallout/player/player_hit5.mp3",
	"vj_fallout/player/player_hit6.mp3",
	"vj_fallout/player/player_hit7.mp3",
	"vj_fallout/player/player_hit8.mp3",
	"vj_fallout/player/player_hit9.mp3",
	"vj_fallout/player/player_hit10.mp3",
	"vj_fallout/player/player_hit11.mp3",
	"vj_fallout/player/player_hit12.mp3",
	"vj_fallout/player/player_hit13.mp3",
	"vj_fallout/player/player_hit14.mp3",
	"vj_fallout/player/player_hit15.mp3",
	"vj_fallout/player/player_hit16.mp3",
	"vj_fallout/player/player_hit17.mp3",
	"vj_fallout/player/player_hit18.mp3",
}
ENT.SoundTbl_Death = {
	"vj_fallout/player/player_death01.mp3",
	"vj_fallout/player/player_death02.mp3",
	"vj_fallout/player/player_death03.mp3",
	"vj_fallout/player/player_death04.mp3",
	"vj_fallout/player/player_death05.mp3",
	"vj_fallout/player/player_death06.mp3",
}

ENT.HairColor = Color(127,111,63)
ENT.SpawnWithHairChance = 1
ENT.tbl_HairModels = {
	"models/fallout/player/hair/hairdefaultfacegen.mdl"
}
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/