AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/gecko.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 65
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_GECKO"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDistance = 80
ENT.MeleeAttackDamageDistance = 110
ENT.MeleeAttackDamage = 35
ENT.DisableFootStepSoundTimer = true

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

	-- ====== File Path Variables ====== --
	-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStepL = {
	"vj_fallout/gecko/foot/fs_gecko_l01.mp3",
	"vj_fallout/gecko/foot/fs_gecko_l02.mp3",
	"vj_fallout/gecko/foot/fs_gecko_l03.mp3",
	"vj_fallout/gecko/foot/fs_gecko_l04.mp3",
}
ENT.SoundTbl_FootStepR = {
	"vj_fallout/gecko/foot/fs_gecko_r01.mp3",
	"vj_fallout/gecko/foot/fs_gecko_r02.mp3",
	"vj_fallout/gecko/foot/fs_gecko_r03.mp3",
	"vj_fallout/gecko/foot/fs_gecko_r04.mp3",
}
ENT.SoundTbl_Alert = {
	"vj_fallout/gecko/gecko_scream01.mp3",
	"vj_fallout/gecko/gecko_scream02.mp3",
	"vj_fallout/gecko/gecko_scream03.mp3",
	"vj_fallout/gecko/gecko_snarl01.mp3",
	"vj_fallout/gecko/gecko_snarl02.mp3",
	"vj_fallout/gecko/gecko_snarl03.mp3",
	"vj_fallout/gecko/gecko_snarl04.mp3",
}
ENT.SoundTbl_CombatIdle = {
	"vj_fallout/gecko/gecko_combatidle01.mp3",
	"vj_fallout/gecko/gecko_combatidle02.mp3",
	"vj_fallout/gecko/gecko_combatidle03.mp3",
	"vj_fallout/gecko/gecko_combatidle04.mp3",
}
ENT.SoundTbl_BeforeMeleeAttack = {
	"vj_fallout/gecko/gecko_claw_atk_vox01.mp3",
	"vj_fallout/gecko/gecko_claw_atk_vox02.mp3",
	"vj_fallout/gecko/gecko_claw_atk_vox03.mp3",
	"vj_fallout/gecko/gecko_claw_atk_vox04.mp3",
	"vj_fallout/gecko/gecko_claw_atk_vox05.mp3",
	"vj_fallout/gecko/gecko_claw_atk_vox06.mp3",
}
ENT.SoundTbl_Pain = {
	"vj_fallout/gecko/gecko_painvox01.mp3",
	"vj_fallout/gecko/gecko_painvox02.mp3",
}
ENT.SoundTbl_Death = {
	"vj_fallout/gecko/gecko_death01.mp3",
	"vj_fallout/gecko/gecko_death02.mp3",
	"vj_fallout/gecko/gecko_death03.mp3",
	"vj_fallout/gecko/gecko_death04.mp3",
}

ENT.HasExtraMeleeAttackSounds = true

ENT.HasFlameAttack = false
ENT.FlameDamage = 5
ENT.FlameParticle = "flame_gargantua"
ENT.HasSpitAttack = false
ENT.RangeDistance = 250
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetupInventory(opWep)
	if self.CustomInventory then self:CustomInventory() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.tbl_Inventory = {}
	self:SetupInventory()
	self:SetCollisionBounds(Vector(24,24,65),Vector(-24,-24,0))
	local v1,v2 = self:GetCollisionBounds()
	self.Height = v2.z
	self.DefaultDistance = self.MeleeAttackDistance
	
	self.FlameLP = CreateSound(self,"vj_fallout/gecko/fire_gecko_flame_lp.wav")
	self.FlameLP:ChangeVolume(78)
	self.SpitLP = CreateSound(self,"vj_fallout/gecko/green_gecko_spit_lp.wav")
	self.SpitLP:ChangeVolume(75)
	
	self.CurrentRange = 0 -- 0 = None, 1 = Flame, 2 = Spit
	
	self.NextPflupSoundT = 0
	self.NextRangeAttackT = CurTime() +1
	
	if self.GeckoInit then self:GeckoInit() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "event_emit FootLeft" then
		if CurTime() > self.NextPflupSoundT then
			VJ_EmitSound(self,"vj_fallout/gecko/gecko_panting0" .. math.random(1,6) .. ".mp3",75,math.random(self.GeneralSoundPitch1,self.GeneralSoundPitch2))
			self.NextPflupSoundT = CurTime() +0.5
		end
		VJ_EmitSound(self,self.SoundTbl_FootStepL,self.FootStepSoundLevel,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
	elseif key == "event_emit FootRight" then
		if CurTime() > self.NextPflupSoundT then
			VJ_EmitSound(self,"vj_fallout/gecko/gecko_panting0" .. math.random(1,6) .. ".mp3",75,math.random(self.GeneralSoundPitch1,self.GeneralSoundPitch2))
			self.NextPflupSoundT = CurTime() +0.5
		end
		VJ_EmitSound(self,self.SoundTbl_FootStepR,self.FootStepSoundLevel,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
	elseif string.find(key,"event_mattack") then
		local atk = string.Replace(key,"event_mattack ","")
		local chomp = string.find(atk,"power")
		if chomp then
			self.SoundTbl_MeleeAttackExtra = {"vj_fallout/gecko/gecko_chomp01.mp3","vj_fallout/gecko/gecko_chomp02.mp3","vj_fallout/gecko/gecko_chomp03.mp3"}
		else
			self.SoundTbl_MeleeAttackExtra = {"vj_fallout/gecko/gecko_claw_atk01.mp3","vj_fallout/gecko/gecko_claw_atk02.mp3","vj_fallout/gecko/gecko_claw_atk03.mp3"}
		end
		self:MeleeAttackCode()
	elseif string.find(key,"event_rattack") then
		local atk = string.Replace(key,"event_rattack ","")
		if atk == "spitstart" then // RANGE_ATTACK2
			self.SpitLP:Stop()
			self.SpitLP:Play()
		end
		if atk == "spit" then
			local spit = ents.Create("obj_vj_f3r_spit")
			spit:SetPos(self:GetAttachment(1).Pos)
			spit:SetAngles(self:GetAttachment(1).Ang)
			spit:Spawn()
			spit:SetOwner(self)
			spit:SetPhysicsAttacker(self)
			local vel = self:CalculateProjectile("Curve",spit:GetPos(),(IsValid(self:GetEnemy()) && self:GetEnemy():GetPos() +self:GetEnemy():OBBCenter()) or self:GetPos() +self:GetForward() *1000,900)
			local phys = spit:GetPhysicsObject()
			if (phys:IsValid()) then
				phys:Wake()
				phys:SetVelocity(vel)
			end
		end
		if atk == "start" then // RANGE_ATTACK1
			VJ_EmitSound(self,"vj_fallout/gecko/fire_gecko_flameburst0" .. math.random(1,2) .. ".mp3")
			local att = self:GetAttachment(self:LookupAttachment("mouth"))

			if self.CurrentRange == 1 then
				self.FlameLP:Stop()
				self.FlameLP:Play()

				local spawnparticle = ents.Create("info_particle_system")
				spawnparticle:SetKeyValue("start_active","1")
				spawnparticle:SetKeyValue("effect_name",self.FlameParticle)
				spawnparticle:SetPos(att.Pos)
				spawnparticle:SetAngles(att.Ang)
				spawnparticle:Spawn()
				spawnparticle:Activate()
				spawnparticle:SetParent(self)
				spawnparticle:Fire("SetParentAttachment","mouth")
				self:DeleteOnRemove(spawnparticle)
				self.Flame = spawnparticle
				-- timer.Simple(2,function() SafeRemoveEntity(spawnparticle) end)
				-- timer.Simple(2,function() if IsValid(self) then self.FlameLP:Stop() end end)
			elseif self.CurrentRange == 2 then
				self.SpitLP:Stop()
				self.SpitLP:Play()
			end
		end
		if atk == "flame" then
			self:DoFlameDamage(self.RangeDistance,self.FlameDamage,self)
		end
		if atk == "end" then
			if self.FlameLP:IsPlaying() then
				VJ_EmitSound(self,"vj_fallout/gecko/fire_gecko_flame_end.wav")
			end
			if self.SpitLP:IsPlaying() then
				VJ_EmitSound(self,"vj_fallout/gecko/green_gecko_spit_end.wav")
				self.SpitLP:Stop()
			end
			self.FlameLP:Stop()
			self.SpitLP:Stop()
			SafeRemoveEntity(self.Flame)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	local idle = self.Alerted && ACT_IDLE_AGITATED or ACT_IDLE
	local walk = ACT_WALK
	local run = ACT_RUN
	if (self:Health() <= self:GetMaxHealth() *0.35) then idle = ACT_IDLE_STIMULATED; walk = ACT_WALK_HURT; run = ACT_WALK_HURT end
	self.AnimTbl_IdleStand = {idle}
	self.AnimTbl_Walk = {walk}
	self.AnimTbl_Run = {run}
	if (self:GetActivity() != ACT_RANGE_ATTACK1 && !self:IsPlayingGesture(ACT_GESTURE_RANGE_ATTACK1)) && self.FlameLP:IsPlaying() then
		SafeRemoveEntity(self.Flame)
		self.FlameLP:Stop()
	end
	if (self:GetActivity() != ACT_RANGE_ATTACK2 && !self:IsPlayingGesture(ACT_GESTURE_RANGE_ATTACK2)) && self.SpitLP:IsPlaying() then
		self.SpitLP:Stop()
	end
	
	if !self.VJ_IsBeingControlled then
		local enemy = self:GetEnemy()
		if IsValid(enemy) then
			local dist = self.NearestPointToEnemyDistance
			if self.HasFlameAttack or self.HasSpitAttack then
				if dist <= self.RangeDistance && self:Visible(enemy) && !self.MeleeAttacking && CurTime() > self.NextRangeAttackT then
					if self.HasFlameAttack then
						if self:IsMoving() then
							self:RestartGesture(ACT_GESTURE_RANGE_ATTACK1)
							self.vACT_StopAttacks = true
							local vACT_StopActivitiesTime = self:DecideAnimationLength(ACT_GESTURE_RANGE_ATTACK1,false)
							if timer.Exists("timer_act_stopattacks") then
								timer.Adjust("timer_act_stopattacks" .. self:EntIndex(),vACT_StopActivitiesTime,1,function() self.vACT_StopAttacks = false end)
							else
								timer.Create("timer_act_stopattacks" .. self:EntIndex(),vACT_StopActivitiesTime,1,function() self.vACT_StopAttacks = false end)
							end
						else
							self:VJ_ACT_PLAYACTIVITY(ACT_RANGE_ATTACK1,true,false,true)
						end
						self.CurrentRange = 1
					elseif self.HasSpitAttack then
						if self:IsMoving() then
							self:RestartGesture(ACT_GESTURE_RANGE_ATTACK2)
							self.vACT_StopAttacks = true
							local vACT_StopActivitiesTime = self:DecideAnimationLength(ACT_GESTURE_RANGE_ATTACK2,false)
							if timer.Exists("timer_act_stopattacks") then
								timer.Adjust("timer_act_stopattacks" .. self:EntIndex(),vACT_StopActivitiesTime,1,function() self.vACT_StopAttacks = false end)
							else
								timer.Create("timer_act_stopattacks" .. self:EntIndex(),vACT_StopActivitiesTime,1,function() self.vACT_StopAttacks = false end)
							end
						else
							self:VJ_ACT_PLAYACTIVITY(ACT_RANGE_ATTACK2,true,false,true)
						end
						self.CurrentRange = 2
					end
					self.NextRangeAttackT = CurTime() +math.Rand(6,10)
				end
			end
		end
	else
		if self.VJ_TheController:KeyDown(IN_ATTACK2) && (self.HasFlameAttack or self.HasSpitAttack) then
			if !self.MeleeAttacking && CurTime() > self.NextRangeAttackT then
				if self.HasFlameAttack then
					if self:IsMoving() then
						self:RestartGesture(ACT_GESTURE_RANGE_ATTACK1)
						self.vACT_StopAttacks = true
						local vACT_StopActivitiesTime = self:DecideAnimationLength(ACT_GESTURE_RANGE_ATTACK1,false)
						if timer.Exists("timer_act_stopattacks") then
							timer.Adjust("timer_act_stopattacks" .. self:EntIndex(),vACT_StopActivitiesTime,1,function() self.vACT_StopAttacks = false end)
						else
							timer.Create("timer_act_stopattacks" .. self:EntIndex(),vACT_StopActivitiesTime,1,function() self.vACT_StopAttacks = false end)
						end
					else
						self:VJ_ACT_PLAYACTIVITY(ACT_RANGE_ATTACK1,true,false,true)
					end
					self.CurrentRange = 1
				elseif self.HasSpitAttack then
					if self:IsMoving() then
						self:RestartGesture(ACT_GESTURE_RANGE_ATTACK2)
						self.vACT_StopAttacks = true
						local vACT_StopActivitiesTime = self:DecideAnimationLength(ACT_GESTURE_RANGE_ATTACK2,false)
						if timer.Exists("timer_act_stopattacks") then
							timer.Adjust("timer_act_stopattacks" .. self:EntIndex(),vACT_StopActivitiesTime,1,function() self.vACT_StopAttacks = false end)
						else
							timer.Create("timer_act_stopattacks" .. self:EntIndex(),vACT_StopActivitiesTime,1,function() self.vACT_StopAttacks = false end)
						end
					else
						self:VJ_ACT_PLAYACTIVITY(ACT_RANGE_ATTACK2,true,false,true)
					end
					self.CurrentRange = 2
				end
				self.NextRangeAttackT = CurTime() +3
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	local time = self:GetPathTimeToGoal()
	if self.NearestPointToEnemyDistance > self.DefaultDistance && time > 0.5 && time < 1.5 && math.random(1,2) == 1 then
		self.MeleeAttackDistance = self.DefaultDistance *2
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK2}
		self.HasMeleeAttackKnockBack = true
		self.MeleeAttackKnockBack_Forward1 = 270
		self.MeleeAttackKnockBack_Forward2 = 290
		self.MeleeAttackKnockBack_Up1 = self.Height +(self.Height *0.8)
		self.MeleeAttackKnockBack_Up2 = self.Height +(self.Height *0.9)
	else
		self.MeleeAttackDistance = self.DefaultDistance
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}
		self.HasMeleeAttackKnockBack = false
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,GetCorpse)
	GetCorpse.tbl_Inventory = self.tbl_Inventory
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	self.FlameLP:Stop()
	self.SpitLP:Stop()
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/