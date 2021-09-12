AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/supermutant.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 200
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_FEV_MUTANT"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = false -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {"vjges_h2hattackright_a"} -- Melee Attack Animations
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDamage = 18
ENT.MeleeAttackAnimationAllowOtherTasks = true
ENT.HasGrenadeAttack = false -- Should the SNPC have a grenade attack?
ENT.Immune_AcidPoisonRadiation = true
ENT.DisableFootStepSoundTimer = true
ENT.BecomeEnemyToPlayer = false
ENT.AnimTbl_ShootWhileMovingRun = {ACT_WALK_AIM}

ENT.HasCallForHelpAnimation = false

	-- ====== Animations ====== --
ENT.AnimTbl_TakingCover = {}
ENT.AnimTbl_MoveOrHideOnDamageByEnemy = {}
ENT.AnimTbl_AlertFriendsOnDeath = {}
ENT.AnimTbl_WeaponAttackCrouch = {}
ENT.AnimTbl_WeaponReloadBehindCover = {}
ENT.AnimTbl_ScaredBehaviorStand = {ACT_IDLE}
ENT.AnimTbl_ScaredBehaviorMovement = {ACT_RUN}

	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 15 -- Chance of it flinching from 1 to x | 1 will make it always flinch
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

	-- ====== File Path Variables ====== --
	-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStepL = {
	"vj_fallout/supermutant/foot/supermutant_foot_l01.mp3",
	"vj_fallout/supermutant/foot/supermutant_foot_l02.mp3",
	"vj_fallout/supermutant/foot/supermutant_foot_l03.mp3",
}
ENT.SoundTbl_FootStepR = {
	"vj_fallout/supermutant/foot/supermutant_foot_r01.mp3",
	"vj_fallout/supermutant/foot/supermutant_foot_r02.mp3",
	"vj_fallout/supermutant/foot/supermutant_foot_r03.mp3",
}
ENT.SoundTbl_IdleDialogue = {
	"vj_fallout/supermutant/genericsup_supertalk1_000a4a4a_1.wav",
	"vj_fallout/supermutant/genericsup_supertalk1_000a4a4b_1.wav",
	"vj_fallout/supermutant/genericsup_supertalk1_000a4a4c_1.wav",
	"vj_fallout/supermutant/genericsup_supertalk1_000a4a4d_1.wav",
	"vj_fallout/supermutant/genericsup_supertalk1_000a4a4e_1.wav",
	"vj_fallout/supermutant/genericsup_supertalk1_000a9cf7_1.wav",
	"vj_fallout/supermutant/genericsup_supertalk1_000a9cf8_1.wav",
	"vj_fallout/supermutant/genericsup_supertalk1_000c73bb_1.wav",
}
ENT.SoundTbl_IdleDialogueAnswer = {
	"vj_fallout/supermutant/genericsup_supertalk2_000a4a31_1.wav",
	"vj_fallout/supermutant/genericsup_supertalk2_000a4a32_1.wav",
	"vj_fallout/supermutant/genericsup_supertalk2_000a4a33_1.wav",
	"vj_fallout/supermutant/genericsup_supertalk2_000a4a34_1.wav",
	"vj_fallout/supermutant/genericsup_supertalk2_000a4a35_1.wav",
}
ENT.SoundTbl_Idle = {
	"vj_fallout/supermutant/genericsup_idlechatter_000b3ec6_1.wav",
	"vj_fallout/supermutant/genericsup_idlechatter_000b3ec7_1.wav",
	"vj_fallout/supermutant/genericsup_idlechatter_000b3ec8_1.wav",
	"vj_fallout/supermutant/genericsup_idlechatter_000b3ec9_1.wav",
	"vj_fallout/supermutant/genericsup_idlechatter_000b3eca_1.wav"
}
ENT.SoundTbl_FollowPlayer = {
	"vj_fallout/supermutant/genericsup_supertalk2_000a4a34_1.wav",
	"vj_fallout/supermutant/genericsup_supertalk2_000a4a35_1.wav",
}
ENT.SoundTbl_UnFollowPlayer = {
	"vj_fallout/supermutant/genericsupermutant_goodbye_000a4a3b_1.wav",
	"vj_fallout/supermutant/genericsupermutant_goodbye_000a4a3c_1.wav",
	"vj_fallout/supermutant/genericsupermutant_goodbye_000a4a3d_1.wav",
	"vj_fallout/supermutant/genericsupermutant_goodbye_000a4a3e_1.wav",
	"vj_fallout/supermutant/genericsupermutant_goodbye_000a4a3f_1.wav",
}
ENT.SoundTbl_Investigate = {
	"vj_fallout/supermutant/genericsup_alertidle_000483d7_1.wav",
	"vj_fallout/supermutant/genericsup_alertidle_0006297d_1.wav",
	"vj_fallout/supermutant/genericsup_alertidle_0006297e_1.wav",
	"vj_fallout/supermutant/genericsup_alertidle_0006297f_1.wav",
	"vj_fallout/supermutant/genericsup_alertidle_00062980_1.wav",
	"vj_fallout/supermutant/genericsup_alertidle_00062981_1.wav",
	"vj_fallout/supermutant/genericsup_normaltoalert_000483d9_1.wav",
	"vj_fallout/supermutant/genericsup_normaltoalert_00062982_1.wav",
	"vj_fallout/supermutant/genericsup_normaltoalert_00062983_1.wav",
	"vj_fallout/supermutant/genericsup_normaltoalert_00062984_1.wav",
	"vj_fallout/supermutant/genericsup_normaltoalert_00062985_1.wav",
	"vj_fallout/supermutant/genericsup_normaltoalert_00062986_1.wav",
}
ENT.SoundTbl_OnPlayerSight = {
	"vj_fallout/supermutant/genericsup_greeting_0004f783_1.wav",
	"vj_fallout/supermutant/genericsup_supertalk1_000a9cf8_1.wav",
	"vj_fallout/supermutant/genericsup_supertalk2_000a4a31_1.wav",
	"vj_fallout/supermutant/genericsupermutant_hello_000a4a40_1.wav",
	"vj_fallout/supermutant/genericsupermutant_hello_000a4a41_1.wav",
	"vj_fallout/supermutant/genericsupermutant_hello_000a4a42_1.wav",
	"vj_fallout/supermutant/genericsupermutant_hello_000a4a43_1.wav",
	"vj_fallout/supermutant/genericsupermutant_hello_000a4a44_1.wav",
	"vj_fallout/supermutant/genericsupermutant_hello_000a9cf9_1.wav",
}
ENT.SoundTbl_Suppressing = {
	"vj_fallout/supermutant/genericsup_powerattack_00021808_1.wav",
	"vj_fallout/supermutant/genericsup_powerattack_00021809_1.wav",
	"vj_fallout/supermutant/genericsup_powerattack_00062975_1.wav",
	"vj_fallout/supermutant/genericsup_powerattack_00062976_1.wav",
	"vj_fallout/supermutant/genericsup_powerattack_0006297c_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_000198cd_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_000198ce_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_000198cf_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_0001efae_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_0001efaf_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_0001f937_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_0001f938_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_0001f939_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_0001f93a_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_000217f7_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_000217f8_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_000217f9_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_000217fa_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_000217fb_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_000217fc_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_000217fd_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_000217fe_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_000217ff_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_00029585_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_00029586_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_00029587_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_00029588_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_00029589_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_0002958a_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_0002958b_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_0002958c_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_0002958d_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_0002958e_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_0002958f_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_00029590_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_00029591_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_00029592_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_00029593_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_00029594_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_00029595_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_00029596_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_00029597_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_00029598_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_00029599_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_0002959a_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_0002959b_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_0002959c_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_0002959d_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_0002959e_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_0002959f_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_000295a0_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_000295a1_1.wav",
	"vj_fallout/supermutant/genericsupermutant_attack_000295a2_1.wav",
}
ENT.SoundTbl_Alert = {
	"vj_fallout/supermutant/genericsup_alerttocombat_000483d8_1.wav",
	"vj_fallout/supermutant/genericsup_alerttocombat_0006295f_1.wav",
	"vj_fallout/supermutant/genericsup_alerttocombat_00062960_1.wav",
	"vj_fallout/supermutant/genericsup_alerttocombat_00062961_1.wav",
	"vj_fallout/supermutant/genericsup_alerttocombat_00062962_1.wav",
	"vj_fallout/supermutant/genericsup_alerttocombat_00062963_1.wav",
	"vj_fallout/supermutant/genericsup_losttocombat_000483d4_1.wav",
	"vj_fallout/supermutant/genericsup_losttocombat_00062991_1.wav",
	"vj_fallout/supermutant/genericsup_losttocombat_00062992_1.wav",
	"vj_fallout/supermutant/genericsup_losttocombat_00062993_1.wav",
	"vj_fallout/supermutant/genericsup_losttocombat_00062994_1.wav",
	"vj_fallout/supermutant/genericsup_losttocombat_00062995_1.wav",
	"vj_fallout/supermutant/genericsup_normaltocombat_000483db_1.wav",
	"vj_fallout/supermutant/genericsup_normaltocombat_000483dc_1.wav",
	"vj_fallout/supermutant/genericsup_normaltocombat_0006296f_1.wav",
	"vj_fallout/supermutant/genericsup_normaltocombat_00062970_1.wav",
	"vj_fallout/supermutant/genericsup_normaltocombat_00062971_1.wav",
	"vj_fallout/supermutant/genericsup_normaltocombat_00062972_1.wav",
}
ENT.SoundTbl_OnGrenadeSight = {
	"vj_fallout/supermutant/genericsup_avoidthreat_000217f3_1.wav",
	"vj_fallout/supermutant/genericsup_avoidthreat_000217f4_1.wav",
	"vj_fallout/supermutant/genericsup_avoidthreat_000217f5_1.wav",
	"vj_fallout/supermutant/genericsup_avoidthreat_000217f6_1.wav",
	"vj_fallout/supermutant/genericsup_avoidthreat_0006296d_1.wav",
	"vj_fallout/supermutant/genericsup_avoidthreat_0006296e_1.wav",
	"vj_fallout/supermutant/genericsup_avoidthreatresp_00062967_1.wav",
	"vj_fallout/supermutant/genericsup_avoidthreatresp_00062968_1.wav",
	"vj_fallout/supermutant/genericsup_avoidthreatresp_00062969_1.wav",
	"vj_fallout/supermutant/genericsup_avoidthreatresp_0006296c_1.wav",
}
ENT.SoundTbl_OnKilledEnemy = {
	"vj_fallout/supermutant/genericsup_combattonormal_000483d3_1.wav",
	"vj_fallout/supermutant/genericsup_combattonormal_000629a7_1.wav",
	"vj_fallout/supermutant/genericsup_combattonormal_000629a8_1.wav",
	"vj_fallout/supermutant/genericsup_combattonormal_000629a9_1.wav",
	"vj_fallout/supermutant/genericsup_combattonormal_000629aa_1.wav",
	"vj_fallout/supermutant/genericsup_combattonormal_000629ab_1.wav",
}
ENT.SoundTbl_Pain = {
	"vj_fallout/supermutant/genericsupermutant_hit_0001f932_1.wav",
	"vj_fallout/supermutant/genericsupermutant_hit_0001f933_1.wav",
	"vj_fallout/supermutant/genericsupermutant_hit_0001f934_1.wav",
	"vj_fallout/supermutant/genericsupermutant_hit_0001f935_1.wav",
	"vj_fallout/supermutant/genericsupermutant_hit_0001f936_1.wav",
	"vj_fallout/supermutant/genericsupermutant_hit_000217f1_1.wav",
	"vj_fallout/supermutant/genericsupermutant_hit_000217f2_1.wav",
	"vj_fallout/supermutant/genericsupermutant_hit_000629b3_1.wav",
	"vj_fallout/supermutant/genericsupermutant_hit_000629b5_1.wav",
	"vj_fallout/supermutant/genericsupermutant_hit_000629b8_1.wav",
	"vj_fallout/supermutant/genericsupermutant_hit_000629bd_1.wav",
	"vj_fallout/supermutant/genericsupermutant_hit_000c73c2_1.wav",
	"vj_fallout/supermutant/genericsupermutant_hit_000c73c3_1.wav",
	"vj_fallout/supermutant/genericsupermutant_hit_000c73c4_1.wav",
	"vj_fallout/supermutant/genericsupermutant_hit_000c73c5_1.wav",
}
ENT.SoundTbl_Death = {
	"vj_fallout/supermutant/genericsupermutant_death_000198a9_1.wav",
	"vj_fallout/supermutant/genericsupermutant_death_000198ab_1.wav",
	"vj_fallout/supermutant/genericsupermutant_death_00021804_1.wav",
	"vj_fallout/supermutant/genericsupermutant_death_00021805_1.wav",
	"vj_fallout/supermutant/genericsupermutant_death_00021806_1.wav",
	"vj_fallout/supermutant/genericsupermutant_death_00029583_1.wav",
	"vj_fallout/supermutant/genericsupermutant_death_00029584_1.wav",
	"vj_fallout/supermutant/genericsupermutant_death_000629a2_1.wav",
	"vj_fallout/supermutant/genericsupermutant_death_000629a3_1.wav",
	"vj_fallout/supermutant/genericsupermutant_death_0009fa53_1.wav",
	"vj_fallout/supermutant/genericsupermutant_death_000c73bd_1.wav",
	"vj_fallout/supermutant/genericsupermutant_death_000c73be_1.wav",
	"vj_fallout/supermutant/genericsupermutant_death_000c73bf_1.wav",
	"vj_fallout/supermutant/genericsupermutant_death_000c73c0_1.wav",
}

ENT.MouthParameter = "mouth"
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetupInventory(opWep)
	self:AddToInventory(opWep.ID,opWep:GetClass(),1)
	if self.CustomInventory then self:CustomInventory() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.tbl_Inventory = {}
	self:SetCollisionBounds(Vector(30,30,110),Vector(-30,-30,0))
	timer.Simple(0.02,function()
		if IsValid(self) then
			if IsValid(self:GetActiveWeapon()) then
				local wep = self:GetActiveWeapon()
				-- if wep.AnimationType == nil then self:Remove() end
				-- if wep.AnimationType then
					-- self:SetupHoldTypes(wep,wep.AnimationType)
				-- end

				if self.CanHolsterWeapon && !self.Human_GuardMode then
					if !IsValid(self:GetEnemy()) && !self.IsHolstered then
						self:Unequip()
					end
				end
				self:SetupInventory(self:GetActiveWeapon())
			end
		end
	end)
	for i = 1,18 do
		self:SetBodygroup(i,math.random(0,self:GetBodygroupCount(i)))
	end
	self:SetSkin(math.random(0,1))
	if self.CustomInit then self:CustomInit() end
	self.NPC_NextMouthMove = CurTime()
	self.NPC_NextMouthDistance = 0
	self.NextStimPackT = CurTime()
	self.NextStealthBoyT = CurTime()
	self:GuardInit()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:ExtraInput(key,activator,caller,data)
	if key == "event_emit FootLeft" then
		VJ_EmitSound(self,self.SoundTbl_FootStepL,self.FootStepSoundLevel,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
	elseif key == "event_emit FootRight" then
		VJ_EmitSound(self,self.SoundTbl_FootStepR,self.FootStepSoundLevel,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
	end
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
		self.WeaponAnimTranslations[ACT_RUN_AIM] 						= run
		self.WeaponAnimTranslations[ACT_RANGE_ATTACK1] 					= aim
		self.WeaponAnimTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= fire
		self.WeaponAnimTranslations[ACT_RELOAD]							= "vjges_" .. reload
	elseif htype == "1hp" then
		local aim = VJ_SequenceToActivity(self,"2hraim")
		local walk = ACT_GESTURE_RANGE_ATTACK_SMG2
		local walk_crouch = VJ_SequenceToActivity(self,"2hraim_sneak")
		local run = ACT_GESTURE_RANGE_ATTACK_SMG1_LOW
		local run_crouch = VJ_SequenceToActivity(self,"2hraim_sneakfast")
		local fire = VJ_SequenceToActivity(self,"2hrattack2")
		local crouch = VJ_SequenceToActivity(self,"sneak2hraim")
		local reload = "2hrreloada"

		self.WeaponAnimTranslations[ACT_IDLE_ANGRY] 					= aim
		self.WeaponAnimTranslations[ACT_WALK_AIM] 						= walk
		self.WeaponAnimTranslations[ACT_RUN_AIM] 						= run
		self.WeaponAnimTranslations[ACT_RANGE_ATTACK1] 					= aim
		self.WeaponAnimTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= fire
		self.WeaponAnimTranslations[ACT_RELOAD]							= "vjges_" .. reload
	elseif htype == "2ha" then
		local aim = VJ_SequenceToActivity(self,"2haaim")
		local walk = VJ_SequenceToActivity(self,"2haaim_walk")
		local walk_crouch = VJ_SequenceToActivity(self,"2haaim_sneak")
		local run = VJ_SequenceToActivity(self,"2haaim_run")
		local run_crouch = VJ_SequenceToActivity(self,"2haaim_sneakfast")
		local fire = VJ_SequenceToActivity(self,"2haattackloop")
		local crouch = VJ_SequenceToActivity(self,"sneak2haaim")
		local reload = "2hareloada"

		self.WeaponAnimTranslations[ACT_IDLE_ANGRY] 					= aim
		self.WeaponAnimTranslations[ACT_WALK_AIM] 						= walk
		self.WeaponAnimTranslations[ACT_RUN_AIM] 						= run
		self.WeaponAnimTranslations[ACT_RANGE_ATTACK1] 					= aim
		self.WeaponAnimTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= fire
		self.WeaponAnimTranslations[ACT_RELOAD]							= "vjges_" .. reload
	elseif htype == "1hm" then
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
		self.WeaponAnimTranslations[ACT_RUN_AIM] 						= run
		self.WeaponAnimTranslations[ACT_RANGE_ATTACK1] 					= aim
		self.WeaponAnimTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= fire
		self.WeaponAnimTranslations[ACT_RELOAD]							= "vjges_" .. reload
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
		self.WeaponAnimTranslations[ACT_RUN_AIM] 						= run
		self.WeaponAnimTranslations[ACT_RANGE_ATTACK1] 					= aim
		self.WeaponAnimTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= fire
		self.WeaponAnimTranslations[ACT_RELOAD]							= "vjges_" .. reload
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
		self.WeaponAnimTranslations[ACT_RUN_AIM] 						= run
		self.WeaponAnimTranslations[ACT_RANGE_ATTACK1] 					= aim
		self.WeaponAnimTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= fire
		self.WeaponAnimTranslations[ACT_RELOAD]							= ACT_RELOAD
	elseif htype == "2hr" then
		local aim = VJ_SequenceToActivity(self,"2hraim")
		local walk = ACT_GESTURE_RANGE_ATTACK_SMG2
		local walk_crouch = VJ_SequenceToActivity(self,"2hraim_sneak")
		local run = ACT_GESTURE_RANGE_ATTACK_SMG1_LOW
		local run_crouch = VJ_SequenceToActivity(self,"2hraim_sneakfast")
		local fire = VJ_SequenceToActivity(self,"2hrattack2")
		local crouch = VJ_SequenceToActivity(self,"sneak2hraim")
		local reload = "2hrreloada"

		self.WeaponAnimTranslations[ACT_IDLE_ANGRY] 					= aim
		self.WeaponAnimTranslations[ACT_WALK_AIM] 						= walk
		self.WeaponAnimTranslations[ACT_RUN_AIM] 						= run
		self.WeaponAnimTranslations[ACT_RANGE_ATTACK1] 					= aim
		self.WeaponAnimTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= fire
		self.WeaponAnimTranslations[ACT_RELOAD]							= "vjges_" .. reload
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
		self.WeaponAnimTranslations[ACT_RUN_AIM] 						= run
		self.WeaponAnimTranslations[ACT_RANGE_ATTACK1] 					= aim
		self.WeaponAnimTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= fire
		self.WeaponAnimTranslations[ACT_RELOAD]							= "vjges_" .. reload
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
		self.AnimTbl_ShootWhileMovingRun = self.AnimTbl_Walk
		self.AnimTbl_ShootWhileMovingWalk = self.AnimTbl_Walk
		self.AnimTbl_WeaponReload = {}
		self.AnimTbl_AlertFriendsOnDeath = self.AnimTbl_IdleStand
		self.AnimTbl_CustomWaitForEnemyToComeOut = self.AnimTbl_IdleStand
	elseif htype == "2ha" then
		self.AnimTbl_IdleStand = {VJ_SequenceToActivity(self,"2haaim")}
		self.AnimTbl_Walk = {VJ_SequenceToActivity(self,"2haaim_walk")}
		self.AnimTbl_Run = {VJ_SequenceToActivity(self,"2haaim_run")}
		self.AnimTbl_WeaponAttack = self.AnimTbl_IdleStand
		self.AnimTbl_WeaponAttackFiringGesture = {"2haattackloop"}
		self.AnimTbl_ShootWhileMovingRun = self.AnimTbl_Walk
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
		self.AnimTbl_ShootWhileMovingRun = self.AnimTbl_Walk
		self.AnimTbl_ShootWhileMovingWalk = self.AnimTbl_Walk
		self.AnimTbl_WeaponReload = {"vjges_2hhreloade"}
		self.AnimTbl_AlertFriendsOnDeath = self.AnimTbl_IdleStand
		self.AnimTbl_CustomWaitForEnemyToComeOut = self.AnimTbl_IdleStand
	elseif htype == "2hl" then
		self.AnimTbl_IdleStand = {VJ_SequenceToActivity(self,"2hlaim")}
		self.AnimTbl_Walk = {VJ_SequenceToActivity(self,"2hlaim_walk")}
		self.AnimTbl_Run = {VJ_SequenceToActivity(self,"2hlaim_run")}
		self.AnimTbl_WeaponAttack = self.AnimTbl_IdleStand
		self.AnimTbl_WeaponAttackFiringGesture = {"2hlattackright"}
		self.AnimTbl_ShootWhileMovingRun = self.AnimTbl_Walk
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
		self.AnimTbl_ShootWhileMovingRun = self.AnimTbl_Walk
		self.AnimTbl_ShootWhileMovingWalk = self.AnimTbl_Walk
		self.AnimTbl_WeaponReload = {}
		self.AnimTbl_AlertFriendsOnDeath = self.AnimTbl_IdleStand
		self.AnimTbl_CustomWaitForEnemyToComeOut = self.AnimTbl_IdleStand
	elseif htype == "2hr" || htype == "2hr_bolt" then
		self.AnimTbl_IdleStand = {VJ_SequenceToActivity(self,"2hraim")}
		self.AnimTbl_Walk = {VJ_SequenceToActivity(self,"2hraim_walk")}
		self.AnimTbl_Run = {VJ_SequenceToActivity(self,"2hraim_run")}
		self.AnimTbl_WeaponAttack = self.AnimTbl_IdleStand
		self.AnimTbl_WeaponAttackFiringGesture = {"2hrattack3"}
		self.AnimTbl_ShootWhileMovingRun = self.AnimTbl_Walk
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
		self.AnimTbl_ShootWhileMovingRun = self.AnimTbl_Walk
		self.AnimTbl_ShootWhileMovingWalk = self.AnimTbl_Walk
		self.AnimTbl_WeaponReload = {}
		self.AnimTbl_AlertFriendsOnDeath = self.AnimTbl_IdleStand
		self.AnimTbl_CustomWaitForEnemyToComeOut = self.AnimTbl_IdleStand
	end
	-- table.insert(wep.NPC_AnimationTbl_Custom,self.AnimTbl_IdleStand[1])
	-- table.insert(wep.NPC_AnimationTbl_Custom,self.AnimTbl_Walk[1])
	-- table.insert(wep.NPC_AnimationTbl_Custom,self.AnimTbl_Run[1])
	-- if #self.AnimTbl_WeaponReload > 0 then table.insert(wep.NPC_ReloadAnimationTbl_Custom,VJ_SequenceToActivity(self,string.Replace(self.AnimTbl_WeaponReload[1],"vjges_ ",""))) end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert(argent)

end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,GetCorpse)
	GetCorpse.tbl_Inventory = self.tbl_Inventory

	GetCorpse:SetMaterial(" ")
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/