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
ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
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
ENT.SoundTbl_FootStep = {"npc/footsteps/hardboot_generic6.wav"}
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
ENT.SoundTbl_Swing = {
	"vj_fallout/player/player_powerattack01.mp3",
	"vj_fallout/player/player_powerattack02.mp3",
	"vj_fallout/player/player_powerattack03.mp3",
	"vj_fallout/player/player_powerattack04.mp3",
	"vj_fallout/player/player_powerattack05.mp3",
	"vj_fallout/player/player_powerattack06.mp3"
}

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
ENT.Controller_UseFirstPerson = true
ENT.Controller_FirstPersonBone = "Bip01 Head"
ENT.Controller_FirstPersonOffset = Vector(4,0,5)
ENT.Controller_FirstPersonAngle = Angle(90,0,90)
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
			table.insert(self.tbl_Apparel,apparel:GetModel())
		else
			table.insert(self.tbl_Hair,apparel:GetModel())
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPlayerSight(argent)
	if self.Human_IsSoldier && !IsValid(self:GetEnemy()) then
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
	self.tbl_Apparel = {}
	self.tbl_Hair = {}
	self.HasApparel = false
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
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnPlayCreateSound(SoundData,SoundFile)
	self.NPC_NextMouthMove = CurTime() + SoundDuration(SoundFile)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "event_swing" then
		VJ_EmitSound(self,self.SoundTbl_Swing,80,100)
	elseif string.find(key,"event_1hm") then
		local atk = string.Replace(key,"event_1hm ","")
		self:MeleeAttackCode()
	elseif string.find(key,"event_2hm") then
		local atk = string.Replace(key,"event_2hm ","")
		self:MeleeAttackCode()
	elseif string.find(key,"event_mattack") then
		local atk = string.Replace(key,"event_mattack ","")
		self:MeleeAttackCode()
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
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Equip()
	self.IsHolstered = false
	self.WeaponAnimTranslations[ACT_IDLE] = self.WeaponAnimTranslations[ACT_IDLE_ANGRY]
	self.WeaponAnimTranslations[ACT_WALK] = self.WeaponAnimTranslations[ACT_WALK_AIM]
	self.WeaponAnimTranslations[ACT_RUN] = self.WeaponAnimTranslations[ACT_RUN_AIM]
	-- self.AnimTbl_IdleStand = {self.Weapon_Idle}
	-- self.AnimTbl_Walk = {self.Weapon_Walk}
	-- self.AnimTbl_Run = {self.Weapon_Run}
	if IsValid(self:GetActiveWeapon()) then
		self:GetActiveWeapon():SetNoDraw(false)
		if self:GetActiveWeapon().NPC_EquipSound then
			VJ_EmitSound(self:GetActiveWeapon(),self:GetActiveWeapon().NPC_EquipSound,75,100)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Unequip()
	self.IsHolstered = true
	self.WeaponAnimTranslations[ACT_IDLE] = ACT_IDLE
	self.WeaponAnimTranslations[ACT_WALK] = ACT_WALK
	self.WeaponAnimTranslations[ACT_RUN] = ACT_RUN
	-- self.Weapon_Idle = self.AnimTbl_IdleStand[1]
	-- self.Weapon_Walk = self.AnimTbl_Walk[1]
	-- self.Weapon_Run = self.AnimTbl_Run[1]
	-- self.AnimTbl_IdleStand = {ACT_IDLE}
	-- self.AnimTbl_Walk = {ACT_WALK}
	-- self.AnimTbl_Run = {ACT_RUN}
	if IsValid(self:GetActiveWeapon()) then
		self:GetActiveWeapon():SetNoDraw(true)
		if self:GetActiveWeapon().NPC_UnequipSound then
			VJ_EmitSound(self:GetActiveWeapon(),self:GetActiveWeapon().NPC_UnequipSound,75,100)
		end
	end
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
	self:GuardAI()
	if IsValid(self:GetEnemy()) then
		self.NextHolsterT = CurTime() +15
	end
	if self.CanHolsterWeapon && !self.VJ_F3R_InGuardMode then
		if !IsValid(self:GetEnemy()) && !self.IsHolstered && CurTime() > self.NextHolsterT then
			self:Unequip()
			-- self.NextHolsterT = CurTime() +5
		elseif IsValid(self:GetEnemy()) && self.IsHolstered then
			self:Equip()
		end
	elseif self.IsHolstered && self.VJ_F3R_InGuardMode then
		self:Equip()
	end
	if CurTime() < self.NPC_NextMouthMove then
		if self.NPC_NextMouthDistance == 0 then
			self.NPC_NextMouthDistance = math.random(15,80)
		else
			self.NPC_NextMouthDistance = 0
		end
		self:SetPoseParameter(self.MouthParameter,self.NPC_NextMouthDistance)
	else
		self:SetPoseParameter(self.MouthParameter,0)
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
	self:SetupApparel(GetCorpse)
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/