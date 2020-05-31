AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/yaoguai.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 220
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_YAOGUAI"} -- NPCs with the same class with be allied to each other
ENT.FriendsWithAllPlayerAllies = true

ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDistance = 80
ENT.MeleeAttackDamageDistance = 110
ENT.MeleeAttackDamage = 75

	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 12 -- Chance of it flinching from 1 to x | 1 will make it always flinch
ENT.NextMoveAfterFlinchTime = "LetBaseDecide" -- How much time until it can move, attack, etc. | Use this for schedules or else the base will set the time 0.6 if it sees it's a schedule!
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

	-- ====== File Path Variables ====== --
	-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {
	"vj_fallout/yaoguai/foot/yaoguai_footfront_l.mp3",
	"vj_fallout/yaoguai/foot/yaoguai_footfront_r.mp3",
	"vj_fallout/yaoguai/foot/yaoguai_footrear_l.mp3",
	"vj_fallout/yaoguai/foot/yaoguai_footrear_r.mp3",
}
ENT.SoundTbl_Idle = {
	"vj_fallout/yaoguai/yaoguai_idlebreathe01.mp3",
	"vj_fallout/yaoguai/yaoguai_idlebreathe02.mp3",
	"vj_fallout/yaoguai/yaoguai_idlebreathe03.mp3",
	"vj_fallout/yaoguai/yaoguai_idlebreathe04.mp3",
	"vj_fallout/yaoguai/yaoguai_idlebreathe05.mp3",
	"vj_fallout/yaoguai/yaoguai_idlesniff01.mp3",
	"vj_fallout/yaoguai/yaoguai_idlesniff02.mp3",
}
ENT.SoundTbl_Alert = {
	"vj_fallout/yaoguai/yaoguai_injured01.mp3"
}
ENT.SoundTbl_BeforeMeleeAttack = {
	"vj_fallout/yaoguai/yaoguai_attackforward01.mp3",
	"vj_fallout/yaoguai/yaoguai_attackforward02.mp3",
	"vj_fallout/yaoguai/yaoguai_attackforward03.mp3",
	"vj_fallout/yaoguai/yaoguai_attackswing01.mp3",
	"vj_fallout/yaoguai/yaoguai_attackswing02.mp3",
	"vj_fallout/yaoguai/yaoguai_bite.mp3",
}
ENT.SoundTbl_Pain = {
	"vj_fallout/yaoguai/yaoguai_injured01.mp3",
	"vj_fallout/yaoguai/yaoguai_injured02.mp3",
	"vj_fallout/yaoguai/yaoguai_injured03.mp3",
}
ENT.SoundTbl_Death = {
	"vj_fallout/yaoguai/yaoguai_death01.mp3",
	"vj_fallout/yaoguai/yaoguai_death02.mp3",
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetupInventory(opWep)
	if self.CustomInventory then self:CustomInventory() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.tbl_Inventory = {}
	self:SetupInventory()
	self:SetCollisionBounds(Vector(30,30,70),Vector(-30,-30,0))
	local v1,v2 = self:GetCollisionBounds()
	self.Height = v2.z
	self.DefaultDistance = self.MeleeAttackDistance
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if string.find(key,"Foot") then
		VJ_EmitSound(self,self.SoundTbl_FootStepL,self.FootStepSoundLevel,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
	elseif string.find(key,"event_mattack") then
		self:MeleeAttackCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	self.AnimTbl_Walk = {self:Health() <= self:GetMaxHealth() *0.35 && ACT_WALK_HURT or ACT_WALK}
	self.AnimTbl_Run = {self:Health() <= self:GetMaxHealth() *0.35 && ACT_RUN_HURT or ACT_RUN}
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	local time = self:GetPathTimeToGoal()
	if !(self:Health() <= self:GetMaxHealth() *0.5) && self.NearestPointToEnemyDistance > self.DefaultDistance && time > 0.5 && time < 1.5 then
		self.MeleeAttackDistance = self.DefaultDistance *2
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK2}
	else
		self.MeleeAttackDistance = self.DefaultDistance
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}
		self.HasMeleeAttackKnockBack = false
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,GetCorpse)
	GetCorpse.tbl_Inventory = self.tbl_Inventory
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/