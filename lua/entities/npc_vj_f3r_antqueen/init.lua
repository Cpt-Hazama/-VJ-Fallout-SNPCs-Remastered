AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/giantantqueen.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 1000
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_GIANTANT"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)

ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDistance = 90
ENT.MeleeAttackDamageDistance = 210
ENT.MeleeAttackDamage = 25
ENT.MeleeAttackDamageType = bit.bor(DMG_SLASH,DMG_ALWAYSGIB)

	-- ====== File Path Variables ====== --
	-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStepL = {
	"vj_fallout/giantantqueen/foot/antqueen_foot_run_l01.mp3",
	"vj_fallout/giantantqueen/foot/antqueen_foot_run_l02.mp3",
}
ENT.SoundTbl_FootStepR = {
	"vj_fallout/giantantqueen/foot/antqueen_foot_run_r01.mp3",
	"vj_fallout/giantantqueen/foot/antqueen_foot_run_r02.mp3",
}
ENT.SoundTbl_Idle = {
	"vj_fallout/giantantqueen/antqueen_idle01.mp3",
	"vj_fallout/giantantqueen/antqueen_idle02.mp3",
	"vj_fallout/giantantqueen/antqueen_idle03.mp3",
}
ENT.SoundTbl_BeforeMeleeAttack = {
	"vj_fallout/giantantqueen/antqueen_attack01.mp3",
	"vj_fallout/giantantqueen/antqueen_attack02.mp3",
	"vj_fallout/giantantqueen/antqueen_attack03.mp3",
}
ENT.SoundTbl_Pain = {
	"vj_fallout/giantantqueen/antqueen_injured01.mp3",
	"vj_fallout/giantantqueen/antqueen_injured02.mp3",
}
ENT.SoundTbl_Death = {
	"vj_fallout/giantantqueen/antqueen_death.mp3"
}

ENT.RangeDistance = 1000

ENT.VJC_Data = {
    CameraMode = 1, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
    ThirdP_Offset = Vector(0,0,-20), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "Bip01 Head", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(12, 0, 4), -- The offset for the controller when the camera is in first person
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetupInventory(opWep)
	if self.CustomInventory then self:CustomInventory() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.tbl_Inventory = {}
	self:SetupInventory()
	self:SetCollisionBounds(Vector(110,110,122),Vector(-110,-110,0))
	local v1,v2 = self:GetCollisionBounds()
	self.Height = v2.z
	self.DefaultDistance = self.MeleeAttackDistance
	
	self.NextRangeAttackT = 0

	if self.AntInit then self:AntInit() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "event_emit FootLeft" or key == "event_emit FootLeftRun" then
		VJ_EmitSound(self,self.SoundTbl_FootStepL,self.FootStepSoundLevel,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
	elseif key == "event_emit FootRight" or key == "event_emit FootRightRun" then
		VJ_EmitSound(self,self.SoundTbl_FootStepR,self.FootStepSoundLevel,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
	elseif string.find(key,"event_mattack") then
		local atk = string.Replace(key,"event_mattack ","")
		self:MeleeAttackCode()
	elseif string.find(key,"event_rattack") then
		if !IsValid(self:GetEnemy()) then return end
		VJ_EmitSound(self,"vj_fallout/giantantqueen/antqueen_attack_spit.mp3")
		local spit = ents.Create("obj_vj_f3r_spit")
		spit:SetPos(self:GetAttachment(1).Pos)
		spit:SetAngles(self:GetAttachment(1).Ang)
		spit:Spawn()
		spit.DirectDamage = 40
		spit.DirectDamageType = self:GetSkin() == 1 && bit.bor(DMG_ACID,DMG_RADIATION,DMG_BURN) or bit.bor(DMG_ACID,DMG_RADIATION)
		spit:SetOwner(self)
		spit:SetPhysicsAttacker(self)
		local vel = self:CalculateProjectile("Curve",spit:GetPos(),self:GetEnemy():GetPos() +self:GetEnemy():OBBCenter(),900)
		local phys = spit:GetPhysicsObject()
		if (phys:IsValid()) then
			phys:Wake()
			phys:SetVelocity(vel)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	local enemy = self:GetEnemy()
	local cont = self.VJ_TheController
	if IsValid(enemy) then
		local dist = self.NearestPointToEnemyDistance
		if IsValid(cont) && cont:KeyDown(IN_ATTACK2) or !IsValid(cont) && dist <= self.RangeDistance && self:Visible(enemy) then
			if !(!self.MeleeAttacking && CurTime() > self.NextRangeAttackT) then return end
			self:VJ_ACT_PLAYACTIVITY(ACT_RANGE_ATTACK1,true,false,true)
			self.NextRangeAttackT = CurTime() +math.Rand(2,5)
		end
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
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/