AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/player/default.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 50
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = nil -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = false -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {"vjges_h2hattackright_a_npc"} -- Melee Attack Animations
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDamage = 8
ENT.MeleeAttackAnimationAllowOtherTasks = true
ENT.HasGrenadeAttack = false -- Should the SNPC have a grenade attack?
ENT.BecomeEnemyToPlayer = true
ENT.BecomeEnemyToPlayerLevel = 2

ENT.Weapon_AimTurnDiff_Def = 0.83

ENT.HasOnPlayerSight = true -- Should do something when it sees the enemy? Example: Play a sound
ENT.OnPlayerSightDistance = 200 -- How close should the player be until it runs the code?
ENT.OnPlayerSightOnlyOnce = false -- Should it only run the code once?
ENT.OnPlayerSightNextTime1 = 20 -- How much time should it pass until it runs the code again? | First number in math.random
ENT.OnPlayerSightNextTime2 = 30 -- How much time should it pass until it runs the code again? | Second number in math.random

ENT.FootStepTimeRun = 0.35
ENT.FootStepTimeWalk = 0.55

ENT.HasCallForHelpAnimation = false

	-- ====== Animations ====== --
-- ENT.AnimTbl_TakingCover = {}
-- ENT.AnimTbl_MoveOrHideOnDamageByEnemy = {}
-- ENT.AnimTbl_AlertFriendsOnDeath = {}
-- ENT.AnimTbl_WeaponAttackCrouch = {}
-- ENT.AnimTbl_WeaponReloadBehindCover = {}
ENT.AnimTbl_ScaredBehaviorStand = {ACT_IDLE}
ENT.AnimTbl_ScaredBehaviorMovement = {ACT_RUN}

	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 5 -- Chance of it flinching from 1 to x | 1 will make it always flinch
ENT.NextMoveAfterFlinchTime = false -- How much time until it can move, attack, etc. | Use this for schedules or else the base will set the time 0.6 if it sees it's a schedule!
ENT.HasHitGroupFlinching = true -- It will flinch when hit in certain hitgroups | It can also have certain animations to play in certain hitgroups
ENT.HitGroupFlinching_DefaultWhenNotHit = false -- If it uses hitgroup flinching, should it do the regular flinch if it doesn't hit any of the specified hitgroups?
ENT.HitGroupFlinching_Values = {
	{
		HitGroup = {101},
		Animation = {ACT_FLINCH_HEAD}
	},
	{
		HitGroup = {104},
		Animation = {ACT_FLINCH_LEFTARM}
	},
	{
		HitGroup = {105},
		Animation = {ACT_FLINCH_RIGHTARM}
	},
	{
		HitGroup = {106},
		Animation = {ACT_FLINCH_LEFTLEG}
	},
	{
		HitGroup = {107},
		Animation = {ACT_FLINCH_RIGHTLEG}
	},
	{
		HitGroup = {102,103},
		Animation = {ACT_FLINCH_CHEST}
	},
}

ENT.SoundTbl_FootStep = 0
ENT.SoundTbl_IdleDialogue = {}
ENT.SoundTbl_IdleDialogueAnswer = {}
ENT.SoundTbl_Idle = {}
ENT.SoundTbl_FollowPlayer = {}
ENT.SoundTbl_UnFollowPlayer = {}
ENT.SoundTbl_Investigate = {}
ENT.SoundTbl_OnPlayerSight = {}
ENT.SoundTbl_Suppressing = {}
ENT.SoundTbl_Alert = {}
ENT.SoundTbl_OnGrenadeSight = {}
ENT.SoundTbl_OnKilledEnemy = {}
ENT.SoundTbl_Guard_Warn = {}
ENT.SoundTbl_Guard_Angry = {}
ENT.SoundTbl_Guard_Calmed = {}
ENT.SoundTbl_Pain = {}
ENT.SoundTbl_Death = {}
ENT.SoundTbl_Swing = {}

ENT.GeneralSoundPitch1 = 100

ENT.MouthParameter = "mouth"
ENT.Human_IsAggressive = false
ENT.Human_IsSoldier = false

ENT.VJ_F3R_InGuardMode = false
ENT.VJ_F3R_GuardWarnDistance = 800
ENT.VJ_F3R_RanGuardStatusChange = false
ENT.VJ_F3R_GuardPosition = Vector(0,0,0)
ENT.VJ_F3R_MaxGuardDistance = 550

ENT.HairColor = Color(255,255,255)
ENT.CantHaveHairWithApparel = false
ENT.SpawnWithApparelChance = 1
ENT.SpawnWithHairChance = 1
ENT.SpawnWithBeardChance = 1
ENT.tbl_HairModels = {}
ENT.tbl_BeardModels = {}
ENT.tbl_ApparelModels = {}
ENT.CanHolsterWeapon = true
ENT.IsHolstered = false

ENT.VJC_Data = {
    CameraMode = 1, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
    ThirdP_Offset = Vector(0,25,-40), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "Bip01 Head", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(3, 0, 0), -- The offset for the controller when the camera is in first person
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetVoice(voice)
	if voice == "female01" then
		self.SoundTbl_Idle = {}
		self.SoundTbl_Alert = {
			"vj_fallout/human/femaleadult01/b_alerttocombat01.wav",
			"vj_fallout/human/femaleadult01/b_alerttocombat02.wav",
			"vj_fallout/human/femaleadult01/b_alerttocombat03.wav",
			"vj_fallout/human/femaleadult01/b_alerttocombat04.wav",
			"vj_fallout/human/femaleadult01/b_alerttocombat05.wav",
			"vj_fallout/human/femaleadult01/b_normaltocombat01.wav",
			"vj_fallout/human/femaleadult01/b_normaltocombat02.wav",
			"vj_fallout/human/femaleadult01/b_normaltocombat03.wav",
			"vj_fallout/human/femaleadult01/b_normaltocombat04.wav"
		}
		self.SoundTbl_CombatIdle = {
			"vj_fallout/human/femaleadult01/b_alertidle01.wav",
			"vj_fallout/human/femaleadult01/b_alertidle02.wav",
			"vj_fallout/human/femaleadult01/b_alertidle03.wav",
			"vj_fallout/human/femaleadult01/b_alertidle04.wav",
			"vj_fallout/human/femaleadult01/b_alertidle05.wav",
			"vj_fallout/human/femaleadult01/b_alertidle06.wav"
		}
		self.SoundTbl_Investigate = {
			"vj_fallout/human/femaleadult01/b_normaltoalert01.wav",
			"vj_fallout/human/femaleadult01/b_normaltoalert02.wav",
			"vj_fallout/human/femaleadult01/b_normaltoalert03.wav",
			"vj_fallout/human/femaleadult01/b_normaltoalert04.wav",
			"vj_fallout/human/femaleadult01/b_normaltoalert05.wav"
		}
		self.SoundTbl_LostEnemy = {
			"vj_fallout/human/femaleadult01/b_alerttonormal01.wav",
			"vj_fallout/human/femaleadult01/b_alerttonormal02.wav",
			"vj_fallout/human/femaleadult01/b_alerttonormal03.wav",
			"vj_fallout/human/femaleadult01/b_alerttonormal04.wav",
			"vj_fallout/human/femaleadult01/b_alerttonormal05.wav",
			"vj_fallout/human/femaleadult01/b_alerttonormal06.wav",
			"vj_fallout/human/femaleadult01/b_combattolost01.wav",
			"vj_fallout/human/femaleadult01/b_combattolost02.wav",
			"vj_fallout/human/femaleadult01/b_combattolost03.wav",
			"vj_fallout/human/femaleadult01/b_combattolost04.wav",
			"vj_fallout/human/femaleadult01/b_combattolost05.wav",
			"vj_fallout/human/femaleadult01/b_combattolost06.wav"
		}
		self.SoundTbl_Suppressing = {
			"vj_fallout/human/femaleadult01/b_attack01.wav",
			"vj_fallout/human/femaleadult01/b_attack02.wav",
			"vj_fallout/human/femaleadult01/b_attack03.wav",
			"vj_fallout/human/femaleadult01/b_attack04.wav",
			"vj_fallout/human/femaleadult01/b_attack05.wav",
			"vj_fallout/human/femaleadult01/b_attack06.wav",
			"vj_fallout/human/femaleadult01/b_attack07.wav",
			"vj_fallout/human/femaleadult01/b_attack08.wav",
			"vj_fallout/human/femaleadult01/b_attack09.wav",
			"vj_fallout/human/femaleadult01/b_attack10.wav",
			"vj_fallout/human/femaleadult01/b_attack11.wav"
		}
		self.SoundTbl_DamageByPlayer = {}
		self.SoundTbl_CallForHelp = {}
		self.SoundTbl_OnGrenadeSight = {
			"vj_fallout/human/femaleadult01/b_avoidthreat01.wav",
			"vj_fallout/human/femaleadult01/b_avoidthreat02.wav",
			"vj_fallout/human/femaleadult01/b_avoidthreat03.wav",
			"vj_fallout/human/femaleadult01/b_avoidthreat04.wav",
		}
		self.SoundTbl_AllyDeath = {
			"vj_fallout/human/femaleadult01/b_deathresponse01.wav",
			"vj_fallout/human/femaleadult01/b_deathresponse02.wav",
			"vj_fallout/human/femaleadult01/b_deathresponse03.wav",
			"vj_fallout/human/femaleadult01/b_deathresponse04.wav",
		}
		self.SoundTbl_Pain = {
			"vj_fallout/human/femaleadult01/b_hit01.wav",
			"vj_fallout/human/femaleadult01/b_hit02.wav",
			"vj_fallout/human/femaleadult01/b_hit03.wav",
			"vj_fallout/human/femaleadult01/b_hit04.wav",
			"vj_fallout/human/femaleadult01/b_hit05.wav",
			"vj_fallout/human/femaleadult01/b_hit06.wav",
			"vj_fallout/human/femaleadult01/b_hit07.wav",
			"vj_fallout/human/femaleadult01/hit01.wav",
			"vj_fallout/human/femaleadult01/hit02.wav",
			"vj_fallout/human/femaleadult01/hit03.wav",
			"vj_fallout/human/femaleadult01/hit04.wav",
			"vj_fallout/human/femaleadult01/hit05.wav",
		}
		self.SoundTbl_Death = {
			"vj_fallout/human/femaleadult01/death01.wav",
			"vj_fallout/human/femaleadult01/death02.wav",
			"vj_fallout/human/femaleadult01/death03.wav"
		}
		self.SoundTbl_OnClearedArea = {
			"vj_fallout/human/femaleadult01/b_combattonormal01.wav",
			"vj_fallout/human/femaleadult01/b_combattonormal02.wav",
			"vj_fallout/human/femaleadult01/b_combattonormal03.wav",
			"vj_fallout/human/femaleadult01/b_combattonormal04.wav",
			"vj_fallout/human/femaleadult01/b_combattonormal05.wav",
			"vj_fallout/human/femaleadult01/b_combattonormal06.wav"
		}
		self.SoundTbl_OnKilledEnemy = {}
		self.SoundTbl_Guard_Warn = {}
		self.SoundTbl_Guard_Angry = {}
		self.SoundTbl_Guard_Calmed = {}
	elseif voice == "female06" then
		self.SoundTbl_Idle = {}
		self.SoundTbl_Alert = {
			"vj_fallout/human/femaleadult06/b_alerttocombat01.wav",
			"vj_fallout/human/femaleadult06/b_alerttocombat02.wav",
			"vj_fallout/human/femaleadult06/b_alerttocombat03.wav",
			"vj_fallout/human/femaleadult06/b_alerttocombat04.wav",
			"vj_fallout/human/femaleadult06/b_alerttocombat05.wav",
			"vj_fallout/human/femaleadult06/b_normaltocombat01.wav",
			"vj_fallout/human/femaleadult06/b_normaltocombat02.wav",
			"vj_fallout/human/femaleadult06/b_normaltocombat03.wav",
			"vj_fallout/human/femaleadult06/b_normaltocombat04.wav"
		}
		self.SoundTbl_CombatIdle = {
			"vj_fallout/human/femaleadult06/b_alertidle01.wav",
			"vj_fallout/human/femaleadult06/b_alertidle02.wav",
			"vj_fallout/human/femaleadult06/b_alertidle03.wav",
			"vj_fallout/human/femaleadult06/b_alertidle04.wav",
			"vj_fallout/human/femaleadult06/b_alertidle05.wav",
			"vj_fallout/human/femaleadult06/b_alertidle06.wav"
		}
		self.SoundTbl_Investigate = {
			"vj_fallout/human/femaleadult06/b_normaltoalert01.wav",
			"vj_fallout/human/femaleadult06/b_normaltoalert02.wav",
			"vj_fallout/human/femaleadult06/b_normaltoalert03.wav",
			"vj_fallout/human/femaleadult06/b_normaltoalert04.wav",
			"vj_fallout/human/femaleadult06/b_normaltoalert05.wav"
		}
		self.SoundTbl_LostEnemy = {
			"vj_fallout/human/femaleadult06/b_alerttonormal01.wav",
			"vj_fallout/human/femaleadult06/b_alerttonormal02.wav",
			"vj_fallout/human/femaleadult06/b_alerttonormal03.wav",
			"vj_fallout/human/femaleadult06/b_alerttonormal04.wav",
			"vj_fallout/human/femaleadult06/b_alerttonormal05.wav",
			"vj_fallout/human/femaleadult06/b_alerttonormal06.wav",
			"vj_fallout/human/femaleadult06/b_combattolost01.wav",
			"vj_fallout/human/femaleadult06/b_combattolost02.wav",
			"vj_fallout/human/femaleadult06/b_combattolost03.wav",
			"vj_fallout/human/femaleadult06/b_combattolost04.wav",
			"vj_fallout/human/femaleadult06/b_combattolost05.wav",
			"vj_fallout/human/femaleadult06/b_combattolost06.wav"
		}
		self.SoundTbl_Suppressing = {
			"vj_fallout/human/femaleadult06/b_attack01.wav",
			"vj_fallout/human/femaleadult06/b_attack02.wav",
			"vj_fallout/human/femaleadult06/b_attack03.wav",
			"vj_fallout/human/femaleadult06/b_attack04.wav",
			"vj_fallout/human/femaleadult06/b_attack05.wav",
			"vj_fallout/human/femaleadult06/b_attack06.wav",
			"vj_fallout/human/femaleadult06/b_attack07.wav",
			"vj_fallout/human/femaleadult06/b_attack08.wav",
			"vj_fallout/human/femaleadult06/b_attack09.wav",
			"vj_fallout/human/femaleadult06/b_attack10.wav",
			"vj_fallout/human/femaleadult06/b_attack11.wav"
		}
		self.SoundTbl_DamageByPlayer = {}
		self.SoundTbl_CallForHelp = {}
		self.SoundTbl_OnGrenadeSight = {
			"vj_fallout/human/femaleadult06/b_avoidthreat01.wav",
			"vj_fallout/human/femaleadult06/b_avoidthreat02.wav",
			"vj_fallout/human/femaleadult06/b_avoidthreat03.wav",
			"vj_fallout/human/femaleadult06/b_avoidthreat04.wav",
		}
		self.SoundTbl_AllyDeath = {
			"vj_fallout/human/femaleadult06/b_deathresponse01.wav",
			"vj_fallout/human/femaleadult06/b_deathresponse02.wav",
			"vj_fallout/human/femaleadult06/b_deathresponse03.wav",
			"vj_fallout/human/femaleadult06/b_deathresponse04.wav",
		}
		self.SoundTbl_Pain = {
			"vj_fallout/human/femaleadult06/b_hit01.wav",
			"vj_fallout/human/femaleadult06/b_hit02.wav",
			"vj_fallout/human/femaleadult06/b_hit03.wav",
			"vj_fallout/human/femaleadult06/b_hit04.wav",
			"vj_fallout/human/femaleadult06/b_hit05.wav",
			"vj_fallout/human/femaleadult06/b_hit06.wav",
			"vj_fallout/human/femaleadult06/b_hit07.wav",
			"vj_fallout/human/femaleadult06/hit01.wav",
			"vj_fallout/human/femaleadult06/hit02.wav",
			"vj_fallout/human/femaleadult06/hit03.wav",
			"vj_fallout/human/femaleadult06/hit04.wav",
			"vj_fallout/human/femaleadult06/hit05.wav",
		}
		self.SoundTbl_Death = {
			"vj_fallout/human/femaleadult06/death01.wav",
			"vj_fallout/human/femaleadult06/death02.wav",
			"vj_fallout/human/femaleadult06/death03.wav"
		}
		self.SoundTbl_OnClearedArea = {
			"vj_fallout/human/femaleadult06/b_combattonormal01.wav",
			"vj_fallout/human/femaleadult06/b_combattonormal02.wav",
			"vj_fallout/human/femaleadult06/b_combattonormal03.wav",
			"vj_fallout/human/femaleadult06/b_combattonormal04.wav",
			"vj_fallout/human/femaleadult06/b_combattonormal05.wav",
			"vj_fallout/human/femaleadult06/b_combattonormal06.wav"
		}
		self.SoundTbl_OnKilledEnemy = {}
		self.SoundTbl_Guard_Warn = {}
		self.SoundTbl_Guard_Angry = {}
		self.SoundTbl_Guard_Calmed = {}
	elseif voice == "female03" then
		self.SoundTbl_OnGrenadeSight = {
			"vj_fallout/human/femaleadult03/genericadu_avoidthreat_0017520f_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_avoidthreat_00175210_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_avoidthreat_00175217_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_avoidthreat_00175218_1.wav",
		}
		self.SoundTbl_OnClearedArea = {
			"vj_fallout/human/femaleadult03/generic_combattonormal_00175189_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_combattonormal_0017518a_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_combattonormal_0017518b_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_combattonormal_0017518c_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_combattonormal_00175196_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_combattonormal_00175197_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_combattonormal_00175198_1.wav",
		}
		self.SoundTbl_CombatIdle = {
			"vj_fallout/human/femaleadult03/generic_alertidle_00175249_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_alertidle_0017524a_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_alertidle_0017524b_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_alertidle_0017524c_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_alertidle_00175256_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_alertidle_00175257_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_alertidle_00175258_1.wav",
		}
		self.SoundTbl_Guard_Angry = {
			"vj_fallout/human/femaleadult03/generic_normaltocombat_001750e6_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_normaltocombat_001750e7_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_normaltocombat_001750e8_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_normaltocombat_001750e9_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_normaltocombat_001750f3_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_normaltocombat_001750f4_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_normaltocombat_001750f5_1.wav",
		}
		self.SoundTbl_Guard_Warn = {
			"vj_fallout/human/femaleadult03/genericadu_guardtrespass_0017513e_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_guardtrespass_0017513f_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_guardtrespass_00175140_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_guardtrespass_0017514a_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_guardtrespass_0017514b_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_guardtrespass_0017514c_1.wav",
		}
		self.SoundTbl_Suppressing = {
			"vj_fallout/human/femaleadult03/genericadultcombat_attack_001751e8_1.wav",
			"vj_fallout/human/femaleadult03/genericadultcombat_attack_001751e9_1.wav",
			"vj_fallout/human/femaleadult03/genericadultcombat_attack_001751ea_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_attack_001751ec_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_attack_001751ed_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_attack_001751ee_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_attack_001751ef_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_attack_001751f0_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_attack_001751f1_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_attack_001751f2_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguen_attack_001751eb_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_attack_001751fd_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_attack_001751fe_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_attack_001751ff_1.wav",
		}
		self.SoundTbl_FollowPlayer = {
			"vj_fallout/human/femaleadult03/generic_hello_0017529a_1.wav",
			"vj_fallout/human/femaleadult03/genericadult_greeting_00175434_1.wav",
			"vj_fallout/human/femaleadult03/genericadult_hello_0017529b_1.wav",
			"vj_fallout/human/femaleadult03/genericadult_hello_0017529c_1.wav",
			"vj_fallout/human/femaleadult03/genericadult_hello_0017529d_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_0015439b_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_0015439c_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00155dad_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00155dae_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00155daf_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_0017585f_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00175860_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00175861_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00175862_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00175863_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00175864_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00175865_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00175866_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00175867_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00175868_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00175869_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155eb8_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155eb9_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155eba_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ebb_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ebc_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ebd_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ebe_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ebf_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ec0_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ec1_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ec2_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ec3_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ec4_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ec5_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ec6_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ec7_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ec8_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ec9_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155eca_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ecb_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ecc_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ecd_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00156a91_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00156a92_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_0016335d_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754e8_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754e9_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754ea_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754eb_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754ec_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754ed_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754ee_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754ef_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754f0_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754f1_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754f2_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754f3_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754f4_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754f5_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754f6_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754f7_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754f8_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754f9_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754fa_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754fb_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754fc_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754fd_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754fe_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754ff_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175500_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175501_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175502_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175503_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175504_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175505_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175506_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175507_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175508_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175509_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_0017550a_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_0017550b_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_0017550c_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_0017550d_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_0017550e_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_0017550f_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175510_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175511_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175512_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175513_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175514_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175515_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175516_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175517_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00176eec_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00176eee_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_001559c9_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155ea6_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155ea7_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155ea8_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155ea9_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155eaa_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155eab_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155eac_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155ead_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155eae_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155eaf_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155eb0_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155eb1_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155eb2_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155eb3_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155eb4_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155eb5_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155eb6_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00156a5d_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_00156907_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752ca_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752cb_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752cc_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752cd_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752ce_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752cf_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752d0_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752d1_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752d2_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752d3_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752d4_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752d5_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752d6_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752d7_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752d8_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752d9_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752da_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752db_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752dc_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752dd_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752de_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752df_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752e1_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752e2_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752e3_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752e4_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752e5_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752e6_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752e7_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752e8_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752e9_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752ea_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueprimm_greeting_00099cf7_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueprimm_greeting_000cdb14_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueprimm_greeting_000cdb15_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueprimm_greeting_000cdb16_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguer_greeting_0011e469_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguer_greeting_0012b879_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguer_greeting_0014f39d_1.wav",
			"vj_fallout/human/femaleadult03/vdialogues_greeting_000f3bf3_1.wav",
			"vj_fallout/human/femaleadult03/vsafehouse_greeting_0015a8f7_1.wav",
		}
		self.SoundTbl_OnPlayerSight = {}
		self.SoundTbl_Investigate = {
			"vj_fallout/human/femaleadult03/generic_normaltoalert_00175171_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_normaltoalert_00175172_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_normaltoalert_00175173_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_normaltoalert_00175174_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_normaltoalert_0017517d_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_normaltoalert_0017517e_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_normaltoalert_0017517f_1.wav",
		}
		self.SoundTbl_OnKilledEnemy = {
			"vj_fallout/human/femaleadult03/generic_combattonormal_00175189_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_combattonormal_0017518a_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_combattonormal_0017518b_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_combattonormal_0017518c_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_combattonormal_00175196_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_combattonormal_00175197_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_combattonormal_00175198_1.wav",
		}
		self.SoundTbl_UnFollowPlayer = {
			"vj_fallout/human/femaleadult03/generic_goodbye_00049e16_1.wav",
			"vj_fallout/human/femaleadult03/genericadult_goodbye_0004e5e3_1.wav",
			"vj_fallout/human/femaleadult03/genericadult_goodbye_001751c5_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_goodbye_001559af_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_goodbye_00155ea2_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_goodbye_00155ea3_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_goodbye_00155ea4_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguer_goodbye_0014f391_1.wav",
		}
		self.SoundTbl_Guard_Calmed = {
			"vj_fallout/human/femaleadult03/generic_alerttonormal_0017527d_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_acceptyield_001750d8_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_alerttonormal_0017527e_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_alerttonormal_0017527f_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_alerttonormal_00175280_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_acceptyield_001750da_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_acceptyield_001750db_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_acceptyield_001750df_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_alerttonormal_0017528a_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_alerttonormal_0017528b_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_alerttonormal_0017528c_1.wav",
		}
		self.SoundTbl_AllyDeath = {
			"vj_fallout/human/femaleadult03/genericadu_deathresponse_001751ab_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_deathresponse_001751ac_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_deathresponse_001751ad_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_deathresponse_001751ae_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_deathresponse_001751af_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguen_deathresponse_0015724b_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_deathresponse_001751c0_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_deathresponse_001751c1_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_deathresponse_001751c2_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_deathresponse_001751c3_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_deathresponse_001751c4_1.wav",
		}
		self.SoundTbl_IdleDialogue = {
			"vj_fallout/human/femaleadult03/generic_hello_0017529a_1.wav",
			"vj_fallout/human/femaleadult03/genericadult_greeting_00175434_1.wav",
			"vj_fallout/human/femaleadult03/genericadult_hello_0017529b_1.wav",
			"vj_fallout/human/femaleadult03/genericadult_hello_0017529c_1.wav",
			"vj_fallout/human/femaleadult03/genericadult_hello_0017529d_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_0015439b_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_0015439c_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00155dad_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00155dae_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00155daf_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_0017585f_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00175860_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00175861_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00175862_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00175863_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00175864_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00175865_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00175866_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00175867_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00175868_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00175869_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155eb8_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155eb9_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155eba_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ebb_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ebc_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ebd_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ebe_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ebf_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ec0_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ec1_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ec2_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ec3_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ec4_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ec5_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ec6_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ec7_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ec8_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ec9_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155eca_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ecb_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ecc_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ecd_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00156a91_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00156a92_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_0016335d_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754e8_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754e9_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754ea_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754eb_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754ec_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754ed_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754ee_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754ef_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754f0_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754f1_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754f2_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754f3_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754f4_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754f5_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754f6_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754f7_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754f8_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754f9_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754fa_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754fb_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754fc_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754fd_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754fe_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754ff_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175500_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175501_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175502_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175503_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175504_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175505_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175506_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175507_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175508_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175509_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_0017550a_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_0017550b_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_0017550c_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_0017550d_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_0017550e_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_0017550f_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175510_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175511_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175512_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175513_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175514_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175515_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175516_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175517_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00176eec_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00176eee_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_001559c9_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155ea6_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155ea7_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155ea8_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155ea9_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155eaa_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155eab_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155eac_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155ead_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155eae_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155eaf_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155eb0_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155eb1_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155eb2_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155eb3_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155eb4_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155eb5_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155eb6_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00156a5d_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_00156907_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752ca_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752cb_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752cc_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752cd_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752ce_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752cf_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752d0_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752d1_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752d2_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752d3_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752d4_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752d5_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752d6_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752d7_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752d8_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752d9_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752da_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752db_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752dc_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752dd_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752de_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752df_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752e1_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752e2_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752e3_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752e4_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752e5_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752e6_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752e7_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752e8_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752e9_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752ea_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueprimm_greeting_00099cf7_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueprimm_greeting_000cdb14_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueprimm_greeting_000cdb15_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueprimm_greeting_000cdb16_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguer_greeting_0011e469_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguer_greeting_0012b879_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguer_greeting_0014f39d_1.wav",
			"vj_fallout/human/femaleadult03/vdialogues_greeting_000f3bf3_1.wav",
			"vj_fallout/human/femaleadult03/vsafehouse_greeting_0015a8f7_1.wav",
		}
		self.SoundTbl_Alert = {
			"vj_fallout/human/femaleadult03/generic_alerttocombat_001751d8_1.wav",
			"vj_fallout/human/femaleadult03/generic_normaltocombat_001750e6_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_alerttocombat_0005200f_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_alerttocombat_001751d9_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_alerttocombat_001751da_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_alerttocombat_001751db_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_normaltocombat_001750e7_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_normaltocombat_001750e8_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_normaltocombat_001750e9_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_alerttocombat_001751e5_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_alerttocombat_001751e6_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_alerttocombat_001751e7_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_normaltocombat_001750f3_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_normaltocombat_001750f4_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_normaltocombat_001750f5_1.wav",
		}
		self.SoundTbl_DamageByPlayer = {
			"vj_fallout/human/femaleadult03/genericadultcombat_assault_001750fc_1.wav",
			"vj_fallout/human/femaleadult03/genericadultcombat_assault_001750fd_1.wav",
			"vj_fallout/human/femaleadult03/genericadultcombat_assault_001750fe_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguen_assault_001750ff_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_assault_0017510d_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_assault_0017510e_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_assault_00176ee8_1.wav",
		}
		self.SoundTbl_Idle = {}
		self.SoundTbl_LostEnemy = {
			"vj_fallout/human/femaleadult03/generic_alerttonormal_0017527d_1.wav",
			"vj_fallout/human/femaleadult03/generic_combattolost_0017515b_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_alerttonormal_0017527e_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_alerttonormal_0017527f_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_alerttonormal_00175280_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_combattolost_0017515c_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_combattolost_0017515d_1.wav",
			"vj_fallout/human/femaleadult03/genericadu_combattolost_0017515e_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_alerttonormal_0017528a_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_alerttonormal_0017528b_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_alerttonormal_0017528c_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_combattolost_00175168_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_combattolost_00175169_1.wav",
			"vj_fallout/human/femaleadult03/vnellisgen_combattolost_0017516a_1.wav",
		}
		self.SoundTbl_Pain = {
			"vj_fallout/human/femaleadult03/generic_hit_00175238_1.wav",
			"vj_fallout/human/femaleadult03/generic_hit_00175239_1.wav",
			"vj_fallout/human/femaleadult03/generic_hit_0017523a_1.wav",
			"vj_fallout/human/femaleadult03/generic_hit_0017523b_1.wav",
			"vj_fallout/human/femaleadult03/generic_hit_0017523c_1.wav",
			"vj_fallout/human/femaleadult03/genericadultcombat_hit_0017523d_1.wav",
			"vj_fallout/human/femaleadult03/genericadultcombat_hit_0017523e_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguen_hit_0015b6c4_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguen_hit_00175245_1.wav",
		}
		self.SoundTbl_Swing = {
			"vj_fallout/human/femaleadult03/generic_powerattack_001750e0_1.wav",
			"vj_fallout/human/femaleadult03/generic_powerattack_001750e1_1.wav",
			"vj_fallout/human/femaleadult03/generic_powerattack_001750e2_1.wav",
			"vj_fallout/human/femaleadult03/generic_powerattack_001750e3_1.wav",
		}
		self.SoundTbl_IdleDialogueAnswer = {
			"vj_fallout/human/femaleadult03/generic_goodbye_00049e16_1.wav",
			"vj_fallout/human/femaleadult03/generic_hello_0017529a_1.wav",
			"vj_fallout/human/femaleadult03/genericadult_goodbye_0004e5e3_1.wav",
			"vj_fallout/human/femaleadult03/genericadult_goodbye_001751c5_1.wav",
			"vj_fallout/human/femaleadult03/genericadult_greeting_00175434_1.wav",
			"vj_fallout/human/femaleadult03/genericadult_hello_0017529b_1.wav",
			"vj_fallout/human/femaleadult03/genericadult_hello_0017529c_1.wav",
			"vj_fallout/human/femaleadult03/genericadult_hello_0017529d_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_0015439b_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_0015439c_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00155dad_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00155dae_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00155daf_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_0017585f_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00175860_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00175861_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00175862_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00175863_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00175864_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00175865_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00175866_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00175867_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00175868_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueb_greeting_00175869_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_goodbye_001559af_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_goodbye_00155ea2_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_goodbye_00155ea3_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_goodbye_00155ea4_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155eb8_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155eb9_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155eba_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ebb_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ebc_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ebd_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ebe_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ebf_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ec0_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ec1_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ec2_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ec3_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ec4_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ec5_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ec6_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ec7_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ec8_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ec9_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155eca_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ecb_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ecc_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00155ecd_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00156a91_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00156a92_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_0016335d_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754e8_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754e9_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754ea_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754eb_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754ec_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754ed_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754ee_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754ef_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754f0_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754f1_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754f2_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754f3_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754f4_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754f5_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754f6_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754f7_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754f8_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754f9_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754fa_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754fb_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754fc_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754fd_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754fe_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_001754ff_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175500_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175501_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175502_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175503_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175504_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175505_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175506_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175507_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175508_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175509_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_0017550a_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_0017550b_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_0017550c_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_0017550d_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_0017550e_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_0017550f_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175510_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175511_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175512_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175513_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175514_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175515_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175516_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00175517_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00176eec_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_greeting_00176eee_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_001559c9_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155ea6_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155ea7_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155ea8_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155ea9_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155eaa_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155eab_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155eac_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155ead_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155eae_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155eaf_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155eb0_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155eb1_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155eb2_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155eb3_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155eb4_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155eb5_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00155eb6_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguef_hello_00156a5d_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_00156907_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752ca_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752cb_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752cc_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752cd_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752ce_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752cf_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752d0_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752d1_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752d2_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752d3_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752d4_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752d5_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752d6_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752d7_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752d8_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752d9_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752da_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752db_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752dc_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752dd_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752de_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752df_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752e1_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752e2_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752e3_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752e4_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752e5_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752e6_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752e7_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752e8_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752e9_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguencrmilitary_hello_001752ea_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueprimm_greeting_00099cf7_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueprimm_greeting_000cdb14_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueprimm_greeting_000cdb15_1.wav",
			"vj_fallout/human/femaleadult03/vdialogueprimm_greeting_000cdb16_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguer_goodbye_0014f391_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguer_greeting_0011e469_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguer_greeting_0012b879_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguer_greeting_0014f39d_1.wav",
			"vj_fallout/human/femaleadult03/vdialogues_greeting_000f3bf3_1.wav",
			"vj_fallout/human/femaleadult03/vsafehouse_greeting_0015a8f7_1.wav",
		}
		self.SoundTbl_Death = {
			"vj_fallout/human/femaleadult03/generic_death_00175180_1.wav",
			"vj_fallout/human/femaleadult03/generic_death_00175181_1.wav",
			"vj_fallout/human/femaleadult03/generic_death_00175182_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguen_death_00175186_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguen_death_00175187_1.wav",
			"vj_fallout/human/femaleadult03/vdialoguen_death_00175188_1.wav",
		}
	elseif voice == "female07" then
		self.SoundTbl_Idle = {}
		self.SoundTbl_Alert = {
			"vj_fallout/human/femaleadult07/b_alerttocombat01.wav",
			"vj_fallout/human/femaleadult07/b_alerttocombat02.wav",
			"vj_fallout/human/femaleadult07/b_alerttocombat03.wav",
			"vj_fallout/human/femaleadult07/b_alerttocombat04.wav",
			"vj_fallout/human/femaleadult07/b_alerttocombat05.wav",
			"vj_fallout/human/femaleadult07/b_normaltocombat01.wav",
			"vj_fallout/human/femaleadult07/b_normaltocombat02.wav",
			"vj_fallout/human/femaleadult07/b_normaltocombat03.wav",
			"vj_fallout/human/femaleadult07/b_normaltocombat04.wav"
		}
		self.SoundTbl_CombatIdle = {
			"vj_fallout/human/femaleadult07/b_alertidle01.wav",
			"vj_fallout/human/femaleadult07/b_alertidle02.wav",
			"vj_fallout/human/femaleadult07/b_alertidle03.wav",
			"vj_fallout/human/femaleadult07/b_alertidle04.wav",
			"vj_fallout/human/femaleadult07/b_alertidle05.wav",
			"vj_fallout/human/femaleadult07/b_alertidle06.wav"
		}
		self.SoundTbl_Investigate = {
			"vj_fallout/human/femaleadult07/b_normaltoalert01.wav",
			"vj_fallout/human/femaleadult07/b_normaltoalert02.wav",
			"vj_fallout/human/femaleadult07/b_normaltoalert03.wav",
			"vj_fallout/human/femaleadult07/b_normaltoalert04.wav",
			"vj_fallout/human/femaleadult07/b_normaltoalert05.wav"
		}
		self.SoundTbl_LostEnemy = {
			"vj_fallout/human/femaleadult07/b_alerttonormal01.wav",
			"vj_fallout/human/femaleadult07/b_alerttonormal02.wav",
			"vj_fallout/human/femaleadult07/b_alerttonormal03.wav",
			"vj_fallout/human/femaleadult07/b_alerttonormal04.wav",
			"vj_fallout/human/femaleadult07/b_alerttonormal05.wav",
			"vj_fallout/human/femaleadult07/b_alerttonormal06.wav",
			"vj_fallout/human/femaleadult07/b_combattolost01.wav",
			"vj_fallout/human/femaleadult07/b_combattolost02.wav",
			"vj_fallout/human/femaleadult07/b_combattolost03.wav",
			"vj_fallout/human/femaleadult07/b_combattolost04.wav",
			"vj_fallout/human/femaleadult07/b_combattolost05.wav",
			"vj_fallout/human/femaleadult07/b_combattolost06.wav"
		}
		self.SoundTbl_Suppressing = {
			"vj_fallout/human/femaleadult07/b_attack01.wav",
			"vj_fallout/human/femaleadult07/b_attack02.wav",
			"vj_fallout/human/femaleadult07/b_attack03.wav",
			"vj_fallout/human/femaleadult07/b_attack04.wav",
			"vj_fallout/human/femaleadult07/b_attack05.wav",
			"vj_fallout/human/femaleadult07/b_attack06.wav",
			"vj_fallout/human/femaleadult07/b_attack07.wav",
			"vj_fallout/human/femaleadult07/b_attack08.wav",
			"vj_fallout/human/femaleadult07/b_attack09.wav",
			"vj_fallout/human/femaleadult07/b_attack10.wav",
			"vj_fallout/human/femaleadult07/b_attack11.wav"
		}
		self.SoundTbl_DamageByPlayer = {}
		self.SoundTbl_CallForHelp = {}
		self.SoundTbl_OnGrenadeSight = {
			"vj_fallout/human/femaleadult07/b_avoidthreat01.wav",
			"vj_fallout/human/femaleadult07/b_avoidthreat02.wav",
			"vj_fallout/human/femaleadult07/b_avoidthreat03.wav",
			"vj_fallout/human/femaleadult07/b_avoidthreat04.wav",
		}
		self.SoundTbl_AllyDeath = {
			"vj_fallout/human/femaleadult07/b_deathresponse01.wav",
			"vj_fallout/human/femaleadult07/b_deathresponse02.wav",
			"vj_fallout/human/femaleadult07/b_deathresponse03.wav",
			"vj_fallout/human/femaleadult07/b_deathresponse04.wav",
		}
		self.SoundTbl_Pain = {
			"vj_fallout/human/femaleadult07/b_hit01.wav",
			"vj_fallout/human/femaleadult07/b_hit02.wav",
			"vj_fallout/human/femaleadult07/b_hit03.wav",
			"vj_fallout/human/femaleadult07/b_hit04.wav",
			"vj_fallout/human/femaleadult07/b_hit05.wav",
			"vj_fallout/human/femaleadult07/b_hit06.wav",
			"vj_fallout/human/femaleadult07/b_hit07.wav",
			"vj_fallout/human/femaleadult07/hit01.wav",
			"vj_fallout/human/femaleadult07/hit02.wav",
			"vj_fallout/human/femaleadult07/hit03.wav",
			"vj_fallout/human/femaleadult07/hit04.wav",
			"vj_fallout/human/femaleadult07/hit05.wav",
		}
		self.SoundTbl_Death = {
			"vj_fallout/human/femaleadult07/death01.wav",
			"vj_fallout/human/femaleadult07/death02.wav",
			"vj_fallout/human/femaleadult07/death03.wav"
		}
		self.SoundTbl_OnClearedArea = {
			"vj_fallout/human/femaleadult07/b_combattonormal01.wav",
			"vj_fallout/human/femaleadult07/b_combattonormal02.wav",
			"vj_fallout/human/femaleadult07/b_combattonormal03.wav",
			"vj_fallout/human/femaleadult07/b_combattonormal04.wav",
			"vj_fallout/human/femaleadult07/b_combattonormal05.wav",
			"vj_fallout/human/femaleadult07/b_combattonormal06.wav"
		}
		self.SoundTbl_OnKilledEnemy = {}
		self.SoundTbl_Guard_Warn = {}
		self.SoundTbl_Guard_Angry = {}
		self.SoundTbl_Guard_Calmed = {}
	elseif voice == "femaleraider" then
		self.SoundTbl_OnGrenadeSight = {
			"vj_fallout/human/femaleraider/genericrai_avoidthreatresp_000853a9_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_avoidthreatresp_000853ab_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_avoidthreat_00028d45_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_avoidthreat_00028d46_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_avoidthreat_00028d47_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_avoidthreat_0004834f_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_avoidthreat_00048791_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_avoidthreat_000853bf_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_avoidthreat_000853c0_1.mp3",
		}
		self.SoundTbl_OnClearedArea = {
			"vj_fallout/human/femaleraider/genericrai_combattonormal_00028d69_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_combattonormal_00029a93_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_combattonormal_00085377_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_combattonormal_00085378_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_combattonormal_00085379_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_combattonormal_0008537a_1.mp3",
		}
		self.SoundTbl_CombatIdle = {
			"vj_fallout/human/femaleraider/genericraider_alertidle_0008539d_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_alertidle_0008539e_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_alertidle_0008539f_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_alertidle_000853a0_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_alertidle_000853a1_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_alertidle_000853a2_1.mp3",
		}
		self.SoundTbl_Guard_Angry = {
			"vj_fallout/human/femaleraider/generic_normaltocombat_000208e5_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_normaltocombat_00028d3f_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_normaltocombat_00028d40_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_normaltocombat_00029a80_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_normaltocombat_00085386_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_normaltocombat_00085387_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_normaltocombat_00085388_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_startcombatresp_000853ad_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_startcombatresp_000853b0_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_startcombatresp_000853b1_1.mp3",
		}
		self.SoundTbl_Guard_Warn = {}
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
			"vj_fallout/human/femaleraider/genericraider_attack_000853ca_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_attack_000853cb_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_attack_000853cd_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_attack_000853ce_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_attack_000853cf_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_attack_000853d0_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_attack_000c73c6_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_attack_000c73c7_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_attack_000cadf0_1.mp3",
		}
		self.SoundTbl_FollowPlayer = {}
		self.SoundTbl_OnPlayerSight = {}
		self.SoundTbl_Investigate = {
			"vj_fallout/human/femaleraider/generic_normaltoalert_0002fc23_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_normaltoalert_00028d49_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_normaltoalert_00029a94_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_normaltoalert_0008537b_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_normaltoalert_0008537c_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_normaltoalert_0008537d_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_normaltoalert_0008537e_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_normaltoalertre_000819c3_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_normaltoalertre_000819c4_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_normaltoalertre_00085381_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_normaltoalertre_00085382_1.mp3",
		}
		self.SoundTbl_OnKilledEnemy = {
			"vj_fallout/human/femaleraider/genericrai_combattonormal_00028d69_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_combattonormal_00029a93_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_combattonormal_00085377_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_combattonormal_00085378_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_combattonormal_00085379_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_combattonormal_0008537a_1.mp3",
		}
		self.SoundTbl_UnFollowPlayer = {}
		self.SoundTbl_Guard_Calmed = {
			"vj_fallout/human/femaleraider/genericrai_alerttonormal_00028d6f_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_alerttonormal_00028d70_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_alerttonormal_00028d71_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_alerttonormal_00028d72_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_alerttonormal_00028d73_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_alerttonormal_00028d74_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_alerttonormal_00028d75_1.mp3",
		}
		self.SoundTbl_AllyDeath = {
			"vj_fallout/human/femaleraider/genericrai_deathresponse_00028d58_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_deathresponse_00029a7b_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_deathresponse_0004834c_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_deathresponse_0004834d_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_deathresponse_0008537f_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_deathresponse_00085380_1.mp3",
		}
		self.SoundTbl_IdleDialogue = {}
		self.SoundTbl_Alert = {
			"vj_fallout/human/femaleraider/generic_normaltocombat_000208e5_1.mp3",
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
		}
		self.SoundTbl_DamageByPlayer = {
			"vj_fallout/human/femaleraider/genericraider_assault_00085370_1.mp3",
		}
		self.SoundTbl_Idle = {}
		self.SoundTbl_LostEnemy = {
			"vj_fallout/human/femaleraider/genericrai_alerttonormal_00028d6f_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_alerttonormal_00028d70_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_alerttonormal_00028d71_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_alerttonormal_00028d72_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_alerttonormal_00028d73_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_alerttonormal_00028d74_1.mp3",
			"vj_fallout/human/femaleraider/genericrai_alerttonormal_00028d75_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_combattolost_00028d6d_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_combattolost_00028d6e_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_combattolost_00029a83_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_combattolost_000853d5_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_combattolost_000853d6_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_combattolost_000853d7_1.mp3",
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
			"vj_fallout/human/femaleraider/genericraider_hit_0002892e_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_hit_00028d4d_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_hit_00028d4e_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_hit_00028d4f_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_hit_00029a72_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_hit_00048796_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_hit_00048798_1.mp3",
		}
		self.SoundTbl_Swing = {
			"vj_fallout/human/femaleraider/generic_powerattack_00022aaf_1.mp3",
			"vj_fallout/human/femaleraider/generic_powerattack_00022ab1_1.mp3",
			"vj_fallout/human/femaleraider/generic_powerattack_00051ffa_1.mp3",
			"vj_fallout/human/femaleraider/generic_powerattack_00051ffb_1.mp3",
			"vj_fallout/human/femaleraider/genericraider_powerattack_00085383_1.mp3",
		}
		self.SoundTbl_IdleDialogueAnswer = {}
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
	elseif voice == "male04" then
		self.SoundTbl_OnGrenadeSight = {
			"vj_fallout/human/maleadult04/genericadu_avoidthreat_0017520f_1.wav",
			"vj_fallout/human/maleadult04/genericadu_avoidthreat_00175210_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_avoidthreat_00175211_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_avoidthreat_00175212_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_avoidthreat_00175217_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_avoidthreat_00175218_1.wav",
		}
		self.SoundTbl_OnClearedArea = {
			"vj_fallout/human/maleadult04/generic_combattonormal_00175189_1.wav",
			"vj_fallout/human/maleadult04/genericadu_combattonormal_0017518a_1.wav",
			"vj_fallout/human/maleadult04/genericadu_combattonormal_0017518b_1.wav",
			"vj_fallout/human/maleadult04/genericadu_combattonormal_0017518c_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_combattonormal_0017518d_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_combattonormal_0017518e_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_combattonormal_0017518f_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_combattonormal_00175196_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_combattonormal_00175197_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_combattonormal_00175198_1.wav",
		}
		self.SoundTbl_CombatIdle = {
			"vj_fallout/human/maleadult04/generic_alertidle_00175249_1.wav",
			"vj_fallout/human/maleadult04/genericadu_alertidle_0017524a_1.wav",
			"vj_fallout/human/maleadult04/genericadu_alertidle_0017524b_1.wav",
			"vj_fallout/human/maleadult04/genericadu_alertidle_0017524c_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_alertidle_00152cf8_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_alertidle_0017524e_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_alertidle_0017524f_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_alertidle_00175256_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_alertidle_00175257_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_alertidle_00175258_1.wav",
		}
		self.SoundTbl_Guard_Angry = {
			"vj_fallout/human/maleadult04/generic_normaltocombat_001750e6_1.wav",
			"vj_fallout/human/maleadult04/genericadu_normaltocombat_001750e7_1.wav",
			"vj_fallout/human/maleadult04/genericadu_normaltocombat_001750e8_1.wav",
			"vj_fallout/human/maleadult04/genericadu_normaltocombat_001750e9_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_normaltocombat_001750ea_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_normaltocombat_001750eb_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_normaltocombat_001750ec_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_normaltocombat_001750f3_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_normaltocombat_001750f4_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_normaltocombat_001750f5_1.wav",
		}
		self.SoundTbl_Guard_Warn = {
			"vj_fallout/human/maleadult04/genericadu_guardtrespass_0017513e_1.wav",
			"vj_fallout/human/maleadult04/genericadu_guardtrespass_0017513f_1.wav",
			"vj_fallout/human/maleadult04/genericadu_guardtrespass_00175140_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_guardtrespass_00175141_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_guardtrespass_00175142_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_guardtrespass_00175143_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_guardtrespass_0017514a_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_guardtrespass_0017514b_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_guardtrespass_0017514c_1.wav",
		}
		self.SoundTbl_Suppressing = {
			"vj_fallout/human/maleadult04/genericadultcombat_attack_001751e8_1.wav",
			"vj_fallout/human/maleadult04/genericadultcombat_attack_001751e9_1.wav",
			"vj_fallout/human/maleadult04/genericadultcombat_attack_001751ea_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_attack_001751fd_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_attack_001751fe_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_attack_001751ff_1.wav",
		}
		self.SoundTbl_FollowPlayer = {
			"vj_fallout/human/maleadult04/generic_hello_0017529a_1.wav",
			"vj_fallout/human/maleadult04/genericadult_greeting_00175434_1.wav",
			"vj_fallout/human/maleadult04/genericadult_hello_0017529b_1.wav",
			"vj_fallout/human/maleadult04/genericadult_hello_0017529c_1.wav",
			"vj_fallout/human/maleadult04/genericadult_hello_0017529d_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_hello_00152d1c_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_hello_0017537a_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_hello_0017537b_1.wav",
		}
		self.SoundTbl_OnPlayerSight = {}
		self.SoundTbl_Investigate = {
			"vj_fallout/human/maleadult04/generic_normaltoalert_00175171_1.wav",
			"vj_fallout/human/maleadult04/genericadu_normaltoalert_00175172_1.wav",
			"vj_fallout/human/maleadult04/genericadu_normaltoalert_00175173_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_normaltoalert_00175175_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_normaltoalert_00175176_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_normaltoalert_00175177_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_normaltoalert_0017517d_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_normaltoalert_0017517e_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_normaltoalert_0017517f_1.wav",
		}
		self.SoundTbl_OnKilledEnemy = {
			"vj_fallout/human/maleadult04/generic_combattonormal_00175189_1.wav",
			"vj_fallout/human/maleadult04/genericadu_combattonormal_0017518a_1.wav",
			"vj_fallout/human/maleadult04/genericadu_combattonormal_0017518b_1.wav",
			"vj_fallout/human/maleadult04/genericadu_combattonormal_0017518c_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_combattonormal_0017518d_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_combattonormal_0017518e_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_combattonormal_0017518f_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_combattonormal_00175196_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_combattonormal_00175197_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_combattonormal_00175198_1.wav",
		}
		self.SoundTbl_UnFollowPlayer = {
			"vj_fallout/human/maleadult04/generic_goodbye_00049e16_1.wav",
			"vj_fallout/human/maleadult04/genericadult_goodbye_0004e5e3_1.wav",
			"vj_fallout/human/maleadult04/genericadult_goodbye_001751c5_1.wav",
		}
		self.SoundTbl_Guard_Calmed = {
			"vj_fallout/human/maleadult04/generic_alerttonormal_0017527d_1.wav",
			"vj_fallout/human/maleadult04/genericadu_acceptyield_001750d8_1.wav",
			"vj_fallout/human/maleadult04/genericadu_alerttonormal_0017527e_1.wav",
			"vj_fallout/human/maleadult04/genericadu_alerttonormal_0017527f_1.wav",
			"vj_fallout/human/maleadult04/genericadu_alerttonormal_00175280_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_acceptyield_001750d9_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_alerttonormal_00175281_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_alerttonormal_00175282_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_alerttonormal_00175283_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_acceptyield_001750df_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_alerttonormal_0017528a_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_alerttonormal_0017528b_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_alerttonormal_0017528c_1.wav",
		}
		self.SoundTbl_AllyDeath = {
			"vj_fallout/human/maleadult04/genericadu_deathresponse_001751ab_1.wav",
			"vj_fallout/human/maleadult04/genericadu_deathresponse_001751ac_1.wav",
			"vj_fallout/human/maleadult04/genericadu_deathresponse_001751ad_1.wav",
			"vj_fallout/human/maleadult04/genericadu_deathresponse_001751ae_1.wav",
			"vj_fallout/human/maleadult04/genericadu_deathresponse_001751af_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_deathresponse_001751b0_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_deathresponse_001751b1_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_deathresponse_001751b2_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_deathresponse_001751b3_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_deathresponse_001751b4_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_deathresponse_001751c0_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_deathresponse_001751c1_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_deathresponse_001751c2_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_deathresponse_001751c3_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_deathresponse_001751c4_1.wav",
		}
		self.SoundTbl_IdleDialogue = {
			"vj_fallout/human/maleadult04/generic_hello_0017529a_1.wav",
			"vj_fallout/human/maleadult04/genericadult_greeting_00175434_1.wav",
			"vj_fallout/human/maleadult04/genericadult_hello_0017529b_1.wav",
			"vj_fallout/human/maleadult04/genericadult_hello_0017529c_1.wav",
			"vj_fallout/human/maleadult04/genericadult_hello_0017529d_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_hello_00152d1c_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_hello_0017537a_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_hello_0017537b_1.wav",
		}
		self.SoundTbl_Alert = {
			"vj_fallout/human/maleadult04/generic_alerttocombat_001751d8_1.wav",
			"vj_fallout/human/maleadult04/generic_normaltocombat_001750e6_1.wav",
			"vj_fallout/human/maleadult04/genericadu_alerttocombat_0005200f_1.wav",
			"vj_fallout/human/maleadult04/genericadu_alerttocombat_001751d9_1.wav",
			"vj_fallout/human/maleadult04/genericadu_alerttocombat_001751da_1.wav",
			"vj_fallout/human/maleadult04/genericadu_alerttocombat_001751db_1.wav",
			"vj_fallout/human/maleadult04/genericadu_normaltocombat_001750e7_1.wav",
			"vj_fallout/human/maleadult04/genericadu_normaltocombat_001750e8_1.wav",
			"vj_fallout/human/maleadult04/genericadu_normaltocombat_001750e9_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_alerttocombat_001751dc_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_alerttocombat_001751dd_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_alerttocombat_001751de_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_normaltocombat_001750ea_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_normaltocombat_001750eb_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_normaltocombat_001750ec_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_alerttocombat_001751e5_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_alerttocombat_001751e6_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_alerttocombat_001751e7_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_normaltocombat_001750f3_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_normaltocombat_001750f4_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_normaltocombat_001750f5_1.wav",
		}
		self.SoundTbl_DamageByPlayer = {
			"vj_fallout/human/maleadult04/genericadultcombat_assault_001750fc_1.wav",
			"vj_fallout/human/maleadult04/genericadultcombat_assault_001750fd_1.wav",
			"vj_fallout/human/maleadult04/genericadultcombat_assault_001750fe_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_assault_00175100_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_assault_00175101_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_assault_00175102_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_assault_0017510d_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_assault_0017510e_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_assault_00176ee8_1.wav",
		}
		self.SoundTbl_Idle = {}
		self.SoundTbl_LostEnemy = {
			"vj_fallout/human/maleadult04/generic_alerttonormal_0017527d_1.wav",
			"vj_fallout/human/maleadult04/generic_combattolost_0017515b_1.wav",
			"vj_fallout/human/maleadult04/genericadu_alerttonormal_0017527e_1.wav",
			"vj_fallout/human/maleadult04/genericadu_alerttonormal_0017527f_1.wav",
			"vj_fallout/human/maleadult04/genericadu_alerttonormal_00175280_1.wav",
			"vj_fallout/human/maleadult04/genericadu_combattolost_0017515c_1.wav",
			"vj_fallout/human/maleadult04/genericadu_combattolost_0017515d_1.wav",
			"vj_fallout/human/maleadult04/genericadu_combattolost_0017515e_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_alerttonormal_00175281_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_alerttonormal_00175282_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_alerttonormal_00175283_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_combattolost_0017515f_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_combattolost_00175160_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_combattolost_00175161_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_alerttonormal_0017528a_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_alerttonormal_0017528b_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_alerttonormal_0017528c_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_combattolost_00175168_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_combattolost_00175169_1.wav",
			"vj_fallout/human/maleadult04/vnellisgen_combattolost_0017516a_1.wav",
		}
		self.SoundTbl_Pain = {
			"vj_fallout/human/maleadult04/generic_hit_00175238_1.wav",
			"vj_fallout/human/maleadult04/generic_hit_00175239_1.wav",
			"vj_fallout/human/maleadult04/generic_hit_0017523a_1.wav",
			"vj_fallout/human/maleadult04/generic_hit_0017523b_1.wav",
			"vj_fallout/human/maleadult04/generic_hit_0017523c_1.wav",
			"vj_fallout/human/maleadult04/genericadultcombat_hit_0017523d_1.wav",
			"vj_fallout/human/maleadult04/genericadultcombat_hit_0017523e_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_hit_0017523f_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_hit_00175240_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_hit_00175241_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_hit_00175242_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_hit_00175243_1.wav",
		}
		self.SoundTbl_Swing = {
			"vj_fallout/human/maleadult04/generic_powerattack_001750e0_1.wav",
			"vj_fallout/human/maleadult04/generic_powerattack_001750e1_1.wav",
			"vj_fallout/human/maleadult04/generic_powerattack_001750e2_1.wav",
			"vj_fallout/human/maleadult04/generic_powerattack_001750e3_1.wav",
		}
		self.SoundTbl_IdleDialogueAnswer = {
			"vj_fallout/human/maleadult04/generic_goodbye_00049e16_1.wav",
			"vj_fallout/human/maleadult04/generic_hello_0017529a_1.wav",
			"vj_fallout/human/maleadult04/genericadult_goodbye_0004e5e3_1.wav",
			"vj_fallout/human/maleadult04/genericadult_goodbye_001751c5_1.wav",
			"vj_fallout/human/maleadult04/genericadult_greeting_00175434_1.wav",
			"vj_fallout/human/maleadult04/genericadult_hello_0017529b_1.wav",
			"vj_fallout/human/maleadult04/genericadult_hello_0017529c_1.wav",
			"vj_fallout/human/maleadult04/genericadult_hello_0017529d_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_hello_00152d1c_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_hello_0017537a_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_hello_0017537b_1.wav",
		}
		self.SoundTbl_Death = {
			"vj_fallout/human/maleadult04/generic_death_00175180_1.wav",
			"vj_fallout/human/maleadult04/generic_death_00175181_1.wav",
			"vj_fallout/human/maleadult04/generic_death_00175182_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_death_00175183_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_death_00175184_1.wav",
			"vj_fallout/human/maleadult04/vdialoguec_death_00175185_1.wav",
		}
	elseif voice == "male05" then
		self.SoundTbl_OnGrenadeSight = {
			"vj_fallout/human/maleadult05/genericadu_avoidthreat_0017520f_1.wav",
			"vj_fallout/human/maleadult05/genericadu_avoidthreat_00175210_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_avoidthreat_00175215_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_avoidthreat_00175216_1.wav",
			"vj_fallout/human/maleadult05/vdialoguekings_avoidthreat_00153613_1.wav",
			"vj_fallout/human/maleadult05/vdialoguekings_avoidthreat_00153614_1.wav",
			"vj_fallout/human/maleadult05/vdialoguekings_avoidthreat_00153615_1.wav",
		}
		self.SoundTbl_OnClearedArea = {
			"vj_fallout/human/maleadult05/generic_combattonormal_00175189_1.wav",
			"vj_fallout/human/maleadult05/genericadu_combattonormal_0017518a_1.wav",
			"vj_fallout/human/maleadult05/genericadu_combattonormal_0017518b_1.wav",
			"vj_fallout/human/maleadult05/genericadu_combattonormal_0017518c_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_combattonormal_00175193_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_combattonormal_00175194_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_combattonormal_00175195_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_combattonormal_0015364e_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_combattonormal_0015364f_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_combattonormal_00153650_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_combattonormal_00153651_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_combattonormal_00153652_1.wav",
		}
		self.SoundTbl_CombatIdle = {
			"vj_fallout/human/maleadult05/generic_alertidle_00175249_1.wav",
			"vj_fallout/human/maleadult05/genericadu_alertidle_0017524a_1.wav",
			"vj_fallout/human/maleadult05/genericadu_alertidle_0017524b_1.wav",
			"vj_fallout/human/maleadult05/genericadu_alertidle_0017524c_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_alertidle_00175253_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_alertidle_00175254_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_alertidle_00175255_1.wav",
			"vj_fallout/human/maleadult05/vdialoguekings_alertidle_00153665_1.wav",
			"vj_fallout/human/maleadult05/vdialoguekings_alertidle_00153666_1.wav",
			"vj_fallout/human/maleadult05/vdialoguekings_alertidle_00153667_1.wav",
			"vj_fallout/human/maleadult05/vdialoguekings_alertidle_00153668_1.wav",
			"vj_fallout/human/maleadult05/vdialoguekings_alertidle_00153669_1.wav",
		}
		self.SoundTbl_Guard_Angry = {
			"vj_fallout/human/maleadult05/generic_normaltocombat_001750e6_1.wav",
			"vj_fallout/human/maleadult05/genericadu_normaltocombat_001750e7_1.wav",
			"vj_fallout/human/maleadult05/genericadu_normaltocombat_001750e8_1.wav",
			"vj_fallout/human/maleadult05/genericadu_normaltocombat_001750e9_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_normaltocombat_001750f0_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_normaltocombat_001750f1_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_normaltocombat_001750f2_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_normaltocombat_00153648_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_normaltocombat_00153649_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_normaltocombat_0015364a_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_normaltocombat_0015364b_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_normaltocombat_0015364c_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_normaltocombat_0015364d_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_startcombatresp_0015365f_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_startcombatresp_00153660_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_startcombatresp_00153661_1.wav",
		}
		self.SoundTbl_Guard_Warn = {
			"vj_fallout/human/maleadult05/genericadu_guardtrespass_0017513e_1.wav",
			"vj_fallout/human/maleadult05/genericadu_guardtrespass_0017513f_1.wav",
			"vj_fallout/human/maleadult05/genericadu_guardtrespass_00175140_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_guardtrespass_00175147_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_guardtrespass_00175148_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_guardtrespass_00175149_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_guardtrespass_00153600_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_guardtrespass_00153601_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_guardtrespass_00153602_1.wav",
		}
		self.SoundTbl_Suppressing = {
			"vj_fallout/human/maleadult05/genericadultcombat_attack_001751e8_1.wav",
			"vj_fallout/human/maleadult05/genericadultcombat_attack_001751e9_1.wav",
			"vj_fallout/human/maleadult05/genericadultcombat_attack_001751ea_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_attack_0014f00e_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_attack_0014f00f_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_attack_0014f010_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_attack_0014f011_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_attack_0014f012_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_attack_001751fa_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_attack_001751fb_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_attack_001751fc_1.wav",
			"vj_fallout/human/maleadult05/vdialoguekings_attack_00153610_1.wav",
			"vj_fallout/human/maleadult05/vdialoguekings_attack_00153611_1.wav",
			"vj_fallout/human/maleadult05/vdialoguekings_attack_00153612_1.wav",
			"vj_fallout/human/maleadult05/vdialoguekings_attack_0015590e_1.wav",
			"vj_fallout/human/maleadult05/vdialoguekings_attack_0015590f_1.wav",
			"vj_fallout/human/maleadult05/vdialoguekings_attack_00155910_1.wav",
			"vj_fallout/human/maleadult05/vdialoguekings_attack_00155911_1.wav",
			"vj_fallout/human/maleadult05/vdialoguekings_attack_00155912_1.wav",
			"vj_fallout/human/maleadult05/vdialoguekings_attack_00155913_1.wav",
			"vj_fallout/human/maleadult05/vdialoguekings_attack_00155914_1.wav",
			"vj_fallout/human/maleadult05/vdialoguekings_attack_00155915_1.wav",
			"vj_fallout/human/maleadult05/vdialoguen_attack_001751eb_1.wav",
		}
		self.SoundTbl_FollowPlayer = {
			"vj_fallout/human/maleadult05/generic_hello_0017529a_1.wav",
			"vj_fallout/human/maleadult05/genericadult_greeting_00175434_1.wav",
			"vj_fallout/human/maleadult05/genericadult_hello_0017529b_1.wav",
			"vj_fallout/human/maleadult05/genericadult_hello_0017529c_1.wav",
			"vj_fallout/human/maleadult05/genericadult_hello_0017529d_1.wav",
		}
		self.SoundTbl_OnPlayerSight = {}
		self.SoundTbl_Investigate = {
			"vj_fallout/human/maleadult05/generic_normaltoalert_00175171_1.wav",
			"vj_fallout/human/maleadult05/genericadu_normaltoalert_00175172_1.wav",
			"vj_fallout/human/maleadult05/genericadu_normaltoalert_00175173_1.wav",
			"vj_fallout/human/maleadult05/genericadu_normaltoalert_00175174_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_normaltoalert_0017517a_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_normaltoalert_0017517b_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_normaltoalert_0017517c_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_normaltoalert_00153679_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_normaltoalert_0015367a_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_normaltoalert_0015367b_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_normaltoalert_0015367c_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_normaltoalertre_00153637_1.wav",
		}
		self.SoundTbl_OnKilledEnemy = {
			"vj_fallout/human/maleadult05/generic_combattonormal_00175189_1.wav",
			"vj_fallout/human/maleadult05/genericadu_combattonormal_0017518a_1.wav",
			"vj_fallout/human/maleadult05/genericadu_combattonormal_0017518b_1.wav",
			"vj_fallout/human/maleadult05/genericadu_combattonormal_0017518c_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_combattonormal_00175193_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_combattonormal_00175194_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_combattonormal_00175195_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_combattonormal_0015364e_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_combattonormal_0015364f_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_combattonormal_00153650_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_combattonormal_00153651_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_combattonormal_00153652_1.wav",
		}
		self.SoundTbl_UnFollowPlayer = {
			"vj_fallout/human/maleadult05/generic_goodbye_00049e16_1.wav",
			"vj_fallout/human/maleadult05/genericadult_goodbye_0004e5e3_1.wav",
			"vj_fallout/human/maleadult05/genericadult_goodbye_001751c5_1.wav",
		}
		self.SoundTbl_Guard_Calmed = {
			"vj_fallout/human/maleadult05/generic_alerttonormal_0017527d_1.wav",
			"vj_fallout/human/maleadult05/genericadu_acceptyield_001750d8_1.wav",
			"vj_fallout/human/maleadult05/genericadu_alerttonormal_0017527e_1.wav",
			"vj_fallout/human/maleadult05/genericadu_alerttonormal_0017527f_1.wav",
			"vj_fallout/human/maleadult05/genericadu_alerttonormal_00175280_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_acceptyield_0014eff4_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_acceptyield_001750de_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_alerttonormal_00175287_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_alerttonormal_00175288_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_alerttonormal_00175289_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_alerttonormal_0015366a_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_alerttonormal_0015366b_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_alerttonormal_0015366c_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_alerttonormal_0015366d_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_alerttonormal_0015366e_1.wav",
			"vj_fallout/human/maleadult05/vdialoguekings_acceptyield_0015361d_1.wav",
		}
		self.SoundTbl_AllyDeath = {
			"vj_fallout/human/maleadult05/genericadu_deathresponse_001751ab_1.wav",
			"vj_fallout/human/maleadult05/genericadu_deathresponse_001751ac_1.wav",
			"vj_fallout/human/maleadult05/genericadu_deathresponse_001751ad_1.wav",
			"vj_fallout/human/maleadult05/genericadu_deathresponse_001751ae_1.wav",
			"vj_fallout/human/maleadult05/genericadu_deathresponse_001751af_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_deathresponse_001751bb_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_deathresponse_001751bc_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_deathresponse_001751bd_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_deathresponse_001751be_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_deathresponse_001751bf_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_deathresponse_00153616_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_deathresponse_00153617_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_deathresponse_00153618_1.wav",
			"vj_fallout/human/maleadult05/vdialoguen_deathresponse_0015724b_1.wav",
		}
		self.SoundTbl_IdleDialogue = {
			"vj_fallout/human/maleadult05/generic_hello_0017529a_1.wav",
			"vj_fallout/human/maleadult05/genericadult_greeting_00175434_1.wav",
			"vj_fallout/human/maleadult05/genericadult_hello_0017529b_1.wav",
			"vj_fallout/human/maleadult05/genericadult_hello_0017529c_1.wav",
			"vj_fallout/human/maleadult05/genericadult_hello_0017529d_1.wav",
		}
		self.SoundTbl_Alert = {
			"vj_fallout/human/maleadult05/generic_alerttocombat_001751d8_1.wav",
			"vj_fallout/human/maleadult05/generic_normaltocombat_001750e6_1.wav",
			"vj_fallout/human/maleadult05/genericadu_alerttocombat_0005200f_1.wav",
			"vj_fallout/human/maleadult05/genericadu_alerttocombat_001751d9_1.wav",
			"vj_fallout/human/maleadult05/genericadu_alerttocombat_001751da_1.wav",
			"vj_fallout/human/maleadult05/genericadu_alerttocombat_001751db_1.wav",
			"vj_fallout/human/maleadult05/genericadu_normaltocombat_001750e7_1.wav",
			"vj_fallout/human/maleadult05/genericadu_normaltocombat_001750e8_1.wav",
			"vj_fallout/human/maleadult05/genericadu_normaltocombat_001750e9_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_alerttocombat_001751e2_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_alerttocombat_001751e3_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_alerttocombat_001751e4_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_normaltocombat_001750f0_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_normaltocombat_001750f1_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_normaltocombat_001750f2_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_alerttocombat_0015365a_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_alerttocombat_0015365b_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_alerttocombat_0015365c_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_alerttocombat_0015365d_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_alerttocombat_0015365e_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_normaltocombat_00153648_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_normaltocombat_00153649_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_normaltocombat_0015364a_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_normaltocombat_0015364b_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_normaltocombat_0015364c_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_normaltocombat_0015364d_1.wav",
		}
		self.SoundTbl_DamageByPlayer = {
			"vj_fallout/human/maleadult05/genericadultcombat_assault_001750fc_1.wav",
			"vj_fallout/human/maleadult05/genericadultcombat_assault_001750fd_1.wav",
			"vj_fallout/human/maleadult05/genericadultcombat_assault_001750fe_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_assault_0014f001_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_assault_0014f002_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_assault_0017510a_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_assault_0017510b_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_assault_0017510c_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_assaultnocrime_00153608_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_assaultnocrime_00153609_1.wav",
			"vj_fallout/human/maleadult05/vdialoguekings_assault_0015360a_1.wav",
			"vj_fallout/human/maleadult05/vdialoguekings_assault_0015360b_1.wav",
			"vj_fallout/human/maleadult05/vdialoguekings_assault_0015360c_1.wav",
			"vj_fallout/human/maleadult05/vdialoguen_assault_001750ff_1.wav",
		}
		self.SoundTbl_Idle = {}
		self.SoundTbl_LostEnemy = {
			"vj_fallout/human/maleadult05/generic_alerttonormal_0017527d_1.wav",
			"vj_fallout/human/maleadult05/generic_combattolost_0017515b_1.wav",
			"vj_fallout/human/maleadult05/genericadu_alerttonormal_0017527e_1.wav",
			"vj_fallout/human/maleadult05/genericadu_alerttonormal_0017527f_1.wav",
			"vj_fallout/human/maleadult05/genericadu_alerttonormal_00175280_1.wav",
			"vj_fallout/human/maleadult05/genericadu_combattolost_0017515c_1.wav",
			"vj_fallout/human/maleadult05/genericadu_combattolost_0017515d_1.wav",
			"vj_fallout/human/maleadult05/genericadu_combattolost_0017515e_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_alerttonormal_00175287_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_alerttonormal_00175288_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_alerttonormal_00175289_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_combattolost_00175165_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_combattolost_00175166_1.wav",
			"vj_fallout/human/maleadult05/vdialogueg_combattolost_00175167_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_alerttonormal_0015366a_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_alerttonormal_0015366b_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_alerttonormal_0015366c_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_alerttonormal_0015366d_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_alerttonormal_0015366e_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_combattolost_00153674_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_combattolost_00153675_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_combattolost_00153676_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_combattolost_00153677_1.wav",
			"vj_fallout/human/maleadult05/vdialoguek_combattolost_00153678_1.wav",
		}
		self.SoundTbl_Pain = {
			"vj_fallout/human/maleadult05/generic_hit_00175238_1.wav",
			"vj_fallout/human/maleadult05/generic_hit_00175239_1.wav",
			"vj_fallout/human/maleadult05/generic_hit_0017523a_1.wav",
			"vj_fallout/human/maleadult05/generic_hit_0017523b_1.wav",
			"vj_fallout/human/maleadult05/generic_hit_0017523c_1.wav",
			"vj_fallout/human/maleadult05/genericadultcombat_hit_0017523d_1.wav",
			"vj_fallout/human/maleadult05/genericadultcombat_hit_0017523e_1.wav",
			"vj_fallout/human/maleadult05/vdialoguekings_hit_00153619_1.wav",
			"vj_fallout/human/maleadult05/vdialoguekings_hit_0015361a_1.wav",
			"vj_fallout/human/maleadult05/vdialoguekings_hit_0015361b_1.wav",
			"vj_fallout/human/maleadult05/vdialoguekings_hit_0015361c_1.wav",
			"vj_fallout/human/maleadult05/vdialoguekings_hit_00153653_1.wav",
			"vj_fallout/human/maleadult05/vdialoguen_hit_0015b6c4_1.wav",
			"vj_fallout/human/maleadult05/vdialoguen_hit_00175244_1.wav",
			"vj_fallout/human/maleadult05/vdialoguen_hit_00175245_1.wav",
			"vj_fallout/human/maleadult05/vdialoguen_hit_00175246_1.wav",
			"vj_fallout/human/maleadult05/vdialoguen_hit_00175247_1.wav",
		}
		self.SoundTbl_Swing = {
			"vj_fallout/human/maleadult05/generic_powerattack_001750e0_1.wav",
			"vj_fallout/human/maleadult05/generic_powerattack_001750e1_1.wav",
			"vj_fallout/human/maleadult05/generic_powerattack_001750e2_1.wav",
			"vj_fallout/human/maleadult05/generic_powerattack_001750e3_1.wav",
			"vj_fallout/human/maleadult05/vdialoguekings_powerattack_0015363a_1.wav",
			"vj_fallout/human/maleadult05/vdialoguekings_powerattack_0015363b_1.wav",
			"vj_fallout/human/maleadult05/vdialoguekings_powerattack_0015363c_1.wav",
		}
		self.SoundTbl_IdleDialogueAnswer = {
			"vj_fallout/human/maleadult05/generic_goodbye_00049e16_1.wav",
			"vj_fallout/human/maleadult05/generic_hello_0017529a_1.wav",
			"vj_fallout/human/maleadult05/genericadult_goodbye_0004e5e3_1.wav",
			"vj_fallout/human/maleadult05/genericadult_goodbye_001751c5_1.wav",
			"vj_fallout/human/maleadult05/genericadult_greeting_00175434_1.wav",
			"vj_fallout/human/maleadult05/genericadult_hello_0017529b_1.wav",
			"vj_fallout/human/maleadult05/genericadult_hello_0017529c_1.wav",
			"vj_fallout/human/maleadult05/genericadult_hello_0017529d_1.wav",
		}
		self.SoundTbl_Death = {
			"vj_fallout/human/maleadult05/generic_death_00175180_1.wav",
			"vj_fallout/human/maleadult05/generic_death_00175181_1.wav",
			"vj_fallout/human/maleadult05/generic_death_00175182_1.wav",
			"vj_fallout/human/maleadult05/vdialoguekings_death_00153605_1.wav",
			"vj_fallout/human/maleadult05/vdialoguekings_death_00153606_1.wav",
			"vj_fallout/human/maleadult05/vdialoguekings_death_00153607_1.wav",
			"vj_fallout/human/maleadult05/vdialoguen_death_00175186_1.wav",
			"vj_fallout/human/maleadult05/vdialoguen_death_00175187_1.wav",
			"vj_fallout/human/maleadult05/vdialoguen_death_00175188_1.wav",
		}
	elseif voice == "malefiend" then
		self.SoundTbl_OnGrenadeSight = {
			"vj_fallout/human/maleadult01/fiend_avoidthreat01.wav",
			"vj_fallout/human/maleadult01/fiend_avoidthreat02.wav",
		}
		self.SoundTbl_OnClearedArea = {}
		self.SoundTbl_CombatIdle = {
			"vj_fallout/human/maleadult01/fiend_alertidle01.wav",
			"vj_fallout/human/maleadult01/fiend_alertidle02.wav",
		}
		self.SoundTbl_Guard_Angry = {}
		self.SoundTbl_Guard_Warn = {}
		self.SoundTbl_Suppressing = {
			"vj_fallout/human/maleadult01/fiend_attack01.wav",
			"vj_fallout/human/maleadult01/fiend_attack02.wav",
			"vj_fallout/human/maleadult01/fiend_attack03.wav",
		}
		self.SoundTbl_FollowPlayer = {}
		self.SoundTbl_OnPlayerSight = {}
		self.SoundTbl_Investigate = {
			"vj_fallout/human/maleadult01/fiend_normaltoalert01.wav",
			"vj_fallout/human/maleadult01/fiend_normaltoalert02.wav",
			"vj_fallout/human/maleadult01/fiend_normaltoalert03.wav",
		}
		self.SoundTbl_OnKilledEnemy = {}
		self.SoundTbl_UnFollowPlayer = {}
		self.SoundTbl_Guard_Calmed = {
			"vj_fallout/human/maleadult01/fiend_alerttonormal01.wav",
			"vj_fallout/human/maleadult01/fiend_alerttonormal02.wav",
			"vj_fallout/human/maleadult01/fiend_alerttonormal03.wav",
		}
		self.SoundTbl_AllyDeath = {
			"vj_fallout/human/maleadult01/fiend_deathresponse01.wav",
			"vj_fallout/human/maleadult01/fiend_deathresponse02.wav",
			"vj_fallout/human/maleadult01/fiend_deathresponse03.wav",
			"vj_fallout/human/maleadult01/fiend_deathresponse04.wav",
			"vj_fallout/human/maleadult01/fiend_deathresponse05.wav",
			"vj_fallout/human/maleadult01/fiend_deathresponse06.wav",
		}
		self.SoundTbl_IdleDialogue = {
			"vj_fallout/human/maleadult01/generic_hello01.wav",
			"vj_fallout/human/maleadult01/genericadult_greeting01.wav",
			"vj_fallout/human/maleadult01/genericadult_hello01.wav",
			"vj_fallout/human/maleadult01/genericadult_hello02.wav",
			"vj_fallout/human/maleadult01/genericadult_hello03.wav",
		}
		self.SoundTbl_Alert = {
			"vj_fallout/human/maleadult01/fiend_alerttocombat01.wav",
			"vj_fallout/human/maleadult01/fiend_alerttocombat02.wav",
			"vj_fallout/human/maleadult01/fiend_alerttocombat03.wav",
		}
		self.SoundTbl_DamageByPlayer = {}
		self.SoundTbl_Idle = {}
		self.SoundTbl_LostEnemy = {
			"vj_fallout/human/maleadult01/fiend_alerttonormal01.wav",
			"vj_fallout/human/maleadult01/fiend_alerttonormal02.wav",
			"vj_fallout/human/maleadult01/fiend_alerttonormal03.wav",
			"vj_fallout/human/maleadult01/fiend_combattolost01.wav",
			"vj_fallout/human/maleadult01/fiend_combattolost02.wav",
			"vj_fallout/human/maleadult01/fiend_combattolost03.wav",
		}
		self.SoundTbl_Pain = {
			"vj_fallout/human/maleadult01/b_hit01.wav",
			"vj_fallout/human/maleadult01/b_hit02.wav",
			"vj_fallout/human/maleadult01/b_hit03.wav",
			"vj_fallout/human/maleadult01/b_hit04.wav",
			"vj_fallout/human/maleadult01/b_hit05.wav",
			"vj_fallout/human/maleadult01/b_hit06.wav",
			"vj_fallout/human/maleadult01/b_hit07.wav",
			"vj_fallout/human/maleadult01/generic_hit01.wav",
			"vj_fallout/human/maleadult01/generic_hit02.wav",
			"vj_fallout/human/maleadult01/generic_hit03.wav",
			"vj_fallout/human/maleadult01/generic_hit04.wav",
			"vj_fallout/human/maleadult01/generic_hit05.wav",
			"vj_fallout/human/maleadult01/genericadultcombat_hit01.wav",
			"vj_fallout/human/maleadult01/genericadultcombat_hit02.wav",
		}
		self.SoundTbl_Swing = {
			"vj_fallout/human/maleadult01/generic_powerattack01.wav",
			"vj_fallout/human/maleadult01/generic_powerattack02.wav",
			"vj_fallout/human/maleadult01/generic_powerattack03.wav",
			"vj_fallout/human/maleadult01/generic_powerattack04.wav",
			"vj_fallout/human/maleadult01/powerattack01.wav",
			"vj_fallout/human/maleadult01/powerattack02.wav",
			"vj_fallout/human/maleadult01/powerattack03.wav",
			"vj_fallout/human/maleadult01/powerattack04.wav",
		}
		self.SoundTbl_IdleDialogueAnswer = {
			"vj_fallout/human/maleadult01/generic_goodbye01.wav",
			"vj_fallout/human/maleadult01/generic_hello01.wav",
			"vj_fallout/human/maleadult01/genericadult_goodbye01.wav",
			"vj_fallout/human/maleadult01/genericadult_goodbye02.wav",
			"vj_fallout/human/maleadult01/genericadult_greeting01.wav",
			"vj_fallout/human/maleadult01/genericadult_hello01.wav",
			"vj_fallout/human/maleadult01/genericadult_hello02.wav",
			"vj_fallout/human/maleadult01/genericadult_hello03.wav",
		}
		self.SoundTbl_Death = {
			"vj_fallout/human/maleadult01/death01.wav",
			"vj_fallout/human/maleadult01/death02.wav",
			"vj_fallout/human/maleadult01/death03.wav",
			"vj_fallout/human/maleadult01/generic_death01.wav",
			"vj_fallout/human/maleadult01/generic_death02.wav",
			"vj_fallout/human/maleadult01/generic_death03.wav",
		}
	elseif voice == "male01" then
		self.SoundTbl_OnGrenadeSight = {
			"vj_fallout/human/maleadult01/b_generic_avoidthreat01.wav",
			"vj_fallout/human/maleadult01/b_generic_avoidthreat02.wav",
		}
		self.SoundTbl_OnClearedArea = {
			"vj_fallout/human/maleadult01/b_generic_combattonormal01.wav",
			"vj_fallout/human/maleadult01/b_generic_combattonormal02.wav",
			"vj_fallout/human/maleadult01/b_generic_combattonormal03.wav",
			"vj_fallout/human/maleadult01/b_generic_combattonormal04.wav",
		}
		self.SoundTbl_CombatIdle = {
			"vj_fallout/human/maleadult01/b_generic_alertidle01.wav",
			"vj_fallout/human/maleadult01/b_generic_alertidle02.wav",
			"vj_fallout/human/maleadult01/b_generic_alertidle03.wav",
			"vj_fallout/human/maleadult01/b_generic_alertidle04.wav",
		}
		self.SoundTbl_Guard_Angry = {
			"vj_fallout/human/maleadult01/b_generic_normaltocombat01.wav",
			"vj_fallout/human/maleadult01/b_generic_normaltocombat02.wav",
			"vj_fallout/human/maleadult01/b_generic_normaltocombat03.wav",
			"vj_fallout/human/maleadult01/b_generic_normaltocombat04.wav",
		}
		self.SoundTbl_Guard_Warn = {
			"vj_fallout/human/maleadult01/b_generic_guardtrespass01.wav",
			"vj_fallout/human/maleadult01/b_generic_guardtrespass02.wav",
			"vj_fallout/human/maleadult01/b_generic_guardtrespass03.wav",
		}
		self.SoundTbl_Suppressing = {
			"vj_fallout/human/maleadult01/b_generic_attack01.wav",
			"vj_fallout/human/maleadult01/b_generic_attack02.wav",
			"vj_fallout/human/maleadult01/b_generic_attack03.wav",
		}
		self.SoundTbl_FollowPlayer = {
			"vj_fallout/human/maleadult01/b_generic_greeting01.wav",
			"vj_fallout/human/maleadult01/b_generic_greeting02.wav",
			"vj_fallout/human/maleadult01/b_generic_greeting03.wav",
			"vj_fallout/human/maleadult01/b_generic_greeting04.wav",
			"vj_fallout/human/maleadult01/b_generic_hello01.wav",
			"vj_fallout/human/maleadult01/b_generic_hello02.wav",
			"vj_fallout/human/maleadult01/b_generic_hello03.wav",
			"vj_fallout/human/maleadult01/b_generic_hello04.wav",
		}
		self.SoundTbl_OnPlayerSight = {}
		self.SoundTbl_Investigate = {
			"vj_fallout/human/maleadult01/b_generic_normaltoalert01.wav",
			"vj_fallout/human/maleadult01/b_generic_normaltoalert02.wav",
			"vj_fallout/human/maleadult01/b_generic_normaltoalert03.wav",
			"vj_fallout/human/maleadult01/b_generic_normaltoalert04.wav",
		}
		self.SoundTbl_OnKilledEnemy = {
			"vj_fallout/human/maleadult01/b_generic_combattonormal01.wav",
			"vj_fallout/human/maleadult01/b_generic_combattonormal02.wav",
			"vj_fallout/human/maleadult01/b_generic_combattonormal03.wav",
			"vj_fallout/human/maleadult01/b_generic_combattonormal04.wav",
		}
		self.SoundTbl_UnFollowPlayer = {
			"vj_fallout/human/maleadult01/b_generic_goodbye01.wav",
			"vj_fallout/human/maleadult01/b_generic_goodbye02.wav",
		}
		self.SoundTbl_Guard_Calmed = {
			"vj_fallout/human/maleadult01/b_generic_acceptyield01.wav",
			"vj_fallout/human/maleadult01/b_generic_alerttonormal01.wav",
			"vj_fallout/human/maleadult01/b_generic_alerttonormal02.wav",
			"vj_fallout/human/maleadult01/b_generic_alerttonormal03.wav",
			"vj_fallout/human/maleadult01/b_generic_alerttonormal04.wav",
		}
		self.SoundTbl_AllyDeath = {
			"vj_fallout/human/maleadult01/b_generic_deathresponse01.wav",
			"vj_fallout/human/maleadult01/b_generic_deathresponse02.wav",
			"vj_fallout/human/maleadult01/b_generic_deathresponse03.wav",
			"vj_fallout/human/maleadult01/b_generic_deathresponse04.wav",
			"vj_fallout/human/maleadult01/b_generic_deathresponse05.wav",
		}
		self.SoundTbl_IdleDialogue = {
			"vj_fallout/human/maleadult01/b_generic_greeting01.wav",
			"vj_fallout/human/maleadult01/b_generic_greeting02.wav",
			"vj_fallout/human/maleadult01/b_generic_greeting03.wav",
			"vj_fallout/human/maleadult01/b_generic_greeting04.wav",
			"vj_fallout/human/maleadult01/b_generic_hello01.wav",
			"vj_fallout/human/maleadult01/b_generic_hello02.wav",
			"vj_fallout/human/maleadult01/b_generic_hello03.wav",
			"vj_fallout/human/maleadult01/b_generic_hello04.wav",
		}
		self.SoundTbl_Alert = {
			"vj_fallout/human/maleadult01/b_generic_alerttocombat01.wav",
			"vj_fallout/human/maleadult01/b_generic_alerttocombat02.wav",
			"vj_fallout/human/maleadult01/b_generic_alerttocombat03.wav",
			"vj_fallout/human/maleadult01/b_generic_alerttocombat04.wav",
			"vj_fallout/human/maleadult01/b_generic_alerttocombat05.wav",
			"vj_fallout/human/maleadult01/b_generic_normaltocombat01.wav",
			"vj_fallout/human/maleadult01/b_generic_normaltocombat02.wav",
			"vj_fallout/human/maleadult01/b_generic_normaltocombat03.wav",
			"vj_fallout/human/maleadult01/b_generic_normaltocombat04.wav",
		}
		self.SoundTbl_DamageByPlayer = {
			"vj_fallout/human/maleadult01/b_generic_assault01.wav",
			"vj_fallout/human/maleadult01/b_generic_assault02.wav",
			"vj_fallout/human/maleadult01/b_generic_assault03.wav",
		}
		self.SoundTbl_Idle = {}
		self.SoundTbl_LostEnemy = {
			"vj_fallout/human/maleadult01/b_generic_alerttonormal01.wav",
			"vj_fallout/human/maleadult01/b_generic_alerttonormal02.wav",
			"vj_fallout/human/maleadult01/b_generic_alerttonormal03.wav",
			"vj_fallout/human/maleadult01/b_generic_alerttonormal04.wav",
			"vj_fallout/human/maleadult01/b_generic_combattolost01.wav",
			"vj_fallout/human/maleadult01/b_generic_combattolost02.wav",
			"vj_fallout/human/maleadult01/b_generic_combattolost03.wav",
			"vj_fallout/human/maleadult01/b_generic_combattolost04.wav",
		}
		self.SoundTbl_Pain = {
			"vj_fallout/human/maleadult01/b_generic_hit01.wav",
			"vj_fallout/human/maleadult01/b_generic_hit02.wav",
			"vj_fallout/human/maleadult01/b_generic_hit03.wav",
			"vj_fallout/human/maleadult01/b_generic_hit04.wav",
			"vj_fallout/human/maleadult01/b_generic_hit05.wav",
			"vj_fallout/human/maleadult01/b_generic_hit06.wav",
			"vj_fallout/human/maleadult01/b_generic_hit07.wav",
		}
		self.SoundTbl_Swing = {
			"vj_fallout/human/maleadult01/b_generic_powerattack01.wav",
			"vj_fallout/human/maleadult01/b_generic_powerattack02.wav",
			"vj_fallout/human/maleadult01/b_generic_powerattack03.wav",
			"vj_fallout/human/maleadult01/b_generic_powerattack04.wav",
		}
		self.SoundTbl_IdleDialogueAnswer = {
			"vj_fallout/human/maleadult01/b_generic_goodbye01.wav",
			"vj_fallout/human/maleadult01/b_generic_goodbye02.wav",
			"vj_fallout/human/maleadult01/b_generic_greeting01.wav",
			"vj_fallout/human/maleadult01/b_generic_greeting02.wav",
			"vj_fallout/human/maleadult01/b_generic_greeting03.wav",
			"vj_fallout/human/maleadult01/b_generic_greeting04.wav",
			"vj_fallout/human/maleadult01/b_generic_hello01.wav",
			"vj_fallout/human/maleadult01/b_generic_hello02.wav",
			"vj_fallout/human/maleadult01/b_generic_hello03.wav",
			"vj_fallout/human/maleadult01/b_generic_hello04.wav",
		}
		self.SoundTbl_Death = {
			"vj_fallout/human/maleadult01/b_generic_death01.wav",
			"vj_fallout/human/maleadult01/b_generic_death02.wav",
			"vj_fallout/human/maleadult01/b_generic_death03.wav",
		}
	elseif voice == "maleraider" then
		self.SoundTbl_OnGrenadeSight = {
			"vj_fallout/human/maleadult01/b_avoidthreat01.wav",
			"vj_fallout/human/maleadult01/b_avoidthreat02.wav",
			"vj_fallout/human/maleadult01/b_avoidthreat03.wav",
			"vj_fallout/human/maleadult01/b_avoidthreat04.wav",
			"vj_fallout/human/maleadult01/b_avoidthreatresp01.wav",
			"vj_fallout/human/maleadult01/b_avoidthreatresp02.wav",
			"vj_fallout/human/maleadult01/fiend_avoidthreat01.wav",
			"vj_fallout/human/maleadult01/fiend_avoidthreat02.wav",
			"vj_fallout/human/maleadult01/genericadu_avoidthreat01.wav",
			"vj_fallout/human/maleadult01/genericadu_avoidthreat02.wav",
		}
		self.SoundTbl_OnClearedArea = {
			"vj_fallout/human/maleadult01/b_combattonormal01.wav",
			"vj_fallout/human/maleadult01/b_combattonormal02.wav",
			"vj_fallout/human/maleadult01/b_combattonormal03.wav",
			"vj_fallout/human/maleadult01/b_combattonormal04.wav",
			"vj_fallout/human/maleadult01/b_combattonormal05.wav",
			"vj_fallout/human/maleadult01/b_combattonormal06.wav",
			"vj_fallout/human/maleadult01/fie_combattonormal01.wav",
			"vj_fallout/human/maleadult01/fie_combattonormal02.wav",
			"vj_fallout/human/maleadult01/fie_combattonormal03.wav",
			"vj_fallout/human/maleadult01/generic_combattonormal01.wav",
			"vj_fallout/human/maleadult01/genericadu_combattonormal01.wav",
			"vj_fallout/human/maleadult01/genericadu_combattonormal02.wav",
			"vj_fallout/human/maleadult01/genericadu_combattonormal03.wav",
		}
		self.SoundTbl_CombatIdle = {
			"vj_fallout/human/maleadult01/b_alertidle01.wav",
			"vj_fallout/human/maleadult01/b_alertidle02.wav",
			"vj_fallout/human/maleadult01/b_alertidle03.wav",
			"vj_fallout/human/maleadult01/b_alertidle04.wav",
			"vj_fallout/human/maleadult01/b_alertidle05.wav",
			"vj_fallout/human/maleadult01/b_alertidle06.wav",
			"vj_fallout/human/maleadult01/fiend_alertidle01.wav",
			"vj_fallout/human/maleadult01/fiend_alertidle02.wav",
			"vj_fallout/human/maleadult01/generic_alertidle01.wav",
			"vj_fallout/human/maleadult01/genericadu_alertidle01.wav",
			"vj_fallout/human/maleadult01/genericadu_alertidle02.wav",
			"vj_fallout/human/maleadult01/genericadu_alertidle03.wav",
		}
		self.SoundTbl_Guard_Angry = {
			"vj_fallout/human/maleadult01/b_normaltocombat01.wav",
			"vj_fallout/human/maleadult01/b_normaltocombat02.wav",
			"vj_fallout/human/maleadult01/b_normaltocombat03.wav",
			"vj_fallout/human/maleadult01/b_normaltocombat04.wav",
			"vj_fallout/human/maleadult01/b_startcombatresp01.wav",
			"vj_fallout/human/maleadult01/b_startcombatresp02.wav",
			"vj_fallout/human/maleadult01/b_startcombatresp03.wav",
			"vj_fallout/human/maleadult01/b_startcombatresp04.wav",
			"vj_fallout/human/maleadult01/b_startcombatresp05.wav",
			"vj_fallout/human/maleadult01/fie_normaltocombat01.wav",
			"vj_fallout/human/maleadult01/fie_normaltocombat02.wav",
			"vj_fallout/human/maleadult01/fie_normaltocombat03.wav",
			"vj_fallout/human/maleadult01/generic_normaltocombat01.wav",
			"vj_fallout/human/maleadult01/genericadu_normaltocombat01.wav",
			"vj_fallout/human/maleadult01/genericadu_normaltocombat02.wav",
			"vj_fallout/human/maleadult01/genericadu_normaltocombat03.wav",
		}
		self.SoundTbl_Guard_Warn = {
			"vj_fallout/human/maleadult01/genericadu_guardtrespass01.wav",
			"vj_fallout/human/maleadult01/genericadu_guardtrespass02.wav",
			"vj_fallout/human/maleadult01/genericadu_guardtrespass03.wav",
		}
		self.SoundTbl_Suppressing = {
			"vj_fallout/human/maleadult01/b_attack01.wav",
			"vj_fallout/human/maleadult01/b_attack02.wav",
			"vj_fallout/human/maleadult01/b_attack03.wav",
			"vj_fallout/human/maleadult01/b_attack04.wav",
			"vj_fallout/human/maleadult01/b_attack05.wav",
			"vj_fallout/human/maleadult01/b_attack06.wav",
			"vj_fallout/human/maleadult01/b_attack07.wav",
			"vj_fallout/human/maleadult01/b_attack08.wav",
			"vj_fallout/human/maleadult01/b_attack09.wav",
			"vj_fallout/human/maleadult01/b_attack10.wav",
			"vj_fallout/human/maleadult01/b_attack11.wav",
			"vj_fallout/human/maleadult01/fiend_attack01.wav",
			"vj_fallout/human/maleadult01/fiend_attack02.wav",
			"vj_fallout/human/maleadult01/fiend_attack03.wav",
			"vj_fallout/human/maleadult01/genericadultcombat_attack01.wav",
			"vj_fallout/human/maleadult01/genericadultcombat_attack02.wav",
			"vj_fallout/human/maleadult01/genericadultcombat_attack03.wav",
		}
		self.SoundTbl_FollowPlayer = {
			"vj_fallout/human/maleadult01/generic_hello01.wav",
			"vj_fallout/human/maleadult01/genericadult_greeting01.wav",
			"vj_fallout/human/maleadult01/genericadult_hello01.wav",
			"vj_fallout/human/maleadult01/genericadult_hello02.wav",
			"vj_fallout/human/maleadult01/genericadult_hello03.wav",
		}
		self.SoundTbl_OnPlayerSight = {}
		self.SoundTbl_Investigate = {
			"vj_fallout/human/maleadult01/b_normaltoalert01.wav",
			"vj_fallout/human/maleadult01/b_normaltoalert02.wav",
			"vj_fallout/human/maleadult01/b_normaltoalert03.wav",
			"vj_fallout/human/maleadult01/b_normaltoalert04.wav",
			"vj_fallout/human/maleadult01/b_normaltoalert05.wav",
			"vj_fallout/human/maleadult01/fiend_normaltoalert01.wav",
			"vj_fallout/human/maleadult01/fiend_normaltoalert02.wav",
			"vj_fallout/human/maleadult01/fiend_normaltoalert03.wav",
			"vj_fallout/human/maleadult01/generic_normaltoalert01.wav",
			"vj_fallout/human/maleadult01/genericadu_normaltoalert01.wav",
			"vj_fallout/human/maleadult01/genericadu_normaltoalert02.wav",
			"vj_fallout/human/maleadult01/genericadu_normaltoalert03.wav",
		}
		self.SoundTbl_OnKilledEnemy = {
			"vj_fallout/human/maleadult01/b_combattonormal01.wav",
			"vj_fallout/human/maleadult01/b_combattonormal02.wav",
			"vj_fallout/human/maleadult01/b_combattonormal03.wav",
			"vj_fallout/human/maleadult01/b_combattonormal04.wav",
			"vj_fallout/human/maleadult01/b_combattonormal05.wav",
			"vj_fallout/human/maleadult01/b_combattonormal06.wav",
			"vj_fallout/human/maleadult01/fie_combattonormal01.wav",
			"vj_fallout/human/maleadult01/fie_combattonormal02.wav",
			"vj_fallout/human/maleadult01/fie_combattonormal03.wav",
			"vj_fallout/human/maleadult01/generic_combattonormal01.wav",
			"vj_fallout/human/maleadult01/genericadu_combattonormal01.wav",
			"vj_fallout/human/maleadult01/genericadu_combattonormal02.wav",
			"vj_fallout/human/maleadult01/genericadu_combattonormal03.wav",
		}
		self.SoundTbl_UnFollowPlayer = {
			"vj_fallout/human/maleadult01/generic_goodbye01.wav",
			"vj_fallout/human/maleadult01/genericadult_goodbye01.wav",
			"vj_fallout/human/maleadult01/genericadult_goodbye02.wav",
		}
		self.SoundTbl_Guard_Calmed = {
			"vj_fallout/human/maleadult01/b_alerttonormal01.wav",
			"vj_fallout/human/maleadult01/b_alerttonormal02.wav",
			"vj_fallout/human/maleadult01/b_alerttonormal03.wav",
			"vj_fallout/human/maleadult01/b_alerttonormal04.wav",
			"vj_fallout/human/maleadult01/b_alerttonormal05.wav",
			"vj_fallout/human/maleadult01/b_alerttonormal06.wav",
			"vj_fallout/human/maleadult01/fiend_alerttonormal01.wav",
			"vj_fallout/human/maleadult01/fiend_alerttonormal02.wav",
			"vj_fallout/human/maleadult01/fiend_alerttonormal03.wav",
			"vj_fallout/human/maleadult01/generic_alerttonormal01.wav",
			"vj_fallout/human/maleadult01/genericadu_acceptyield01.wav",
			"vj_fallout/human/maleadult01/genericadu_alerttonormal01.wav",
			"vj_fallout/human/maleadult01/genericadu_alerttonormal02.wav",
			"vj_fallout/human/maleadult01/genericadu_alerttonormal03.wav",
		}
		self.SoundTbl_AllyDeath = {
			"vj_fallout/human/maleadult01/b_deathresponse01.wav",
			"vj_fallout/human/maleadult01/b_deathresponse02.wav",
			"vj_fallout/human/maleadult01/b_deathresponse03.wav",
			"vj_fallout/human/maleadult01/b_deathresponse04.wav",
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
		}
		self.SoundTbl_IdleDialogue = {
			"vj_fallout/human/maleadult01/generic_hello01.wav",
			"vj_fallout/human/maleadult01/genericadult_greeting01.wav",
			"vj_fallout/human/maleadult01/genericadult_hello01.wav",
			"vj_fallout/human/maleadult01/genericadult_hello02.wav",
			"vj_fallout/human/maleadult01/genericadult_hello03.wav",
		}
		self.SoundTbl_Alert = {
			"vj_fallout/human/maleadult01/b_alerttocombat01.wav",
			"vj_fallout/human/maleadult01/b_alerttocombat02.wav",
			"vj_fallout/human/maleadult01/b_alerttocombat03.wav",
			"vj_fallout/human/maleadult01/b_alerttocombat04.wav",
			"vj_fallout/human/maleadult01/b_alerttocombat05.wav",
			"vj_fallout/human/maleadult01/b_normaltocombat01.wav",
			"vj_fallout/human/maleadult01/b_normaltocombat02.wav",
			"vj_fallout/human/maleadult01/b_normaltocombat03.wav",
			"vj_fallout/human/maleadult01/b_normaltocombat04.wav",
			"vj_fallout/human/maleadult01/fie_normaltocombat01.wav",
			"vj_fallout/human/maleadult01/fie_normaltocombat02.wav",
			"vj_fallout/human/maleadult01/fie_normaltocombat03.wav",
			"vj_fallout/human/maleadult01/fiend_alerttocombat01.wav",
			"vj_fallout/human/maleadult01/fiend_alerttocombat02.wav",
			"vj_fallout/human/maleadult01/fiend_alerttocombat03.wav",
			"vj_fallout/human/maleadult01/generic_alerttocombat01.wav",
			"vj_fallout/human/maleadult01/generic_normaltocombat01.wav",
			"vj_fallout/human/maleadult01/genericadu_alerttocombat01.wav",
			"vj_fallout/human/maleadult01/genericadu_alerttocombat02.wav",
			"vj_fallout/human/maleadult01/genericadu_alerttocombat03.wav",
			"vj_fallout/human/maleadult01/genericadu_alerttocombat04.wav",
			"vj_fallout/human/maleadult01/genericadu_normaltocombat01.wav",
			"vj_fallout/human/maleadult01/genericadu_normaltocombat02.wav",
			"vj_fallout/human/maleadult01/genericadu_normaltocombat03.wav",
		}
		self.SoundTbl_DamageByPlayer = {
			"vj_fallout/human/maleadult01/genericadultcombat_assault01.wav",
			"vj_fallout/human/maleadult01/genericadultcombat_assault02.wav",
			"vj_fallout/human/maleadult01/genericadultcombat_assault03.wav",
		}
		self.SoundTbl_Idle = {}
		self.SoundTbl_LostEnemy = {
			"vj_fallout/human/maleadult01/b_alerttonormal01.wav",
			"vj_fallout/human/maleadult01/b_alerttonormal02.wav",
			"vj_fallout/human/maleadult01/b_alerttonormal03.wav",
			"vj_fallout/human/maleadult01/b_alerttonormal04.wav",
			"vj_fallout/human/maleadult01/b_alerttonormal05.wav",
			"vj_fallout/human/maleadult01/b_alerttonormal06.wav",
			"vj_fallout/human/maleadult01/b_combattolost01.wav",
			"vj_fallout/human/maleadult01/b_combattolost02.wav",
			"vj_fallout/human/maleadult01/b_combattolost03.wav",
			"vj_fallout/human/maleadult01/b_combattolost04.wav",
			"vj_fallout/human/maleadult01/b_combattolost05.wav",
			"vj_fallout/human/maleadult01/b_combattolost06.wav",
			"vj_fallout/human/maleadult01/fiend_alerttonormal01.wav",
			"vj_fallout/human/maleadult01/fiend_alerttonormal02.wav",
			"vj_fallout/human/maleadult01/fiend_alerttonormal03.wav",
			"vj_fallout/human/maleadult01/fiend_combattolost01.wav",
			"vj_fallout/human/maleadult01/fiend_combattolost02.wav",
			"vj_fallout/human/maleadult01/fiend_combattolost03.wav",
			"vj_fallout/human/maleadult01/generic_alerttonormal01.wav",
			"vj_fallout/human/maleadult01/generic_combattolost01.wav",
			"vj_fallout/human/maleadult01/genericadu_alerttonormal01.wav",
			"vj_fallout/human/maleadult01/genericadu_alerttonormal02.wav",
			"vj_fallout/human/maleadult01/genericadu_alerttonormal03.wav",
			"vj_fallout/human/maleadult01/genericadu_combattolost01.wav",
			"vj_fallout/human/maleadult01/genericadu_combattolost02.wav",
			"vj_fallout/human/maleadult01/genericadu_combattolost03.wav",
		}
		self.SoundTbl_Pain = {
			"vj_fallout/human/maleadult01/b_hit01.wav",
			"vj_fallout/human/maleadult01/b_hit02.wav",
			"vj_fallout/human/maleadult01/b_hit03.wav",
			"vj_fallout/human/maleadult01/b_hit04.wav",
			"vj_fallout/human/maleadult01/b_hit05.wav",
			"vj_fallout/human/maleadult01/b_hit06.wav",
			"vj_fallout/human/maleadult01/b_hit07.wav",
			"vj_fallout/human/maleadult01/generic_hit01.wav",
			"vj_fallout/human/maleadult01/generic_hit02.wav",
			"vj_fallout/human/maleadult01/generic_hit03.wav",
			"vj_fallout/human/maleadult01/generic_hit04.wav",
			"vj_fallout/human/maleadult01/generic_hit05.wav",
			"vj_fallout/human/maleadult01/genericadultcombat_hit01.wav",
			"vj_fallout/human/maleadult01/genericadultcombat_hit02.wav",
		}
		self.SoundTbl_Swing = {
			"vj_fallout/human/maleadult01/generic_powerattack01.wav",
			"vj_fallout/human/maleadult01/generic_powerattack02.wav",
			"vj_fallout/human/maleadult01/generic_powerattack03.wav",
			"vj_fallout/human/maleadult01/generic_powerattack04.wav",
			"vj_fallout/human/maleadult01/powerattack01.wav",
			"vj_fallout/human/maleadult01/powerattack02.wav",
			"vj_fallout/human/maleadult01/powerattack03.wav",
			"vj_fallout/human/maleadult01/powerattack04.wav",
		}
		self.SoundTbl_IdleDialogueAnswer = {
			"vj_fallout/human/maleadult01/generic_goodbye01.wav",
			"vj_fallout/human/maleadult01/generic_hello01.wav",
			"vj_fallout/human/maleadult01/genericadult_goodbye01.wav",
			"vj_fallout/human/maleadult01/genericadult_goodbye02.wav",
			"vj_fallout/human/maleadult01/genericadult_greeting01.wav",
			"vj_fallout/human/maleadult01/genericadult_hello01.wav",
			"vj_fallout/human/maleadult01/genericadult_hello02.wav",
			"vj_fallout/human/maleadult01/genericadult_hello03.wav",
		}
		self.SoundTbl_Death = {
			"vj_fallout/human/maleadult01/death01.wav",
			"vj_fallout/human/maleadult01/death02.wav",
			"vj_fallout/human/maleadult01/death03.wav",
			"vj_fallout/human/maleadult01/generic_death01.wav",
			"vj_fallout/human/maleadult01/generic_death02.wav",
			"vj_fallout/human/maleadult01/generic_death03.wav",
		}
	elseif voice == "maleclone" then
		self.SoundTbl_OnGrenadeSight = {
			"vj_fallout/human/maleadult01/vault108_avoidthreat01.wav",
		}
		self.SoundTbl_OnClearedArea = {
			"vj_fallout/human/maleadult01/vault108_combattonormal01.wav",
			"vj_fallout/human/maleadult01/vault108_combattonormal02.wav",
			"vj_fallout/human/maleadult01/vault108_combattonormal03.wav",
		}
		self.SoundTbl_CombatIdle = {
			"vj_fallout/human/maleadult01/vault108_alertidle01.wav",
			"vj_fallout/human/maleadult01/vault108_alertidle02.wav",
		}
		self.SoundTbl_Guard_Angry = {
			"vj_fallout/human/maleadult01/vault108_normaltocombat01.wav",
			"vj_fallout/human/maleadult01/vault108_startcombatresp01.wav",
		}
		self.SoundTbl_Guard_Warn = {}
		self.SoundTbl_Suppressing = {
			"vj_fallout/human/maleadult01/vault108_attack01.wav",
			"vj_fallout/human/maleadult01/vault108_attack02.wav",
		}
		self.SoundTbl_FollowPlayer = {}
		self.SoundTbl_OnPlayerSight = {}
		self.SoundTbl_Investigate = {
			"vj_fallout/human/maleadult01/vault108_normaltoalert01.wav",
		}
		self.SoundTbl_OnKilledEnemy = {
			"vj_fallout/human/maleadult01/vault108_combattonormal01.wav",
			"vj_fallout/human/maleadult01/vault108_combattonormal02.wav",
			"vj_fallout/human/maleadult01/vault108_combattonormal03.wav",
		}
		self.SoundTbl_UnFollowPlayer = {}
		self.SoundTbl_Guard_Calmed = {
			"vj_fallout/human/maleadult01/vault108_alerttonormal01.wav",
			"vj_fallout/human/maleadult01/vault108_alerttonormal02.wav",
		}
		self.SoundTbl_AllyDeath = {}
		self.SoundTbl_IdleDialogue = {}
		self.SoundTbl_Alert = {
			"vj_fallout/human/maleadult01/vault108_alerttocombat01.wav",
			"vj_fallout/human/maleadult01/vault108_alerttocombat02.wav",
			"vj_fallout/human/maleadult01/vault108_alerttocombat03.wav",
			"vj_fallout/human/maleadult01/vault108_normaltocombat01.wav",
		}
		self.SoundTbl_DamageByPlayer = {}
		self.SoundTbl_Idle = {}
		self.SoundTbl_LostEnemy = {
			"vj_fallout/human/maleadult01/vault108_alerttonormal01.wav",
			"vj_fallout/human/maleadult01/vault108_alerttonormal02.wav",
			"vj_fallout/human/maleadult01/vault108_combattolost01.wav",
		}
		self.SoundTbl_Pain = {
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
		self.SoundTbl_Swing = {
			"vj_fallout/player/player_powerattack01.mp3",
			"vj_fallout/player/player_powerattack02.mp3",
			"vj_fallout/player/player_powerattack03.mp3",
			"vj_fallout/player/player_powerattack04.mp3",
			"vj_fallout/player/player_powerattack05.mp3",
			"vj_fallout/player/player_powerattack06.mp3"
		}
		self.SoundTbl_IdleDialogueAnswer = {}
		self.SoundTbl_Death = {
			"vj_fallout/player/player_death01.mp3",
			"vj_fallout/player/player_death02.mp3",
			"vj_fallout/player/player_death03.mp3",
			"vj_fallout/player/player_death04.mp3",
			"vj_fallout/player/player_death05.mp3",
			"vj_fallout/player/player_death06.mp3",
		}
	elseif voice == "male02" then
		self.SoundTbl_OnGrenadeSight = {
			"vj_fallout/human/maleadult02/b_avoidthreat01.wav",
			"vj_fallout/human/maleadult02/b_avoidthreat02.wav",
			"vj_fallout/human/maleadult02/b_avoidthreat03.wav",
			"vj_fallout/human/maleadult02/b_avoidthreat04.wav",
			"vj_fallout/human/maleadult02/b_avoidthreatresp01.wav",
			"vj_fallout/human/maleadult02/b_avoidthreatresp02.wav",
		}
		self.SoundTbl_OnClearedArea = {
			"vj_fallout/human/maleadult02/b_combattonormal01.wav",
			"vj_fallout/human/maleadult02/b_combattonormal02.wav",
			"vj_fallout/human/maleadult02/b_combattonormal03.wav",
			"vj_fallout/human/maleadult02/b_combattonormal04.wav",
			"vj_fallout/human/maleadult02/b_combattonormal05.wav",
			"vj_fallout/human/maleadult02/b_combattonormal06.wav",
		}
		self.SoundTbl_CombatIdle = {
			"vj_fallout/human/maleadult02/b_alertidle01.wav",
			"vj_fallout/human/maleadult02/b_alertidle02.wav",
			"vj_fallout/human/maleadult02/b_alertidle03.wav",
			"vj_fallout/human/maleadult02/b_alertidle04.wav",
			"vj_fallout/human/maleadult02/b_alertidle05.wav",
			"vj_fallout/human/maleadult02/b_alertidle06.wav",
		}
		self.SoundTbl_Guard_Angry = {
			"vj_fallout/human/maleadult02/b_normaltocombat01.wav",
			"vj_fallout/human/maleadult02/b_normaltocombat02.wav",
			"vj_fallout/human/maleadult02/b_normaltocombat03.wav",
			"vj_fallout/human/maleadult02/b_normaltocombat04.wav",
			"vj_fallout/human/maleadult02/b_startcombatresp01.wav",
			"vj_fallout/human/maleadult02/b_startcombatresp02.wav",
			"vj_fallout/human/maleadult02/b_startcombatresp03.wav",
			"vj_fallout/human/maleadult02/b_startcombatresp04.wav",
			"vj_fallout/human/maleadult02/b_startcombatresp05.wav",
		}
		self.SoundTbl_Guard_Warn = {}
		self.SoundTbl_Suppressing = {
			"vj_fallout/human/maleadult02/b_attack01.wav",
			"vj_fallout/human/maleadult02/b_attack02.wav",
			"vj_fallout/human/maleadult02/b_attack03.wav",
			"vj_fallout/human/maleadult02/b_attack04.wav",
			"vj_fallout/human/maleadult02/b_attack05.wav",
			"vj_fallout/human/maleadult02/b_attack06.wav",
			"vj_fallout/human/maleadult02/b_attack07.wav",
			"vj_fallout/human/maleadult02/b_attack08.wav",
			"vj_fallout/human/maleadult02/b_attack09.wav",
			"vj_fallout/human/maleadult02/b_attack10.wav",
			"vj_fallout/human/maleadult02/b_attack11.wav",
		}
		self.SoundTbl_FollowPlayer = {}
		self.SoundTbl_OnPlayerSight = {}
		self.SoundTbl_Investigate = {
			"vj_fallout/human/maleadult02/b_normaltoalert01.wav",
			"vj_fallout/human/maleadult02/b_normaltoalert02.wav",
			"vj_fallout/human/maleadult02/b_normaltoalert03.wav",
			"vj_fallout/human/maleadult02/b_normaltoalert04.wav",
			"vj_fallout/human/maleadult02/b_normaltoalert05.wav",
		}
		self.SoundTbl_OnKilledEnemy = {
			"vj_fallout/human/maleadult02/b_combattonormal01.wav",
			"vj_fallout/human/maleadult02/b_combattonormal02.wav",
			"vj_fallout/human/maleadult02/b_combattonormal03.wav",
			"vj_fallout/human/maleadult02/b_combattonormal04.wav",
			"vj_fallout/human/maleadult02/b_combattonormal05.wav",
			"vj_fallout/human/maleadult02/b_combattonormal06.wav",
		}
		self.SoundTbl_UnFollowPlayer = {}
		self.SoundTbl_Guard_Calmed = {
			"vj_fallout/human/maleadult02/b_alerttonormal01.wav",
			"vj_fallout/human/maleadult02/b_alerttonormal02.wav",
			"vj_fallout/human/maleadult02/b_alerttonormal03.wav",
			"vj_fallout/human/maleadult02/b_alerttonormal04.wav",
			"vj_fallout/human/maleadult02/b_alerttonormal05.wav",
			"vj_fallout/human/maleadult02/b_alerttonormal06.wav",
		}
		self.SoundTbl_AllyDeath = {
			"vj_fallout/human/maleadult02/b_deathresponse01.wav",
			"vj_fallout/human/maleadult02/b_deathresponse02.wav",
			"vj_fallout/human/maleadult02/b_deathresponse03.wav",
			"vj_fallout/human/maleadult02/b_deathresponse04.wav",
		}
		self.SoundTbl_IdleDialogue = {}
		self.SoundTbl_Alert = {
			"vj_fallout/human/maleadult02/b_alerttocombat01.wav",
			"vj_fallout/human/maleadult02/b_alerttocombat02.wav",
			"vj_fallout/human/maleadult02/b_alerttocombat03.wav",
			"vj_fallout/human/maleadult02/b_alerttocombat04.wav",
			"vj_fallout/human/maleadult02/b_alerttocombat05.wav",
			"vj_fallout/human/maleadult02/b_normaltocombat01.wav",
			"vj_fallout/human/maleadult02/b_normaltocombat02.wav",
			"vj_fallout/human/maleadult02/b_normaltocombat03.wav",
			"vj_fallout/human/maleadult02/b_normaltocombat04.wav",
		}
		self.SoundTbl_DamageByPlayer = {}
		self.SoundTbl_Idle = {}
		self.SoundTbl_LostEnemy = {
			"vj_fallout/human/maleadult02/b_alerttonormal01.wav",
			"vj_fallout/human/maleadult02/b_alerttonormal02.wav",
			"vj_fallout/human/maleadult02/b_alerttonormal03.wav",
			"vj_fallout/human/maleadult02/b_alerttonormal04.wav",
			"vj_fallout/human/maleadult02/b_alerttonormal05.wav",
			"vj_fallout/human/maleadult02/b_alerttonormal06.wav",
			"vj_fallout/human/maleadult02/b_combattolost01.wav",
			"vj_fallout/human/maleadult02/b_combattolost02.wav",
			"vj_fallout/human/maleadult02/b_combattolost03.wav",
			"vj_fallout/human/maleadult02/b_combattolost04.wav",
			"vj_fallout/human/maleadult02/b_combattolost05.wav",
			"vj_fallout/human/maleadult02/b_combattolost06.wav",
		}
		self.SoundTbl_Pain = {
			"vj_fallout/human/maleadult02/b_hit01.wav",
			"vj_fallout/human/maleadult02/b_hit02.wav",
			"vj_fallout/human/maleadult02/b_hit03.wav",
			"vj_fallout/human/maleadult02/b_hit04.wav",
			"vj_fallout/human/maleadult02/b_hit05.wav",
			"vj_fallout/human/maleadult02/b_hit06.wav",
			"vj_fallout/human/maleadult02/b_hit07.wav",
		}
		self.SoundTbl_Swing = {
			"vj_fallout/human/maleadult02/powerattack01.wav",
			"vj_fallout/human/maleadult02/powerattack02.wav",
			"vj_fallout/human/maleadult02/powerattack03.wav",
			"vj_fallout/human/maleadult02/powerattack04.wav",
		}
		self.SoundTbl_IdleDialogueAnswer = {}
		self.SoundTbl_Death = {
			"vj_fallout/human/maleadult02/death01.wav",
			"vj_fallout/human/maleadult02/death02.wav",
			"vj_fallout/human/maleadult02/death03.wav",
		}
	elseif voice == "male03" then
		self.SoundTbl_OnGrenadeSight = {
			"vj_fallout/human/maleadult03/fiend_avoidthreat01.wav",
		}
		self.SoundTbl_OnClearedArea = {
			"vj_fallout/human/maleadult03/fie_combattonormal01.wav",
			"vj_fallout/human/maleadult03/fie_combattonormal02.wav",
			"vj_fallout/human/maleadult03/fie_combattonormal03.wav",
		}
		self.SoundTbl_CombatIdle = {
			"vj_fallout/human/maleadult03/fiend_alertidle01.wav",
			"vj_fallout/human/maleadult03/fiend_alertidle02.wav",
		}
		self.SoundTbl_Guard_Angry = {
			"vj_fallout/human/maleadult03/fie_normaltocombat01.wav",
			"vj_fallout/human/maleadult03/fie_normaltocombat02.wav",
			"vj_fallout/human/maleadult03/fie_normaltocombat03.wav",
		}
		self.SoundTbl_Guard_Warn = {}
		self.SoundTbl_Suppressing = {
			"vj_fallout/human/maleadult03/fiend_attack01.wav",
			"vj_fallout/human/maleadult03/fiend_attack02.wav",
			"vj_fallout/human/maleadult03/fiend_attack03.wav",
		}
		self.SoundTbl_FollowPlayer = {}
		self.SoundTbl_OnPlayerSight = {}
		self.SoundTbl_Investigate = {
			"vj_fallout/human/maleadult03/fiend_normaltoalert01.wav",
			"vj_fallout/human/maleadult03/fiend_normaltoalert02.wav",
			"vj_fallout/human/maleadult03/fiend_normaltoalert03.wav",
		}
		self.SoundTbl_OnKilledEnemy = {
			"vj_fallout/human/maleadult03/fie_combattonormal01.wav",
			"vj_fallout/human/maleadult03/fie_combattonormal02.wav",
			"vj_fallout/human/maleadult03/fie_combattonormal03.wav",
		}
		self.SoundTbl_UnFollowPlayer = {}
		self.SoundTbl_Guard_Calmed = {
			"vj_fallout/human/maleadult03/fiend_alerttonormal01.wav",
			"vj_fallout/human/maleadult03/fiend_alerttonormal02.wav",
			"vj_fallout/human/maleadult03/fiend_alerttonormal03.wav",
		}
		self.SoundTbl_AllyDeath = {
			"vj_fallout/human/maleadult03/fiend_deathresponse01.wav",
			"vj_fallout/human/maleadult03/fiend_deathresponse02.wav",
			"vj_fallout/human/maleadult03/fiend_deathresponse03.wav",
			"vj_fallout/human/maleadult03/fiend_deathresponse04.wav",
			"vj_fallout/human/maleadult03/fiend_deathresponse05.wav",
			"vj_fallout/human/maleadult03/fiend_deathresponse06.wav",
		}
		self.SoundTbl_IdleDialogue = {}
		self.SoundTbl_Alert = {
			"vj_fallout/human/maleadult03/fie_normaltocombat01.wav",
			"vj_fallout/human/maleadult03/fie_normaltocombat02.wav",
			"vj_fallout/human/maleadult03/fie_normaltocombat03.wav",
			"vj_fallout/human/maleadult03/fiend_alerttocombat01.wav",
			"vj_fallout/human/maleadult03/fiend_alerttocombat02.wav",
			"vj_fallout/human/maleadult03/fiend_alerttocombat03.wav",
		}
		self.SoundTbl_DamageByPlayer = {}
		self.SoundTbl_Idle = {}
		self.SoundTbl_LostEnemy = {
			"vj_fallout/human/maleadult03/fiend_alerttonormal01.wav",
			"vj_fallout/human/maleadult03/fiend_alerttonormal02.wav",
			"vj_fallout/human/maleadult03/fiend_alerttonormal03.wav",
			"vj_fallout/human/maleadult03/fiend_combattolost01.wav",
			"vj_fallout/human/maleadult03/fiend_combattolost02.wav",
			"vj_fallout/human/maleadult03/fiend_combattolost03.wav",
		}
		self.SoundTbl_Pain = {}
		self.SoundTbl_Swing = {
			"vj_fallout/human/maleadult03/powerattack01.wav",
			"vj_fallout/human/maleadult03/powerattack02.wav",
			"vj_fallout/human/maleadult03/powerattack03.wav",
			"vj_fallout/human/maleadult03/powerattack04.wav",
		}
		self.SoundTbl_IdleDialogueAnswer = {}
		self.SoundTbl_Death = {
			"vj_fallout/human/maleadult03/death01.wav",
			"vj_fallout/human/maleadult03/death02.wav",
			"vj_fallout/human/maleadult03/death03.wav",
		}
	elseif voice == "male08" then
		self.SoundTbl_OnGrenadeSight = {
			"vj_fallout/human/maleadult08/b_avoidthreat01.wav",
			"vj_fallout/human/maleadult08/b_avoidthreat02.wav",
			"vj_fallout/human/maleadult08/b_avoidthreat03.wav",
			"vj_fallout/human/maleadult08/b_avoidthreat04.wav",
			"vj_fallout/human/maleadult08/b_avoidthreatresp01.wav",
			"vj_fallout/human/maleadult08/b_avoidthreatresp02.wav",
		}
		self.SoundTbl_OnClearedArea = {
			"vj_fallout/human/maleadult08/b_combattonormal01.wav",
			"vj_fallout/human/maleadult08/b_combattonormal02.wav",
			"vj_fallout/human/maleadult08/b_combattonormal03.wav",
			"vj_fallout/human/maleadult08/b_combattonormal04.wav",
			"vj_fallout/human/maleadult08/b_combattonormal05.wav",
			"vj_fallout/human/maleadult08/b_combattonormal06.wav",
		}
		self.SoundTbl_CombatIdle = {
			"vj_fallout/human/maleadult08/b_alertidle01.wav",
			"vj_fallout/human/maleadult08/b_alertidle02.wav",
			"vj_fallout/human/maleadult08/b_alertidle03.wav",
			"vj_fallout/human/maleadult08/b_alertidle04.wav",
			"vj_fallout/human/maleadult08/b_alertidle05.wav",
			"vj_fallout/human/maleadult08/b_alertidle06.wav",
		}
		self.SoundTbl_Guard_Angry = {
			"vj_fallout/human/maleadult08/b_normaltocombat01.wav",
			"vj_fallout/human/maleadult08/b_normaltocombat02.wav",
			"vj_fallout/human/maleadult08/b_normaltocombat03.wav",
			"vj_fallout/human/maleadult08/b_normaltocombat04.wav",
			"vj_fallout/human/maleadult08/b_startcombatresp01.wav",
			"vj_fallout/human/maleadult08/b_startcombatresp02.wav",
			"vj_fallout/human/maleadult08/b_startcombatresp03.wav",
			"vj_fallout/human/maleadult08/b_startcombatresp04.wav",
			"vj_fallout/human/maleadult08/b_startcombatresp05.wav",
		}
		self.SoundTbl_Guard_Warn = {}
		self.SoundTbl_Suppressing = {
			"vj_fallout/human/maleadult08/b_attack01.wav",
			"vj_fallout/human/maleadult08/b_attack02.wav",
			"vj_fallout/human/maleadult08/b_attack03.wav",
			"vj_fallout/human/maleadult08/b_attack04.wav",
			"vj_fallout/human/maleadult08/b_attack05.wav",
			"vj_fallout/human/maleadult08/b_attack06.wav",
			"vj_fallout/human/maleadult08/b_attack07.wav",
			"vj_fallout/human/maleadult08/b_attack08.wav",
			"vj_fallout/human/maleadult08/b_attack09.wav",
			"vj_fallout/human/maleadult08/b_attack10.wav",
			"vj_fallout/human/maleadult08/b_attack11.wav",
			"vj_fallout/human/maleadult08/b_attackresponse01.wav",
			"vj_fallout/human/maleadult08/b_attackresponse02.wav",
		}
		self.SoundTbl_FollowPlayer = {}
		self.SoundTbl_OnPlayerSight = {}
		self.SoundTbl_Investigate = {
			"vj_fallout/human/maleadult08/b_normaltoalert01.wav",
			"vj_fallout/human/maleadult08/b_normaltoalert02.wav",
			"vj_fallout/human/maleadult08/b_normaltoalert03.wav",
			"vj_fallout/human/maleadult08/b_normaltoalert04.wav",
			"vj_fallout/human/maleadult08/b_normaltoalert05.wav",
		}
		self.SoundTbl_OnKilledEnemy = {
			"vj_fallout/human/maleadult08/b_combattonormal01.wav",
			"vj_fallout/human/maleadult08/b_combattonormal02.wav",
			"vj_fallout/human/maleadult08/b_combattonormal03.wav",
			"vj_fallout/human/maleadult08/b_combattonormal04.wav",
			"vj_fallout/human/maleadult08/b_combattonormal05.wav",
			"vj_fallout/human/maleadult08/b_combattonormal06.wav",
		}
		self.SoundTbl_UnFollowPlayer = {}
		self.SoundTbl_Guard_Calmed = {
			"vj_fallout/human/maleadult08/b_alerttonormal01.wav",
			"vj_fallout/human/maleadult08/b_alerttonormal02.wav",
			"vj_fallout/human/maleadult08/b_alerttonormal03.wav",
			"vj_fallout/human/maleadult08/b_alerttonormal04.wav",
			"vj_fallout/human/maleadult08/b_alerttonormal05.wav",
			"vj_fallout/human/maleadult08/b_alerttonormal06.wav",
		}
		self.SoundTbl_AllyDeath = {
			"vj_fallout/human/maleadult08/b_deathresponse01.wav",
			"vj_fallout/human/maleadult08/b_deathresponse02.wav",
			"vj_fallout/human/maleadult08/b_deathresponse03.wav",
			"vj_fallout/human/maleadult08/b_deathresponse04.wav",
		}
		self.SoundTbl_IdleDialogue = {}
		self.SoundTbl_Alert = {
			"vj_fallout/human/maleadult08/b_alerttocombat01.wav",
			"vj_fallout/human/maleadult08/b_alerttocombat02.wav",
			"vj_fallout/human/maleadult08/b_alerttocombat03.wav",
			"vj_fallout/human/maleadult08/b_alerttocombat04.wav",
			"vj_fallout/human/maleadult08/b_alerttocombat05.wav",
			"vj_fallout/human/maleadult08/b_normaltocombat01.wav",
			"vj_fallout/human/maleadult08/b_normaltocombat02.wav",
			"vj_fallout/human/maleadult08/b_normaltocombat03.wav",
			"vj_fallout/human/maleadult08/b_normaltocombat04.wav",
		}
		self.SoundTbl_DamageByPlayer = {}
		self.SoundTbl_Idle = {}
		self.SoundTbl_LostEnemy = {
			"vj_fallout/human/maleadult08/b_alerttonormal01.wav",
			"vj_fallout/human/maleadult08/b_alerttonormal02.wav",
			"vj_fallout/human/maleadult08/b_alerttonormal03.wav",
			"vj_fallout/human/maleadult08/b_alerttonormal04.wav",
			"vj_fallout/human/maleadult08/b_alerttonormal05.wav",
			"vj_fallout/human/maleadult08/b_alerttonormal06.wav",
			"vj_fallout/human/maleadult08/b_combattolost01.wav",
			"vj_fallout/human/maleadult08/b_combattolost02.wav",
			"vj_fallout/human/maleadult08/b_combattolost03.wav",
			"vj_fallout/human/maleadult08/b_combattolost04.wav",
			"vj_fallout/human/maleadult08/b_combattolost05.wav",
			"vj_fallout/human/maleadult08/b_combattolost06.wav",
		}
		self.SoundTbl_Pain = {
			"vj_fallout/human/maleadult08/b_hit01.wav",
			"vj_fallout/human/maleadult08/b_hit02.wav",
			"vj_fallout/human/maleadult08/b_hit03.wav",
			"vj_fallout/human/maleadult08/b_hit04.wav",
			"vj_fallout/human/maleadult08/b_hit05.wav",
			"vj_fallout/human/maleadult08/b_hit06.wav",
			"vj_fallout/human/maleadult08/b_hit07.wav",
		}
		self.SoundTbl_Swing = {
			"vj_fallout/human/maleadult08/powerattack01.wav",
			"vj_fallout/human/maleadult08/powerattack02.wav",
			"vj_fallout/human/maleadult08/powerattack03.wav",
			"vj_fallout/human/maleadult08/powerattack04.wav",
		}
		self.SoundTbl_IdleDialogueAnswer = {}
		self.SoundTbl_Death = {
			"vj_fallout/human/maleadult08/death01.wav",
			"vj_fallout/human/maleadult08/death02.wav",
			"vj_fallout/human/maleadult08/death03.wav",
		}
	elseif voice == "maledefault" then
		self.SoundTbl_Idle = {}
		self.SoundTbl_IdleDialogue = {}
		self.SoundTbl_IdleDialogueAnswer = {}
		self.SoundTbl_FollowPlayer = {}
		self.SoundTbl_UnFollowPlayer = {}
		self.SoundTbl_Alert = {}
		self.SoundTbl_CombatIdle = {}
		self.SoundTbl_Investigate = {}
		self.SoundTbl_LostEnemy = {}
		self.SoundTbl_Suppressing = {}
		self.SoundTbl_DamageByPlayer = {}
		self.SoundTbl_OnGrenadeSight = {}
		self.SoundTbl_AllyDeath = {}
		self.SoundTbl_Pain = {
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
		self.SoundTbl_Death = {
			"vj_fallout/player/player_death01.mp3",
			"vj_fallout/player/player_death02.mp3",
			"vj_fallout/player/player_death03.mp3",
			"vj_fallout/player/player_death04.mp3",
			"vj_fallout/player/player_death05.mp3",
			"vj_fallout/player/player_death06.mp3",
		}
		self.SoundTbl_OnClearedArea = {}
		self.SoundTbl_OnKilledEnemy = {}
		self.SoundTbl_Guard_Warn = {}
		self.SoundTbl_Guard_Angry = {}
		self.SoundTbl_Guard_Calmed = {}
		self.SoundTbl_Swing = {
			"vj_fallout/player/player_powerattack01.mp3",
			"vj_fallout/player/player_powerattack02.mp3",
			"vj_fallout/player/player_powerattack03.mp3",
			"vj_fallout/player/player_powerattack04.mp3",
			"vj_fallout/player/player_powerattack05.mp3",
			"vj_fallout/player/player_powerattack06.mp3"
		}
	elseif voice == "femaledefault" then
		self.SoundTbl_OnGrenadeSight = {}
		self.SoundTbl_OnClearedArea = {}
		self.SoundTbl_CombatIdle = {}
		self.SoundTbl_Guard_Angry = {}
		self.SoundTbl_Guard_Warn = {}
		self.SoundTbl_Suppressing = {}
		self.SoundTbl_FollowPlayer = {}
		self.SoundTbl_OnPlayerSight = {}
		self.SoundTbl_Investigate = {}
		self.SoundTbl_OnKilledEnemy = {}
		self.SoundTbl_UnFollowPlayer = {}
		self.SoundTbl_Guard_Calmed = {}
		self.SoundTbl_AllyDeath = {}
		self.SoundTbl_IdleDialogue = {}
		self.SoundTbl_Alert = {}
		self.SoundTbl_DamageByPlayer = {}
		self.SoundTbl_Idle = {}
		self.SoundTbl_LostEnemy = {}
		self.SoundTbl_Pain = {
			"vj_fallout/female/genericplayer_hit_1.mp3",
			"vj_fallout/female/genericplayer_hit_10.mp3",
			"vj_fallout/female/genericplayer_hit_11.mp3",
			"vj_fallout/female/genericplayer_hit_12.mp3",
			"vj_fallout/female/genericplayer_hit_13.mp3",
			"vj_fallout/female/genericplayer_hit_14.mp3",
			"vj_fallout/female/genericplayer_hit_15.mp3",
			"vj_fallout/female/genericplayer_hit_16.mp3",
			"vj_fallout/female/genericplayer_hit_2.mp3",
			"vj_fallout/female/genericplayer_hit_3.mp3",
			"vj_fallout/female/genericplayer_hit_4.mp3",
			"vj_fallout/female/genericplayer_hit_5.mp3",
			"vj_fallout/female/genericplayer_hit_6.mp3",
			"vj_fallout/female/genericplayer_hit_7.mp3",
			"vj_fallout/female/genericplayer_hit_8.mp3",
			"vj_fallout/female/genericplayer_hit_9.mp3",
		}
		self.SoundTbl_Swing = {
			"vj_fallout/female/genericplayer_powerattack_1.mp3",
			"vj_fallout/female/genericplayer_powerattack_2.mp3",
			"vj_fallout/female/genericplayer_powerattack_3.mp3",
			"vj_fallout/female/genericplayer_powerattack_4.mp3",
			"vj_fallout/female/genericplayer_powerattack_5.mp3",
			"vj_fallout/female/genericplayer_powerattack_6.mp3",
		}
		self.SoundTbl_IdleDialogueAnswer = {}
		self.SoundTbl_Death = {
			"vj_fallout/female/genericplayer_death_1.mp3",
			"vj_fallout/female/genericplayer_death_2.mp3",
			"vj_fallout/female/genericplayer_death_3.mp3",
			"vj_fallout/female/genericplayer_death_4.mp3",
			"vj_fallout/female/genericplayer_death_5.mp3",
		}
	else
		self.SoundTbl_Idle = {}
		self.SoundTbl_IdleDialogue = {}
		self.SoundTbl_IdleDialogueAnswer = {}
		self.SoundTbl_FollowPlayer = {}
		self.SoundTbl_UnFollowPlayer = {}
		self.SoundTbl_Alert = {}
		self.SoundTbl_CombatIdle = {}
		self.SoundTbl_Investigate = {}
		self.SoundTbl_LostEnemy = {}
		self.SoundTbl_Suppressing = {}
		self.SoundTbl_DamageByPlayer = {}
		self.SoundTbl_OnGrenadeSight = {}
		self.SoundTbl_AllyDeath = {}
		self.SoundTbl_Pain = {}
		self.SoundTbl_Death = {}
		self.SoundTbl_OnClearedArea = {}
		self.SoundTbl_OnKilledEnemy = {}
		self.SoundTbl_Guard_Warn = {}
		self.SoundTbl_Guard_Angry = {}
		self.SoundTbl_Guard_Calmed = {}
		self.SoundTbl_Swing = {}
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:BeforeApparelSpawned() end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetupApparel(ent)
	if ent != self then
		if #self.tbl_Apparel > 0 then
			for _,mdl in pairs(self.tbl_Apparel) do
				self:AddApparel(ent,mdl)
			end
		end
		if #self.tbl_Hair > 0 then
			for _,mdl in pairs(self.tbl_Hair) do
				self:AddApparel(ent,mdl,true,self.HairColor)
			end
		end
	else
		self:BeforeApparelSpawned()
		if #self.tbl_ApparelModels > 0 then
			if math.random(1,self.SpawnWithApparelChance) == 1 then
				self.HasApparel = true
				self:AddApparel(ent,VJ.PICK(self.tbl_ApparelModels))
			end
		end
		if #self.tbl_HairModels > 0 then
			if self.CantHaveHairWithApparel && self.HasApparel then return end
			if math.random(1,self.SpawnWithHairChance) == 1 then
				self:AddApparel(ent,VJ.PICK(self.tbl_HairModels),true,self.HairColor)
			end
		end
		if #self.tbl_BeardModels > 0 then
			if math.random(1,self.SpawnWithBeardChance) == 1 then
				self:AddApparel(ent,VJ.PICK(self.tbl_BeardModels),true,self.HairColor)
			end
		end
		if self.CustomApparel then self:CustomApparel(ent) end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:AddApparel(ent,mdl,ishair,color)
	local attach = ent:GetAttachment(ent:LookupAttachment("headgear"))
	apparel = ents.Create("prop_dynamic")
	apparel:SetModel(mdl)
	apparel:SetPos(attach.Pos)
	apparel:SetAngles(attach.Ang)
	apparel:SetOwner(ent)
	apparel:SetParent(ent)
	apparel:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
	if !ishair then apparel:AddEffects(EF_BONEMERGE) end
	apparel:Fire("SetParentAttachment","headgear",0)
	apparel:Spawn()
	apparel:Activate()
	-- apparel:SetRenderMode(RENDERMODE_TRANSALPHA)
	ent:DeleteOnRemove(apparel)
	if color then
		apparel:SetColor(color)
	end
	apparel:SetSolid(SOLID_NONE)
	if ent == self then
		if !ishair then
			table.insert(self.tbl_CurrentApparel,apparel)
			table.insert(self.tbl_Apparel,apparel:GetModel())
		else
			table.insert(self.tbl_CurrentHair,apparel)
			table.insert(self.tbl_Hair,apparel:GetModel())
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPlayerSight(argent)
	if self.Human_IsSoldier && !IsValid(self:GetEnemy()) && self:Disposition(argent) == D_LI then
		self:StopMoving()
		self:VJ_ACT_PLAYACTIVITY(ACT_MP_GESTURE_VC_NODNO,true,false,true)
		if IsValid(self:GetActiveWeapon()) && self:GetWeaponState() == VJ.NPC_WEP_STATE_READY then
			self:GetActiveWeapon():SetNoDraw(true)
			if self:GetActiveWeapon().NPC_UnequipSound then
				VJ_EmitSound(self:GetActiveWeapon(),self:GetActiveWeapon().NPC_UnequipSound,75,100)
			end
		end
		timer.Simple(self:DecideAnimationLength(ACT_MP_GESTURE_VC_NODNO,false),function()
			if IsValid(self) && IsValid(self:GetActiveWeapon()) && self:GetWeaponState() == VJ.NPC_WEP_STATE_READY then
				self:GetActiveWeapon():SetNoDraw(false)
				if self:GetActiveWeapon().NPC_EquipSound then
					VJ_EmitSound(self:GetActiveWeapon(),self:GetActiveWeapon().NPC_EquipSound,75,100)
				end
			end
		end)
	end
	if self.VJ_F3R_InGuardMode && self:Disposition(argent) != D_LI then
		if argent:GetPos():Distance(self:GetPos()) <= self.VJ_F3R_GuardWarnDistance then
			VJ_EmitSound(self,self.SoundTbl_Guard_Warn,78,100)
			local time = math.random(5,8)
			for i = 1,time *2 do
				timer.Simple(i *0.5,function() if IsValid(self) && !IsValid(self:GetEnemy()) then if IsValid(argent) then self:SetTarget(argent); self:StopMoving(); self:ClearSchedule(); self:VJ_TASK_FACE_X("TASK_FACE_TARGET") end end end)
			end
			timer.Simple(time,function()
				if IsValid(self) then
					if IsValid(argent) then 
						if argent:GetPos():Distance(self:GetPos()) <= self.VJ_F3R_GuardWarnDistance then
							table.insert(self.VJ_AddCertainEntityAsEnemy,argent)
							self:VJ_DoSetEnemy(argent,true,true)
							self:SetEnemy(argent)
							VJ_EmitSound(self,self.SoundTbl_Guard_Angry,78,100)
						else
							VJ_EmitSound(self,self.SoundTbl_Guard_Calmed,78,100)
						end
					end
				end
			end)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetupInventory(opWep)
	if opWep then self:AddToInventory(opWep.ID,opWep:GetClass(),1) end
	if self.CustomInventory then self:CustomInventory() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Init()
	self.tbl_Inventory = {}
	self.tbl_CurrentApparel = {}
	self.tbl_Apparel = {}
	self.tbl_CurrentHair = {}
	self.tbl_Hair = {}
	self.HasApparel = false

	self.CanHolsterWeapon = GetConVar("vj_f3r_human_holster"):GetBool()
	
	self:SetCollisionBounds(Vector(18,18,82),Vector(-18,-18,0))
	timer.Simple(0.02,function()
		if IsValid(self) then
			if IsValid(self:GetActiveWeapon()) then
				local wep = self:GetActiveWeapon()
				-- if wep.AnimationType == nil then self:Remove() end
				-- if wep.AnimationType then
					-- self:SetupHoldTypes(wep,wep.AnimationType)
				-- end

				if self.CanHolsterWeapon && !self.VJ_F3R_InGuardMode then
					if !IsValid(self:GetEnemy()) && self:GetWeaponState() == VJ.NPC_WEP_STATE_READY then
						self:Unequip()
					end
				elseif !self.CanHolsterWeapon then
					self:Equip()
				end
				self:SetupInventory(self:GetActiveWeapon())
			end
		end
	end)
	-- for i = 1,18 do
		-- self:SetBodygroup(i,math.random(0,self:GetBodygroupCount(i)))
	-- end
	-- self:SetSkin(math.random(0,1))
	if self.CustomInit then self:CustomInit() end
	self:SetupApparel(self)
	self.NPC_NextMouthMove = CurTime()
	self.NPC_NextMouthDistance = 0
	self.NextStimPackT = CurTime()
	self.NextStealthBoyT = CurTime()
	self:GuardInit()
	if self.Gender && self.Gender == 2 then
		self:ManipulateBoneJiggle(92,1)
		self:ManipulateBoneJiggle(93,1)
	end
	if self.AfterInit then self:AfterInit() end
	
	-- self:SetVoice("female01")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_Initialize(ply,controlEnt)
	function controlEnt:OnThink()
		local npc = self.VJCE_NPC
		local canTurnAndStuph = (IsValid(npc:GetActiveWeapon()) && npc:GetWeaponState() == VJ.NPC_WEP_STATE_READY) or self.VJC_Camera_Mode == 2
		self.VJC_NPC_CanTurn = canTurnAndStuph
		self.VJC_BullseyeTracking = npc:IsMoving() && canTurnAndStuph
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnPlayCreateSound(SoundData,SoundFile)
	-- print(self,SoundDuration(SoundFile))
	self.NPC_NextMouthMove = CurTime() +SoundDuration(SoundFile)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnFootStepSound() VJ_CreateStepSound(self,32) end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:ExtraInput(key,activator,caller,data) end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "event_swing" then
		VJ_EmitSound(self,self.SoundTbl_Swing,80,100)
	elseif string.find(key,"event_1hm") then
		local atk = string.Replace(key,"event_1hm ","")
		local wep = self:GetActiveWeapon()
		self.MeleeAttackDamage = IsValid(wep) && wep.IsMeleeWeapon && (key == "event_1hm forwardpower" && wep.Primary.HeavyDamage or wep.Primary.Damage) or 8
		self:MeleeAttackCode()
	elseif string.find(key,"event_2hm") then
		local atk = string.Replace(key,"event_2hm ","")
		self:MeleeAttackCode()
	elseif string.find(key,"event_mattack") then
		local atk = string.Replace(key,"event_mattack ","")
		self:MeleeAttackCode()
	end
	self:ExtraInput(key,activator,caller,data)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:ItemThink()
	if self:FindInventoryItem(ITEM_VJ_STIMPACK) then
		if IsValid(self:GetEnemy()) && CurTime() > self.NextStealthBoyT && math.random(1,200) == 1 then
			self:RemoveFromInventory(ITEM_VJ_STIMPACK,1)
			self:Item_Stealthboy()
			self.NextStealthBoyT = CurTime() +math.Rand(25,30)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetAnimationTranslations(htype)
	local wep = self:GetActiveWeapon()
	if wep.AnimationType then
		htype = wep.AnimationType
	end
	self.AnimationTranslations[ACT_IDLE] 							= ACT_IDLE
	self.AnimationTranslations[ACT_WALK] 							= ACT_WALK
	self.AnimationTranslations[ACT_RUN] 							= ACT_RUN
	if htype == "1gt" then
		local aim = VJ_SequenceToActivity(self,"1gtaim")
		local walk = VJ_SequenceToActivity(self,"1gtaim_walk")
		local walk_crouch = VJ_SequenceToActivity(self,"1gtaim_sneak")
		local run = VJ_SequenceToActivity(self,"1gtaim_run")
		local run_crouch = VJ_SequenceToActivity(self,"1gtaim_sneakfast")
		local fire = VJ_SequenceToActivity(self,"1gtattackthrow")
		local crouch = VJ_SequenceToActivity(self,"sneak1gtaim")
		local reload = "1gtequip"

		self.AnimationTranslations[ACT_IDLE_ANGRY] 					= aim
		self.AnimationTranslations[ACT_WALK_AIM] 						= walk
		self.AnimationTranslations[ACT_WALK_CROUCH_AIM] 				= walk_crouch
		self.AnimationTranslations[ACT_RUN_AIM] 						= run
		self.AnimationTranslations[ACT_RUN_CROUCH_AIM] 				= run_crouch
		self.AnimationTranslations[ACT_RANGE_ATTACK1] 					= aim
		self.AnimationTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= fire
		self.AnimationTranslations[ACT_RANGE_ATTACK1_LOW] 				= crouch
		self.AnimationTranslations[ACT_RELOAD]							= "vjges_" .. reload
		self.AnimationTranslations[ACT_COVER_LOW] 						= crouch
		self.AnimationTranslations[ACT_RELOAD_LOW] 					= crouch
	elseif htype == "1hp" then
		local aim = VJ_SequenceToActivity(self,"1hpaim")
		local walk = VJ_SequenceToActivity(self,"1hpaim_walk")
		local walk_crouch = VJ_SequenceToActivity(self,"1hpaim_sneak")
		local run = VJ_SequenceToActivity(self,"1hpaim_run")
		local run_crouch = VJ_SequenceToActivity(self,"1hpaim_sneakfast")
		local fire = VJ_SequenceToActivity(self,"1hpattackright")
		local crouch = VJ_SequenceToActivity(self,"sneak1hpaim")
		local reload = "1hpreloada"

		self.AnimationTranslations[ACT_IDLE_ANGRY] 					= aim
		self.AnimationTranslations[ACT_WALK_AIM] 						= walk
		self.AnimationTranslations[ACT_WALK_CROUCH_AIM] 				= walk_crouch
		self.AnimationTranslations[ACT_RUN_AIM] 						= run
		self.AnimationTranslations[ACT_RUN_CROUCH_AIM] 				= run_crouch
		self.AnimationTranslations[ACT_RANGE_ATTACK1] 					= aim
		self.AnimationTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= fire
		self.AnimationTranslations[ACT_RANGE_ATTACK1_LOW] 				= crouch
		self.AnimationTranslations[ACT_RELOAD]							= "vjges_" .. reload
		self.AnimationTranslations[ACT_COVER_LOW] 						= crouch
		self.AnimationTranslations[ACT_RELOAD_LOW] 					= crouch
	elseif htype == "1hm" then
		local aim = VJ_SequenceToActivity(self,"1hmaim")
		local walk = VJ_SequenceToActivity(self,"1hmwalk")
		local walk_crouch = VJ_SequenceToActivity(self,"1hpaim_sneak")
		local run = VJ_SequenceToActivity(self,"1hmrun")
		local run_crouch = VJ_SequenceToActivity(self,"1hpaim_sneakfast")
		local fire = ACT_READINESS_PISTOL_RELAXED_TO_STIMULATED_WALK
		local fire2 = ACT_READINESS_PISTOL_RELAXED_TO_STIMULATED
		local crouch = VJ_SequenceToActivity(self,"sneak1hpaim")
		local reload = "1hmreloada"

		self.AnimationTranslations[ACT_IDLE_ANGRY] 					= aim
		self.AnimationTranslations[ACT_WALK_AIM] 						= walk
		self.AnimationTranslations[ACT_WALK_CROUCH_AIM] 				= walk_crouch
		self.AnimationTranslations[ACT_RUN_AIM] 						= run
		self.AnimationTranslations[ACT_RUN_CROUCH_AIM] 				= run_crouch
		self.AnimationTranslations[ACT_RANGE_ATTACK1] 					= aim
		self.AnimationTranslations[ACT_RANGE_ATTACK2] 					= fire2
		self.AnimationTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= fire
		self.AnimationTranslations[ACT_RANGE_ATTACK1_LOW] 				= crouch
		self.AnimationTranslations[ACT_RELOAD]							= "vjges_" .. reload
		self.AnimationTranslations[ACT_COVER_LOW] 						= crouch
		self.AnimationTranslations[ACT_RELOAD_LOW] 					= crouch
	elseif htype == "2hm" then
		local aim = VJ_SequenceToActivity(self,"2hmaim")
		local walk = VJ_SequenceToActivity(self,"2hmaim_walk")
		local walk_crouch = VJ_SequenceToActivity(self,"2hmaim_walk")
		local run = VJ_SequenceToActivity(self,"2hmaim_run")
		local run_crouch = VJ_SequenceToActivity(self,"2hmaim_run")
		local fire = ACT_GESTURE_MELEE_ATTACK2
		local fire2 = ACT_MELEE_ATTACK2
		local crouch = VJ_SequenceToActivity(self,"2hmaim")
		local reload = "2hmreloada"

		self.AnimationTranslations[ACT_IDLE_ANGRY] 					= aim
		self.AnimationTranslations[ACT_WALK_AIM] 						= walk
		self.AnimationTranslations[ACT_WALK_CROUCH_AIM] 				= walk_crouch
		self.AnimationTranslations[ACT_RUN_AIM] 						= run
		self.AnimationTranslations[ACT_RUN_CROUCH_AIM] 				= run_crouch
		self.AnimationTranslations[ACT_RANGE_ATTACK1] 					= aim
		self.AnimationTranslations[ACT_RANGE_ATTACK2] 					= fire2
		self.AnimationTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= fire
		self.AnimationTranslations[ACT_RANGE_ATTACK1_LOW] 				= crouch
		self.AnimationTranslations[ACT_RELOAD]							= "vjges_" .. reload
		self.AnimationTranslations[ACT_COVER_LOW] 						= crouch
		self.AnimationTranslations[ACT_RELOAD_LOW] 					= crouch
	elseif htype == "2ha" then
		local aim = VJ_SequenceToActivity(self,"2haaim")
		local walk = VJ_SequenceToActivity(self,"2haaim_walk")
		local walk_crouch = VJ_SequenceToActivity(self,"2haaim_sneak")
		local run = VJ_SequenceToActivity(self,"2haaim_run")
		local run_crouch = VJ_SequenceToActivity(self,"2haaim_sneakfast")
		local fire = "2haattackloop"
		local crouch = VJ_SequenceToActivity(self,"sneak2hraim")
		local reload = "2hareloada"

		self.AnimationTranslations[ACT_IDLE_ANGRY] 					= aim
		self.AnimationTranslations[ACT_WALK_AIM] 						= walk
		self.AnimationTranslations[ACT_WALK_CROUCH_AIM] 				= walk_crouch
		self.AnimationTranslations[ACT_RUN_AIM] 						= run
		self.AnimationTranslations[ACT_RUN_CROUCH_AIM] 				= run_crouch
		self.AnimationTranslations[ACT_RANGE_ATTACK1] 					= aim
		self.AnimationTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= fire
		self.AnimationTranslations[ACT_RANGE_ATTACK1_LOW] 				= crouch
		self.AnimationTranslations[ACT_RELOAD]							= "vjges_" .. reload
		self.AnimationTranslations[ACT_COVER_LOW] 						= crouch
		self.AnimationTranslations[ACT_RELOAD_LOW] 					= crouch
	elseif htype == "2hh" then
		local aim = VJ_SequenceToActivity(self,"2hhaim")
		local walk = VJ_SequenceToActivity(self,"2hhaim_walk")
		local walk_crouch = VJ_SequenceToActivity(self,"2hhaim_sneak")
		local run = VJ_SequenceToActivity(self,"2hhaim_run")
		local run_crouch = VJ_SequenceToActivity(self,"2hhaim_sneakfast")
		local fire = "2hhattackloop"
		local crouch = VJ_SequenceToActivity(self,"sneak2hhaim")
		local reload = "2hhreloade"

		self.AnimationTranslations[ACT_IDLE_ANGRY] 					= aim
		self.AnimationTranslations[ACT_WALK_AIM] 						= walk
		self.AnimationTranslations[ACT_WALK_CROUCH_AIM] 				= walk_crouch
		self.AnimationTranslations[ACT_RUN_AIM] 						= run
		self.AnimationTranslations[ACT_RUN_CROUCH_AIM] 				= run_crouch
		self.AnimationTranslations[ACT_RANGE_ATTACK1] 					= aim
		self.AnimationTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= fire
		self.AnimationTranslations[ACT_RANGE_ATTACK1_LOW] 				= crouch
		self.AnimationTranslations[ACT_RELOAD]							= "vjges_" .. reload
		self.AnimationTranslations[ACT_COVER_LOW] 						= crouch
		self.AnimationTranslations[ACT_RELOAD_LOW] 					= crouch
	elseif htype == "2hl" then
		local aim = VJ_SequenceToActivity(self,"2hlaim")
		local walk = VJ_SequenceToActivity(self,"2hlaim_walk")
		local walk_crouch = VJ_SequenceToActivity(self,"2hlaim_sneak")
		local run = VJ_SequenceToActivity(self,"2hlaim_run")
		local run_crouch = VJ_SequenceToActivity(self,"2hlaim_sneakfast")
		local fire = VJ_SequenceToActivity(self,"2hlattack3")
		local crouch = VJ_SequenceToActivity(self,"sneak2hlaim")
		local reload = "2hlreloade"

		self.AnimationTranslations[ACT_IDLE_ANGRY] 					= aim
		self.AnimationTranslations[ACT_WALK_AIM] 						= walk
		self.AnimationTranslations[ACT_WALK_CROUCH_AIM] 				= walk_crouch
		self.AnimationTranslations[ACT_RUN_AIM] 						= run
		self.AnimationTranslations[ACT_RUN_CROUCH_AIM] 				= run_crouch
		self.AnimationTranslations[ACT_RANGE_ATTACK1] 					= aim
		self.AnimationTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= fire
		self.AnimationTranslations[ACT_RANGE_ATTACK1_LOW] 				= crouch
		self.AnimationTranslations[ACT_RELOAD]							= "vjges_" .. reload
		self.AnimationTranslations[ACT_COVER_LOW] 						= crouch
		self.AnimationTranslations[ACT_RELOAD_LOW] 					= crouch
	elseif htype == "2hm" then
		local aim = VJ_SequenceToActivity(self,"2hmaim")
		local walk = VJ_SequenceToActivity(self,"2hmaim_walk")
		local walk_crouch = VJ_SequenceToActivity(self,"2hmaim_sneak")
		local run = VJ_SequenceToActivity(self,"2hmaim_run")
		local run_crouch = VJ_SequenceToActivity(self,"2hmaim_sneakfast")
		local fire = VJ_SequenceToActivity(self,"2hmattackleft_a")
		local crouch = VJ_SequenceToActivity(self,"sneak2hmaim")

		self.AnimationTranslations[ACT_IDLE_ANGRY] 					= aim
		self.AnimationTranslations[ACT_WALK_AIM] 						= walk
		self.AnimationTranslations[ACT_WALK_CROUCH_AIM] 				= walk_crouch
		self.AnimationTranslations[ACT_RUN_AIM] 						= run
		self.AnimationTranslations[ACT_RUN_CROUCH_AIM] 				= run_crouch
		self.AnimationTranslations[ACT_RANGE_ATTACK1] 					= aim
		self.AnimationTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= fire
		self.AnimationTranslations[ACT_RANGE_ATTACK1_LOW] 				= crouch
		self.AnimationTranslations[ACT_RELOAD]							= ACT_RELOAD
		self.AnimationTranslations[ACT_COVER_LOW] 						= crouch
		self.AnimationTranslations[ACT_RELOAD_LOW] 					= crouch
	elseif htype == "2hr" then
		local aim = VJ_SequenceToActivity(self,"2hraim")
		local walk = ACT_GESTURE_RANGE_ATTACK_SMG2
		local walk_crouch = VJ_SequenceToActivity(self,"2hraim_sneak")
		local run = ACT_GESTURE_RANGE_ATTACK_SMG1_LOW
		local run_crouch = VJ_SequenceToActivity(self,"2hraim_sneakfast")
		local fire = VJ_SequenceToActivity(self,"2hrattack4")
		local crouch = VJ_SequenceToActivity(self,"sneak2hraim")
		local reload = "2hrreloadb"

		self.AnimationTranslations[ACT_IDLE_ANGRY] 					= aim
		self.AnimationTranslations[ACT_WALK_AIM] 						= walk
		self.AnimationTranslations[ACT_WALK_CROUCH_AIM] 				= walk_crouch
		self.AnimationTranslations[ACT_RUN_AIM] 						= run
		self.AnimationTranslations[ACT_RUN_CROUCH_AIM] 				= run_crouch
		self.AnimationTranslations[ACT_RANGE_ATTACK1] 					= aim
		self.AnimationTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= fire
		self.AnimationTranslations[ACT_RANGE_ATTACK1_LOW] 				= crouch
		self.AnimationTranslations[ACT_RELOAD]							= "vjges_" .. reload
		self.AnimationTranslations[ACT_COVER_LOW] 						= crouch
		self.AnimationTranslations[ACT_RELOAD_LOW] 					= crouch
	elseif htype == "2hr_bolt" then
		local aim = VJ_SequenceToActivity(self,"2hraim")
		local walk = ACT_GESTURE_RANGE_ATTACK_SMG2
		local walk_crouch = VJ_SequenceToActivity(self,"2hraim_sneak")
		local run = ACT_GESTURE_RANGE_ATTACK_SMG1_LOW
		local run_crouch = VJ_SequenceToActivity(self,"2hraim_sneakfast")
		local fire = VJ_SequenceToActivity(self,"2hrattack3")
		local crouch = VJ_SequenceToActivity(self,"sneak2hraim")
		local reload = "2hrreloada"

		self.AnimationTranslations[ACT_IDLE_ANGRY] 					= aim
		self.AnimationTranslations[ACT_WALK_AIM] 						= walk
		self.AnimationTranslations[ACT_WALK_CROUCH_AIM] 				= walk_crouch
		self.AnimationTranslations[ACT_RUN_AIM] 						= run
		self.AnimationTranslations[ACT_RUN_CROUCH_AIM] 				= run_crouch
		self.AnimationTranslations[ACT_RANGE_ATTACK1] 					= aim
		self.AnimationTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= fire
		self.AnimationTranslations[ACT_RANGE_ATTACK1_LOW] 				= crouch
		self.AnimationTranslations[ACT_RELOAD]							= "vjges_" .. reload
		self.AnimationTranslations[ACT_COVER_LOW] 						= crouch
		self.AnimationTranslations[ACT_RELOAD_LOW] 					= crouch
	end
	self.AnimationTranslations[ACT_WALK_CROUCH] = self.AnimationTranslations[ACT_WALK_CROUCH_AIM]
	self.AnimationTranslations[ACT_RUN_CROUCH] = self.AnimationTranslations[ACT_RUN_CROUCH_AIM]

	if !self.CanHolsterWeapon then
		self.AnimationTranslations[ACT_IDLE] 							= self.AnimationTranslations[ACT_IDLE_ANGRY]
		self.AnimationTranslations[ACT_WALK] 							= self.AnimationTranslations[ACT_WALK_AIM]
		self.AnimationTranslations[ACT_RUN] 							= self.AnimationTranslations[ACT_RUN_AIM]
	end

	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Equip()
	-- self.IsHolstered = false
	self.AnimationTranslations[ACT_IDLE] = self.AnimationTranslations[ACT_IDLE_ANGRY]
	self.AnimationTranslations[ACT_WALK] = self.AnimationTranslations[ACT_WALK_AIM]
	self.AnimationTranslations[ACT_RUN] = self.AnimationTranslations[ACT_RUN_AIM]
	-- self.NextIdleStandTime = 0
	-- self:SetIdleAnimation({ACT_IDLE},true)
	if self:IsMoving() then
		local lastPos = self:GetLastPosition()
		local curSched = self.CurrentSchedule
		local moveType = "TASK_WALK_PATH"
		if curSched != nil && curSched.MoveType == 1 then
			moveType = "TASK_RUN_PATH"
		end
		self:StopMoving()
		self:SetLastPosition(lastPos)
		self:VJ_TASK_GOTO_LASTPOS(moveType,function(x) x.CanShootWhenMoving = true x.ConstantlyFaceEnemy = true end)
	end
	-- self:SetMovementActivity(self:GetActivity() == ACT_RUN && self.AnimationTranslations[ACT_RUN_AIM] or self.AnimationTranslations[ACT_WALK_AIM])
	if IsValid(self:GetActiveWeapon()) then
		self:GetActiveWeapon():SetNoDraw(false)
		if self:GetActiveWeapon().NPC_EquipSound then
			VJ_EmitSound(self:GetActiveWeapon(),self:GetActiveWeapon().NPC_EquipSound,75,100)
		end
	end
	-- print("1")
	self:SetWeaponState(VJ.NPC_WEP_STATE_READY)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Unequip()
	-- self.IsHolstered = true
	self.AnimationTranslations[ACT_IDLE] = ACT_IDLE
	self.AnimationTranslations[ACT_WALK] = ACT_WALK
	self.AnimationTranslations[ACT_RUN] = ACT_RUN
	-- self.NextIdleStandTime = 0
	-- self:SetIdleAnimation({ACT_IDLE},true)
	if self:IsMoving() then
		local lastPos = self:GetLastPosition()
		local curSched = self.CurrentSchedule
		local moveType = "TASK_WALK_PATH"
		if curSched != nil && curSched.MoveType == 1 then
			moveType = "TASK_RUN_PATH"
		end
		self:StopMoving()
		self:SetLastPosition(lastPos)
		self:VJ_TASK_GOTO_LASTPOS(moveType,function(x) x.CanShootWhenMoving = true x.ConstantlyFaceEnemy = true end)
	end
	-- self:SetMovementActivity(self:GetActivity() == self.AnimationTranslations[ACT_RUN_AIM] && ACT_RUN or ACT_WALK)
	if IsValid(self:GetActiveWeapon()) then
		self:GetActiveWeapon():SetNoDraw(true)
		if self:GetActiveWeapon().NPC_UnequipSound then
			VJ_EmitSound(self:GetActiveWeapon(),self:GetActiveWeapon().NPC_UnequipSound,75,100)
		end
	end
	self:SetWeaponState(VJ.NPC_WEP_STATE_HOLSTERED)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:HumanThink() end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert(argent)
	if math.random(1,10) == 1 then
		self:VJ_ACT_PLAYACTIVITY("pointingallert",true,false,true)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnThinkActive()
	self.NextHolsterT = self.NextHolsterT or CurTime()
	if !IsValid(self.VJ_TheController) then
		self:GuardAI()
		if IsValid(self:GetEnemy()) then
			self.NextHolsterT = CurTime() +15
		end
		if self.CanHolsterWeapon then
			if !self.VJ_F3R_InGuardMode then
				if !IsValid(self:GetEnemy()) && self:GetWeaponState() == VJ.NPC_WEP_STATE_READY && CurTime() > self.NextHolsterT && self.CanHolsterWeapon == true then
					self:Unequip()
					-- self.NextHolsterT = CurTime() +5
				elseif IsValid(self:GetEnemy()) && self:GetWeaponState() == VJ.NPC_WEP_STATE_HOLSTERED then
					self:Equip()
				end
			elseif self:GetWeaponState() == VJ.NPC_WEP_STATE_HOLSTERED && self.VJ_F3R_InGuardMode then
				self:Equip()
			end
		end
	else
		if self.VJ_TheController:KeyDown(IN_RELOAD) then
			local wep = self:GetActiveWeapon()
			if wep:Clip1() < wep.Primary.ClipSize then return end
			if CurTime() < self.NextHolsterT then return end
			if self:GetWeaponState() == VJ.NPC_WEP_STATE_HOLSTERED then
				self:Equip()
			else
				self:Unequip()
			end
			self.NextHolsterT = CurTime() +2
		end
	end
	if self.NPC_NextMouthMove > CurTime() then
		self.NPC_NextMouthDistance = Lerp(FrameTime() *30,self:GetMouth(),math.random(-20,90))
		self:SetMouth(self.NPC_NextMouthDistance)
	else
		if self:GetMouth() != 0 then
			self.NPC_NextMouthDistance = math.Round(Lerp(FrameTime() *30,self:GetMouth(),0))
			self:SetMouth(0)
		end
	end
	-- if self.Human_IsAggressive && !IsValid(self:GetEnemy()) then
		-- if CurTime() > self.NextCheckForPlayersT then
			-- local entities = ents.FindInSphere(self:GetPos(),200)
			-- for _,v in ipairs(entities) do
				-- if v:IsPlayer() then
					-- if v.VJ_Fallout_StandingCloseT == nil then v.VJ_Fallout_StandingCloseT = CurTime() end
					-- v.VJ_Fallout_StandingCloseT = v.VJ_Fallout_StandingCloseT +0.55
					-- print(v.VJ_Fallout_StandingCloseT)
					-- if v.VJ_Fallout_StandingCloseT >= CurTime() +8 then
						-- self:StopMoving()
						-- self:SetTarget(v)
						-- self:VJ_TASK_FACE_X("TASK_FACE_TARGET")
						-- v.VJ_Fallout_StandingCloseT = CurTime()
						-- timer.Simple(1,function()
							-- if IsValid(self) then
								-- if !IsValid(self:GetEnemy()) && IsValid(v) then
									-- self:SetEnemy(v)
									-- self:VJ_ACT_PLAYACTIVITY(ACT_MP_GESTURE_VC_FINGERPOINT,true,false,true)
								-- end
							-- end
						-- end)
					-- end
				-- end
			-- end
			-- self.NextCheckForPlayersT = CurTime() +5
		-- end
	-- end
	self:ItemThink()
	self:HumanThink()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,GetCorpse)
	GetCorpse.tbl_Inventory = self.tbl_Inventory

	GetCorpse:SetMaterial(" ")
	self:SetupApparel(GetCorpse)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MeleeAttackCode()
	if self.Dead == true or /*self.vACT_StopAttacks == true or*/ self.Flinching == true or self.ThrowingGrenade == true then return end
	if self.StopMeleeAttackAfterFirstHit == true && self.AlreadyDoneMeleeAttackFirstHit == true then return end
	if /*self.VJ_IsBeingControlled == false &&*/ self.MeleeAttackAnimationFaceEnemy == true then self:FaceCertainEntity(self:GetEnemy(),true) end
	//self.MeleeAttacking = true
	local FindEnts = ents.FindInSphere(self:GetMeleeAttackDamageOrigin(),self.MeleeAttackDamageDistance)
	local hitentity = false
	local HasHitNonPropEnt = false
	if FindEnts != nil then
		for _,v in pairs(FindEnts) do
			if (self.VJ_IsBeingControlled == true && self.VJ_TheControllerBullseye == v) or (v:IsPlayer() && v.IsControlingNPC == true) then continue end
			if (v:IsNPC() or (v:IsPlayer() && v:Alive() && GetConVar("ai_ignoreplayers"):GetInt() == 0)) && (self:Disposition(v) != D_LI) && (v != self) && (v:GetClass() != self:GetClass()) or (v:GetClass() == "prop_physics") or v:GetClass() == "func_breakable_surf" or v:GetClass() == "func_breakable" && (self:GetSightDirection():Dot((v:GetPos() -self:GetPos()):GetNormalized()) > math.cos(math.rad(self.MeleeAttackDamageAngleRadius))) then
				local doactualdmg = DamageInfo()
				doactualdmg:SetDamage(self:VJ_GetDifficultyValue(self.MeleeAttackDamage))
				if v:IsNPC() or v:IsPlayer() then doactualdmg:SetDamageForce(self:GetForward()*((doactualdmg:GetDamage()+100)*70)) end
				doactualdmg:SetInflictor(self)
				doactualdmg:SetAttacker(self)
				v:TakeDamageInfo(doactualdmg, self)
				if v:IsPlayer() then
					v:ViewPunch(Angle(math.random(-1,1)*10,math.random(-1,1)*10,math.random(-1,1)*10))
				end
				VJ_DestroyCombineTurret(self,v)
				if v:GetClass() != "prop_physics" then HasHitNonPropEnt = true end
				if v:GetClass() == "prop_physics" && HasHitNonPropEnt == false then
					//if VJ_HasValue(self.EntitiesToDestoryModel,v:GetModel()) or VJ_HasValue(self.EntitiesToPushModel,v:GetModel()) then
					//hitentity = true else hitentity = false end
					hitentity = false
				else
					hitentity = true
				end
			end
		end
	end
	if hitentity == true then
		self:PlaySoundSystem("MeleeAttack")
		if self.StopMeleeAttackAfterFirstHit == true then self.AlreadyDoneMeleeAttackFirstHit = true /*self:StopMoving()*/ end
	else
		self:CustomOnMeleeAttack_Miss()
		self:PlaySoundSystem("MeleeAttackMiss", {}, VJ_EmitSound)
	end
	if self.AlreadyDoneFirstMeleeAttack == false && self.TimeUntilMeleeAttackDamage != false then
		self:MeleeAttackCode_DoFinishTimers()
	end
	self.AlreadyDoneFirstMeleeAttack = true
end
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/