AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/drone_support.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 300
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_MOTHERSHIP_ZETA"} -- NPCs with the same class with be allied to each other
-- ENT.Behavior = VJ_BEHAVIOR_NEUTRAL

ENT.Bleeds = false

ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDistance = 80
ENT.MeleeAttackDamageDistance = 110
ENT.MeleeAttackDamage = 10
ENT.Immune_AcidPoisonRadiation = true

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
	
	self.IdleLoopSound = CreateSound(self,"vj_fallout/mrhandy/robotmisterhandy_idle_lp.wav")
	self.MoveLoopSound = CreateSound(self,"vj_fallout/mrhandy/robotmrhandy_movement_lp.wav")
	self:PlayIdleLoop()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PlayIdleLoop()
	self.IdleLoopSound:Stop()
	self.MoveLoopSound:Stop()
	self.IdleLoopSound = CreateSound(self,"vj_fallout/drone/robotdrone_idle_lp.wav")
	self.IdleLoopSound:Play()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PlayMoveLoop()
	self.MoveLoopSound:Stop()
	self.IdleLoopSound:Stop()
	self.MoveLoopSound = CreateSound(self,"vj_fallout/drone/robotdrone_movement_lpm.wav")
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
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if string.find(key,"event_mattack") then
		self:MeleeAttackCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnThinkActive()
	if self:IsMoving() then
		if !self.bMoveLoopPlaying then
			self.bMoveLoopPlaying = true
			self:PlayMoveLoop()
		end
	elseif self.bMoveLoopPlaying then
		self:EmitSound("vj_fallout/drone/robotdrone_movement_end.wav",75,100)
		self:PlayIdleLoop()
		self.bMoveLoopPlaying = false
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:TranslateActivity(act)
	if act == ACT_WALK then
		return (self:Health() <= self:GetMaxHealth() *0.35) && ACT_WALK_HURT or ACT_WALK
	elseif act == ACT_RUN then
		return (self:Health() <= self:GetMaxHealth() *0.35) && ACT_RUN_HURT or ACT_RUN
	end

	local translation = self.AnimationTranslations[act]
	if translation then
		if istable(translation) then
			if act == ACT_IDLE then
				self:ResolveAnimation(translation)
			end
			return translation[math.random(1, #translation)] or act -- "or act" = To make sure it doesn't return nil when the table is empty!
		else
			return translation
		end
	end
	return act
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	local time = self:GetPathTimeToGoal()
	if self.EnemyData.DistanceNearest > self.DefaultDistance && time > 0.5 && time < 1.5 && math.random(1,20) == 1 then
		self.MeleeAttackDistance = self.DefaultDistance *2
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK2}
		self.HasMeleeAttackKnockBack = true
		self.MeleeAttackKnockBack_Forward1 = 20
		self.MeleeAttackKnockBack_Forward2 = 50
		self.MeleeAttackKnockBack_Up1 = self.Height +(self.Height *0.1)
		self.MeleeAttackKnockBack_Up2 = self.Height +(self.Height *0.2)
		self.MeleeAttackDamage = 5
		self.TimeUntilMeleeAttackDamage = 0.2
		self.MeleeAttackExtraTimers = {0.4,0.6,0.8,1,1.2,1.4,1.6,1.9,2,2.2,2.4,2.6,2.8,3,3.2,3.4}
	else
		self.MeleeAttackDistance = self.DefaultDistance
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}
		self.HasMeleeAttackKnockBack = false
		self.MeleeAttackDamage = 10
		self.TimeUntilMeleeAttackDamage = false
		self.MeleeAttackExtraTimers = {}
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
	self:StopMovementSound()
end
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/