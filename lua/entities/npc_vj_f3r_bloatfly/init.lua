AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/blowfly.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 15
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_BLOATFLY"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = false -- Should the SNPC have a melee attack?

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.RangeAttackEntityToSpawn = "obj_vj_f3r_centaurspit" -- The entity that is spawned when range attacking
ENT.AnimTbl_RangeAttack = {ACT_RANGE_ATTACK1} -- Range Attack Animations
ENT.RangeDistance = 750 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 0 -- How close does it have to be until it uses melee?
ENT.TimeUntilRangeAttackProjectileRelease = false -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = math.random(2,3) -- How much time until it can use a range attack?
ENT.RangeUseAttachmentForPos = true -- Should the projectile spawn on a attachment?
ENT.RangeUseAttachmentForPosID = "projectile" -- The attachment used on the range attack if RangeUseAttachmentForPos is set to true

ENT.NoChaseAfterCertainRange = true -- Should the SNPC not be able to chase when it's between number x and y?
ENT.NoChaseAfterCertainRange_FarDistance = 500 -- How far until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_CloseDistance = 0 -- How near until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_Type = "Regular"

	-- ====== File Path Variables ====== --
	-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_Idle = {}
ENT.SoundTbl_Alert = {}
ENT.SoundTbl_BeforeRangeAttack = {"vj_fallout/blowfly/blowfly_attack01.mp3"}
ENT.SoundTbl_RangeAttack = {"vj_fallout/blowfly/blowfly_attackdart01.mp3"}
ENT.SoundTbl_Pain = {"vj_fallout/blowfly/blowfly_injured01.mp3","vj_fallout/blowfly/blowfly_injured02.mp3"}
ENT.SoundTbl_Death = {"vj_fallout/blowfly/blowfly_death01.mp3","vj_fallout/blowfly/blowfly_death02.mp3"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetupInventory(opWep)
	if self.CustomInventory then self:CustomInventory() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.tbl_Inventory = {}
	self:SetupInventory()
	self:SetCollisionBounds(Vector(12,12,100),Vector(-12,-12,0))
	local v1,v2 = self:GetCollisionBounds()
	self.Height = v2.z
	self.DefaultDistance = self.MeleeAttackDistance
	
	self.IdleLP = CreateSound(self,"vj_fallout/blowfly/blowfly_idle_lp.wav")
	self.IdleLP:SetSoundLevel(70)
	self.IdleLP:Play()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackCode_GetShootPos(TheProjectile)
	return (self:GetEnemy():GetPos() +self:GetEnemy():OBBCenter() -(self:GetAttachment(self:LookupAttachment(self.RangeUseAttachmentForPosID)).Pos)) *1.3 +self:GetUp() *220
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if string.find(key,"event_rattack") then
		self:RangeAttackCode()
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
	self.IdleLP:Stop()
end
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/