AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/sporeplant.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 180

ENT.SightDistance = 1500
ENT.MovementType = VJ_MOVETYPE_STATIONARY -- How does the SNPC move?
ENT.CanTurnWhileStationary = false -- If set to true, the SNPC will be able to turn while it's a stationary SNPC
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_VAULTSPORE"} -- NPCs with the same class with be allied to each other

ENT.BloodColor = "Green" -- The blood type, this will determine what it should use (decal, particle, etc.)

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDistance = 80
ENT.MeleeAttackDamageDistance = 110
ENT.MeleeAttackDamage = 50

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.RangeAttackEntityToSpawn = "obj_vj_f3r_spit" -- The entity that is spawned when range attacking
ENT.AnimTbl_RangeAttack = {ACT_RANGE_ATTACK1} -- Range Attack Animations
ENT.RangeDistance = 1500 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 80 -- How close does it have to be until it uses melee?
ENT.TimeUntilRangeAttackProjectileRelease = false -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = math.random(3,5) -- How much time until it can use a range attack?
ENT.RangeUseAttachmentForPos = true -- Should the projectile spawn on a attachment?
ENT.RangeUseAttachmentForPosID = "mouth" -- The attachment used on the range attack if RangeUseAttachmentForPos is set to true

	-- ====== File Path Variables ====== --
	-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_Idle = {
	"vj_fallout/sporeplant/sporeplant_mvmt01.mp3",
	"vj_fallout/sporeplant/sporeplant_mvmt02.mp3",
	"vj_fallout/sporeplant/sporeplant_mvmt03.mp3",
	"vj_fallout/sporeplant/sporeplant_mvmt04.mp3",
	"vj_fallout/sporeplant/sporeplant_mvmt05.mp3",
}
ENT.SoundTbl_BeforeMeleeAttack = {
	"vj_fallout/sporeplant/sporeplant_scream01.mp3",
	"vj_fallout/sporeplant/sporeplant_scream02.mp3",
	"vj_fallout/sporeplant/sporeplant_scream03.mp3",
	"vj_fallout/sporeplant/sporeplant_scream04.mp3",
	"vj_fallout/sporeplant/sporeplant_scream05.mp3",
	"vj_fallout/sporeplant/sporeplant_scream06.mp3",
}
ENT.SoundTbl_RangeAttack = {
	"vj_fallout/sporeplant/sporeplant_fire_3d01.mp3",
	"vj_fallout/sporeplant/sporeplant_fire_3d02.mp3",
	"vj_fallout/sporeplant/sporeplant_fire_3d03.mp3",
	"vj_fallout/sporeplant/sporeplant_fire_3d04.mp3",
	"vj_fallout/sporeplant/sporeplant_fire_3d05.mp3",
	"vj_fallout/sporeplant/sporeplant_fire_3d06.mp3",
}
ENT.SoundTbl_Death = {
	"vj_fallout/sporeplant/sporeplant_death01.mp3",
	"vj_fallout/sporeplant/sporeplant_death02.mp3",
	"vj_fallout/sporeplant/sporeplant_death03.mp3",
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetupInventory(opWep)
	if self.CustomInventory then self:CustomInventory() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GetAimDirection()
	local ang = self:GetAngles()
	local pp = self:GetPoseParameter("aim_yaw")
	ang.y = ang.y +pp
	return ang:Forward()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetMeleeAttackDamagePosition()
	return self:GetPos() +self:GetAimDirection()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MeleeAttackCode(isPropAttack, attackDist, CustomEnt) // Thanks Vrej, very cool
	if self.Dead == true or self.vACT_StopAttacks == true or self.Flinching == true or (self.StopMeleeAttackAfterFirstHit == true && self.AlreadyDoneMeleeAttackFirstHit == true) then return end
	isPropAttack = isPropAttack or self.MeleeAttack_DoingPropAttack -- Is this a prop attack?
	attackDist = attackDist or self.MeleeAttackDamageDistance -- How far should the attack go?
	local curEnemy = CustomEnt or self:GetEnemy()
	if self.MeleeAttackAnimationFaceEnemy == true && isPropAttack == false then self:FaceCertainEntity(curEnemy, true) end
	//self.MeleeAttacking = true
	self:CustomOnMeleeAttack_BeforeChecks()
	if self.DisableDefaultMeleeAttackCode == true then return end
	local myPos = self:GetPos()
	local hitRegistered = false
	for _,v in pairs(ents.FindInSphere(self:SetMeleeAttackDamagePosition(), attackDist)) do
		if (self.VJ_IsBeingControlled == true && self.VJ_TheControllerBullseye == v) or (v:IsPlayer() && v.IsControlingNPC == true) then continue end -- If controlled and v is the bullseye OR it's a player controlling then don't damage!
		if v != self && v:GetClass() != self:GetClass() && (((v:IsNPC() or (v:IsPlayer() && v:Alive() && GetConVarNumber("ai_ignoreplayers") == 0)) && self:Disposition(v) != D_LI) or VJ_IsProp(v) == true or v:GetClass() == "func_breakable_surf" or self.EntitiesToDestroyClass[v:GetClass()] or v.VJ_AddEntityToSNPCAttackList == true) && self:GetAimDirection():Dot((Vector(v:GetPos().x, v:GetPos().y, 0) - Vector(myPos.x, myPos.y, 0)):GetNormalized()) > math.cos(math.rad(self.MeleeAttackDamageAngleRadius)) then
			if isPropAttack == true && (v:IsPlayer() or v:IsNPC()) && self:VJ_GetNearestPointToEntityDistance(v) > self.MeleeAttackDistance then continue end //if (self:GetPos():Distance(v:GetPos()) <= self:VJ_GetNearestPointToEntityDistance(v) && self:VJ_GetNearestPointToEntityDistance(v) <= self.MeleeAttackDistance) == false then
			if self:CustomOnMeleeAttack_AfterChecks(v) == true then continue end
			local vProp = VJ_IsProp(v)
			-- Remove prop constraints and push it (If possbile)
			if vProp == true then
				local phys = v:GetPhysicsObject()
				if IsValid(phys) && self:PushOrAttackPropsCode({v}, attackDist) then
					hitRegistered = true
					phys:EnableMotion(true)
					//phys:EnableGravity(true)
					phys:Wake()
					//constraint.RemoveAll(v)
					//if util.IsValidPhysicsObject(v, 1) then
					constraint.RemoveConstraints(v, "Weld") //end
					if self.PushProps == true then
						phys:ApplyForceCenter((curEnemy != nil and curEnemy:GetPos() or myPos) + self:GetForward()*(phys:GetMass() * 700) + self:GetUp()*(phys:GetMass() * 200))
					end
				end
			end
			-- Knockback
			if self.HasMeleeAttackKnockBack == true && v.MovementType != VJ_MOVETYPE_STATIONARY && (v.VJ_IsHugeMonster != true or v.IsVJBaseSNPC_Tank == true) then
				v:SetGroundEntity(NULL)
				v:SetVelocity(self:GetForward()*math.random(self.MeleeAttackKnockBack_Forward1, self.MeleeAttackKnockBack_Forward2) + self:GetUp()*math.random(self.MeleeAttackKnockBack_Up1, self.MeleeAttackKnockBack_Up2) + self:GetRight()*math.random(self.MeleeAttackKnockBack_Right1, self.MeleeAttackKnockBack_Right2))
			end
			-- Damage
			if self.DisableDefaultMeleeAttackDamageCode == false then
				local applyDmg = DamageInfo()
				applyDmg:SetDamage(self:VJ_GetDifficultyValue(self.MeleeAttackDamage))
				applyDmg:SetDamageType(self.MeleeAttackDamageType)
				//applyDmg:SetDamagePosition(self:VJ_GetNearestPointToEntity(v).MyPosition)
				if v:IsNPC() or v:IsPlayer() then applyDmg:SetDamageForce(self:GetForward()*((applyDmg:GetDamage()+100)*70)) end
				applyDmg:SetInflictor(self)
				applyDmg:SetAttacker(self)
				v:TakeDamageInfo(applyDmg, self)
			end
			if self.MeleeAttackSetEnemyOnFire == true then v:Ignite(self.MeleeAttackSetEnemyOnFireTime) end
			-- Bleed Enemy
			if self.MeleeAttackBleedEnemy == true && math.random(1, self.MeleeAttackBleedEnemyChance) == 1 && ((v:IsNPC() && (!VJ_IsHugeMonster)) or v:IsPlayer()) then
				self:CustomOnMeleeAttack_BleedEnemy(v)
				local tName = "timer_melee_bleedply"..v:EntIndex() -- Timer's name
				local tDmg = self.MeleeAttackBleedEnemyDamage -- How much damage each rep does
				timer.Create(tName, self.MeleeAttackBleedEnemyTime, self.MeleeAttackBleedEnemyReps, function()
					if IsValid(v) && v:Health() > 0 then
						v:TakeDamage(tDmg, self, self)
					else -- Remove the timer if the entity is dead in attempt to remove it before the entity respawns (Essential for players)
						timer.Remove(tName)
					end
				end)
			end
			if v:IsPlayer() then
				-- Apply DSP
				if self.HasMeleeAttackDSPSound == true && ((self.MeleeAttackDSPSoundUseDamage == false) or (self.MeleeAttackDSPSoundUseDamage == true && self.MeleeAttackDamage >= self.MeleeAttackDSPSoundUseDamageAmount && GetConVarNumber("vj_npc_nomeleedmgdsp") == 0)) then
					v:SetDSP(self.MeleeAttackDSPSoundType,false)
				end
				v:ViewPunch(Angle(math.random(-1, 1)*self.MeleeAttackDamage, math.random(-1, 1)*self.MeleeAttackDamage, math.random(-1, 1)*self.MeleeAttackDamage))
				-- Slow Player
				if self.SlowPlayerOnMeleeAttack == true then
					self:VJ_DoSlowPlayer(v, self.SlowPlayerOnMeleeAttack_WalkSpeed, self.SlowPlayerOnMeleeAttack_RunSpeed, self.SlowPlayerOnMeleeAttackTime, {PlaySound=self.HasMeleeAttackSlowPlayerSound, SoundTable=self.SoundTbl_MeleeAttackSlowPlayer, SoundLevel=self.MeleeAttackSlowPlayerSoundLevel, FadeOutTime=self.MeleeAttackSlowPlayerSoundFadeOutTime})
					self:CustomOnMeleeAttack_SlowPlayer(v)
				end
			end
			VJ_DestroyCombineTurret(self,v)
			if !vProp then -- Only for non-props...
				hitRegistered = true
			end
		end
	end
	if hitRegistered == true then
		self:PlaySoundSystem("MeleeAttack")
		if self.StopMeleeAttackAfterFirstHit == true then self.AlreadyDoneMeleeAttackFirstHit = true /*self:StopMoving()*/ end
	else
		self:CustomOnMeleeAttack_Miss()
		if self.MeleeAttackWorldShakeOnMiss == true then util.ScreenShake(myPos,self.MeleeAttackWorldShakeOnMissAmplitude,self.MeleeAttackWorldShakeOnMissFrequency,self.MeleeAttackWorldShakeOnMissDuration,self.MeleeAttackWorldShakeOnMissRadius) end
		self:PlaySoundSystem("MeleeAttackMiss", {}, VJ_EmitSound)
	end
	//if self.VJ_IsBeingControlled == false && self.MeleeAttackAnimationFaceEnemy == true then self:FaceCertainEntity(curEnemy,true) end
	if self.AlreadyDoneFirstMeleeAttack == false && self.TimeUntilMeleeAttackDamage != false then
		self:MeleeAttackCode_DoFinishTimers()
	end
	self.AlreadyDoneFirstMeleeAttack = true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.tbl_Inventory = {}
	self:SetupInventory()
	self:SetCollisionBounds(Vector(25,25,80),Vector(-25,-25,0))
	local v1,v2 = self:GetCollisionBounds()
	self.Height = v2.z
	self.DefaultDistance = self.MeleeAttackDistance
	
	self.IdleLP = CreateSound(self,"vj_fallout/sporeplant/sporeplant_mvmt_lp.wav")
	self.IdleLP:SetSoundLevel(70)
	self.IdleLP:Play()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackCode_GetShootPos(TheProjectile)
	return (self:GetEnemy():GetPos() +self:GetEnemy():OBBCenter() -(self:GetAttachment(self:LookupAttachment(self.RangeUseAttachmentForPosID)).Pos)) *1.3 +self:GetUp() *220
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if string.find(key,"event_mattack") then
		self:MeleeAttackCode()
	elseif string.find(key,"event_rattack") then
		self:RangeAttackCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnThinkActive()
	self.AnimTbl_IdleStand = {self.Alerted && ACT_IDLE_AGITATED or ACT_IDLE}
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
	self.IdleLP:Stop()
end
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/