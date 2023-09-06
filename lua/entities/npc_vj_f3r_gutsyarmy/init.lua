AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.StartHealth = 850
ENT.Skin = 0

ENT.VJ_NPC_Class = {"CLASS_ARMY"}
ENT.PlayerFriendly = false

ENT.SoundTbl_Alert = {
	"vj_fallout/mrgutsy/genericrobot_alerttocombat1.mp3",
	"vj_fallout/mrgutsy/genericrobot_alerttocombat2.mp3",
	"vj_fallout/mrgutsy/genericrobot_alerttocombat3.mp3",
	"vj_fallout/mrgutsy/genericrobot_alerttocombat4.mp3",
}
ENT.SoundTbl_CombatIdle = {
	"vj_fallout/mrgutsy/genericrobot_attack1.mp3",
	"vj_fallout/mrgutsy/genericrobot_attack2.mp3",
	"vj_fallout/mrgutsy/genericrobot_attack3.mp3",
	"vj_fallout/mrgutsy/genericrobot_attack4.mp3",
	"vj_fallout/mrgutsy/genericrobot_attack5.mp3",
	"vj_fallout/mrgutsy/genericrobot_attack6.mp3",
	"vj_fallout/mrgutsy/genericrobot_attack7.mp3",
	"vj_fallout/mrgutsy/genericrobot_attack8.mp3",
}
ENT.SoundTbl_Investigate = {
	"vj_fallout/mrgutsy/genericrobot_alertidle1.mp3",
	"vj_fallout/mrgutsy/genericrobot_alertidle2.mp3",
	"vj_fallout/mrgutsy/genericrobot_alertidle3.mp3",
	"vj_fallout/mrgutsy/genericrobot_alertidle4.mp3",
	"vj_fallout/mrgutsy/genericrobot_alertidle5.mp3",
	"vj_fallout/mrgutsy/genericrobot_alertidle6.mp3",
}
ENT.SoundTbl_LostEnemy = {
	"vj_fallout/mrgutsy/genericrobot_combattolost1.mp3",
	"vj_fallout/mrgutsy/genericrobot_combattolost2.mp3",
	"vj_fallout/mrgutsy/genericrobot_combattolost3.mp3",
	"vj_fallout/mrgutsy/genericrobot_combattolost4.mp3",
}
ENT.SoundTbl_OnPlayerSight = {
	-- "vj_fallout/mrgutsy/genericrobot_hello_00081a19_1.mp3",
	-- "vj_fallout/mrgutsy/mq04_hello_0002c23b_1.mp3",
	-- "vj_fallout/mrgutsy/mq04_hello_0002c23d_1.mp3"
}
ENT.SoundTbl_FollowPlayer = {
	-- "vj_fallout/mrgutsy/genericrobot_greeting_000824c0_1.mp3",
	-- "vj_fallout/mrgutsy/mq04_greeting_0002c22c_1.mp3"
}
ENT.SoundTbl_UnFollowPlayer = {
	-- "vj_fallout/mrgutsy/dialoguerivetcity_goodbye_0005a7d0_1.mp3",
	-- "vj_fallout/mrgutsy/genericrobot_goodbye_00075932_1.mp3",
	-- "vj_fallout/mrgutsy/ms05_goodbye_0004d5a3_1.mp3"
}
ENT.SoundTbl_OnKilledEnemy = {
	"vj_fallout/mrgutsy/genericrob_combattonormal1.mp3",
	"vj_fallout/mrgutsy/genericrob_combattonormal2.mp3",
	"vj_fallout/mrgutsy/genericrob_combattonormal3.mp3",
	"vj_fallout/mrgutsy/genericrobot_alerttonormal1.mp3",
	"vj_fallout/mrgutsy/genericrobot_alerttonormal2.mp3",
	"vj_fallout/mrgutsy/genericrobot_alerttonormal3.mp3",
}
ENT.SoundTbl_DamageByPlayer = {
	-- "vj_fallout/mrgutsy/genericrobot_assault_000819c8_1.mp3",
	-- "vj_fallout/mrgutsy/genericrobot_assault_000819c9_1.mp3",
	-- "vj_fallout/mrgutsy/genericrobot_assault_000819ca_1.mp3",
}
ENT.SoundTbl_AllyDeath = {
	"vj_fallout/mrgutsy/genericrobot_murder1.mp3",
	"vj_fallout/mrgutsy/genericrobot_murder2.mp3",
	"vj_fallout/mrgutsy/genericrobot_murder3.mp3",
}
ENT.SoundTbl_Pain = {
	"vj_fallout/mrgutsy/genericrobot_hit1.mp3"
}
ENT.SoundTbl_Death = {
	"vj_fallout/mrgutsy/genericrobot_death1.mp3",
	"vj_fallout/mrgutsy/genericrobot_death2.mp3",
	"vj_fallout/mrgutsy/genericrobot_death3.mp3",
	"vj_fallout/mrgutsy/genericrobot_death4.mp3",
}
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/