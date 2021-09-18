AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/fallout/supermutant.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.VJ_NPC_Class = {"CLASS_FEV_MUTANT_EAST"} -- NPCs with the same class with be allied to each other

ENT.SuperMutant_IsFawkes = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInit()
	if self.SuperMutant_IsFawkes then
		self.SoundTbl_Idle = {}
		self.SoundTbl_IdleDialogue = {
			"vj_fallout/supermutant/followers_idlechatter_0005c251_1.wav",
			"vj_fallout/supermutant/followers_idlechatter_0005c252_1.wav",
			"vj_fallout/supermutant/followers_idlechatter_0005c253_1.wav",
			"vj_fallout/supermutant/followers_idlechatter_0008955f_1.wav",
			"vj_fallout/supermutant/followers_idlechatter_00089560_1.wav",
			"vj_fallout/supermutant/followers_idlechatter_00089561_1.wav",
			"vj_fallout/supermutant/followers_idlechatter_00089567_1.wav",
			"vj_fallout/supermutant/followers_idlechatter_00089569_1.wav",
			"vj_fallout/supermutant/followers_idlechatter_0008956a_1.wav",
			"vj_fallout/supermutant/followers_idlechatter_0008956b_1.wav",
		}
		self.SoundTbl_IdleDialogueAnswer = {
			"vj_fallout/supermutant/followers_idlechatter_00089562_1.wav",
			"vj_fallout/supermutant/followers_idlechatter_00089563_1.wav",
			"vj_fallout/supermutant/followers_idlechatter_00089564_1.wav",
			"vj_fallout/supermutant/followers_idlechatter_00089565_1.wav",
			"vj_fallout/supermutant/followers_idlechatter_00089566_1.wav",
			"vj_fallout/supermutant/followers_idlechatter_00089568_1.wav",
			"vj_fallout/supermutant/followers_idlechatter_0008956c_1.wav",
			"vj_fallout/supermutant/followers_idlechatter_0008956d_1.wav",
		}
		self.SoundTbl_FollowPlayer = {
			"vj_fallout/supermutant/fferepeatb_hello_000aeb29_1.wav",
			"vj_fallout/supermutant/followers_goodbye_0004bdbb_1.wav",
			"vj_fallout/supermutant/followers_hello_00096bab_1.wav",
			"vj_fallout/supermutant/mainquestc_hello_0001f484_1.wav",
		}
		self.SoundTbl_UnFollowPlayer = {
			"vj_fallout/supermutant/fferepeatb_goodbye_0004f780_1.wav",
			"vj_fallout/supermutant/fferepeatb_goodbye_0004f781_1.wav",
			"vj_fallout/supermutant/fferepeatb_goodbye_0004f782_1.wav",
			"vj_fallout/supermutant/followers_goodbye_000a53f2_1.wav",
			"vj_fallout/supermutant/followers_goodbye_000a53f4_1.wav",
			"vj_fallout/supermutant/followers_greeting_00096baa_1.wav",
		}
		self.SoundTbl_Investigate = {
			"vj_fallout/supermutant/followersh_alertidle_000bcbc2_1.wav",
			"vj_fallout/supermutant/followersh_alertidle_000bcbc3_1.wav",
			"vj_fallout/supermutant/followersh_alertidle_000bcbc4_1.wav",
			"vj_fallout/supermutant/followersh_alertidle_000bcbc5_1.wav",
		}
		self.SoundTbl_OnPlayerSight = {}
		self.SoundTbl_BeforeMeleeAttack = {
			"vj_fallout/supermutant/followersh_powerattack_000bcbab_1.wav",
			"vj_fallout/supermutant/followersh_powerattack_000bcbac_1.wav",
			"vj_fallout/supermutant/followersh_powerattack_000bcbad_1.wav",
			"vj_fallout/supermutant/followersh_powerattack_000bcbae_1.wav",
		}
		self.SoundTbl_Suppressing = {
			"vj_fallout/supermutant/followersh_powerattack_000bcbab_1.wav",
			"vj_fallout/supermutant/followersh_powerattack_000bcbac_1.wav",
			"vj_fallout/supermutant/followersh_powerattack_000bcbad_1.wav",
			"vj_fallout/supermutant/followersh_powerattack_000bcbae_1.wav",
			"vj_fallout/supermutant/followershirefawkes_attack_000bcbc6_1.wav",
			"vj_fallout/supermutant/followershirefawkes_attack_000bcbc7_1.wav",
			"vj_fallout/supermutant/followershirefawkes_attack_000bcbc8_1.wav",
			"vj_fallout/supermutant/followershirefawkes_attack_000bcbc9_1.wav",
			"vj_fallout/supermutant/followershirefawkes_attack_000bcbca_1.wav",
			"vj_fallout/supermutant/followershirefawkes_attack_000bcbcb_1.wav",
			"vj_fallout/supermutant/followershirefawkes_attack_000bcbcc_1.wav",
			"vj_fallout/supermutant/followershirefawkes_attack_000bcbcd_1.wav",
			"vj_fallout/supermutant/followershirefawkes_attack_000bcbce_1.wav",
			"vj_fallout/supermutant/followershirefawkes_attack_000bcbcf_1.wav",
			"vj_fallout/supermutant/followershirefawkes_attack_000bcbd0_1.wav",
			"vj_fallout/supermutant/followershirefawkes_attack_000bcbd1_1.wav",
			"vj_fallout/supermutant/followershirefawkes_attack_000bcbd2_1.wav",
			"vj_fallout/supermutant/followershirefawkes_attack_000bcbd3_1.wav",
			"vj_fallout/supermutant/followershirefawkes_attack_000bcbd4_1.wav",
			"vj_fallout/supermutant/followershirefawkes_attack_000bcbd5_1.wav",
			"vj_fallout/supermutant/followershirefawkes_attack_000bcbd6_1.wav",
		}
		self.SoundTbl_Alert = {
			"vj_fallout/supermutant/followersh_alerttocombat_000bcbde_1.wav",
			"vj_fallout/supermutant/followersh_alerttocombat_000bcbdf_1.wav",
			"vj_fallout/supermutant/followersh_alerttocombat_000bcbe0_1.wav",
			"vj_fallout/supermutant/followersh_losttocombat_000bcbbf_1.wav",
			"vj_fallout/supermutant/followersh_losttocombat_000bcbc0_1.wav",
			"vj_fallout/supermutant/followersh_losttocombat_000bcbc1_1.wav",
			"vj_fallout/supermutant/followersh_normaltocombat_000bcbb5_1.wav",
			"vj_fallout/supermutant/followersh_normaltocombat_000bcbb6_1.wav",
			"vj_fallout/supermutant/followersh_normaltocombat_000bcbb7_1.wav",
			"vj_fallout/supermutant/followersh_normaltocombat_000bcbb8_1.wav",
			"vj_fallout/supermutant/followersh_normaltocombat_000bcbb9_1.wav",
			"vj_fallout/supermutant/followersh_normaltocombat_000bcbba_1.wav",
			"vj_fallout/supermutant/followersh_normaltocombat_000bcbbb_1.wav",
			"vj_fallout/supermutant/followersh_normaltocombat_000bcbbc_1.wav",
			"vj_fallout/supermutant/followersh_normaltocombat_000bcbbd_1.wav",
			"vj_fallout/supermutant/followersh_normaltocombat_000bcbbe_1.wav",
		}
		self.SoundTbl_LostEnemy = {
			"vj_fallout/supermutant/followersh_alerttonormal_000bcbaf_1.wav",
			"vj_fallout/supermutant/followersh_alerttonormal_000bcbb0_1.wav",
			"vj_fallout/supermutant/followersh_alerttonormal_000bcbb1_1.wav",
			"vj_fallout/supermutant/followersh_combattolost_000bcba7_1.wav",
			"vj_fallout/supermutant/followersh_combattolost_000bcba8_1.wav",
			"vj_fallout/supermutant/followersh_combattolost_000bcba9_1.wav",
			"vj_fallout/supermutant/followersh_combattolost_000bcbaa_1.wav",
			"vj_fallout/supermutant/followersh_lostidle_000bcbb2_1.wav",
			"vj_fallout/supermutant/followersh_lostidle_000bcbb3_1.wav",
			"vj_fallout/supermutant/followersh_lostidle_000bcbb4_1.wav",
			"vj_fallout/supermutant/followersh_losttonormal_000bcb9b_1.wav",
			"vj_fallout/supermutant/followersh_losttonormal_000bcb9c_1.wav",
			"vj_fallout/supermutant/followersh_losttonormal_000bcb9d_1.wav",
		}
		self.SoundTbl_OnGrenadeSight = {
			"vj_fallout/supermutant/supermutant_avoidthreat01.wav",
			"vj_fallout/supermutant/supermutant_avoidthreat02.wav",
			"vj_fallout/supermutant/supermutant_avoidthreat03.wav",
		}
		self.SoundTbl_OnKilledEnemy = {
			"vj_fallout/supermutant/followersh_combattonormal_000bcbd7_1.wav",
			"vj_fallout/supermutant/followersh_combattonormal_000bcbd8_1.wav",
			"vj_fallout/supermutant/followersh_combattonormal_000bcbd9_1.wav",
			"vj_fallout/supermutant/followersh_combattonormal_000bcbda_1.wav",
			"vj_fallout/supermutant/followersh_combattonormal_000bcbdb_1.wav",
			"vj_fallout/supermutant/followersh_combattonormal_000bcbdc_1.wav",
			"vj_fallout/supermutant/followersh_combattonormal_000bcbdd_1.wav",
		}
		self.SoundTbl_AllyDeath = {
			"vj_fallout/supermutant/supermutant_deathresponse01.wav",
			"vj_fallout/supermutant/supermutant_deathresponse02.wav",
			"vj_fallout/supermutant/supermutant_deathresponse03.wav",
		}
		self.SoundTbl_Pain = {
			"vj_fallout/supermutant/followershirefawkes_hit_000bcb9e_1.wav",
			"vj_fallout/supermutant/followershirefawkes_hit_000bcb9f_1.wav",
			"vj_fallout/supermutant/followershirefawkes_hit_000bcba0_1.wav",
			"vj_fallout/supermutant/followershirefawkes_hit_000bcba1_1.wav",
			"vj_fallout/supermutant/followershirefawkes_hit_000bcba2_1.wav",
			"vj_fallout/supermutant/followershirefawkes_hit_000bcba3_1.wav",
		}
		self.SoundTbl_Death = {
			"vj_fallout/supermutant/followershirefawkes_death_000bcba4_1.wav",
			"vj_fallout/supermutant/followershirefawkes_death_000bcba5_1.wav",
			"vj_fallout/supermutant/followershirefawkes_death_000bcba6_1.wav",
		}
	else
		self.SoundTbl_Idle = {}
		self.SoundTbl_IdleDialogue = {
			"vj_fallout/supermutant/mq08_mq08mutieconvo01_000a7b08_1.wav",
			"vj_fallout/supermutant/mq08_mq08mutieconvo01_000a7b09_1.wav",
			"vj_fallout/supermutant/mq08_mq08mutieconvo01_000a7b0a_1.wav",
			"vj_fallout/supermutant/mq08_mq08mutieconvo01_000a7b0d_1.wav",
			"vj_fallout/supermutant/mq08_mq08mutieconvo01_000a7b0f_1.wav",
			"vj_fallout/supermutant/mq08_mq08mutieconvo01_000a7b10_1.wav",
			"vj_fallout/supermutant/ms01_ms01kitchenconversati_0002ab87_1.wav",
			"vj_fallout/supermutant/ms01_ms01kitchenconversati_0002ab89_1.wav",
			"vj_fallout/supermutant/ms01_ms01mutantconverstaio_0009e888_1.wav",
			"vj_fallout/supermutant/ms01_ms01mutantconverstaio_0009e88a_1.wav",
			"vj_fallout/supermutant/ms01_ms01mutantconverstaio_0009e88b_1.wav",
			"vj_fallout/supermutant/ms01_ms01mutantconverstaio_0009e88d_1.wav",
			"vj_fallout/supermutant/ms01_ms01mutantconverstaio_0009e88f_1.wav",
			"vj_fallout/supermutant/ms01_ms01mutantconverstaio_0009e891_1.wav",
			"vj_fallout/supermutant/ms01_ms01mutanttaunt_0002de06_1.wav",
			"vj_fallout/supermutant/ms01_ms01mutanttaunt_0002de0a_1.wav",
			"vj_fallout/supermutant/ms18_goodbye_000b0f1c_1.wav",
			"vj_fallout/supermutant/ms18_goodbye_000b0f1e_1.wav",
			"vj_fallout/supermutant/ms18_goodbye_000b0f20_1.wav",
		}
		self.SoundTbl_IdleDialogueAnswer = {
			"vj_fallout/supermutant/mq08_mq08mutieconvo01_000a7b0b_1.wav",
			"vj_fallout/supermutant/mq08_mq08mutieconvo01_000a7b0c_1.wav",
			"vj_fallout/supermutant/mq08_mq08mutieconvo01_000a7b0e_1.wav",
			"vj_fallout/supermutant/ms01_ms01kitchenconversati_0002ab8d_1.wav",
			"vj_fallout/supermutant/ms01_ms01kitchenconversati_0002ab8f_1.wav",
			"vj_fallout/supermutant/ms01_ms01mutantconverstaio_0009e889_1.wav",
			"vj_fallout/supermutant/ms01_ms01mutantconverstaio_0009e88c_1.wav",
			"vj_fallout/supermutant/ms01_ms01mutantconverstaio_0009e88e_1.wav",
			"vj_fallout/supermutant/ms01_ms01mutantconverstaio_0009e890_1.wav",
			"vj_fallout/supermutant/ms01_ms01mutantconverstaio_0009e893_1.wav",
			"vj_fallout/supermutant/ms01_ms01mutanttaunt_0002de07_1.wav",
			"vj_fallout/supermutant/ms01_ms01mutanttaunt_0002de0b_1.wav",
			"vj_fallout/supermutant/ms18_goodbye_000b0f1d_1.wav",
			"vj_fallout/supermutant/ms18_goodbye_000b0f1f_1.wav",
			"vj_fallout/supermutant/ms18_hello_000b0f13_1.wav",
		}
		self.SoundTbl_FollowPlayer = {
			"vj_fallout/supermutant/fferepeatb_hello_000aeb29_1.wav",
			"vj_fallout/supermutant/followers_goodbye_0004bdbb_1.wav",
			"vj_fallout/supermutant/followers_hello_00096bab_1.wav",
			"vj_fallout/supermutant/mainquestc_hello_0001f484_1.wav",
			"vj_fallout/supermutant/mq08_greeting_000bb766_1.wav",
		}
		self.SoundTbl_UnFollowPlayer = {
			"vj_fallout/supermutant/fferepeatb_goodbye_0004f780_1.wav",
			"vj_fallout/supermutant/fferepeatb_goodbye_0004f781_1.wav",
			"vj_fallout/supermutant/fferepeatb_goodbye_0004f782_1.wav",
			"vj_fallout/supermutant/followers_goodbye_000a53f2_1.wav",
			"vj_fallout/supermutant/followers_goodbye_000a53f4_1.wav",
			"vj_fallout/supermutant/followers_greeting_00096baa_1.wav",
			"vj_fallout/supermutant/mq08_goodbye_000bf216_1.wav",
			"vj_fallout/supermutant/mq08_goodbye_000bf217_1.wav",
			"vj_fallout/supermutant/mq08_goodbye_000bf218_1.wav",
		}
		self.SoundTbl_Investigate = {
			"vj_fallout/supermutant/supermutant_lostidle01.wav",
			"vj_fallout/supermutant/supermutant_lostidle02.wav",
			"vj_fallout/supermutant/supermutant_lostidle03.wav",
			"vj_fallout/supermutant/supermutant_lostidle04.wav",
			"vj_fallout/supermutant/supermutant_normaltoalert01.wav",
			"vj_fallout/supermutant/supermutant_normaltoalert02.wav",
			"vj_fallout/supermutant/supermutant_normaltoalert03.wav",
			"vj_fallout/supermutant/supermutant_normaltoalert04.wav",
		}
		self.SoundTbl_OnPlayerSight = {}
		self.SoundTbl_BeforeMeleeAttack = {
			"vj_fallout/supermutant/supermutant_powerattack01.wav",
			"vj_fallout/supermutant/supermutant_powerattack02.wav",
			"vj_fallout/supermutant/supermutant_powerattack03.wav",
			"vj_fallout/supermutant/supermutant_powerattack04.wav",
			"vj_fallout/supermutant/supermutant_powerattack05.wav",
		}
		self.SoundTbl_Suppressing = {
			"vj_fallout/supermutant/ms18_goodbye_000b0f1b_1.wav",
			"vj_fallout/supermutant/ms18_ms18supermutantrespon_000b0f0e_1.wav",
			"vj_fallout/supermutant/supermutant_attack01.wav",
			"vj_fallout/supermutant/supermutant_attack02.wav",
			"vj_fallout/supermutant/supermutant_attack03.wav",
			"vj_fallout/supermutant/supermutant_attack04.wav",
			"vj_fallout/supermutant/supermutant_attack05.wav",
			"vj_fallout/supermutant/supermutant_attack06.wav",
			"vj_fallout/supermutant/supermutant_attack07.wav",
			"vj_fallout/supermutant/supermutant_attack08.wav",
			"vj_fallout/supermutant/supermutant_attack09.wav",
			"vj_fallout/supermutant/supermutant_powerattack01.wav",
			"vj_fallout/supermutant/supermutant_powerattack02.wav",
			"vj_fallout/supermutant/supermutant_powerattack03.wav",
			"vj_fallout/supermutant/supermutant_powerattack04.wav",
			"vj_fallout/supermutant/supermutant_powerattack05.wav",
		}
		self.SoundTbl_Alert = {
			"vj_fallout/supermutant/ms01_ms01mutanttaunt_0002de0c_1.wav",
			"vj_fallout/supermutant/supermutant_alerttocombat01.wav",
			"vj_fallout/supermutant/supermutant_alerttocombat02.wav",
			"vj_fallout/supermutant/supermutant_alerttocombat03.wav",
			"vj_fallout/supermutant/supermutant_alerttocombat04.wav",
			"vj_fallout/supermutant/supermutant_alerttocombat05.wav",
			"vj_fallout/supermutant/supermutant_losttocombat01.wav",
			"vj_fallout/supermutant/supermutant_losttocombat02.wav",
			"vj_fallout/supermutant/supermutant_losttocombat03.wav",
			"vj_fallout/supermutant/supermutant_normaltocombat01.wav",
			"vj_fallout/supermutant/supermutant_normaltocombat02.wav",
		}
		self.SoundTbl_LostEnemy = {
			"vj_fallout/supermutant/supermutant_alerttonormal01.wav",
			"vj_fallout/supermutant/supermutant_alerttonormal02.wav",
			"vj_fallout/supermutant/supermutant_alerttonormal03.wav",
			"vj_fallout/supermutant/supermutant_alerttonormal04.wav",
			"vj_fallout/supermutant/supermutant_alerttonormal05.wav",
			"vj_fallout/supermutant/supermutant_combattolost01.wav",
			"vj_fallout/supermutant/supermutant_combattolost02.wav",
			"vj_fallout/supermutant/supermutant_combattolost03.wav",
			"vj_fallout/supermutant/supermutant_losttonormal01.wav",
			"vj_fallout/supermutant/supermutant_losttonormal02.wav",
			"vj_fallout/supermutant/supermutant_losttonormal03.wav",
		}
		self.SoundTbl_OnGrenadeSight = {
			"vj_fallout/supermutant/supermutant_avoidthreat01.wav",
			"vj_fallout/supermutant/supermutant_avoidthreat02.wav",
			"vj_fallout/supermutant/supermutant_avoidthreat03.wav",
		}
		self.SoundTbl_OnKilledEnemy = {
			"vj_fallout/supermutant/supermutant_combattonormal01.wav",
			"vj_fallout/supermutant/supermutant_combattonormal02.wav",
			"vj_fallout/supermutant/supermutant_combattonormal03.wav",
			"vj_fallout/supermutant/supermutant_combattonormal04.wav",
		}
		self.SoundTbl_AllyDeath = {
			"vj_fallout/supermutant/supermutant_deathresponse01.wav",
			"vj_fallout/supermutant/supermutant_deathresponse02.wav",
			"vj_fallout/supermutant/supermutant_deathresponse03.wav",
		}
		self.SoundTbl_Pain = {
			"vj_fallout/supermutant/supermutant_hit01.wav",
			"vj_fallout/supermutant/supermutant_hit02.wav",
			"vj_fallout/supermutant/supermutant_hit03.wav",
			"vj_fallout/supermutant/supermutant_hit04.wav",
			"vj_fallout/supermutant/supermutant_hit05.wav",
			"vj_fallout/supermutant/supermutant_hit06.wav",
			"vj_fallout/supermutant/supermutant_hit07.wav",
			"vj_fallout/supermutant/supermutant_hit08.wav",
			"vj_fallout/supermutant/supermutant_hit09.wav",
			"vj_fallout/supermutant/supermutant_hit10.wav",
			"vj_fallout/supermutant/supermutant_hit11.wav",
		}
		self.SoundTbl_Death = {
			"vj_fallout/supermutant/supermutant_death01.wav",
			"vj_fallout/supermutant/supermutant_death02.wav",
			"vj_fallout/supermutant/supermutant_death03.wav",
			"vj_fallout/supermutant/supermutant_death04.wav",
			"vj_fallout/supermutant/supermutant_death05.wav",
			"vj_fallout/supermutant/supermutant_death06.wav",
			"vj_fallout/supermutant/supermutant_death07.wav",
			"vj_fallout/supermutant/supermutant_death08.wav",
			"vj_fallout/supermutant/supermutant_death09.wav",
		}
	end
end