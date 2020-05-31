AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/tunneler.mdl"}
ENT.StartHealth = 125

ENT.VJ_NPC_Class = {"CLASS_TUNNELER"}

ENT.BloodColor = "Red"

ENT.MeleeAttackDamage = 35

ENT.Glow = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetupInventory(opWep)
	if self.CustomInventory then self:CustomInventory() end
	self.OutsideT = CurTime() +math.Rand(30,60)
	self.DamageT = CurTime() +5
	self.IsHiding = false
	self:SetSkin(0)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Dig()
	if self:GetActivity() != ACT_CLIMB_DOWN then
		self:VJ_ACT_PLAYACTIVITY(ACT_CLIMB_DOWN,true,false,false)
		VJ_EmitSound(self,"vj_fallout/sporecarrier/sporecarrier_rise0" .. math.random(1,2) .. ".mp3")
		timer.Simple(self:DecideAnimationLength(ACT_CLIMB_DOWN,false),function()
			self.IsHiding = true
			timer.Simple(math.Rand(15,30),function()
				if IsValid(self) then
					self.DamageT = CurTime() +15
					self:VJ_ACT_PLAYACTIVITY(ACT_CLIMB_UP,true,false,false)
					self.OutsideT = CurTime() +math.Rand(30,60)
					self.IsHiding = false
					
					VJ_EmitSound(self,"vj_fallout/sporecarrier/sporecarrier_risevox0" .. math.random(1,3) .. ".mp3")
					VJ_EmitSound(self,"vj_fallout/sporecarrier/sporecarrier_rise0" .. math.random(1,2) .. ".mp3")
				end
			end)
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	self.AnimTbl_Walk = {self:Health() <= self:GetMaxHealth() *0.35 && ACT_WALK_HURT or ACT_WALK}
	self.AnimTbl_Run = {self:Health() <= self:GetMaxHealth() *0.35 && ACT_RUN_HURT or ACT_RUN}
	self.AnimTbl_IdleStand = {self.Alerted && ACT_IDLE_STIMULATED or ACT_IDLE}

	self:SetCollisionGroup(self.IsHiding && COLLISION_GROUP_IN_VEHICLE or COLLISION_GROUP_NPC)
	self:SetNoDraw(self.IsHiding)
	self:DrawShadow(!self.IsHiding)
	self.DisableFindEnemy = self.IsHiding
	self.DisableSelectSchedule = self.IsHiding
	self.DisableTakeDamageFindEnemy = self.IsHiding
	self.DisableTouchFindEnemy = self.IsHiding
	self.DisableMakingSelfEnemyToNPCs = self.IsHiding
	self.DisableWandering = self.IsHiding
	self.DisableChasingEnemy = self.IsHiding
	self.HasMeleeAttack = !self.IsHiding
	self.HasSounds = !self.IsHiding
	
	if CurTime() < self.OutsideT then self.DamageT = CurTime() +15 end
	
	if CurTime() > self.DamageT && !self.IsHiding then
		self:TakeDamage(1,self,self)
		if math.random(1,10) == 1 && IsValid(self:GetEnemy()) then
			self:Dig()
		end
	end

	if !IsValid(self:GetEnemy()) then
		if !self.IsHiding && CurTime() > self.OutsideT then
			self:Dig()
		end
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/