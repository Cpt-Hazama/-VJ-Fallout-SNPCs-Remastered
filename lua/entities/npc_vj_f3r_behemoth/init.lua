AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/supermutant_behemoth.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 2500
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_FEV_MUTANT_EAST"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_RANGE_ATTACK2}
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDistance = 110
ENT.MeleeAttackDamageDistance = 240
ENT.MeleeAttackDamage = 185
ENT.Immune_AcidPoisonRadiation = true

ENT.ConstantlyFaceEnemy = false
ENT.ConstantlyFaceEnemyDistance = 850
	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 50 -- Chance of it flinching from 1 to x | 1 will make it always flinch
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

	-- ====== File Path Variables ====== --
	-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStepL = {
	"vj_fallout/supermutant_behemoth/foot/supermutantbehemoth_foot_l01.mp3",
	"vj_fallout/supermutant_behemoth/foot/supermutantbehemoth_foot_l02.mp3",
}
ENT.SoundTbl_FootStepR = {
	"vj_fallout/supermutant_behemoth/foot/supermutantbehemoth_foot_r01.mp3",
	"vj_fallout/supermutant_behemoth/foot/supermutantbehemoth_foot_r02.mp3",
}
ENT.SoundTbl_Alert = {
	"vj_fallout/supermutant_behemoth/supermutantbehemoth_injured01.mp3",
	"vj_fallout/supermutant_behemoth/supermutantbehemoth_injured02.mp3",
	"vj_fallout/supermutant_behemoth/supermutantbehemoth_injured03.mp3",
}
ENT.SoundTbl_BeforeMeleeAttack = {
	"vj_fallout/supermutant_behemoth/supermutantbehemoth_attack01.mp3",
	"vj_fallout/supermutant_behemoth/supermutantbehemoth_attack02.mp3",
	"vj_fallout/supermutant_behemoth/supermutantbehemoth_attack03.mp3",
}
ENT.SoundTbl_Pain = {
	"vj_fallout/supermutant_behemoth/supermutantbehemoth_injured01.mp3",
	"vj_fallout/supermutant_behemoth/supermutantbehemoth_injured02.mp3",
	"vj_fallout/supermutant_behemoth/supermutantbehemoth_injured03.mp3",
}
ENT.SoundTbl_Death = {
	"vj_fallout/supermutant_behemoth/supermutantbehemoth_death01.mp3",
	"vj_fallout/supermutant_behemoth/supermutantbehemoth_death02.mp3",
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetupInventory(opWep)
	if self.CustomInventory then self:CustomInventory() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.tbl_Inventory = {}
	self:SetupInventory()
	self:SetCollisionBounds(Vector(70,70,230),Vector(-70,-70,0))
	local v1,v2 = self:GetCollisionBounds()
	self.Height = v2.z
	self.DefaultDistance = self.MeleeAttackDistance
	self:SetBodygroup(1,math.random(0,3))
	self:SetBodygroup(2,1)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "event_emit FootLeft" then
		VJ_EmitSound(self,self.SoundTbl_FootStepL,self.FootStepSoundLevel,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
		util.ScreenShake(self:GetPos(),16,100,2,1250)
	elseif key == "event_emit FootRight" then
		VJ_EmitSound(self,self.SoundTbl_FootStepR,self.FootStepSoundLevel,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
		util.ScreenShake(self:GetPos(),16,100,2,1000)
	elseif string.find(key,"event_mattack") then
		local atk = string.Replace(key,"event_mattack ","")
		self:MeleeAttackCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	if self:Health() <= self:GetMaxHealth() *0.35 then
		self.AnimTbl_Walk = {ACT_WALK_HURT}
		self.AnimTbl_Run = {ACT_RUN_HURT}
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