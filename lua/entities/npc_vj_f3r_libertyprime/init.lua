AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2020 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/libertyprime.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 5000000
ENT.HullType = HULL_LARGE
ENT.VJ_IsHugeMonster = true -- Is this a huge monster?
ENT.TurningSpeed = 10 -- How fast it can turn

ENT.VJ_NPC_Class = {"CLASS_UNITED_STATES_FRIENDLY", "CLASS_PLAYER_ALLY", "CLASS_BOS"}

ENT.Immune_AcidPoisonRadiation = true -- Makes the SNPC not get damage from Acid, posion, radiation
ENT.Immune_Physics = true -- If set to true, the SNPC won't take damage from props
ENT.AllowIgnition = false
ENT.Immune_Fire = true -- Immune to fire-type damages

ENT.FriendsWithAllPlayerAllies = true -- Should this SNPC be friends with all other player allies that are running on VJ Base?

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.MeleeAttackDamage = 800
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.MeleeAttackDamageType = bit.bor(DMG_CRUSH,DMG_ALWAYSGIB) -- Type of Damage
ENT.MeleeAttackDistance = 125 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 250 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = false
ENT.NextAnyAttackTime_Melee = 3.6 -- How much time until it can use any attack again? | Counted in Seconds
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.MeleeAttackWorldShakeOnMiss = true -- Should it shake the world when it misses during melee attack?
ENT.MeleeAttackWorldShakeOnMissAmplitude = 30 -- How much the screen will shake | From 1 to 16, 1 = really low 16 = really high
ENT.MeleeAttackWorldShakeOnMissRadius = 7000 -- How far the screen shake goes, in world units

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.DisableRangeAttackAnimation = true -- if true, it will disable the animation code
ENT.NextRangeAttackTime = 0 -- How much time until it can use a range attack?

ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events
ENT.HasDeathRagdoll = false -- If set to false, it will not spawn the regular ragdoll of the SNPC
ENT.HasSoundTrack = true -- Does the SNPC have a sound track?
ENT.HasImpactSounds = false -- If set to false, it won't play the impact sounds
ENT.AlertSounds_OnlyOnce = true -- After it plays it once, it will never play it again
ENT.IdleSounds_PlayOnAttacks = true -- It will be able to continue and play idle sounds when it performs an attack
ENT.FollowPlayerCloseDistance = 300 -- If the SNPC is that close to the player then stand still until the player goes farther away
ENT.BecomeEnemyToPlayer = true -- Should the friendly SNPC become enemy towards the player if it's damaged by a player?
ENT.BecomeEnemyToPlayerLevel = 6 -- How many times does the player have to hit the SNPC for it to become enemy?
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Death = {"vjseq_brace"} -- Death Animations
ENT.DeathAnimationTime = 6 -- Time until the SNPC spawns its corpse and gets removed
ENT.GibOnDeathDamagesTable = {"All"} -- Damages that it gibs from | "UseDefault" = Uses default damage types | "All" = Gib from any damage
ENT.ConstantlyFaceEnemy = true -- Should it face the enemy constantly?
ENT.ConstantlyFaceEnemy_IfAttacking = true -- Should it face the enemy when attacking?
ENT.ConstantlyFaceEnemy_Postures = "Standing" -- "Both" = Moving or standing | "Moving" = Only when moving | "Standing" = Only when standing
ENT.ConstantlyFaceEnemyDistance = 2000 -- How close does it have to be until it starts to face the enemy?
ENT.NoChaseAfterCertainRange = true -- Should the SNPC not be able to chase when it's between number x and y?
ENT.NoChaseAfterCertainRange_FarDistance = 1500 -- How far until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_CloseDistance = 50 -- How near until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_Type = "OnlyRange" -- "Regular" = Default behavior | "OnlyRange" = Only does it if it's able to range attack
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {
	"vj_fallout/libertyprime/foot/libertyprime_foot_l_near.mp3",
	"vj_fallout/libertyprime/foot/libertyprime_foot_r_near.mp3"
}
ENT.SoundTbl_Breath = {"vj_fallout/libertyprime/libertyprime_idle_lp.wav"}
ENT.SoundTbl_Idle = {"vj_fallout/libertyprime/genericrobot_attack1.mp3","vj_fallout/libertyprime/genericrobot_attack3.mp3","vj_fallout/libertyprime/genericrobot_attack4.mp3","vj_fallout/libertyprime/genericrobot_attack5.mp3","vj_fallout/libertyprime/genericrobot_attack7.mp3","vj_fallout/libertyprime/genericrobot_attack9.mp3","vj_fallout/libertyprime/genericrobot_attack10.mp3","vj_fallout/libertyprime/genericrobot_attack11.mp3","vj_fallout/libertyprime/genericrobot_attack14.mp3","vj_fallout/libertyprime/genericrobot_attack15.mp3","vj_fallout/libertyprime/genericrobot_attack16.mp3","vj_fallout/libertyprime/genericrobot_attack18.mp3","vj_fallout/libertyprime/genericrobot_attack19.mp3","vj_fallout/libertyprime/genericrobot_attack20.mp3","vj_fallout/libertyprime/genericrobot_attack23.mp3"}
ENT.SoundTbl_CombatIdle = {"vj_fallout/libertyprime/genericrobot_attack1.mp3","vj_fallout/libertyprime/genericrobot_attack3.mp3","vj_fallout/libertyprime/genericrobot_attack4.mp3","vj_fallout/libertyprime/genericrobot_attack5.mp3","vj_fallout/libertyprime/genericrobot_attack7.mp3","vj_fallout/libertyprime/genericrobot_attack9.mp3","vj_fallout/libertyprime/genericrobot_attack10.mp3","vj_fallout/libertyprime/genericrobot_attack11.mp3","vj_fallout/libertyprime/genericrobot_attack14.mp3","vj_fallout/libertyprime/genericrobot_attack15.mp3","vj_fallout/libertyprime/genericrobot_attack16.mp3","vj_fallout/libertyprime/genericrobot_attack18.mp3","vj_fallout/libertyprime/genericrobot_attack19.mp3","vj_fallout/libertyprime/genericrobot_attack20.mp3","vj_fallout/libertyprime/genericrobot_attack23.mp3","vj_fallout/libertyprime/genericrobot_attack2.mp3","vj_fallout/libertyprime/genericrobot_attack6.mp3","vj_fallout/libertyprime/genericrobot_attack8.mp3","vj_fallout/libertyprime/genericrobot_attack12.mp3","vj_fallout/libertyprime/genericrobot_attack13.mp3","vj_fallout/libertyprime/genericrobot_attack17.mp3","vj_fallout/libertyprime/genericrobot_attack21.mp3","vj_fallout/libertyprime/genericrobot_attack22.mp3"}
ENT.SoundTbl_Alert = {"vj_fallout/libertyprime/freeformci_citadelprimevoi_0006dd17_1.mp3"}
ENT.SoundTbl_MeleeAttackExtra = {"vj_impact_metal/metalhit1.wav","vj_impact_metal/metalhit2.wav","vj_impact_metal/metalhit3.wav"}
ENT.SoundTbl_MeleeAttackMiss = ENT.SoundTbl_FootStep
ENT.SoundTbl_Death = {"vj_fallout/libertyprime/voc_robotlibertyprime_dlc03_01.mp3"}
ENT.SoundTbl_SoundTrack = {"vj_fallout/libertyprime/soundtrack_old.mp3"}

-- ENT.SoundTrackChance = 4

ENT.AlertSoundLevel = 110
ENT.IdleSoundLevel = 120
ENT.CombatIdleSoundLevel = 120
ENT.MeleeAttackSoundLevel = 110
ENT.ExtraMeleeAttackSoundLevel = 90
ENT.MeleeAttackMissSoundLevel = 110
ENT.PainSoundLevel = 110
ENT.DeathSoundLevel = 110
ENT.ImpactSoundLevel = 110
ENT.FootStepSoundLevel = 110
ENT.BeforeRangeAttackSoundLevel = 110
ENT.RangeAttackSoundLevel = 110
ENT.BreathSoundLevel = 70

ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100

ENT.NextSoundTime_Idle2 = 8

ENT.AttackTimersCustom = {"timer_range_finished_libertylaser", "timer_range_start_libertylaser"}

-- Custom
ENT.LibertyPrime_DoingNukeAttack = false
ENT.LibertyPrime_DoingLaserAttack = false
ENT.LibertyPrime_NextNukeAttackT = 0

ENT.VJC_Data = {
    CameraMode = 1, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
    ThirdP_Offset = Vector(0,0,-200), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "Bip01 Head", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(4, 0, 5), -- The offset for the controller when the camera is in first person
}

local defVector = Vector(0, 0, 0)
local defAngle = Angle(0, 0, 0)
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(100, 100, 490), Vector(-100, -100, 0))
	self:StopAllCommonSpeechSounds()
	self.StartSound = VJ_CreateSound(self,"vj_fallout/libertyprime/mq11_mq11primeactivationli_00071ef7_1.mp3",110)
	local dur = SoundDuration("vj_fallout/libertyprime/mq11_mq11primeactivationli_00071ef7_1.mp3") +1 -- .MP3's always return 1 second shorter than what they really are
	self.NextIdleSoundT = CurTime() +dur
	self.NextAlertSoundT = CurTime() +dur

	if GetConVar("vj_f3r_prime_nukes"):GetInt() == 0 then
		self.LibertyPrime_NextNukeAttackT = CurTime() +999999999
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:LibertyPrime_DoFootstep(at)
	self:FootStepSoundCode()
	local attach = self:GetAttachment(self:LookupAttachment(at)).Pos
	util.ScreenShake(attach, 10, 100, 0.4, 7000)
	local effectdata = EffectData()
	effectdata:SetOrigin(attach)
	effectdata:SetScale(1000)
	util.Effect("ThumperDust", effectdata)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	if key == "event_lfoot" then
		self:LibertyPrime_DoFootstep("lfoot")
	elseif key == "event_rfoot" then
		self:LibertyPrime_DoFootstep("rfoot")
	elseif key == "event_lfoot trans" then
		VJ_EmitSound(self, "vj_fallout/libertyprime/foot/libertyprime_foot_l_trans.mp3", 100, 100)
	elseif key == "event_rfoot trans" then
		VJ_EmitSound(self, "vj_fallout/libertyprime/foot/libertyprime_foot_r_trans.mp3", 100, 100)
	elseif key == "event_mattack stomp" then
		self:MeleeAttackCode()
	elseif key == "event_bodygroup 1 1" then
		self:SetBodygroup(1, 1)
		self:PlaySoundSystem("BeforeRangeAttack", "vj_fallout/libertyprime/libertyprime_bomb_equip.mp3")
	elseif key == "event_rattack range" then
		self:VJ_ACT_PLAYACTIVITY(ACT_RANGE_ATTACK1,false,0,true)
	elseif key == "event_bodygroup 1 0" then
		self:SetBodygroup(1, 0)
	elseif key == "event_rattack throw" then
		self:RangeAttackCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	if self.RangeAttacking == false then
		self:SetBodygroup(1,0)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert()
	if self.HasAlertSounds == true then
		self.NextIdleSoundT = CurTime() + 13
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleRangeAttacks()
	if !IsValid(self:GetEnemy()) then return end
	if self:GetEnemy():GetPos():Distance(self:GetPos()) > 2500 && CurTime() > self.LibertyPrime_NextNukeAttackT && ((!IsValid(self.VJ_TheController)) or (IsValid(self.VJ_TheController) && self.VJ_TheController:KeyDown(IN_JUMP))) then
		self.LibertyPrime_DoingNukeAttack = true
		self.LibertyPrime_DoingLaserAttack = false
		self.RangeAttackEntityToSpawn = "obj_vj_f3r_mininuke_prime" -- The entity that is spawned when range attacking
		self.RangeDistance = 8000 -- This is how far away it can shoot
		self.RangeToMeleeDistance = 2500 -- How close does it have to be until it uses melee?
		self.RangeUseAttachmentForPos = true -- Should the projectile spawn on a attachment?
		self.RangeUseAttachmentForPosID = "bomb" -- The attachment used on the range attack if RangeUseAttachmentForPos is set to true
		self.TimeUntilRangeAttackProjectileRelease = false //2.8 -- How much time until the projectile code is ran?
		self.NextAnyAttackTime_Range = 3.4667 -- How much time until it can use any attack again? | Counted in Seconds
		-- self.RangeAttackExtraTimers = nil
		self.DisableDefaultRangeAttackCode = false
		self.RangeAttackAnimationFaceEnemy = true
		self.RangeAttackAnimationStopMovement = true
	else
		self.LibertyPrime_DoingNukeAttack = false
		self.LibertyPrime_DoingLaserAttack = true
		self.RangeDistance = 6000 -- This is how far away it can shoot
		self.RangeToMeleeDistance = 200 -- How close does it have to be until it uses melee?
		self.TimeUntilRangeAttackProjectileRelease = 0.01 -- How much time until the projectile code is ran?
		self.NextAnyAttackTime_Range = 0.25 -- How much time until it can use any attack again? | Counted in Seconds
		-- self.RangeAttackExtraTimers = {0.25,0.5}
		self.DisableDefaultRangeAttackCode = true
		self.RangeAttackAnimationFaceEnemy = false
		self.RangeAttackAnimationStopMovement = false
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:LibertyPrime_DoLaserTrace()
	local tr = util.TraceLine({
		start = self:GetAttachment(self:LookupAttachment("eye")).Pos,
		endpos = self:GetEnemy():GetPos() +self:GetEnemy():OBBCenter() +VectorRand() *25,
		filter = self,
	})
	return tr.HitPos
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomRangeAttackCode()
	if self.LibertyPrime_DoingNukeAttack == true then
		self:SetBodygroup(1, 0)
	elseif self.LibertyPrime_DoingLaserAttack == true then
		//if ((self:GetAngles() - (self:GetEnemy():GetPos() -self:GetPos()):Angle()).y <= 40 or (self:GetAngles() - (self:GetEnemy():GetPos() -self:GetPos()):Angle()).y >= 320) then -- If it's between 45 and 315 then don't shoot!
		local trPos = self:LibertyPrime_DoLaserTrace() //self:GetEnemy():GetPos() + self:GetUp()*math.Rand(-20,20) + self:GetRight()*math.Rand(-20,20)
		sound.Play("vj_fallout/libertyprime/libertyprime_laser_fire.mp3",self:GetAttachment(1).Pos, 110, 100)
		util.ScreenShake(trPos, 100, 200, 0.4, 3000)
		-- util.ParticleTracerEx("Weapon_Combine_Ion_Cannon_Beam", self:GetPos(), trPos, false, self:EntIndex(), 1)
		-- ParticleEffect("aurora_shockwave", trPos, defAngle)
		-- ParticleEffect("Weapon_Combine_Ion_Cannon_Exlposion_c", trPos, defAngle)
		util.ParticleTracerEx("vj_f3r_lp_laser", self:GetPos(), trPos, false, self:EntIndex(), 1)
		ParticleEffect("vj_f3r_lp_impact", trPos, defAngle)
		util.VJ_SphereDamage(self, self, trPos, 80, 94, DMG_ENERGYBEAM, true, false, {Force=90})
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_Miss()
	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetAttachment(self:LookupAttachment("rfoot")).Pos) -- the vector of were you want the effect to spawn
	effectdata:SetScale(1000) -- how big the particles are, can even be 0.1 or 0.6
	util.Effect("ThumperDust", effectdata) -- Add as many as you want
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRangeAttack_BeforeStartTimer()
	if self.LibertyPrime_DoingNukeAttack == true then
		self:VJ_ACT_PLAYACTIVITY(ACT_ARM, false, 0, true)
		self.PlayingAttackAnimation = true
		self.CurrentAttackAnimation = ACT_ARM
		self.CurrentAttackAnimationDuration = VJ_GetSequenceDuration(self, self.CurrentAttackAnimation) + 1.64
		timer.Simple(self.CurrentAttackAnimationDuration, function()
			if IsValid(self) then
				self.PlayingAttackAnimation = false
			end
		end)
		self.LibertyPrime_NextNukeAttackT = CurTime() + 45
	elseif self.LibertyPrime_DoingLaserAttack == true then
		self:RestartGesture(ACT_GESTURE_RANGE_ATTACK1)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackCode_GetShootPos(projectile)
	return self:CalculateProjectile("Line", self:GetAttachment(self:LookupAttachment(self.RangeUseAttachmentForPosID)).Pos, self:GetEnemy():GetPos() + self:GetEnemy():OBBCenter(), 5000)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_OnBleed(dmginfo, hitgroup)
	local dmgPos = dmginfo:GetDamagePosition()
	if dmgPos == defVector then return end
	if math.random(1, 3) == 1 then
		local dmgSpark = ents.Create("env_spark")
		dmgSpark:SetKeyValue("Magnitude","3")
		dmgSpark:SetKeyValue("Spark Trail Length","3")
		dmgSpark:SetPos(dmgPos)
		dmgSpark:SetAngles(self:GetAngles())
		//dmgSpark:Fire("LightColor", "255 255 255")
		dmgSpark:SetParent(self)
		dmgSpark:Spawn()
		dmgSpark:Activate()
		dmgSpark:Fire("StartSpark", "", 0)
		dmgSpark:Fire("StopSpark", "", 0.001)
		self:DeleteOnRemove(dmgSpark)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomDeathAnimationCode(dmginfo, hitgroup)
	timer.Simple(0.5, function()
		if IsValid(self) then
			util.ScreenShake(self:GetPos(), 100, 200, 1, 3000)
			if self.HasGibDeathParticles == true then ParticleEffect("vj_explosion2", self:GetPos() + self:GetUp()*360 + self:GetRight() *-50, defAngle) end
			local effectdata = EffectData()
			effectdata:SetOrigin(self:GetPos() + self:GetUp()*360 + self:GetRight() *-50) -- the vector of were you want the effect to spawn
			util.Effect("Explosion", effectdata)
		end
	end)
	timer.Simple(2, function()
		if IsValid(self) then
			util.ScreenShake(self:GetPos(), 100, 200, 1, 3000)
			if self.HasGibDeathParticles == true then ParticleEffect("vj_explosion2", self:GetPos() + self:GetUp()*300, defAngle) end
			local effectdata = EffectData()
			effectdata:SetOrigin(self:GetPos() + self:GetUp()*460) -- the vector of were you want the effect to spawn
			util.Effect("Explosion", effectdata)
		end
	end)
	timer.Simple(3.5, function()
		if IsValid(self) then
			util.ScreenShake(self:GetPos(), 100, 200, 1, 3000)
			if self.HasGibDeathParticles == true then ParticleEffect("vj_explosion2", self:GetPos() + self:GetUp()*460, defAngle) end
			local effectdata = EffectData()
			effectdata:SetOrigin(self:GetPos() + self:GetUp()*460) -- the vector of were you want the effect to spawn
			util.Effect("Explosion", effectdata)
		end
	end)
	timer.Simple(5.05, function()
		if IsValid(self) then
			util.ScreenShake(self:GetPos(), 100, 200, 1, 3000)
			if self.HasGibDeathParticles == true then ParticleEffect("vj_explosion2", self:GetBonePosition(self:LookupBone("Bip01 R Clavicle")), defAngle) end
			local effectdata = EffectData()
			effectdata:SetOrigin(self:GetBonePosition(self:LookupBone("Bip01 R Clavicle"))) -- the vector of were you want the effect to spawn
			util.Effect("Explosion", effectdata)
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
local gibMdls = {"models/props_debris/metal_panelchunk01a.mdl","models/props_debris/metal_panelchunk01b.mdl","models/props_debris/metal_panelchunk01d.mdl","models/props_debris/metal_panelchunk01e.mdl","models/props_debris/metal_panelchunk01f.mdl","models/props_debris/metal_panelchunk01g.mdl","models/props_debris/metal_panelchunk02d.mdl","models/props_debris/metal_panelchunk02e.mdl"}
local gibColor = Color(50, 50, 50)
--
function ENT:SetUpGibesOnDeath(dmginfo, hitgroup)
	if self.DeathAnimationCodeRan == false then return false end
	for i = 0, self:GetBoneCount() -15 do
		self:CreateGibEntity("prop_physics", gibMdls, {Pos=self:GetBonePosition(i), Vel=self:GetForward()*math.Rand(-200,200) + self:GetRight()*math.Rand(-200,200) + self:GetUp()*math.Rand(350,600)}, function(gib)
			gib:Ignite(math.Rand(20, 30), 0)
			gib:SetColor(gibColor)
		end)
	end
	return true, {DeathAnim=true}
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomGibOnDeathSounds(dmginfo, hitgroup) return false end -- Disable gib sounds
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnKilled(dmginfo, hitgroup)
	util.BlastDamage(self, self, self:GetPos() + self:GetUp()*360, 200, 40)
	util.BlastDamage(self, self, self:GetPos(), 400, 40)
	util.ScreenShake(self:GetPos(), 100, 200, 1, 3000)
	if self.HasGibDeathParticles == true then
		for i = 0, self:GetBoneCount() -62 do
			ParticleEffect("vj_explosion2", self:GetBonePosition(i), defAngle)
		end
		local pos = self:GetPos() + self:GetUp()*260
		local effectdata = EffectData()
		effectdata:SetOrigin(pos) -- the vector of were you want the effect to spawn
		util.Effect("Explosion", effectdata)
		ParticleEffect("mininuke_explosion_child_flash", pos, defAngle)
		ParticleEffect("mininuke_explosion_child_flash_mod", pos, defAngle)
		ParticleEffect("mininuke_explosion_child_shrapnel", pos, defAngle)
		ParticleEffect("mininuke_explosion_child_smoke", pos, defAngle)
		ParticleEffect("mininuke_explosion_child_sparks", pos, defAngle)
		ParticleEffect("mininuke_explosion_child_sparks2", pos, defAngle)
		ParticleEffect("mininuke_explosion_shrapnel_fire_child", pos, defAngle)
		ParticleEffect("mininuke_explosion_shrapnel_smoke_child", pos, defAngle)
	end
	self:RunGibOnDeathCode(dmginfo, hitgroup)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	VJ_STOPSOUND(self.CurrentDeathSound)
	VJ_STOPSOUND(self.StartSound)
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2020 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/