AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/cazadore.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 200
ENT.HullType = HULL_MEDIUM
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_CAZADORE"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDistance = 80
ENT.MeleeAttackDamageDistance = 110
ENT.MeleeAttackDamage = 40
ENT.DisableFootStepSoundTimer = true

	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 12 -- Chance of it flinching from 1 to x | 1 will make it always flinch
ENT.NextMoveAfterFlinchTime = false -- How much time until it can move, attack, etc. | Use this for schedules or else the base will set the time 0.6 if it sees it's a schedule!
ENT.HasHitGroupFlinching = true -- It will flinch when hit in certain hitgroups | It can also have certain animations to play in certain hitgroups
ENT.HitGroupFlinching_DefaultWhenNotHit = false -- If it uses hitgroup flinching, should it do the regular flinch if it doesn't hit any of the specified hitgroups?
ENT.HitGroupFlinching_Values = {
	{
		HitGroup = {104,105},
		Animation = {ACT_FLINCH_STOMACH}
	},
	{
		HitGroup = {106,107},
		Animation = {ACT_FLINCH_LEFTLEG}
	},
	{
		HitGroup = {101,102,103},
		Animation = {ACT_FLINCH_CHEST}
	},
}

	-- ====== File Path Variables ====== --
	-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {
	"vj_fallout/cazadore/foot/cazadore_foot01.mp3",
	"vj_fallout/cazadore/foot/cazadore_foot02.mp3",
	"vj_fallout/cazadore/foot/cazadore_foot03.mp3",
	"vj_fallout/cazadore/foot/cazadore_foot04.mp3",
	"vj_fallout/cazadore/foot/cazadore_foot05.mp3",
	"vj_fallout/cazadore/foot/cazadore_foot06.mp3",
	"vj_fallout/cazadore/foot/cazadore_foot07.mp3",
	"vj_fallout/cazadore/foot/cazadore_foot08.mp3",
	"vj_fallout/cazadore/foot/cazadore_foot09.mp3",
	"vj_fallout/cazadore/foot/cazadore_foot10.mp3",
}
ENT.SoundTbl_Alert = {
	"vj_fallout/cazadore/caz_chasevox01.mp3",
	"vj_fallout/cazadore/caz_chasevox02.mp3",
	"vj_fallout/cazadore/caz_chasevox03.mp3",
	"vj_fallout/cazadore/caz_chasevox04.mp3",
}
ENT.SoundTbl_BeforeMeleeAttack = {
	"vj_fallout/cazadore/cazadore_powerattackvox01.mp3",
	"vj_fallout/cazadore/cazadore_powerattackvox02.mp3",
	"vj_fallout/cazadore/cazadore_powerattackvox03.mp3",
	"vj_fallout/cazadore/cazadore_powerattackvox04.mp3",
}
ENT.SoundTbl_MeleeAttack = {
	"vj_fallout/cazadore/cazadore_sting_attack01.mp3",
	"vj_fallout/cazadore/cazadore_sting_attack02.mp3",
	"vj_fallout/cazadore/cazadore_sting_attack03.mp3",
	"vj_fallout/cazadore/cazadore_sting_attack04.mp3",
}
ENT.SoundTbl_Pain = {
	"vj_fallout/cazadore/cazadore_hit_sfx01.mp3",
	"vj_fallout/cazadore/cazadore_hit_sfx02.mp3",
	"vj_fallout/cazadore/cazadore_hit_sfx03.mp3",
}
ENT.SoundTbl_Death = {
	"vj_fallout/cazadore/cazadore_death_sfx01.mp3",
	"vj_fallout/cazadore/cazadore_death_sfx02.mp3",
	"vj_fallout/cazadore/cazadore_death_sfx03.mp3",
	"vj_fallout/cazadore/cazadore_death_sfx04.mp3",
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetupInventory(opWep)
	if self.CustomInventory then self:CustomInventory() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert()
	if math.random(1,4) == 1 then
		self:VJ_ACT_PLAYACTIVITY(ACT_IDLE_RELAXED,true,false,true)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.tbl_Inventory = {}
	self:SetupInventory()
	self:SetCollisionBounds(Vector(40,40,75),Vector(-40,-40,0))
	local v1,v2 = self:GetCollisionBounds()
	self.Height = v2.z
	self.DefaultDistance = self.MeleeAttackDistance
	
	self.FlyLoop = CreateSound(self,"vj_fallout/cazadore/cazadore_consciouslp.wav")
	self.FlyLoop:ChangeVolume(2,0)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "event_emit Foot" then
		VJ_EmitSound(self,self.SoundTbl_FootStep,self.FootStepSoundLevel,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
	elseif string.find(key,"event_mattack") then
		local atk = string.Replace(key,"event_mattack ","")
		if atk == "power" || atk == "forwardpower" then
			self.MeleeAttackDamageType = bit.bor(DMG_DIRECT,DMG_ACID)
		else
			self.MeleeAttackDamageType = bit.bor(DMG_SLASH,DMG_ACID)
		end
		self:MeleeAttackCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	local time = self:GetPathTimeToGoal()
	if !(self:Health() <= self:GetMaxHealth() *0.35) && self.NearestPointToEnemyDistance > self.DefaultDistance && time > 0.5 && time < 1.5 && math.random(1,20) == 1 then
		self.MeleeAttackDistance = self.DefaultDistance *2
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK2}
		self.HasMeleeAttackKnockBack = true
		self.MeleeAttackKnockBack_Forward1 = 270
		self.MeleeAttackKnockBack_Forward2 = 290
		self.MeleeAttackKnockBack_Up1 = self.Height +(self.Height *0.8)
		self.MeleeAttackKnockBack_Up2 = self.Height +(self.Height *0.9)
	else
		self.MeleeAttackDistance = self.DefaultDistance
		self.AnimTbl_MeleeAttack = {(self:Health() <= self:GetMaxHealth() *0.35) && "vjseq_h2hattackpower" or ACT_MELEE_ATTACK1}
		self.HasMeleeAttackKnockBack = false
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	local idle = self.Alerted && ACT_IDLE_ANGRY or ACT_IDLE
	local walk = self.Alerted && ACT_WALK_AIM or ACT_WALK
	local run = ACT_RUN
	if self.VJ_IsBeingControlled then walk = ACT_WALK end
	if (self:Health() <= self:GetMaxHealth() *0.35) then idle = ACT_IDLE; walk = ACT_WALK_HURT; run = ACT_WALK_HURT end
	self.AnimTbl_IdleStand = {idle}
	self.AnimTbl_Walk = {walk}
	self.AnimTbl_Run = {run}

	local act = self:GetActivity()
	if VJ_HasValue({ACT_MELEE_ATTACK1,ACT_MELEE_ATTACK2,ACT_ARM,ACT_DISARM,ACT_FLINCH_CHEST,ACT_FLINCH_LEFTLEG,ACT_FLINCH_STOMACH,ACT_IDLE_ANGRY,ACT_RUN,ACT_WALK_AIM},act) then
		if !self.FlyLoop:IsPlaying() then
			self.FlyLoop:Play()
		end
	elseif self.FlyLoop:IsPlaying() then
		self.FlyLoop:Stop()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,GetCorpse)
	GetCorpse.tbl_Inventory = self.tbl_Inventory
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	self.FlyLoop:Stop()
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/