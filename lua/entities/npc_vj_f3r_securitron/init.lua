AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/fallout/securitron.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 150
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_MRHOUSE"} -- NPCs with the same class with be allied to each other

ENT.Bleeds = false

ENT.HasMeleeAttack = false -- Should the SNPC have a melee attack?

ENT.BecomeEnemyToPlayer = true
ENT.PlayerFriendly = true
ENT.BecomeEnemyToPlayerLevel = 2

ENT.HasOnPlayerSight = true -- Should do something when it sees the enemy? Example: Play a sound
ENT.OnPlayerSightDistance = 200 -- How close should the player be until it runs the code?
ENT.OnPlayerSightOnlyOnce = false -- Should it only run the code once?
ENT.OnPlayerSightNextTime1 = 20 -- How much time should it pass until it runs the code again? | First number in math.random
ENT.OnPlayerSightNextTime2 = 30 -- How much time should it pass until it runs the code again? | Second number in math.random

ENT.Immune_AcidPoisonRadiation = true
ENT.Immune_Fire = true

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.RangeAttackEntityToSpawn = "obj_vj_f3r_missile" -- The entity that is spawned when range attacking
ENT.AnimTbl_RangeAttack = {"vjges_2hlattackleft"} -- Range Attack Animations
ENT.RangeAttackAnimationStopMovement = false -- Should it stop moving when performing a range attack?
ENT.RangeAttackAnimationFaceEnemy = false
ENT.RangeDistance = 2000 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 400 -- How close does it have to be until it uses melee?
ENT.TimeUntilRangeAttackProjectileRelease = false -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = math.random(6,12) -- How much time until it can use a range attack?
ENT.RangeUseAttachmentForPos = true -- Should the projectile spawn on a attachment?
ENT.RangeUseAttachmentForPosID = "muzzle_missile" -- The attachment used on the range attack if RangeUseAttachmentForPos is set to true

ENT.CanFlinch = 0 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 15 -- Chance of it flinching from 1 to x | 1 will make it always flinch
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

ENT.SoundTbl_FootStep = {}
ENT.SoundTbl_Idle = {}
ENT.SoundTbl_Alert = {}
ENT.SoundTbl_CombatIdle = {}
ENT.SoundTbl_LostEnemy = {}
ENT.SoundTbl_OnKilledEnemy = {}
ENT.SoundTbl_AllyDeath = {}
ENT.SoundTbl_DamageByPlayer = {}
ENT.SoundTbl_Pain = {}
ENT.SoundTbl_Death = {}

ENT.SoundTbl_Guard_Warn = {}
ENT.SoundTbl_Guard_Angry = {}
ENT.SoundTbl_Guard_Calmed = {}

ENT.ConstantlyFaceEnemy = true -- Should it face the enemy constantly?
ENT.ConstantlyFaceEnemy_IfVisible = true -- Should it only face the enemy if it's visible?
ENT.ConstantlyFaceEnemy_IfAttacking = false -- Should it face the enemy when attacking?
ENT.ConstantlyFaceEnemy_Postures = "Standing" -- "Both" = Moving or standing | "Moving" = Only when moving | "Standing" = Only when standing
ENT.ConstantlyFaceEnemyDistance = 1200 -- How close does it have to be until it starts to face the enemy?
ENT.NoChaseAfterCertainRange = true -- Should the SNPC not be able to chase when it's between number x and y?
ENT.NoChaseAfterCertainRange_FarDistance = 1200 -- How far until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_CloseDistance = 0

ENT.VJ_F3R_InGuardMode = false
ENT.VJ_F3R_GuardWarnDistance = 800
ENT.VJ_F3R_RanGuardStatusChange = false
ENT.VJ_F3R_GuardPosition = Vector(0,0,0)
ENT.VJ_F3R_MaxGuardDistance = 550

ENT.Skin = 7
/*-- Skin Guide --
	0 = Default
	1 = Infantry
	3 = Jane
	5 = Marilyn
	7 = Police
	9 = Victor
	11 = Yes Man
	14 = Default (Clean)
	15 = Infantry (Clean)
	17 = Jane (Clean)
	19 = Marilyn (Clean)
	21 = Police (Clean)
	23 = Victor (Clean)
	25 = Yes Man (Clean)
*/
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPlayerSight(argent)
	if self.Human_GuardMode then
		if argent:GetPos():Distance(self:GetPos()) <= self.Human_GuardWarnDistance then
			VJ_EmitSound(self,self.SoundTbl_Guard_Warn,78,100)
			local time = math.random(8,12)
			for i = 1,time *2 do
				timer.Simple(i *0.5,function() if IsValid(self) && !IsValid(self:GetEnemy()) then if IsValid(argent) then self:SetTarget(argent); self:StopMoving(); self:ClearSchedule(); self:VJ_TASK_FACE_X("TASK_FACE_TARGET") end end end)
			end
			timer.Simple(time,function()
				if IsValid(self) then
					if IsValid(argent) then 
						if argent:GetPos():Distance(self:GetPos()) <= self.Human_GuardWarnDistance then
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
function ENT:PlayIdleLoop()
	self.IdleLoopSound:Stop()
	self.MoveLoopSound:Stop()
	-- self.IdleLoopSound = CreateSound(self,"vj_fallout/sentrybot/sentrybot_idle_lp.wav")
	self.IdleLoopSound:Play()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PlayMoveLoop()
	self.MoveLoopSound:Stop()
	self.IdleLoopSound:Stop()
	-- self.MoveLoopSound = CreateSound(self,"vj_fallout/sentrybot/sentrybot_movement_lp.wav")
	self.MoveLoopSound:Play()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:StopMovementSound()
	self.IdleLoopSound:Stop()
	self.MoveLoopSound:Stop()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PlayMovementSound()
	if self:IsMoving() then
		self.bMoveLoopPlaying = true
		self:PlayMoveLoop()
	else
		self:PlayIdleLoop()
		self.bMoveLoopPlaying = false
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SpinLoopGesture()
	if CurTime() > self.NextGestT then
		-- local gesture = self:AddGestureSequence(self:LookupSequence("2hrattackspinloop"))
		-- self:SetLayerPriority(gesture,2)
		-- self:SetLayerPlaybackRate(gesture,self.AnimationPlaybackRate *0.5)
		self:RestartGesture(ACT_RANGE_ATTACK1)
		self.NextGestT = CurTime() +0.3
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetupInventory(opWep)
	if self.CustomInventory then self:CustomInventory() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.tbl_Inventory = {}
	self:SetupInventory()
	self:SetCollisionBounds(Vector(26,26,110),Vector(-26,-26,0))
	local v1,v2 = self:GetCollisionBounds()
	self.Height = v2.z
	self.DefaultDistance = self.MeleeAttackDistance
	
	self.IdleLoopSound = CreateSound(self,"vj_fallout/sentrybot/sentrybot_idle_lp.wav")
	self.IdleLoopSound:SetSoundLevel(70)
	self.MoveLoopSound = CreateSound(self,"vj_fallout/sentrybot/sentrybot_movement_lp.wav")
	self.SpinLoop = CreateSound(self,self.Weapon == 0 && "vj_fallout/weapons/minigun/wpn_minigun_fire_loop-old1.wav" or "vj_fallout/weapons/gatlinglaser/gatlinglaser_fire_lp.wav")
	self.SpinLoop:SetSoundLevel(self.Weapon == 0 && 150 or 95)

	self:PlayIdleLoop()

	self.HasSpunUp = false
	self.SpinningUp = false
	self.NextCanSpinT = 0
	self.NextFireT = 0
	self.NextGestT = 0
			
	-- local light = ents.Create("light_dynamic")
	-- light:SetKeyValue("brightness", "1")
	-- light:SetKeyValue("distance", "100")
	-- light:SetPos(self:GetPos())
	-- light:SetLocalAngles(self:GetAngles())
	-- light:Fire("Color", "255 255 255")
	-- light:SetParent(self)
	-- light:Spawn()
	-- light:Activate()
	-- light:Fire("TurnOn","",0)
	-- light:Fire("SetParentAttachment","screen",0)
	-- self:DeleteOnRemove(light)
	
	self:SetSkin(self.Skin)
	-- self:SetBodygroup(1,self.Weapon)
	self:GuardInit()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SpinUp()
	if !self.SpinningUp && CurTime() > self.NextCanSpinT then
		self.SpinningUp = true
		self.NextCanSpinT = CurTime() +SoundDuration("vj_fallout/weapons/minigun/wpn_minigun_spinup.wav") +0.05
		VJ_EmitSound(self,"vj_fallout/weapons/minigun/wpn_minigun_spinup.wav",85)
		timer.Simple(SoundDuration("vj_fallout/weapons/minigun/wpn_minigun_spinup.wav"),function()
			if IsValid(self) then
				self.HasSpunUp = true
				self.NextFireT = CurTime() +0.1
				self.SpinLoop:Play()
				self.SpinLoop:ChangeVolume(self.Weapon == 0 && 120 or 90)
			end
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackCode_GetShootPos(TheProjectile)
	return (self:GetEnemy():GetPos() +self:GetEnemy():OBBCenter() -(self:GetAttachment(self:LookupAttachment(self.RangeUseAttachmentForPosID)).Pos))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "event_firemissile" then
		self:RangeAttackCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GetMuzzle()
	return self:GetBodygroup(1) +1
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:FireWeapon(rad)
	if (self:GetForward():Dot((self:GetEnemy():GetPos() - self:GetPos()):GetNormalized()) > math.cos(math.rad(rad))) then
		local start = self:GetAttachment(self.Weapon +1).Pos
		if self.Weapon == 0 then
			local bullet = {}
			bullet.Num = 1
			bullet.Src = start
			bullet.Dir = (self:GetEnemy():GetPos() +self:GetEnemy():OBBCenter()) -start +VectorRand() *18
			bullet.Spread = 4
			bullet.Tracer = 1
			bullet.Force = 5
			bullet.Damage = 5
			bullet.AmmoType = "SMG1"
			self:FireBullets(bullet)
			
			ParticleEffectAttach("muzzleflash_5",PATTACH_POINT_FOLLOW,self,1)
			
			local FireLight1 = ents.Create("light_dynamic")
			FireLight1:SetKeyValue("brightness", "4")
			FireLight1:SetKeyValue("distance", "120")
			FireLight1:SetPos(start)
			FireLight1:SetLocalAngles(self:GetAngles())
			FireLight1:Fire("Color", "255 150 60")
			FireLight1:SetParent(self)
			FireLight1:Spawn()
			FireLight1:Activate()
			FireLight1:Fire("TurnOn","",0)
			FireLight1:Fire("Kill","",0.07)
			self:DeleteOnRemove(FireLight1)
		else
			local bullet = {}
			bullet.Num = 1
			bullet.Src = start
			bullet.Dir = (self:GetEnemy():GetPos() +self:GetEnemy():OBBCenter()) -start +VectorRand() *14
			bullet.Spread = 4
			bullet.Tracer = 1
			bullet.TracerName = "vj_fo3_laser"
			bullet.Force = 7
			bullet.Damage = 7
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
			vjeffectmuz:SetAttachment(self.Weapon +1)
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
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomAttack()
	if !self.VJ_IsBeingControlled then
		if IsValid(self:GetEnemy()) then
			local dist = self.NearestPointToEnemyDistance
			if !self.HasSpunUp && dist <= 2000 && !self.SpinningUp then
				self:SpinUp()
			end
			if self.HasSpunUp then
				self:SpinLoopGesture()
				if CurTime() > self.NextFireT && dist <= 2000 && self:Visible(self:GetEnemy()) && (self:GetForward():Dot((self:GetEnemy():GetPos() - self:GetPos()):GetNormalized()) > math.cos(math.rad(90))) then
					self:FireWeapon(70)
					self.NextFireT = CurTime() +0.03
				end
			end
		end
	else
		local ply = self.VJ_TheController
		if ply:KeyDown(IN_ATTACK) then
			if !self.HasSpunUp && !self.SpinningUp then
				self:SpinUp()
			end
			if self.HasSpunUp then
				self:SpinLoopGesture()
				if CurTime() > self.NextFireT then
					self:FireWeapon(80)
					self.NextFireT = CurTime() +0.03
				end
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	self:GuardAI()
	if self:Health() <= self:GetMaxHealth() *0.35 then
		self.AnimTbl_Walk = {ACT_WALK_HURT}
		self.AnimTbl_Run = {ACT_RUN_HURT}
	end
	if !self.VJ_IsBeingControlled then
		self.ConstantlyFaceEnemy = true
		if IsValid(self:GetEnemy()) then
			self.NoChaseAfterCertainRange = self.NearestPointToEnemyDistance < 200
			self.AnimTbl_IdleStand = {ACT_IDLE_AIM_RELAXED}
			if self.NearestPointToEnemyDistance < 200 then
				self:SetLastPosition(self:GetPos() +self:GetForward() *math.random(-400,-800))
				self:VJ_TASK_GOTO_LASTPOS("TASK_RUN_PATH",function(x) x:EngTask("TASK_FACE_ENEMY",0) x.ConstantlyFaceEnemy = true end)
			end
		else
			self.NoChaseAfterCertainRange = false
		end
	else
		self.NoChaseAfterCertainRange = false
		self.ConstantlyFaceEnemy = false
	end
	self.MoveLoopSound:ChangePitch((self:GetMovementActivity() == ACT_RUN || self:GetMovementActivity() == ACT_RUN_HURT) && 100 or 70)
	if self:IsMoving() then
		if !self.bMoveLoopPlaying then
			self.bMoveLoopPlaying = true
			self:PlayMoveLoop()
		end
	elseif self.bMoveLoopPlaying then
		VJ_EmitSound(self,"vj_fallout/sentrybot/sentrybot_movement_end.mp3",75)
		self:PlayIdleLoop()
		self.bMoveLoopPlaying = false
	end
	if self.SpinningUp && CurTime() > self.NextGestT then
		self:RestartGesture(ACT_GESTURE_RANGE_ATTACK1)
		self.NextGestT = CurTime() +0.3
	end
	if CurTime() > self.NextFireT +0.2 && self.HasSpunUp then
		self.NextCanSpinT = CurTime() +SoundDuration("vj_fallout/weapons/minigun/wpn_minigun_spindown.wav") +0.3
		self.HasSpunUp = false
		self.SpinningUp = false
		self.SpinLoop:Stop()
		self:RestartGesture(ACT_GESTURE_RANGE_ATTACK2)
		VJ_EmitSound(self,"vj_fallout/weapons/minigun/wpn_minigun_spindown.wav",85)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,corpse)
	corpse.tbl_Inventory = self.tbl_Inventory
	if (bit.band(self.SavedDmgInfo.type, DMG_DISSOLVE) != 0) then
		timer.Simple(1,function()
			if IsValid(corpse) then
				local tr = util.TraceLine({
					start = corpse:GetPos(),
					endpos = corpse:GetPos() +Vector(0,0,-600),
					filter = corpse
				})
				if tr.HitWorld then
					local dust = ents.Create("prop_vj_animatable")
					dust:SetModel("models/fallout/goopile.mdl")
					dust:SetPos(tr.HitPos)
					dust:SetAngles(Angle(0,corpse:GetAngles().y,0))
					dust:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
					dust:Spawn()
					dust:SetModelScale(0.001)
					dust:SetModelScale(1,1.25)
					dust.FadeCorpseType = "kill"
					dust.tbl_Inventory = corpse.tbl_Inventory
					VJ.Corpse_Add(dust)
					undo.ReplaceEntity(corpse,dust)
				end
			end
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	self.MoveLoopSound:Stop()
	self.IdleLoopSound:Stop()
	self.SpinLoop:Stop()
end
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/