AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 75
ENT.VJ_NPC_Class = {"CLASS_RAIDER"} -- NPCs with the same class with be allied to each other

ENT.Human_IsAggressive = true
ENT.HairColor = Color(math.random(0,255),math.random(0,255),math.random(0,255))
ENT.CantHaveHairWithApparel = true
ENT.SpawnWithApparelChance = 4
ENT.SpawnWithHairChance = 1
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:BeforeApparelSpawned()
	self.HairColor = Color(math.random(0,255),math.random(0,255),math.random(0,255))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomInit()
	local hp = math.random(self.StartHealth -10,self.StartHealth +10)
	self:SetHealth(hp)
	self:SetMaxHealth(hp)
	self.Gender = math.random(1,2)
	if self.Gender == 1 then
		self:SetModel("models/fallout/player/raider.mdl")
	else
		local tbl = {
			"models/fallout/player/female/raider01.mdl",
			"models/fallout/player/female/raider02.mdl",
			"models/fallout/player/female/raider03.mdl",
			"models/fallout/player/female/raider04.mdl",
		}
		self:SetModel(VJ_PICKRANDOMTABLE(tbl))
	end
	self:SetCollisionBounds(Vector(18,18,82),Vector(-18,-18,0))
	if self.Gender == 1 then
		self.tbl_HairModels = {
			"models/fallout/player/hair/hairraidermid.mdl",
			"models/fallout/player/hair/hairraiderside.mdl",
			"models/fallout/player/hair/hairraiderspike.mdl",
		}
		self.tbl_ApparelModels = {
			"models/fallout/headgear/helmetmetalarmor.mdl",
			"models/fallout/headgear/helmetraider02.mdl",
			"models/fallout/headgear/helmetraider03.mdl",
			"models/fallout/headgear/raiderarmor04_hat.mdl",
			"models/fallout/headgear/raiderarmorhelmet.mdl",
		}
		self.SoundTbl_Investigate = {
			"vj_fallout/human/maleadult01/fiend_combattolost01.wav",
			"vj_fallout/human/maleadult01/fiend_combattolost02.wav",
			"vj_fallout/human/maleadult01/fiend_combattolost03.wav",
			"vj_fallout/human/maleadult01/fiend_lostidle01.wav",
			"vj_fallout/human/maleadult01/fiend_lostidle02.wav",
			"vj_fallout/human/maleadult01/fiend_normaltoalert01.wav",
			"vj_fallout/human/maleadult01/fiend_normaltoalert02.wav",
			"vj_fallout/human/maleadult01/fiend_normaltoalert03.wav",
			"vj_fallout/human/maleadult01/generic_alertidle01.wav",
			"vj_fallout/human/maleadult01/generic_normaltoalert01.wav",
			"vj_fallout/human/maleadult01/genericadu_alertidle01.wav",
			"vj_fallout/human/maleadult01/genericadu_alertidle02.wav",
			"vj_fallout/human/maleadult01/genericadu_alertidle03.wav",
			"vj_fallout/human/maleadult01/genericadu_combattolost01.wav",
			"vj_fallout/human/maleadult01/genericadu_lostidle01.wav",
			"vj_fallout/human/maleadult01/genericadu_lostidle02.wav",
			"vj_fallout/human/maleadult01/genericadu_lostidle03.wav",
			"vj_fallout/human/maleadult01/genericadu_normaltoalert01.wav",
			"vj_fallout/human/maleadult01/genericadu_normaltoalert02.wav",
			"vj_fallout/human/maleadult01/genericadu_normaltoalert03.wav",
		}
		self.SoundTbl_LostEnemy = {
			"vj_fallout/human/maleadult01/fie_combattonormal01.wav",
			"vj_fallout/human/maleadult01/fie_combattonormal02.wav",
			"vj_fallout/human/maleadult01/fie_combattonormal03.wav",
			"vj_fallout/human/maleadult01/fiend_alertidle01.wav",
			"vj_fallout/human/maleadult01/fiend_alertidle02.wav",
			"vj_fallout/human/maleadult01/fiend_lostidle03.wav",
			"vj_fallout/human/maleadult01/fiend_losttonormal03.wav",
			"vj_fallout/human/maleadult01/generic_lostidle01.wav",
		}
		self.SoundTbl_Suppressing = {
			"vj_fallout/human/maleadult01/fiend_attack01.wav",
			"vj_fallout/human/maleadult01/fiend_attack02.wav",
			"vj_fallout/human/maleadult01/fiend_attack03.wav",
			"vj_fallout/human/maleadult01/genericadultcombat_attack01.wav",
			"vj_fallout/human/maleadult01/genericadultcombat_attack02.wav",
			"vj_fallout/human/maleadult01/genericadultcombat_attack03.wav",
		}
		self.SoundTbl_DamageByPlayer = {
			"vj_fallout/human/maleadult01/genericadu_playerfireweapon01.wav",
			"vj_fallout/human/maleadult01/genericadu_playerfireweapon02.wav",
			"vj_fallout/human/maleadult01/genericadultcombat_assault01.wav",
			"vj_fallout/human/maleadult01/genericadultcombat_assault02.wav",
			"vj_fallout/human/maleadult01/genericadultcombat_assault03.wav",
		}
		self.SoundTbl_CallForHelp = {
			"vj_fallout/human/maleadult01/generic_normaltocombat01.wav",
			"vj_fallout/human/maleadult01/genericadu_normaltocombat01.wav",
			"vj_fallout/human/maleadult01/genericadu_normaltocombat02.wav",
			"vj_fallout/human/maleadult01/genericadu_normaltocombat03.wav",
		}
		self.SoundTbl_Alert = {
			"vj_fallout/human/maleadult01/fie_normaltocombat01.wav",
			"vj_fallout/human/maleadult01/fie_normaltocombat02.wav",
			"vj_fallout/human/maleadult01/fie_normaltocombat03.wav",
			"vj_fallout/human/maleadult01/fiend_alerttocombat01.wav",
			"vj_fallout/human/maleadult01/fiend_alerttocombat02.wav",
			"vj_fallout/human/maleadult01/fiend_alerttocombat03.wav",
			"vj_fallout/human/maleadult01/fiend_losttocombat01.wav",
			"vj_fallout/human/maleadult01/fiend_losttocombat02.wav",
			"vj_fallout/human/maleadult01/fiend_losttocombat03.wav",
			"vj_fallout/human/maleadult01/generic_alerttocombat01.wav",
			"vj_fallout/human/maleadult01/genericadu_alerttocombat01.wav",
			"vj_fallout/human/maleadult01/genericadu_alerttocombat02.wav",
			"vj_fallout/human/maleadult01/genericadu_alerttocombat03.wav",
		}
		self.SoundTbl_OnGrenadeSight = {
			"vj_fallout/human/maleadult01/fiend_avoidthreat01.wav",
			"vj_fallout/human/maleadult01/fiend_avoidthreat02.wav",
			"vj_fallout/human/maleadult01/genericadu_avoidthreat01.wav",
			"vj_fallout/human/maleadult01/genericadu_avoidthreat02.wav",
		}
		self.SoundTbl_AllyDeath = {
			"vj_fallout/human/maleadult01/fiend_deathresponse01.wav",
			"vj_fallout/human/maleadult01/fiend_deathresponse02.wav",
			"vj_fallout/human/maleadult01/fiend_deathresponse03.wav",
			"vj_fallout/human/maleadult01/fiend_deathresponse04.wav",
			"vj_fallout/human/maleadult01/fiend_deathresponse05.wav",
			"vj_fallout/human/maleadult01/fiend_deathresponse06.wav",
			"vj_fallout/human/maleadult01/genericadu_deathresponse01.wav",
			"vj_fallout/human/maleadult01/genericadu_deathresponse02.wav",
			"vj_fallout/human/maleadult01/genericadu_deathresponse03.wav",
			"vj_fallout/human/maleadult01/genericadu_deathresponse04.wav",
			"vj_fallout/human/maleadult01/genericadu_deathresponse05.wav",
			"vj_fallout/human/maleadult01/genericadu_deathresponse06.wav",
			"vj_fallout/human/maleadult01/genericadultcombat_murder01.wav",
			"vj_fallout/human/maleadult01/genericadultcombat_murder02.wav",
			"vj_fallout/human/maleadult01/genericadultcombat_murder03.wav",
		}
		self.SoundTbl_Pain = {
			"vj_fallout/human/maleadult01/generic_hit01.wav",
			"vj_fallout/human/maleadult01/generic_hit02.wav",
			"vj_fallout/human/maleadult01/generic_hit03.wav",
			"vj_fallout/human/maleadult01/generic_hit04.wav",
			"vj_fallout/human/maleadult01/generic_hit05.wav",
		}
		self.SoundTbl_Death = {
			"vj_fallout/human/maleadult01/death01.wav",
			"vj_fallout/human/maleadult01/death02.wav",
			"vj_fallout/human/maleadult01/death03.wav",
		}
		self.SoundTbl_OnKilledEnemy = {
			"vj_fallout/human/maleadult01/generic_combattonormal01.wav",
			"vj_fallout/human/maleadult01/genericadu_combattonormal01.wav",
			"vj_fallout/human/maleadult01/genericadu_combattonormal02.wav",
			"vj_fallout/human/maleadult01/genericadu_combattonormal03.wav",
		}
		self.SoundTbl_Guard_Warn = {
			"vj_fallout/human/maleadult01/genericadu_guardtrespass01.wav",
			"vj_fallout/human/maleadult01/genericadu_guardtrespass02.wav",
			"vj_fallout/human/maleadult01/genericadu_guardtrespass03.wav",
		}
		self.SoundTbl_Guard_Calmed = {
			"vj_fallout/human/maleadult01/genericadu_acceptyield01.wav",
			"vj_fallout/human/maleadult01/fiend_losttonormal01.wav",
			"vj_fallout/human/maleadult01/fiend_losttonormal02.wav",
			"vj_fallout/human/maleadult01/generic_losttonormal01.wav",
			"vj_fallout/human/maleadult01/generic_losttonormal02.wav",
			"vj_fallout/human/maleadult01/genericadu_alerttonormal01.wav",
		}
		self.SoundTbl_Barter_Exit = {
			"vj_fallout/human/maleadult01/genericadult_barterexit01.wav",
			"vj_fallout/human/maleadult01/genericadult_barterexit02.wav",
			"vj_fallout/human/maleadult01/genericadult_barterexit03.wav",
			"vj_fallout/human/maleadult01/genericadult_barterexit04.wav",
		}
	else
		self.tbl_HairModels = {
			"models/fallout/player/hair/hairbun.mdl",
			"models/fallout/player/hair/hairf01.mdl",
			"models/fallout/player/hair/hairf01b.mdl",
			"models/fallout/player/hair/hairf01c.mdl",
			"models/fallout/player/hair/hairf02.mdl",
			"models/fallout/player/hair/slippedtail01.mdl",
			"models/fallout/player/hair/slippedtail02.mdl",
			"models/fallout/player/hair/waves.mdl",
		}
		self.SoundTbl_Idle = {
			"vj_fallout/human/femaleraider/genericidl_idlechatter_000b87a1_1.mp3",
			"vj_fallout/human/femaleraider/genericidl_idlechatter_000b87a2_1.mp3",
			"vj_fallout/human/femaleraider/genericidl_idlechatter_000b87a3_1.mp3",
			"vj_fallout/human/femaleraider/genericidl_idlechatter_000b87a4_1.mp3",
			"vj_fallout/human/femaleraider/genericidl_idlechatter_000b87a5_1.mp3",
			"vj_fallout/human/femaleraider/genericidl_idlechatter_000b87a6_1.mp3",
			"vj_fallout/human/femaleraider/genericidl_idlechatter_000b87a7_1.mp3",
			"vj_fallout/human/femaleraider/genericidl_idlechatter_000b87a8_1.mp3",
			"vj_fallout/human/femaleraider/genericidl_idlechatter_000b87a9_1.mp3",
			"vj_fallout/human/femaleraider/genericidl_idlechatter_000b87aa_1.mp3",
			"vj_fallout/human/femaleraider/genericidl_idlechatter_000b87ab_1.mp3",
			"vj_fallout/human/femaleraider/genericidl_idlechatter_000b87ac_1.mp3",
			"vj_fallout/human/femaleraider/genericidl_idlechatter_000b87ad_1.mp3",
			"vj_fallout/human/femaleraider/genericidl_idlechatter_000b87ae_1.mp3",
			"vj_fallout/human/femaleraider/genericidl_idlechatter_000b87af_1.mp3",
		}
		self.SoundTbl_Investigate = {
			"vj_fallout/human/femaleraider/generic_lostidle_0002fc20_1.mp3",
			"vj_fallout/human/femaleraider/generic_normaltoalert_0002fc23_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_normaltoalert_00028d49_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_normaltoalert_00029a94_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_normaltoalert_0008537b_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_normaltoalert_0008537c_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_normaltoalert_0008537d_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_normaltoalert_0008537e_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_alertidle_0008539d_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_alertidle_0008539e_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_alertidle_0008539f_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_alertidle_000853a0_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_alertidle_000853a1_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_alertidle_000853a2_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_lostidle_00085390_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_lostidle_00085391_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_lostidle_00085392_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_lostidle_00085393_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_lostidle_00085394_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_lostidle_00085395_1.mp3",
		}
		self.SoundTbl_LostEnemy = {
			"vj_fallout/human/femaleraider/genericraider_combattolost_00028d6d_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_combattolost_00028d6e_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_combattolost_00029a83_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_combattolost_000853d5_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_combattolost_000853d6_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_combattolost_000853d7_1.mp3",
		}
		self.SoundTbl_CallForHelp = {
			"vj_fallout/human/femaleraider/generic_normaltocombat_000208e5_1.mp3",
		}
		self.SoundTbl_Suppressing = {
			"vj_fallout/human/femaleraider/genericraider_attack_00028d39_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_attack_00029a75_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_attack_00029a76_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_attack_00048354_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_attack_00048355_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_attack_00048356_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_attack_00048357_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_attack_00048358_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_attack_00048793_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_attack_000853c1_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_attack_000853c2_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_attack_000853c4_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_attack_000853c5_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_attack_000853c6_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_attack_000853c8_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_attack_000853c9_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_attack_000853cb_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_attack_000853ca_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_attack_000853cd_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_attack_000853ce_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_attack_000853cf_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_attack_000853d0_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_attack_000c73c6_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_attack_000c73c7_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_attack_000cadf0_1.mp3",
		}
		self.SoundTbl_AllyDeath = {
			"vj_fallout/human/femaleraider/genericrai_deathresponse_00028d58_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_deathresponse_00029a7b_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_deathresponse_0004834c_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_deathresponse_0004834d_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_deathresponse_0008537f_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_deathresponse_0008537f_1.mp3",
		}
		self.SoundTbl_Alert = {
			"vj_fallout/human/femaleraider/genericrai_alerttocombat_00028d6a_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_alerttocombat_00028d6b_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_alerttocombat_00028d6c_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_alerttocombat_000853d2_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_alerttocombat_000853d3_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_alerttocombat_000853d4_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_normaltocombat_00028d3f_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_normaltocombat_00028d40_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_normaltocombat_00029a80_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_normaltocombat_00085386_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_normaltocombat_00085387_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_normaltocombat_00085388_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_losttocombat_00028d5a_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_losttocombat_00029a73_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_losttocombat_0008539a_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_losttocombat_0008539b_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_losttocombat_0008539c_1.mp3",
		}
		self.SoundTbl_OnGrenadeSight = {
			"vj_fallout/human/femaleraider/genericrai_avoidthreatresp_000853a9_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_avoidthreatresp_000853ab_1.mp3",
		}
		self.SoundTbl_OnKilledEnemy = {
			"vj_fallout/human/femaleraider/genericrai_alerttonormal_00028d6f_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_alerttonormal_00028d70_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_alerttonormal_00028d71_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_alerttonormal_00028d72_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_alerttonormal_00028d73_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_alerttonormal_00028d74_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_alerttonormal_00028d75_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_combattonormal_00028d69_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_combattonormal_00029a93_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_combattonormal_00085377_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_combattonormal_00085378_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_combattonormal_00085379_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_combattonormal_0008537a_1.mp3",
		}
		self.SoundTbl_Guard_Warn = {
			"vj_fallout/human/femaleraider/genericraider_assault_00085370_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_pickpocket_000853a4_1.mp3",
		}
		self.SoundTbl_Guard_Angry = {
			"vj_fallout/human/femaleraider/genericrai_startcombatresp_000853ad_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_startcombatresp_000853b0_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_startcombatresp_000853b1_1.mp3",
		}
		self.SoundTbl_Guard_Calmed = {
			"vj_fallout/human/femaleraider/genericraider_losttonormal_00028d35_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_losttonormal_00029a7f_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_losttonormal_00085396_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_losttonormal_00085397_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_losttonormal_00085398_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_losttonormal_00085399_1.mp3",
		}
		self.SoundTbl_Pain = {
			"vj_fallout/human/femaleraider/generic_hit_00015122_1.mp3",
			"vj_fallout/human/femaleraider/generic_hit_00015123_1.mp3",
			"vj_fallout/human/femaleraider/generic_hit_00015124_1.mp3",
			"vj_fallout/human/femaleraider/generic_hit_00015125_1.mp3",
			"vj_fallout/human/femaleraider/generic_hit_00015126_1.mp3",
			"vj_fallout/human/femaleraider/generic_hit_00015127_1.mp3",
			"vj_fallout/human/femaleraider/generic_hit_000208d8_1.mp3",
			"vj_fallout/human/femaleraider/generic_hit_000208da_1.mp3",
			"vj_fallout/human/femaleraider/generic_hit_000208dc_1.mp3",
			"vj_fallout/human/femaleraider/generic_hit_000208de_1.mp3",
			"vj_fallout/human/femaleraider/generic_hit_000208e0_1.mp3",
			"vj_fallout/human/femaleraider/generic_hit_000208e1_1.mp3",
			"vj_fallout/human/femaleraider/generic_hit_000208e2_1.mp3",
			"vj_fallout/human/femaleraider/generic_hit_000208e3_1.mp3",
		}
		self.SoundTbl_Death = {
			"vj_fallout/human/femaleraider/generic_death_0001fb58_1.mp3",
			"vj_fallout/human/femaleraider/generic_death_0001fb59_1.mp3",
			"vj_fallout/human/femaleraider/generic_death_0001fb5a_1.mp3",
			"vj_fallout/human/femaleraider/generic_death_00020712_1.mp3",
			"vj_fallout/human/femaleraider/generic_death_00020713_1.mp3",
			"vj_fallout/human/femaleraider/generic_death_000208d3_1.mp3",
			"vj_fallout/human/femaleraider/generic_death_000208d4_1.mp3",
			"vj_fallout/human/femaleraider/generic_death_000208d5_1.mp3",
			"vj_fallout/human/femaleraider/generic_death_000208d6_1.mp3",
		}
		self.SoundTbl_Swing = {
			"vj_fallout/human/femaleraider/generic_powerattack_00022aaf_1.mp3",
			"vj_fallout/human/femaleraider/generic_powerattack_00022ab1_1.mp3",
			"vj_fallout/human/femaleraider/generic_powerattack_00051ffa_1.mp3",
			"vj_fallout/human/femaleraider/generic_powerattack_00051ffb_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_powerattack_00085383_1.mp3",
		}
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDoKilledEnemy(argent,attacker,inflictor)
	if !IsValid(self:GetEnemy()) then
		if math.random(1,6) == 1 then
			self:VJ_ACT_PLAYACTIVITY(ACT_MP_GESTURE_VC_HANDMOUTH,true,false,true)
			VJ_EmitSound(self,self.SoundTbl_Laugh,82,100)
		end
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/