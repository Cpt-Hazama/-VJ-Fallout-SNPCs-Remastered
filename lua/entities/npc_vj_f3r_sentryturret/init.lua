AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/sentryturret.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 200
ENT.HullType = HULL_HUMAN
ENT.MovementType = VJ_MOVETYPE_STATIONARY -- How does the SNPC move?
ENT.CanTurnWhileStationary = false -- If set to true, the SNPC will be able to turn while it's a stationary SNPC
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY","CLASS_BOS"} -- NPCs with the same class with be allied to each other

ENT.HasMeleeAttack = false -- Should the SNPC have a melee attack?

ENT.BecomeEnemyToPlayer = true
ENT.PlayerFriendly = true
ENT.BecomeEnemyToPlayerLevel = 2

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.DisableDefaultRangeAttackCode = true -- When true, it won't spawn the range attack entity, allowing you to make your own
ENT.DisableRangeAttackAnimation = true -- if true, it will disable the animation code
ENT.RangeToMeleeDistance = 0 -- How close does it have to be until it uses melee?
ENT.RangeAttackAngleRadius = 180 -- What is the attack angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC

	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_Impact = {"ambient/energy/spark1.wav","ambient/energy/spark2.wav","ambient/energy/spark3.wav","ambient/energy/spark4.wav"}
ENT.SoundTbl_Death = {"npc/turret_floor/die.wav"}

	-- ====== Custom ====== --
ENT.Turret_StandDown = true
ENT.Turret_CurrentParameter = 0
ENT.Turret_NextAlarmT = 0

ENT.TimeUntilRangeAttackProjectileRelease = 0 -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = 0.2 -- How much time until it can use a range attack?
ENT.NextAnyAttackTime_Range = 0.2 -- How much time until it can use any attack again? | Counted in Seconds
ENT.SightDistance = 5000 -- How far it can see

ENT.Turret_HasAlarm = true
ENT.LaserDamage = 15

ENT.Turret_TurningSound = "vj_fallout/protectron/robot_protectron_idle_lp.wav"
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetupInventory(opWep)
	if self.CustomInventory then self:CustomInventory() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.tbl_Inventory = {}
	self:SetupInventory()
	self:SetCollisionBounds(Vector(20,20,60), Vector(-20,-20,0))

	self.RangeDistance = self.SightDistance
	self.RangeAttackAngleRadius = 180
	self.SightAngle = 70
	self.Turret_AlarmTimes = 0
	self.Sentry_HasLOS = false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOn_PoseParameterLookingCode(pitch,yaw,roll)
	-- Compare the difference between the current position of the pose parameter and the position it's suppose to go to
	if math.abs(math.AngleDifference(self:GetPoseParameter("aim_yaw"), math.ApproachAngle(self:GetPoseParameter("aim_yaw"), yaw, self.PoseParameterLooking_TurningSpeed))) >= 10 then
		self.Sentry_HasLOS = false
	else
		self.Sentry_HasLOS = true
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomAttackCheck_RangeAttack()
	return self.Sentry_HasLOS
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	local parameter = self:GetPoseParameter("aim_yaw")
	if parameter != self.Turret_CurrentParameter then
		self.turret_turningsd = CreateSound(self,self.Turret_TurningSound) 
		self.turret_turningsd:SetSoundLevel(70)
		self.turret_turningsd:PlayEx(1,100)
	else
		VJ_STOPSOUND(self.turret_turningsd)
	end
	self.Turret_CurrentParameter = parameter
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()
	if IsValid(self:GetEnemy()) then
		self.Turret_StandDown = false
		if self:GetEnemy():Visible(self) && (self:GetForward():Dot((self:GetEnemy():GetPos() -self:GetPos()):GetNormalized()) > math.cos(math.rad(self.RangeAttackAngleRadius))) then
			self.Turret_AlarmTimes = 0
		else
			if self.Turret_HasAlarm == true then
				if CurTime() > self.Turret_NextAlarmT then
					self.Turret_NextAlarmT = CurTime() + 1
					self.Turret_AlarmTimes = self.Turret_AlarmTimes +1
				end
			end
			if self.ResetedEnemy == false && self.Turret_AlarmTimes >= 10 then
				self.ResetedEnemy = true
				self:ResetEnemy(true)
				self.Turret_AlarmTimes = 0
			end
		end
	else
		if CurTime() > self.NextResetEnemyT && self.Alerted == false then
			if self.Turret_StandDown == false then
				self.Turret_StandDown = true
				VJ_EmitSound(self,self.Turret_RetractSound,65,self:VJ_DecideSoundPitch(100,110))
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomRangeAttackCode()
	local start = self:GetAttachment(1).Pos
	local bullet = {}
	bullet.Num = 1
	bullet.Src = start
	bullet.Dir = (self:GetEnemy():GetPos() +self:GetEnemy():OBBCenter()) -start +VectorRand() *20
	bullet.Spread = 4
	bullet.Tracer = 1
	bullet.TracerName = "vj_fo3_laser"
	bullet.Force = 7
	bullet.Damage = self.LaserDamage
	bullet.AmmoType = "SMG1"
	bullet.Callback = function(attacker,tr,dmginfo)
		-- local vjeffectmuz = EffectData()
		-- vjeffectmuz:SetOrigin(tr.HitPos)
		-- util.Effect("vj_fo3_laserhit",vjeffectmuz)
		dmginfo:SetDamageType(bit.bor(DMG_BULLET,DMG_BURN,DMG_DISSOLVE))
	end
	self:FireBullets(bullet)
	
	local vjeffectmuz = EffectData()
	vjeffectmuz:SetOrigin(start)
	vjeffectmuz:SetEntity(self)
	vjeffectmuz:SetStart(start)
	vjeffectmuz:SetNormal(bullet.Dir)
	vjeffectmuz:SetAttachment(1)
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
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,GetCorpse)
	GetCorpse.tbl_Inventory = self.tbl_Inventory
	ParticleEffect("explosion_turret_break_fire", self:GetPos() +self:OBBCenter(), Angle(0,0,0), GetCorpse)
	ParticleEffect("explosion_turret_break_flash", self:GetPos() +self:OBBCenter(), Angle(0,0,0), GetCorpse)
	ParticleEffect("explosion_turret_break_pre_smoke Version #2", self:GetPos() +self:OBBCenter(), Angle(0,0,0), GetCorpse)
	ParticleEffect("explosion_turret_break_sparks", self:GetPos() +self:OBBCenter(), Angle(0,0,0), GetCorpse)
	ParticleEffectAttach("smoke_exhaust_01a",PATTACH_POINT_FOLLOW,GetCorpse,2)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	VJ_STOPSOUND(self.turret_turningsd)
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/