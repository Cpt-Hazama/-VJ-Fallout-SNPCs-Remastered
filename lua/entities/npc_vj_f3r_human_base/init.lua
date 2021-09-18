AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
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

ENT.HasOnPlayerSight = true -- Should do something when it sees the enemy? Example: Play a sound
ENT.OnPlayerSightDistance = 200 -- How close should the player be until it runs the code?
ENT.OnPlayerSightOnlyOnce = false -- Should it only run the code once?
ENT.OnPlayerSightNextTime1 = 20 -- How much time should it pass until it runs the code again? | First number in math.random
ENT.OnPlayerSightNextTime2 = 30 -- How much time should it pass until it runs the code again? | Second number in math.random

ENT.FootStepTimeRun = 0.3
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
ENT.NextMoveAfterFlinchTime = "LetBaseDecide" -- How much time until it can move, attack, etc. | Use this for schedules or else the base will set the time 0.6 if it sees it's a schedule!
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
				self:AddApparel(ent,VJ_PICKRANDOMTABLE(self.tbl_ApparelModels))
			end
		end
		if #self.tbl_HairModels > 0 then
			if self.CantHaveHairWithApparel && self.HasApparel then return end
			if math.random(1,self.SpawnWithHairChance) == 1 then
				self:AddApparel(ent,VJ_PICKRANDOMTABLE(self.tbl_HairModels),true,self.HairColor)
			end
		end
		if #self.tbl_BeardModels > 0 then
			if math.random(1,self.SpawnWithBeardChance) == 1 then
				self:AddApparel(ent,VJ_PICKRANDOMTABLE(self.tbl_BeardModels),true,self.HairColor)
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
		if !self.IsHolstered && IsValid(self:GetActiveWeapon()) then
			self:GetActiveWeapon():SetNoDraw(true)
			if self:GetActiveWeapon().NPC_UnequipSound then
				VJ_EmitSound(self:GetActiveWeapon(),self:GetActiveWeapon().NPC_UnequipSound,75,100)
			end
		end
		timer.Simple(self:DecideAnimationLength(ACT_MP_GESTURE_VC_NODNO,false),function()
			if IsValid(self) && !self.IsHolstered && IsValid(self:GetActiveWeapon()) then
				self:GetActiveWeapon():SetNoDraw(false)
				if self:GetActiveWeapon().NPC_EquipSound then
					VJ_EmitSound(self:GetActiveWeapon(),self:GetActiveWeapon().NPC_EquipSound,75,100)
				end
			end
		end)
	end
	if self.VJ_F3R_InGuardMode then
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
function ENT:CustomOnInitialize()
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
					if !IsValid(self:GetEnemy()) && !self.IsHolstered then
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
function ENT:CustomOnSetupWeaponHoldTypeAnims(htype)
	self.WeaponAnimTranslations[ACT_IDLE] 							= ACT_IDLE
	self.WeaponAnimTranslations[ACT_WALK] 							= ACT_WALK
	self.WeaponAnimTranslations[ACT_RUN] 							= ACT_RUN
	if htype == "1gt" then
		local aim = VJ_SequenceToActivity(self,"1gtaim")
		local walk = VJ_SequenceToActivity(self,"1gtaim_walk")
		local walk_crouch = VJ_SequenceToActivity(self,"1gtaim_sneak")
		local run = VJ_SequenceToActivity(self,"1gtaim_run")
		local run_crouch = VJ_SequenceToActivity(self,"1gtaim_sneakfast")
		local fire = VJ_SequenceToActivity(self,"1gtattackthrow")
		local crouch = VJ_SequenceToActivity(self,"sneak1gtaim")
		local reload = "1gtequip"

		self.WeaponAnimTranslations[ACT_IDLE_ANGRY] 					= aim
		self.WeaponAnimTranslations[ACT_WALK_AIM] 						= walk
		self.WeaponAnimTranslations[ACT_WALK_CROUCH_AIM] 				= walk_crouch
		self.WeaponAnimTranslations[ACT_RUN_AIM] 						= run
		self.WeaponAnimTranslations[ACT_RUN_CROUCH_AIM] 				= run_crouch
		self.WeaponAnimTranslations[ACT_RANGE_ATTACK1] 					= aim
		self.WeaponAnimTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= fire
		self.WeaponAnimTranslations[ACT_RANGE_ATTACK1_LOW] 				= crouch
		self.WeaponAnimTranslations[ACT_RELOAD]							= "vjges_" .. reload
		self.WeaponAnimTranslations[ACT_COVER_LOW] 						= crouch
		self.WeaponAnimTranslations[ACT_RELOAD_LOW] 					= crouch
	elseif htype == "1hp" then
		local aim = VJ_SequenceToActivity(self,"1hpaim")
		local walk = VJ_SequenceToActivity(self,"1hpaim_walk")
		local walk_crouch = VJ_SequenceToActivity(self,"1hpaim_sneak")
		local run = VJ_SequenceToActivity(self,"1hpaim_run")
		local run_crouch = VJ_SequenceToActivity(self,"1hpaim_sneakfast")
		local fire = VJ_SequenceToActivity(self,"1hpattackright")
		local crouch = VJ_SequenceToActivity(self,"sneak1hpaim")
		local reload = "1hpreloada"

		self.WeaponAnimTranslations[ACT_IDLE_ANGRY] 					= aim
		self.WeaponAnimTranslations[ACT_WALK_AIM] 						= walk
		self.WeaponAnimTranslations[ACT_WALK_CROUCH_AIM] 				= walk_crouch
		self.WeaponAnimTranslations[ACT_RUN_AIM] 						= run
		self.WeaponAnimTranslations[ACT_RUN_CROUCH_AIM] 				= run_crouch
		self.WeaponAnimTranslations[ACT_RANGE_ATTACK1] 					= aim
		self.WeaponAnimTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= fire
		self.WeaponAnimTranslations[ACT_RANGE_ATTACK1_LOW] 				= crouch
		self.WeaponAnimTranslations[ACT_RELOAD]							= "vjges_" .. reload
		self.WeaponAnimTranslations[ACT_COVER_LOW] 						= crouch
		self.WeaponAnimTranslations[ACT_RELOAD_LOW] 					= crouch
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

		self.WeaponAnimTranslations[ACT_IDLE_ANGRY] 					= aim
		self.WeaponAnimTranslations[ACT_WALK_AIM] 						= walk
		self.WeaponAnimTranslations[ACT_WALK_CROUCH_AIM] 				= walk_crouch
		self.WeaponAnimTranslations[ACT_RUN_AIM] 						= run
		self.WeaponAnimTranslations[ACT_RUN_CROUCH_AIM] 				= run_crouch
		self.WeaponAnimTranslations[ACT_RANGE_ATTACK1] 					= aim
		self.WeaponAnimTranslations[ACT_RANGE_ATTACK2] 					= fire2
		self.WeaponAnimTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= fire
		self.WeaponAnimTranslations[ACT_RANGE_ATTACK1_LOW] 				= crouch
		self.WeaponAnimTranslations[ACT_RELOAD]							= "vjges_" .. reload
		self.WeaponAnimTranslations[ACT_COVER_LOW] 						= crouch
		self.WeaponAnimTranslations[ACT_RELOAD_LOW] 					= crouch
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

		self.WeaponAnimTranslations[ACT_IDLE_ANGRY] 					= aim
		self.WeaponAnimTranslations[ACT_WALK_AIM] 						= walk
		self.WeaponAnimTranslations[ACT_WALK_CROUCH_AIM] 				= walk_crouch
		self.WeaponAnimTranslations[ACT_RUN_AIM] 						= run
		self.WeaponAnimTranslations[ACT_RUN_CROUCH_AIM] 				= run_crouch
		self.WeaponAnimTranslations[ACT_RANGE_ATTACK1] 					= aim
		self.WeaponAnimTranslations[ACT_RANGE_ATTACK2] 					= fire2
		self.WeaponAnimTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= fire
		self.WeaponAnimTranslations[ACT_RANGE_ATTACK1_LOW] 				= crouch
		self.WeaponAnimTranslations[ACT_RELOAD]							= "vjges_" .. reload
		self.WeaponAnimTranslations[ACT_COVER_LOW] 						= crouch
		self.WeaponAnimTranslations[ACT_RELOAD_LOW] 					= crouch
	elseif htype == "2ha" then
		local aim = VJ_SequenceToActivity(self,"2haaim")
		local walk = VJ_SequenceToActivity(self,"2haaim_walk")
		local walk_crouch = VJ_SequenceToActivity(self,"2haaim_sneak")
		local run = VJ_SequenceToActivity(self,"2haaim_run")
		local run_crouch = VJ_SequenceToActivity(self,"2haaim_sneakfast")
		local fire = VJ_SequenceToActivity(self,"2haattackloop")
		local crouch = VJ_SequenceToActivity(self,"sneak2hraim")
		local reload = "2hareloada"

		self.WeaponAnimTranslations[ACT_IDLE_ANGRY] 					= aim
		self.WeaponAnimTranslations[ACT_WALK_AIM] 						= walk
		self.WeaponAnimTranslations[ACT_WALK_CROUCH_AIM] 				= walk_crouch
		self.WeaponAnimTranslations[ACT_RUN_AIM] 						= run
		self.WeaponAnimTranslations[ACT_RUN_CROUCH_AIM] 				= run_crouch
		self.WeaponAnimTranslations[ACT_RANGE_ATTACK1] 					= aim
		self.WeaponAnimTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= fire
		self.WeaponAnimTranslations[ACT_RANGE_ATTACK1_LOW] 				= crouch
		self.WeaponAnimTranslations[ACT_RELOAD]							= "vjges_" .. reload
		self.WeaponAnimTranslations[ACT_COVER_LOW] 						= crouch
		self.WeaponAnimTranslations[ACT_RELOAD_LOW] 					= crouch
	elseif htype == "2hh" then
		local aim = VJ_SequenceToActivity(self,"2hhaim")
		local walk = VJ_SequenceToActivity(self,"2hhaim_walk")
		local walk_crouch = VJ_SequenceToActivity(self,"2hhaim_sneak")
		local run = VJ_SequenceToActivity(self,"2hhaim_run")
		local run_crouch = VJ_SequenceToActivity(self,"2hhaim_sneakfast")
		local fire = VJ_SequenceToActivity(self,"2hhattackloop")
		local crouch = VJ_SequenceToActivity(self,"sneak2hhaim")
		local reload = "2hhreloade"

		self.WeaponAnimTranslations[ACT_IDLE_ANGRY] 					= aim
		self.WeaponAnimTranslations[ACT_WALK_AIM] 						= walk
		self.WeaponAnimTranslations[ACT_WALK_CROUCH_AIM] 				= walk_crouch
		self.WeaponAnimTranslations[ACT_RUN_AIM] 						= run
		self.WeaponAnimTranslations[ACT_RUN_CROUCH_AIM] 				= run_crouch
		self.WeaponAnimTranslations[ACT_RANGE_ATTACK1] 					= aim
		self.WeaponAnimTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= fire
		self.WeaponAnimTranslations[ACT_RANGE_ATTACK1_LOW] 				= crouch
		self.WeaponAnimTranslations[ACT_RELOAD]							= "vjges_" .. reload
		self.WeaponAnimTranslations[ACT_COVER_LOW] 						= crouch
		self.WeaponAnimTranslations[ACT_RELOAD_LOW] 					= crouch
	elseif htype == "2hl" then
		local aim = VJ_SequenceToActivity(self,"2hlaim")
		local walk = VJ_SequenceToActivity(self,"2hlaim_walk")
		local walk_crouch = VJ_SequenceToActivity(self,"2hlaim_sneak")
		local run = VJ_SequenceToActivity(self,"2hlaim_run")
		local run_crouch = VJ_SequenceToActivity(self,"2hlaim_sneakfast")
		local fire = VJ_SequenceToActivity(self,"2hlattack3")
		local crouch = VJ_SequenceToActivity(self,"sneak2hlaim")
		local reload = "2hlreloade"

		self.WeaponAnimTranslations[ACT_IDLE_ANGRY] 					= aim
		self.WeaponAnimTranslations[ACT_WALK_AIM] 						= walk
		self.WeaponAnimTranslations[ACT_WALK_CROUCH_AIM] 				= walk_crouch
		self.WeaponAnimTranslations[ACT_RUN_AIM] 						= run
		self.WeaponAnimTranslations[ACT_RUN_CROUCH_AIM] 				= run_crouch
		self.WeaponAnimTranslations[ACT_RANGE_ATTACK1] 					= aim
		self.WeaponAnimTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= fire
		self.WeaponAnimTranslations[ACT_RANGE_ATTACK1_LOW] 				= crouch
		self.WeaponAnimTranslations[ACT_RELOAD]							= "vjges_" .. reload
		self.WeaponAnimTranslations[ACT_COVER_LOW] 						= crouch
		self.WeaponAnimTranslations[ACT_RELOAD_LOW] 					= crouch
	elseif htype == "2hm" then
		local aim = VJ_SequenceToActivity(self,"2hmaim")
		local walk = VJ_SequenceToActivity(self,"2hmaim_walk")
		local walk_crouch = VJ_SequenceToActivity(self,"2hmaim_sneak")
		local run = VJ_SequenceToActivity(self,"2hmaim_run")
		local run_crouch = VJ_SequenceToActivity(self,"2hmaim_sneakfast")
		local fire = VJ_SequenceToActivity(self,"2hmattackleft_a")
		local crouch = VJ_SequenceToActivity(self,"sneak2hmaim")

		self.WeaponAnimTranslations[ACT_IDLE_ANGRY] 					= aim
		self.WeaponAnimTranslations[ACT_WALK_AIM] 						= walk
		self.WeaponAnimTranslations[ACT_WALK_CROUCH_AIM] 				= walk_crouch
		self.WeaponAnimTranslations[ACT_RUN_AIM] 						= run
		self.WeaponAnimTranslations[ACT_RUN_CROUCH_AIM] 				= run_crouch
		self.WeaponAnimTranslations[ACT_RANGE_ATTACK1] 					= aim
		self.WeaponAnimTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= fire
		self.WeaponAnimTranslations[ACT_RANGE_ATTACK1_LOW] 				= crouch
		self.WeaponAnimTranslations[ACT_RELOAD]							= ACT_RELOAD
		self.WeaponAnimTranslations[ACT_COVER_LOW] 						= crouch
		self.WeaponAnimTranslations[ACT_RELOAD_LOW] 					= crouch
	elseif htype == "2hr" then
		local aim = VJ_SequenceToActivity(self,"2hraim")
		local walk = ACT_GESTURE_RANGE_ATTACK_SMG2
		local walk_crouch = VJ_SequenceToActivity(self,"2hraim_sneak")
		local run = ACT_GESTURE_RANGE_ATTACK_SMG1_LOW
		local run_crouch = VJ_SequenceToActivity(self,"2hraim_sneakfast")
		local fire = VJ_SequenceToActivity(self,"2hrattack4")
		local crouch = VJ_SequenceToActivity(self,"sneak2hraim")
		local reload = "2hrreloadb"

		self.WeaponAnimTranslations[ACT_IDLE_ANGRY] 					= aim
		self.WeaponAnimTranslations[ACT_WALK_AIM] 						= walk
		self.WeaponAnimTranslations[ACT_WALK_CROUCH_AIM] 				= walk_crouch
		self.WeaponAnimTranslations[ACT_RUN_AIM] 						= run
		self.WeaponAnimTranslations[ACT_RUN_CROUCH_AIM] 				= run_crouch
		self.WeaponAnimTranslations[ACT_RANGE_ATTACK1] 					= aim
		self.WeaponAnimTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= fire
		self.WeaponAnimTranslations[ACT_RANGE_ATTACK1_LOW] 				= crouch
		self.WeaponAnimTranslations[ACT_RELOAD]							= "vjges_" .. reload
		self.WeaponAnimTranslations[ACT_COVER_LOW] 						= crouch
		self.WeaponAnimTranslations[ACT_RELOAD_LOW] 					= crouch
	elseif htype == "2hr_bolt" then
		local aim = VJ_SequenceToActivity(self,"2hraim")
		local walk = ACT_GESTURE_RANGE_ATTACK_SMG2
		local walk_crouch = VJ_SequenceToActivity(self,"2hraim_sneak")
		local run = ACT_GESTURE_RANGE_ATTACK_SMG1_LOW
		local run_crouch = VJ_SequenceToActivity(self,"2hraim_sneakfast")
		local fire = VJ_SequenceToActivity(self,"2hrattack3")
		local crouch = VJ_SequenceToActivity(self,"sneak2hraim")
		local reload = "2hrreloada"

		self.WeaponAnimTranslations[ACT_IDLE_ANGRY] 					= aim
		self.WeaponAnimTranslations[ACT_WALK_AIM] 						= walk
		self.WeaponAnimTranslations[ACT_WALK_CROUCH_AIM] 				= walk_crouch
		self.WeaponAnimTranslations[ACT_RUN_AIM] 						= run
		self.WeaponAnimTranslations[ACT_RUN_CROUCH_AIM] 				= run_crouch
		self.WeaponAnimTranslations[ACT_RANGE_ATTACK1] 					= aim
		self.WeaponAnimTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= fire
		self.WeaponAnimTranslations[ACT_RANGE_ATTACK1_LOW] 				= crouch
		self.WeaponAnimTranslations[ACT_RELOAD]							= "vjges_" .. reload
		self.WeaponAnimTranslations[ACT_COVER_LOW] 						= crouch
		self.WeaponAnimTranslations[ACT_RELOAD_LOW] 					= crouch
	end
	self.WeaponAnimTranslations[ACT_WALK_CROUCH] = self.WeaponAnimTranslations[ACT_WALK_CROUCH_AIM]
	self.WeaponAnimTranslations[ACT_RUN_CROUCH] = self.WeaponAnimTranslations[ACT_RUN_CROUCH_AIM]

	if !self.CanHolsterWeapon then
		self.WeaponAnimTranslations[ACT_IDLE] 							= self.WeaponAnimTranslations[ACT_IDLE_ANGRY]
		self.WeaponAnimTranslations[ACT_WALK] 							= self.WeaponAnimTranslations[ACT_WALK_AIM]
		self.WeaponAnimTranslations[ACT_RUN] 							= self.WeaponAnimTranslations[ACT_RUN_AIM]
	end

	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetupHoldTypes(wep,htype)
	/*
		1gt - grenade
		2ha - automatic rifles?
		2hh - minigun
		2hl - rpg
		2hm - 2hand melee
		2hr - rifles?
		h2h - melee
	*/
	if htype == "1gt" then
		self.AnimTbl_IdleStand = {VJ_SequenceToActivity(self,"1gtaim")}
		self.AnimTbl_Walk = {VJ_SequenceToActivity(self,"1gtaim_walk")}
		self.AnimTbl_Run = {VJ_SequenceToActivity(self,"1gtaim_run")}
		self.AnimTbl_WeaponAttack = self.AnimTbl_IdleStand
		self.AnimTbl_WeaponAttackFiringGesture = {"1gtattackthrow"}
		self.AnimTbl_ShootWhileMovingRun = self.AnimTbl_Run
		self.AnimTbl_ShootWhileMovingWalk = self.AnimTbl_Walk
		self.AnimTbl_WeaponReload = {}
		self.AnimTbl_AlertFriendsOnDeath = self.AnimTbl_IdleStand
		self.AnimTbl_CustomWaitForEnemyToComeOut = self.AnimTbl_IdleStand
	elseif htype == "1hp" then
		self.AnimTbl_IdleStand = {VJ_SequenceToActivity(self,"1hpaim")}
		self.AnimTbl_Walk = {VJ_SequenceToActivity(self,"1hpaim_walk")}
		self.AnimTbl_Run = {VJ_SequenceToActivity(self,"1hpaim_run")}
		self.AnimTbl_WeaponAttack = self.AnimTbl_IdleStand
		self.AnimTbl_WeaponAttackFiringGesture = {"1hpattackright"}
		self.AnimTbl_ShootWhileMovingRun = self.AnimTbl_Run
		self.AnimTbl_ShootWhileMovingWalk = self.AnimTbl_Walk
		self.AnimTbl_WeaponReload = {"vjges_1hpreloada"}
		self.AnimTbl_AlertFriendsOnDeath = self.AnimTbl_IdleStand
		self.AnimTbl_CustomWaitForEnemyToComeOut = self.AnimTbl_IdleStand
	elseif htype == "2ha" then
		self.AnimTbl_IdleStand = {VJ_SequenceToActivity(self,"2haaim")}
		self.AnimTbl_Walk = {VJ_SequenceToActivity(self,"2haaim_walk")}
		self.AnimTbl_Run = {VJ_SequenceToActivity(self,"2haaim_run")}
		self.AnimTbl_WeaponAttack = self.AnimTbl_IdleStand
		self.AnimTbl_WeaponAttackFiringGesture = {"2haattackloop"}
		self.AnimTbl_ShootWhileMovingRun = self.AnimTbl_Run
		self.AnimTbl_ShootWhileMovingWalk = self.AnimTbl_Walk
		self.AnimTbl_WeaponReload = {"vjges_2hareloada"}
		self.AnimTbl_AlertFriendsOnDeath = self.AnimTbl_IdleStand
		self.AnimTbl_CustomWaitForEnemyToComeOut = self.AnimTbl_IdleStand
	elseif htype == "2hh" then
		self.AnimTbl_IdleStand = {VJ_SequenceToActivity(self,"2hhaim")}
		self.AnimTbl_Walk = {VJ_SequenceToActivity(self,"2hhaim_walk")}
		self.AnimTbl_Run = {VJ_SequenceToActivity(self,"2hhaim_run")}
		self.AnimTbl_WeaponAttack = self.AnimTbl_IdleStand
		self.AnimTbl_WeaponAttackFiringGesture = {"2hhattackloop"}
		self.AnimTbl_ShootWhileMovingRun = self.AnimTbl_Run
		self.AnimTbl_ShootWhileMovingWalk = self.AnimTbl_Walk
		self.AnimTbl_WeaponReload = {"vjges_2hhreloade"}
		self.AnimTbl_AlertFriendsOnDeath = self.AnimTbl_IdleStand
		self.AnimTbl_CustomWaitForEnemyToComeOut = self.AnimTbl_IdleStand
	elseif htype == "2hl" then
		self.AnimTbl_IdleStand = {VJ_SequenceToActivity(self,"2hlaim")}
		self.AnimTbl_Walk = {VJ_SequenceToActivity(self,"2hlaim_walk")}
		self.AnimTbl_Run = {VJ_SequenceToActivity(self,"2hlaim_run")}
		self.AnimTbl_WeaponAttack = self.AnimTbl_IdleStand
		self.AnimTbl_WeaponAttackFiringGesture = {"2hlattack3"}
		self.AnimTbl_ShootWhileMovingRun = self.AnimTbl_Run
		self.AnimTbl_ShootWhileMovingWalk = self.AnimTbl_Walk
		self.AnimTbl_WeaponReload = {"vjges_2hlreloade"}
		self.AnimTbl_AlertFriendsOnDeath = self.AnimTbl_IdleStand
		self.AnimTbl_CustomWaitForEnemyToComeOut = self.AnimTbl_IdleStand
	elseif htype == "2hm" then
		self.AnimTbl_IdleStand = {VJ_SequenceToActivity(self,"2hmaim")}
		self.AnimTbl_Walk = {VJ_SequenceToActivity(self,"2hmaim_walk")}
		self.AnimTbl_Run = {VJ_SequenceToActivity(self,"2hmaim_run")}
		self.AnimTbl_WeaponAttack = self.AnimTbl_IdleStand
		self.AnimTbl_WeaponAttackFiringGesture = {"2hmattackleft_a","2hmattackpower","2hmattackright_a","2hmattackright_b"}
		self.AnimTbl_ShootWhileMovingRun = self.AnimTbl_Run
		self.AnimTbl_ShootWhileMovingWalk = self.AnimTbl_Walk
		self.AnimTbl_WeaponReload = {}
		self.AnimTbl_AlertFriendsOnDeath = self.AnimTbl_IdleStand
		self.AnimTbl_CustomWaitForEnemyToComeOut = self.AnimTbl_IdleStand
	elseif htype == "2hr" then
		self.AnimTbl_IdleStand = {VJ_SequenceToActivity(self,"2hraim")}
		self.AnimTbl_Walk = {ACT_GESTURE_RANGE_ATTACK_SMG2}
		self.AnimTbl_Run = {ACT_GESTURE_RANGE_ATTACK_SMG1_LOW}
		self.AnimTbl_WeaponAttack = self.AnimTbl_IdleStand
		self.AnimTbl_WeaponAttackFiringGesture = {"2hrattack4"}
		self.AnimTbl_ShootWhileMovingRun = self.AnimTbl_Run
		self.AnimTbl_ShootWhileMovingWalk = self.AnimTbl_Walk
		self.AnimTbl_WeaponReload = {"vjges_2hrreloadb"}
		self.AnimTbl_AlertFriendsOnDeath = self.AnimTbl_IdleStand
		self.AnimTbl_CustomWaitForEnemyToComeOut = self.AnimTbl_IdleStand
	elseif htype == "2hr_bolt" then
		self.AnimTbl_IdleStand = {VJ_SequenceToActivity(self,"2hraim")}
		self.AnimTbl_Walk = {ACT_GESTURE_RANGE_ATTACK_SMG2}
		self.AnimTbl_Run = {ACT_GESTURE_RANGE_ATTACK_SMG1_LOW}
		self.AnimTbl_WeaponAttack = self.AnimTbl_IdleStand
		self.AnimTbl_WeaponAttackFiringGesture = {"2hrattack3"}
		self.AnimTbl_ShootWhileMovingRun = self.AnimTbl_Run
		self.AnimTbl_ShootWhileMovingWalk = self.AnimTbl_Walk
		self.AnimTbl_WeaponReload = {"vjges_2hrreloada"}
		self.AnimTbl_AlertFriendsOnDeath = self.AnimTbl_IdleStand
		self.AnimTbl_CustomWaitForEnemyToComeOut = self.AnimTbl_IdleStand
	elseif htype == "h2h" then
		self.AnimTbl_IdleStand = {VJ_SequenceToActivity(self,"h2haim")}
		self.AnimTbl_Walk = {VJ_SequenceToActivity(self,"h2haim_walk")}
		self.AnimTbl_Run = {VJ_SequenceToActivity(self,"h2haim_run")}
		self.AnimTbl_WeaponAttack = self.AnimTbl_IdleStand
		self.AnimTbl_WeaponAttackFiringGesture = {"h2hattackleft_a","h2hattackleft_b","h2hattackleftpower","h2hattackright_a","h2hattackright_b","h2hattackrightpower"}
		self.AnimTbl_ShootWhileMovingRun = self.AnimTbl_Run
		self.AnimTbl_ShootWhileMovingWalk = self.AnimTbl_Walk
		self.AnimTbl_WeaponReload = {}
		self.AnimTbl_AlertFriendsOnDeath = self.AnimTbl_IdleStand
		self.AnimTbl_CustomWaitForEnemyToComeOut = self.AnimTbl_IdleStand
	end
	-- table.insert(wep.NPC_AnimationTbl_Custom,self.AnimTbl_IdleStand[1])
	-- table.insert(wep.NPC_AnimationTbl_Custom,self.AnimTbl_Walk[1])
	-- table.insert(wep.NPC_AnimationTbl_Custom,self.AnimTbl_Run[1])
	-- if #self.AnimTbl_WeaponReload > 0 then table.insert(wep.NPC_ReloadAnimationTbl_Custom,VJ_SequenceToActivity(self,string.Replace(self.AnimTbl_WeaponReload[1],"vjges_ ",""))) end
	-- table.insert(self.CustomWalkActivites,self.AnimTbl_Walk[1])
	-- table.insert(self.CustomRunActivites,self.AnimTbl_Run[1])
	if self.CanHolsterWeapon && !self.VJ_F3R_InGuardMode then
		if !IsValid(self:GetEnemy()) && !self.IsHolstered then
			self:Unequip()
		end
	end
	print("2")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Equip()
	self.IsHolstered = false
	self.WeaponAnimTranslations[ACT_IDLE] = self.WeaponAnimTranslations[ACT_IDLE_ANGRY]
	self.WeaponAnimTranslations[ACT_WALK] = self.WeaponAnimTranslations[ACT_WALK_AIM]
	self.WeaponAnimTranslations[ACT_RUN] = self.WeaponAnimTranslations[ACT_RUN_AIM]
	self.NextIdleStandTime = 0
	if IsValid(self:GetActiveWeapon()) then
		self:GetActiveWeapon():SetNoDraw(false)
		if self:GetActiveWeapon().NPC_EquipSound then
			VJ_EmitSound(self:GetActiveWeapon(),self:GetActiveWeapon().NPC_EquipSound,75,100)
		end
	end
	print("1")
	self:SetWeaponState(VJ_WEP_STATE_NONE)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Unequip()
	self.IsHolstered = true
	self.WeaponAnimTranslations[ACT_IDLE] = ACT_IDLE
	self.WeaponAnimTranslations[ACT_WALK] = ACT_WALK
	self.WeaponAnimTranslations[ACT_RUN] = ACT_RUN
	self.NextIdleStandTime = 0
	if IsValid(self:GetActiveWeapon()) then
		self:GetActiveWeapon():SetNoDraw(true)
		if self:GetActiveWeapon().NPC_UnequipSound then
			VJ_EmitSound(self:GetActiveWeapon(),self:GetActiveWeapon().NPC_UnequipSound,75,100)
		end
	end
	self:SetWeaponState(VJ_WEP_STATE_HOLSTERED)
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
function ENT:CustomOnThink()
	self.NextHolsterT = self.NextHolsterT or CurTime()
	if !IsValid(self.VJ_TheController) then
		self:GuardAI()
		if IsValid(self:GetEnemy()) then
			self.NextHolsterT = CurTime() +15
		end
		if self.CanHolsterWeapon then
			if !self.VJ_F3R_InGuardMode then
				if !IsValid(self:GetEnemy()) && !self.IsHolstered && CurTime() > self.NextHolsterT && self.CanHolsterWeapon == true then
					self:Unequip()
					-- self.NextHolsterT = CurTime() +5
				elseif IsValid(self:GetEnemy()) && self.IsHolstered then
					self:Equip()
				end
			elseif self.IsHolstered && self.VJ_F3R_InGuardMode then
				self:Equip()
			end
		end
	else
		if self.VJ_TheController:KeyDown(IN_RELOAD) then
			local wep = self:GetActiveWeapon()
			if wep:Clip1() < wep.Primary.ClipSize then return end
			if CurTime() < self.NextHolsterT then return end
			if self.IsHolstered then
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
	local FindEnts = ents.FindInSphere(self:SetMeleeAttackDamagePosition(),self.MeleeAttackDamageDistance)
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
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/