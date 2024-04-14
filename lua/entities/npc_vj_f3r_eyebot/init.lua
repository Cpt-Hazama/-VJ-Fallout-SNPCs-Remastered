AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/eyebot.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 90
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_ENCLAVE"} -- NPCs with the same class with be allied to each other
ENT.Bleeds = false
ENT.Behavior = VJ_BEHAVIOR_NEUTRAL
ENT.HasMeleeAttack = false

ENT.NoChaseAfterCertainRange = true -- Should the SNPC not be able to chase when it's between number x and y?
ENT.NoChaseAfterCertainRange_FarDistance = 1100 -- How far until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_CloseDistance = 0
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetupInventory(opWep)
	if self.CustomInventory then self:CustomInventory() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.tbl_Inventory = {}
	self:SetupInventory()
	self:SetCollisionBounds(Vector(18,18,110),Vector(-18,-18,0))
	local v1,v2 = self:GetCollisionBounds()
	self.Height = v2.z
	self.DefaultDistance = self.MeleeAttackDistance

	self.NextFireT = 0
	
	self.bMoveLoopPlaying = false
	self.IdleLoopSound = CreateSound(self,"vj_fallout/mrhandy/robotmisterhandy_idle_lp.wav")
	self.MoveLoopSound = CreateSound(self,"vj_fallout/mrhandy/robotmrhandy_movement_lp.wav")
	self:PlayIdleLoop()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:FireWeapon(rad)
	if (self:GetForward():Dot((self:GetEnemy():GetPos() - self:GetPos()):GetNormalized()) > math.cos(math.rad(rad))) then
		local start = self:GetAttachment(1).Pos
		local bullet = {}
		bullet.Num = 1
		bullet.Src = start
		bullet.Dir = (self:GetEnemy():GetPos() +self:GetEnemy():OBBCenter()) -start +VectorRand() *10
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
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomAttack()
	if !self.VJ_IsBeingControlled then
		if IsValid(self:GetEnemy()) then
			local dist = self.NearestPointToEnemyDistance
			if CurTime() > self.NextFireT && dist <= 2000 && self:Visible(self:GetEnemy()) && (self:GetForward():Dot((self:GetEnemy():GetPos() - self:GetPos()):GetNormalized()) > math.cos(math.rad(90))) then
				self:FireWeapon(70)
				self.NextFireT = CurTime() +1
			end
		end
	else
		local ply = self.VJ_TheController
		if ply:KeyDown(IN_ATTACK) then
			if CurTime() > self.NextFireT then
				self:FireWeapon(80)
				self.NextFireT = CurTime() +1
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PlayIdleLoop()
	self.IdleLoopSound:Stop()
	self.MoveLoopSound:Stop()
	self.IdleLoopSound = CreateSound(self,"vj_fallout/eyebot/roboteyebot_idle_lp.wav")
	self.IdleLoopSound:Play()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PlayMoveLoop()
	self.MoveLoopSound:Stop()
	self.IdleLoopSound:Stop()
	self.MoveLoopSound = CreateSound(self,"vj_fallout/eyebot/roboteyebot_movement_lp.wav")
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
	if string.find(key,"event_rattack") then
		
	end
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
		self:EmitSound("vj_fallout/eyebot/roboteyebot_movement_end.wav",75,100)
		self:PlayIdleLoop()
		self.bMoveLoopPlaying = false
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	self.MoveLoopSound:Stop()
	self.IdleLoopSound:Stop()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,GetCorpse)
	ParticleEffect("explosion_turret_break_fire", GetCorpse:GetBonePosition(4), Angle(0,0,0), GetCorpse)
	ParticleEffect("explosion_turret_break_flash", GetCorpse:GetBonePosition(4), Angle(0,0,0), GetCorpse)
	ParticleEffect("explosion_turret_break_pre_smoke Version #2", GetCorpse:GetBonePosition(4), Angle(0,0,0), GetCorpse)
	ParticleEffect("explosion_turret_break_sparks", GetCorpse:GetBonePosition(4), Angle(0,0,0), GetCorpse)
	ParticleEffectAttach("smoke_exhaust_01a",PATTACH_POINT_FOLLOW,GetCorpse,1)
	GetCorpse.tbl_Inventory = self.tbl_Inventory
end
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/