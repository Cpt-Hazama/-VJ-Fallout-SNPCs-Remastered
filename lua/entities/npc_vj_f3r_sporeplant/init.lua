AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/sporeplant.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 180

ENT.SightDistance = 1500
ENT.MovementType = VJ_MOVETYPE_STATIONARY
ENT.CanTurnWhileStationary = true
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
function ENT:CustomOnThink()
	self.AnimTbl_IdleStand = {self.Alerted && ACT_IDLE_AGITATED or ACT_IDLE}
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,GetCorpse)
	GetCorpse.tbl_Inventory = self.tbl_Inventory
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	self.IdleLP:Stop()
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/