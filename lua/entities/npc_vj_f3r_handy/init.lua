AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/mistergutsy.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 500
ENT.HullType = HULL_MEDIUM_TALL
ENT.PlayerFriendly = true
ENT.BecomeEnemyToPlayer = true
ENT.SightAngle = 320
ENT.TurningSpeed = 10
ENT.HasPoseParameterLooking = false
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY"} -- NPCs with the same class with be allied to each other
ENT.Bleeds = false
ENT.Immune_AcidPoisonRadiation = true

ENT.HasMeleeAttack = false -- Should the SNPC have a melee attack?
ENT.DisableDefaultMeleeAttackCode = true
ENT.MeleeAttackAnimationAllowOtherTasks = true
ENT.AnimTbl_MeleeAttack = {} -- Melee Attack Animations
ENT.TimeUntilMeleeAttackDamage = false
ENT.MeleeAttackDistance = 300

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.RangeAttackEntityToSpawn = "obj_vj_f3r_plasma" -- The entity that is spawned when range attacking
ENT.AnimTbl_RangeAttack = {"vjges_1hpattackright"} -- Range Attack Animations
ENT.RangeAttackAnimationStopMovement = false -- Should it stop moving when performing a range attack?
ENT.RangeAttackAnimationFaceEnemy = false
ENT.RangeDistance = 4000 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 300 -- How close does it have to be until it uses melee?
ENT.TimeUntilRangeAttackProjectileRelease = false -- How much time until the projectile code is ran?
ENT.RangeUseAttachmentForPos = true -- Should the projectile spawn on a attachment?
ENT.RangeUseAttachmentForPosID = "plasmagun_muzzle" -- The attachment used on the range attack if RangeUseAttachmentForPos is set to true
ENT.NextRangeAttackTime = 1

	-- ====== File Path Variables ====== --
	-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_Alert = {
	"vj_fallout/mrhandy/genericrobot_alerttocombat1.mp3",
	"vj_fallout/mrhandy/genericrobot_alerttocombat2.mp3",
	"vj_fallout/mrhandy/genericrobot_alerttocombat3.mp3",
	"vj_fallout/mrhandy/genericrobot_alerttocombat4.mp3",
}
ENT.SoundTbl_CombatIdle = {
	"vj_fallout/mrhandy/genericrobot_attack1.mp3",
	"vj_fallout/mrhandy/genericrobot_attack2.mp3",
	"vj_fallout/mrhandy/genericrobot_attack3.mp3",
	"vj_fallout/mrhandy/genericrobot_attack4.mp3",
	"vj_fallout/mrhandy/genericrobot_attack5.mp3",
	"vj_fallout/mrhandy/genericrobot_attack6.mp3",
	"vj_fallout/mrhandy/genericrobot_attack7.mp3",
	"vj_fallout/mrhandy/genericrobot_attack8.mp3",
}
ENT.SoundTbl_Investigate = {
	"vj_fallout/mrhandy/genericrobot_alertidle1.mp3",
	"vj_fallout/mrhandy/genericrobot_alertidle2.mp3",
	"vj_fallout/mrhandy/genericrobot_alertidle3.mp3",
	"vj_fallout/mrhandy/genericrobot_alertidle4.mp3",
	"vj_fallout/mrhandy/genericrobot_alertidle5.mp3",
	"vj_fallout/mrhandy/genericrobot_alertidle6.mp3",
}
ENT.SoundTbl_LostEnemy = {
	"vj_fallout/mrhandy/genericrobot_combattolost1.mp3",
	"vj_fallout/mrhandy/genericrobot_combattolost2.mp3",
	"vj_fallout/mrhandy/genericrobot_combattolost3.mp3",
	"vj_fallout/mrhandy/genericrobot_combattolost4.mp3",
}
ENT.SoundTbl_OnPlayerSight = {
	"vj_fallout/mrhandy/genericrobot_hello_00081a19_1.mp3",
	"vj_fallout/mrhandy/mq04_hello_0002c23b_1.mp3",
	"vj_fallout/mrhandy/mq04_hello_0002c23d_1.mp3"
}
ENT.SoundTbl_FollowPlayer = {
	"vj_fallout/mrhandy/genericrobot_greeting_000824c0_1.mp3",
	"vj_fallout/mrhandy/mq04_greeting_0002c22c_1.mp3"
}
ENT.SoundTbl_UnFollowPlayer = {
	"vj_fallout/mrhandy/dialoguerivetcity_goodbye_0005a7d0_1.mp3",
	"vj_fallout/mrhandy/genericrobot_goodbye_00075932_1.mp3",
	"vj_fallout/mrhandy/ms05_goodbye_0004d5a3_1.mp3"
}
ENT.SoundTbl_OnKilledEnemy = {
	"vj_fallout/mrhandy/genericrob_combattonormal1.mp3",
	"vj_fallout/mrhandy/genericrob_combattonormal2.mp3",
	"vj_fallout/mrhandy/genericrob_combattonormal3.mp3",
	"vj_fallout/mrhandy/genericrobot_alerttonormal1.mp3",
	"vj_fallout/mrhandy/genericrobot_alerttonormal2.mp3",
	"vj_fallout/mrhandy/genericrobot_alerttonormal3.mp3",
}
ENT.SoundTbl_DamageByPlayer = {
	"vj_fallout/mrhandy/genericrobot_assault_000819c8_1.mp3",
	"vj_fallout/mrhandy/genericrobot_assault_000819c9_1.mp3",
	"vj_fallout/mrhandy/genericrobot_assault_000819ca_1.mp3",
}
ENT.SoundTbl_AllyDeath = {
	"vj_fallout/mrhandy/genericrobot_murder1.mp3",
	"vj_fallout/mrhandy/genericrobot_murder2.mp3",
	"vj_fallout/mrhandy/genericrobot_murder3.mp3",
}
ENT.SoundTbl_Pain = {
	"vj_fallout/mrhandy/genericrobot_hit1.mp3"
}
ENT.SoundTbl_Death = {
	"vj_fallout/mrhandy/genericrobot_death1.mp3",
	"vj_fallout/mrhandy/genericrobot_death2.mp3",
	"vj_fallout/mrhandy/genericrobot_death3.mp3",
	"vj_fallout/mrhandy/genericrobot_death4.mp3",
}

ENT.VJ_F3R_InGuardMode = false
ENT.VJ_F3R_GuardWarnDistance = 800
ENT.VJ_F3R_RanGuardStatusChange = false
ENT.VJ_F3R_GuardPosition = Vector(0,0,0)
ENT.VJ_F3R_MaxGuardDistance = 550

ENT.Skin = 1
ENT.NoChaseAfterCertainRange = true -- Should the SNPC not be able to chase when it's between number x and y?
ENT.NoChaseAfterCertainRange_FarDistance = 2000 -- How far until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_CloseDistance = 750

ENT.VJC_Data = {
    CameraMode = 1, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
    ThirdP_Offset = Vector(0,0,-20), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "Bip01 Head", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(4, 0, 4), -- The offset for the controller when the camera is in first person
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:HasFlamer()
	return self:GetBodygroup(1) == 1
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:HasPlasmaPistol()
	return self:GetBodygroup(2) == 1
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetupInventory(opWep)
	if self.CustomInventory then self:CustomInventory() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.tbl_Inventory = {}
	self:SetupInventory()
	self:SetCollisionBounds(Vector(26,26,92),Vector(-26,-26,0))
	local v1,v2 = self:GetCollisionBounds()
	self.Height = v2.z
	self.DefaultDistance = self.MeleeAttackDistance
	self:SetSkin(self.Skin)

	self.NextFlameDMGT = 0
	self.NextAttackScreamT = 0
	self.CurrentAttack = nil
	
	self.IdleLoopSound = CreateSound(self,"vj_fallout/mrhandy/robotmisterhandy_idle_lp.wav")
	self.MoveLoopSound = CreateSound(self,"vj_fallout/mrhandy/robotmrhandy_movement_lp.wav")
	self:PlayIdleLoop()
	
	self:SetBodygroup(1,1)
	self:SetBodygroup(2,1)
	self:GuardInit()
	
	if self.GustyInit then self:GustyInit() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PlayIdleLoop()
	self.IdleLoopSound:Stop()
	self.MoveLoopSound:Stop()
	self.IdleLoopSound = CreateSound(self,"vj_fallout/mrhandy/robotmisterhandy_idle_lp.wav")
	self.IdleLoopSound:Play()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PlayMoveLoop()
	self.MoveLoopSound:Stop()
	self.IdleLoopSound:Stop()
	self.MoveLoopSound = CreateSound(self,"vj_fallout/mrhandy/robotmrhandy_movement_lp.wav")
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
function ENT:RangeAttackCode_GetShootPos(TheProjectile)
	return (self:GetEnemy():GetPos() +self:GetEnemy():OBBCenter() -(self:GetAttachment(self:LookupAttachment(self.RangeUseAttachmentForPosID)).Pos)) *1
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	local key = string.Replace(key,"event_","")
	if key == "equipped" then
		-- self.AnimTbl_IdleStand = {ACT_IDLE_AIM_RELAXED}
	end
	if key == "plasma" then
		local att = self:LookupAttachment("plasmagun_muzzle")
		ParticleEffectAttach("plasma_muzzle_flash",PATTACH_POINT_FOLLOW,self,att)
		VJ_EmitSound(self,"vj_fallout/weapons/plasmapistol/pistolplasma_fire_2d.wav",85,100)
		VJ_EmitSound(self,"vj_fallout/weapons/plasmapistol/pistolplasma_fire_3d.wav",105,100)
		-- self:Gesture("1hpattackright")
		self:RangeAttackCode()
	end
	if key == "rattack" then
		if(self.CurrentAttack == 2) then
			-- self:Gesture("1hpattackright")
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Gesture(ges)
	local gest = self:AddGestureSequence(self:LookupSequence(ges))
	self:SetLayerPriority(gest,2)
	self:SetLayerPlaybackRate(gest,1)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomAttack()
	if IsValid(self.VJ_TheController) && self.VJ_TheController:KeyDown(IN_ATTACK) or (!IsValid(self.VJ_TheController) && IsValid(self:GetEnemy()) && self.NearestPointToEnemyDistance <= self.RangeToMeleeDistance) then
		self:StartFlamer()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:StartFlamer()
	if self.CurrentAttack == 2 then
		self.CurrentAttack = nil
	end
	if !self.CurrentAttack then
		self.CurrentAttack = 1
		ParticleEffectAttach("flamer",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("flamethrower_muzzle"))
		self.FlameLoopSound = CreateSound(self,"vj_fallout/weapons/flamer/flamer_fire_lp.wav")
		self.FlameLoopSound:Play()
		self.NextFlameDMGT = CurTime() +0.3
		self:Gesture("2hlattackspinup")
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRangeAttack_AfterStartTimer()
	if !self.CurrentAttack then
		self.CurrentAttack = 2
		-- self:RestartGesture(ACT_GESTURE_RANGE_ATTACK1)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:InFront(vec,ene,rad)
	return (vec:Dot((ene:GetPos() -self:GetPos()):GetNormalized()) > math.cos(math.rad(rad)))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	self:GuardAI()
	if self:IsMoving() then
		if !self.bMoveLoopPlaying then
			self.bMoveLoopPlaying = true
			self:PlayMoveLoop()
		end
	elseif self.bMoveLoopPlaying then
		self:EmitSound("vj_fallout/mrhandy/robotmrhandy_movement_end.mp3",75,100)
		self:PlayIdleLoop()
		self.bMoveLoopPlaying = false
	end
	
	if IsValid(self:GetEnemy()) then
		self.AnimTbl_IdleStand = {ACT_IDLE_AIM_RELAXED}
		if self.NearestPointToEnemyDistance < 150 && !IsValid(self.VJ_TheController) then
			self:SetLastPosition(self:GetPos() +self:GetForward() *math.random(-250,-400))
			self:VJ_TASK_GOTO_LASTPOS("TASK_RUN_PATH",function(x) x:EngTask("TASK_FACE_ENEMY",0) x.ConstantlyFaceEnemy = true end)
		end
	else
		self.AnimTbl_IdleStand = {ACT_IDLE}
	end

	local pp_yaw = self:GetPoseParameter("aim_yaw")
	local pp_yaw_right = self:GetPoseParameter("aim_yaw_right")
	local pp_pitch_left = self:GetPoseParameter("aim_pitch_left")
	local pp_pitch_right = self:GetPoseParameter("aim_pitch_right")
	local yaw = 0
	local yaw_right = 0
	local pitch_left = 0
	local pitch_right = 0
	local dist = self.NearestPointToEnemyDistance
	if self.CurrentAttack == 1 then
		local att = self:GetAttachment(self:LookupAttachment("flamethrower_muzzle"))
		if CurTime() >= self.NextFlameDMGT then
			-- local entities = ents.FindInSphere(self:GetPos() +self:GetForward() *1,300)
			-- for _,v in pairs(entities) do
			-- 	if (att.Pos:Dot(((v:GetPos() +v:OBBCenter()) -self:GetPos()):GetNormalized()) > math.cos(math.rad(35))) then
			-- 		if ((((v:IsPlayer() && v:Alive()) || v:IsNPC()) && (self:Disposition(v) == 1 || self:Disposition(v) == 2))) then
			-- 			v:Ignite(10,0)
			-- 			v:TakeDamage(5,self,self)
			-- 		end
			-- 	end
			-- end
			self:DoFlameDamage(300,5,self,35,10,att.Pos,att.Ang:Forward())
			self.NextFlameDMGT = CurTime() +0.125
		end
		if IsValid(self.VJ_TheController) && !self.VJ_TheController:KeyDown(IN_ATTACK) or !IsValid(self.VJ_TheController) && (!IsValid(self:GetEnemy()) || self:GetEnemy():Health() <= 0 || !self:Visible(self:GetEnemy()) || dist > self.RangeToMeleeDistance) then
			self.CurrentAttack = nil
			self:StopParticles()
			self:EmitSound("vj_fallout/weapons/flamer/flamer_fire_end.wav",75,100)
			self.FlameLoopSound:Stop()
			self.NextFlameDMGT = nil
		else
			local fDist = dist
			local bPos = att.Pos
			local _ang = self:GetAngles()
			local ang = _ang -((self:GetEnemy():GetPos() +self:GetEnemy():OBBCenter()) -bPos):Angle()
			yaw = math.NormalizeAngle(ang.y -75) *-1
			
			_ang = att.Ang
			ang = ((self:GetEnemy():GetPos() +self:GetEnemy():OBBCenter()) -bPos):Angle() -_ang
			pitch_left = pp_pitch_left +math.NormalizeAngle(ang.p)
			
			-- if CurTime() >= self.NextAttackScreamT then
				-- if math.random(1,4) == 1 then
					-- local sound = self:PlaySound("Attack")
					-- self.NextAttackScreamT = CurTime() +SoundDuration(sound) +math.Rand(6,16)
				-- else
					-- self.NextAttackScreamT = CurTime() +math.Rand(6,16)
				-- end
			-- end
		end
	elseif self.CurrentAttack == 2 then
		if IsValid(self.VJ_TheController) && !self.VJ_TheController:KeyDown(IN_ATTACK2) or !IsValid(self.VJ_TheController) && (!IsValid(self:GetEnemy()) || self:GetEnemy():Health() <= 0 || !self:Visible(self:GetEnemy()) || dist > self.RangeDistance) then
			self.CurrentAttack = nil
		else
			local att = self:GetAttachment(self:LookupAttachment("plasmagun_muzzle"))
			local fDist = self:GetPos():Distance(self:GetEnemy():GetPos())
			local bPos = att.Pos

			local _ang = self:GetAngles()
			local ang = _ang -((self:GetEnemy():GetPos() +self:GetEnemy():OBBCenter()) -bPos):Angle()
			yaw = math.NormalizeAngle(ang.y +75) *-1
			
			_ang = att.Ang
			ang = ((self:GetEnemy():GetPos() +self:GetEnemy():OBBCenter()) -bPos):Angle() -_ang
			yaw_right = pp_yaw_right +math.NormalizeAngle(ang.y)
			pitch_right = pp_pitch_right +math.NormalizeAngle(ang.p)
			
			-- if CurTime() >= self.NextAttackScreamT then
				-- if math.random(1,6) == 1 then
					-- local sound = self:PlaySound("Attack")
					-- self.NextAttackScreamT = CurTime() +SoundDuration(sound) +math.Rand(6,16)
				-- else
					-- self.NextAttackScreamT = CurTime() +math.Rand(6,16)
				-- end
			-- end
		end
	end
	pp_yaw = math.ApproachAngle(pp_yaw,yaw,3)
	self:SetPoseParameter("aim_yaw",pp_yaw)
	pp_yaw_right = math.ApproachAngle(pp_yaw_right,yaw_right,3)
	self:SetPoseParameter("aim_yaw_right",pp_yaw_right)
	pp_pitch_left = math.ApproachAngle(pp_pitch_left,pitch_left,3)
	self:SetPoseParameter("aim_pitch_left",pp_pitch_left)
	pp_pitch_right = math.ApproachAngle(pp_pitch_right,pitch_right,3)
	self:SetPoseParameter("aim_pitch_right",pp_pitch_right)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	self.MoveLoopSound:Stop()
	self.IdleLoopSound:Stop()
	if self.FlameLoopSound then self.FlameLoopSound:Stop() end
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
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/