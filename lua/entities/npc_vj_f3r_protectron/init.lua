AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/protectron.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 150
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_PROTECTRON"} -- NPCs with the same class with be allied to each other
ENT.BecomeEnemyToPlayer = true

ENT.Bleeds = false

ENT.HasOnPlayerSight = true -- Should do something when it sees the enemy? Example: Play a sound
ENT.OnPlayerSightDistance = 325 -- How close should the player be until it runs the code?
ENT.OnPlayerSightOnlyOnce = false -- Should it only run the code once?
ENT.OnPlayerSightNextTime1 = 20 -- How much time should it pass until it runs the code again? | First number in math.random
ENT.OnPlayerSightNextTime2 = 30 -- How much time should it pass until it runs the code again? | Second number in math.random

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.TimeUntilMeleeAttackDamage = 0.8 -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDistance = 80
ENT.MeleeAttackDamage = 15
ENT.MeleeAttackDamageDistance = 105

ENT.FootStepTimeRun = 0.5 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 1 -- Next foot step sound when it is walking

	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 12 -- Chance of it flinching from 1 to x | 1 will make it always flinch
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

ENT.SoundTbl_FootStep = {
	"vj_fallout/protectron/foot/protectron_foot_l01.wav",
	"vj_fallout/protectron/foot/protectron_foot_l02.wav",
	"vj_fallout/protectron/foot/protectron_foot_l03.wav",
	"vj_fallout/protectron/foot/protectron_foot_r01.wav",
	"vj_fallout/protectron/foot/protectron_foot_r02.wav",
	"vj_fallout/protectron/foot/protectron_foot_r03.wav",
}
ENT.SoundTbl_Alert = {
	"vj_fallout/protectron/dialoguete_alerttocombat_00018bdc_1.mp3",
	"vj_fallout/protectron/dialoguete_alerttocombat_00018c18_1.mp3",
	"vj_fallout/protectron/dialoguete_alerttocombat_00018c45_1.mp3",
	"vj_fallout/protectron/dialoguete_alerttocombat_00018c46_1.mp3",
	"vj_fallout/protectron/dialoguete_alerttocombat_00018c48_1.mp3",
	"vj_fallout/protectron/genericrob_normaltocombat1.mp3",
	"vj_fallout/protectron/genericrob_normaltocombat2.mp3",
	"vj_fallout/protectron/genericrob_normaltocombat3.mp3",
	"vj_fallout/protectron/genericrob_normaltocombat4.mp3",
	"vj_fallout/protectron/genericrob_normaltocombat5.mp3",
	"vj_fallout/protectron/genericrobot_alerttocombat1.mp3",
	"vj_fallout/protectron/genericrobot_alerttocombat2.mp3",
	"vj_fallout/protectron/genericrobot_alerttocombat3.mp3",
	"vj_fallout/protectron/genericrobot_losttocombat1.mp3",
	"vj_fallout/protectron/genericrobot_losttocombat2.mp3",
	"vj_fallout/protectron/genericrobot_losttocombat3.mp3",
	"vj_fallout/protectron/genericrobot_normaltoalert1.mp3",
	"vj_fallout/protectron/genericrobot_normaltoalert2.mp3",
	"vj_fallout/protectron/genericrobot_normaltoalert3.mp3",
}
ENT.SoundTbl_BeforeMeleeAttack = {
	"vj_fallout/protectron/robotprotectron_attackwindup.mp3",
}
ENT.SoundTbl_CombatIdle = {
	"vj_fallout/protectron/genericrobot_attack_00015a36_1.mp3",
	"vj_fallout/protectron/genericrobot_attack_0008199d_1.mp3",
	"vj_fallout/protectron/genericrobot_attack_0008199e_1.mp3",
	"vj_fallout/protectron/genericrobot_attack_0008199f_1.mp3",
	"vj_fallout/protectron/genericrobot_attack_000819a0_1.mp3",
	"vj_fallout/protectron/genericrobot_attack_000819a1_1.mp3",
	"vj_fallout/protectron/genericrobot_attack_000819a2_1.mp3",
	"vj_fallout/protectron/genericrobot_attack_000819a3_1.mp3",
	"vj_fallout/protectron/genericrobot_attack_000819a4_1.mp3",
	"vj_fallout/protectron/genericrobot_attack_000819a5_1.mp3",
	"vj_fallout/protectron/genericrobot_attack_000819a6_1.mp3",
	"vj_fallout/protectron/genericrobot_attack_000819a7_1.mp3",
	"vj_fallout/protectron/genericrobot_attack_000819a8_1.mp3",
	"vj_fallout/protectron/genericrobot_attack_000819a9_1.mp3",
	"vj_fallout/protectron/genericrobot_attack_000819aa_1.mp3",
	"vj_fallout/protectron/genericrobot_attack_000819ab_1.mp3",
	"vj_fallout/protectron/genericrobot_attack_000819ac_1.mp3",
	"vj_fallout/protectron/genericrobot_attack_000819ad_1.mp3",
	"vj_fallout/protectron/genericrobot_attack_000819ae_1.mp3",
	"vj_fallout/protectron/genericrobot_attack_000819af_1.mp3",
	"vj_fallout/protectron/genericrobot_attack_000819b0_1.mp3",
	"vj_fallout/protectron/genericrobot_attack_000819b1_1.mp3",
	"vj_fallout/protectron/genericrobot_attack_000819b2_1.mp3",
	"vj_fallout/protectron/genericrobot_attack_000819b3_1.mp3",
	"vj_fallout/protectron/genericrobot_attack_000819b4_1.mp3",
}
ENT.SoundTbl_Investigate = {
	"vj_fallout/protectron/genericrobot_alertidle1.mp3",
	"vj_fallout/protectron/genericrobot_alertidle2.mp3",
	"vj_fallout/protectron/genericrobot_alertidle3.mp3",
}
ENT.SoundTbl_LostEnemy = {
	"vj_fallout/protectron/dialoguete_alerttonormal_000186b2_1.mp3",
	"vj_fallout/protectron/genericrobot_alerttonormal1.mp3",
	"vj_fallout/protectron/genericrobot_alerttonormal2.mp3",
	"vj_fallout/protectron/genericrobot_alerttonormal3.mp3",
	"vj_fallout/protectron/genericrobot_combattolost1.mp3",
	"vj_fallout/protectron/genericrobot_combattolost2.mp3",
	"vj_fallout/protectron/genericrobot_combattolost3.mp3",
	"vj_fallout/protectron/genericrobot_lostidle1.mp3",
	"vj_fallout/protectron/genericrobot_lostidle2.mp3",
	"vj_fallout/protectron/genericrobot_lostidle3.mp3",
	"vj_fallout/protectron/genericrobot_losttonormal1.mp3",
	"vj_fallout/protectron/genericrobot_losttonormal2.mp3",
	"vj_fallout/protectron/genericrobot_losttonormal3.mp3",
}
ENT.SoundTbl_AllyDeath = {
	"vj_fallout/protectron/genericrobot_murder1.mp3",
	"vj_fallout/protectron/genericrobot_murder2.mp3",
	"vj_fallout/protectron/genericrobot_murder3.mp3",
}
ENT.SoundTbl_DamageByPlayer = {
	"vj_fallout/protectron/genericrobot_assault01.mp3",
	"vj_fallout/protectron/genericrobot_assault02.mp3",
	"vj_fallout/protectron/genericrobot_assault03.mp3",
}
ENT.SoundTbl_Pain = {
	"vj_fallout/protectron/genericrobot_hit1.mp3",
	"vj_fallout/protectron/genericrobot_hit2.mp3",
	"vj_fallout/protectron/genericrobot_hit3.mp3",
	"vj_fallout/protectron/genericrobot_hit4.mp3",
	"vj_fallout/protectron/genericrobot_hit5.mp3",
	"vj_fallout/protectron/genericrobot_hit6.mp3",
}
ENT.SoundTbl_Death = {
	"vj_fallout/protectron/genericrobot_death1.mp3",
	"vj_fallout/protectron/genericrobot_death2.mp3",
	"vj_fallout/protectron/genericrobot_death3.mp3",
	"vj_fallout/protectron/genericrobot_death4.mp3",
	"vj_fallout/protectron/genericrobot_death5.mp3",
	"vj_fallout/protectron/genericrobot_death6.mp3",
}
ENT.SoundTbl_Guard_Warn = {
	"vj_fallout/protectron/genericrobot_guardtrespass_000819f7_1.mp3",
	"vj_fallout/protectron/genericrobot_guardtrespass_000819f8_1.mp3",
	"vj_fallout/protectron/genericrobot_guardtrespass_000819f9_1.mp3",
	"vj_fallout/protectron/genericrobot_guardtrespass_000819fa_1.mp3",
	"vj_fallout/protectron/genericrobot_guardtrespass_000819fb_1.mp3",
	"vj_fallout/protectron/genericrobot_guardtrespass_000819fc_1.mp3",
}
ENT.SoundTbl_Guard_Angry = {
	"vj_fallout/protectron/ms05nukaro_alerttocombat1.mp3",
	"vj_fallout/protectron/ms05nukaro_alerttocombat5.mp3",
}
ENT.SoundTbl_Guard_Calmed = {"vj_fallout/protectron/genericrobot_hello_00081a18_1.mp3"}

ENT.LaserDamage = 15
ENT.LaserAttachment = 1

ENT.Skin = 0

ENT.NoChaseAfterCertainRange = true -- Should the SNPC not be able to chase when it's between number x and y?
ENT.NoChaseAfterCertainRange_FarDistance = 1100 -- How far until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_CloseDistance = 100
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetupInventory(opWep)
	if self.CustomInventory then self:CustomInventory() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.tbl_Inventory = {}
	self:SetupInventory()
	self:SetCollisionBounds(Vector(18,18,85),Vector(-18,-18,0))
	local v1,v2 = self:GetCollisionBounds()
	self.Height = v2.z
	self.DefaultDistance = self.MeleeAttackDistance

	self.NextFireT = 0
	
	self.bMoveLoopPlaying = false
	self.IdleLoopSound = CreateSound(self,"vj_fallout/protectron/robot_protectron_idle_lp.wav")
	self:PlayIdleLoop()
	
	self:SetSkin(self.Skin)
	if self.ProtectronInit then self:ProtectronInit() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:FireWeapon(rad)
	if (self:GetForward():Dot((self:GetEnemy():GetPos() - self:GetPos()):GetNormalized()) > math.cos(math.rad(rad))) then	
		self:RestartGesture(ACT_GESTURE_RANGE_ATTACK1)
		timer.Simple(0.45,function()
			if IsValid(self) && IsValid(self:GetEnemy()) then
				local start = self:GetAttachment(self.LaserAttachment).Pos
				local bullet = {}
				bullet.Num = 1
				bullet.Src = start
				bullet.Dir = (self:GetEnemy():GetPos() +self:GetEnemy():OBBCenter()) -start +VectorRand() *10
				bullet.Spread = 4
				bullet.Tracer = 1
				bullet.TracerName = "vj_fo3_laser"
				bullet.Force = 7
				bullet.Damage = self.LaserDamage
				bullet.AmmoType = "SMG1"
				bullet.Callback = function(attacker,tr,dmginfo)
					local vjeffectmuz = EffectData()
					vjeffectmuz:SetOrigin(tr.HitPos)
					util.Effect("vj_fo3_laserhit",vjeffectmuz)
					dmginfo:SetDamageType(bit.bor(DMG_BULLET,DMG_BURN,DMG_DISSOLVE))
				end
				self:FireBullets(bullet)
				
				local vjeffectmuz = EffectData()
				vjeffectmuz:SetOrigin(start)
				vjeffectmuz:SetEntity(self)
				vjeffectmuz:SetStart(start)
				vjeffectmuz:SetNormal(bullet.Dir)
				vjeffectmuz:SetAttachment(self.LaserAttachment)
				util.Effect("vj_fo3_muzzle_gatlinglaser",vjeffectmuz)
				
				local FireLight1 = ents.Create("light_dynamic")
				FireLight1:SetKeyValue("brightness", "4")
				FireLight1:SetKeyValue("distance", "120")
				FireLight1:SetPos(start)
				FireLight1:SetLocalAngles(self:GetAngles())
				FireLight1:Fire("Color", "255 0 0")
				FireLight1:SetParent(self)
				FireLight1:Spawn()
				FireLight1:Activate()
				FireLight1:Fire("TurnOn","",0)
				FireLight1:Fire("Kill","",0.07)
				self:DeleteOnRemove(FireLight1)
				
				VJ_EmitSound(self,"vj_fallout/weapons/laserpistol/pistollaser_fire_2d.wav",85)
				VJ_EmitSound(self,"vj_fallout/weapons/laserpistol/pistollaser_fire_3d.wav",110)
			end
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomAttack()
	if !self.VJ_IsBeingControlled then
		if IsValid(self:GetEnemy()) then
			local dist = self.NearestPointToEnemyDistance
			if CurTime() > self.NextFireT && dist <= 2000 && dist > self.MeleeAttackDistance && self:Visible(self:GetEnemy()) && (self:GetForward():Dot((self:GetEnemy():GetPos() - self:GetPos()):GetNormalized()) > math.cos(math.rad(90))) then
				self:FireWeapon(70)
				self.NextFireT = CurTime() +0.6
			end
		end
	else
		local ply = self.VJ_TheController
		if ply:KeyDown(IN_ATTACK2) then
			if CurTime() > self.NextFireT then
				self:FireWeapon(80)
				self.NextFireT = CurTime() +0.6
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PlayIdleLoop()
	self.IdleLoopSound:Play()
	self.IdleLoopSound:ChangeVolume(75,0)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if string.find(key,"event_rattack") then
		
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	self:GuardAI()

	local idle = self.Alerted && ACT_IDLE_AIM_AGITATED or ACT_IDLE
	local walk = self.Alerted && ACT_WALK_AGITATED or ACT_WALK
	local run = self.Alerted && ACT_RUN_AGITATED or ACT_RUN
	if (self:Health() <= self:GetMaxHealth() *0.35) then
		walk = self.Alerted && ACT_WALK_STIMULATED or ACT_WALK_HURT
		run = self.Alerted && ACT_WALK_STIMULATED or ACT_RUN_HURT
	end
	self.AnimTbl_IdleStand = {idle}
	self.AnimTbl_Walk = {walk}
	self.AnimTbl_Run = {run}
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	self.IdleLoopSound:Stop()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,GetCorpse)
	GetCorpse.tbl_Inventory = self.tbl_Inventory
	GetCorpse:SetBodygroup(0,1)
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/