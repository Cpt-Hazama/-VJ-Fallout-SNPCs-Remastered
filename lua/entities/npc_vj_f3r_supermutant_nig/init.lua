AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/supermutant_nightkin.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.VJ_NPC_Class = {"CLASS_FEV_MUTANT_FRIENDLY"}
ENT.StartHealth = 250

	-- Player Friendly Code --
ENT.PlayerFriendly = true
ENT.HasOnPlayerSight = true
ENT.FriendsWithAllPlayerAllies = true
ENT.PlayerFriendly = true
ENT.FollowPlayer = true
ENT.BecomeEnemyToPlayer = true
ENT.BecomeEnemyToPlayerLevel = 5

ENT.SoundTbl_Idle = {}
ENT.SoundTbl_OnReceiveOrder = {}
ENT.SoundTbl_FollowPlayer = {}
ENT.SoundTbl_UnFollowPlayer = {}
ENT.SoundTbl_Suppressing = {}
ENT.SoundTbl_IdleDialogue = {}
ENT.SoundTbl_IdleDialogueAnswer = {}
ENT.SoundTbl_Investigate = {
	"vj_fallout/nightkin/nightkin_alertidle01.wav",
	"vj_fallout/nightkin/nightkin_alertidle02.wav",
	"vj_fallout/nightkin/nightkin_alertidle03.wav",
	"vj_fallout/nightkin/nightkin_combattolost01.wav",
	"vj_fallout/nightkin/nightkin_combattolost02.wav",
	"vj_fallout/nightkin/nightkin_combattolost03.wav",
	"vj_fallout/nightkin/nightkin_combattonormal01.wav",
	"vj_fallout/nightkin/nightkin_combattonormal02.wav",
	"vj_fallout/nightkin/nightkin_combattonormal03.wav",
	"vj_fallout/nightkin/nightkin_normaltoalert01.wav",
	"vj_fallout/nightkin/nightkin_normaltoalert02.wav",
	"vj_fallout/nightkin/nightkin_normaltoalert03.wav",
}
ENT.SoundTbl_OnPlayerSight = {
	"vj_fallout/nightkin/nightkin_deathresponse01.wav",
	"vj_fallout/nightkin/nightkin_deathresponse02.wav",
}
ENT.SoundTbl_Alert = {
	"vj_fallout/nightkin/nightkin_alerttocombat01.wav",
	"vj_fallout/nightkin/nightkin_alerttocombat02.wav",
	"vj_fallout/nightkin/nightkin_alerttocombat03.wav",
	"vj_fallout/nightkin/nightkin_losttocombat01.wav",
	"vj_fallout/nightkin/nightkin_losttocombat02.wav",
	"vj_fallout/nightkin/nightkin_losttocombat03.wav",
	"vj_fallout/nightkin/nightkin_normaltocombat01.wav",
	"vj_fallout/nightkin/nightkin_normaltocombat02.wav",
	"vj_fallout/nightkin/nightkin_normaltocombat03.wav",
}
ENT.SoundTbl_CallForHelp = {
	"vj_fallout/nightkin/nightkin_flee01.wav",
	"vj_fallout/nightkin/nightkin_flee02.wav",
	"vj_fallout/nightkin/nightkin_flee03.wav",
}
ENT.SoundTbl_WeaponReload = {}
ENT.SoundTbl_OnGrenadeSight = {
	"vj_fallout/nightkin/nightkin_avoidthreat01.wav",
	"vj_fallout/nightkin/nightkin_avoidthreat02.wav",
}
ENT.SoundTbl_OnKilledEnemy = {}
ENT.SoundTbl_Pain = {
	"vj_fallout/nightkin/nightkin_hit01.wav",
	"vj_fallout/nightkin/nightkin_hit02.wav",
	"vj_fallout/nightkin/nightkin_hit03.wav",
	"vj_fallout/nightkin/nightkin_hit04.wav",
	"vj_fallout/nightkin/nightkin_hit05.wav",
	"vj_fallout/nightkin/nightkin_hit06.wav",
}
ENT.SoundTbl_Death = {
	"vj_fallout/nightkin/nightkin_death01.wav",
	"vj_fallout/nightkin/nightkin_death02.wav",
	"vj_fallout/nightkin/nightkin_death03.wav",
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomInventory()
	self:AddToInventory(ITEM_VJ_STIMPACK,nil,math.random(3,6))
end