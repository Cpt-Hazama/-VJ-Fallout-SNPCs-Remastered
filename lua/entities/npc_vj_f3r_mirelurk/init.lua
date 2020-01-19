AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/mirelurk.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 120
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_MIRELURK"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "White" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1,ACT_MELEE_ATTACK1,ACT_MELEE_ATTACK1,ACT_MELEE_ATTACK1,ACT_MELEE_ATTACK2} -- Melee Attack Animations
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDistance = 80
ENT.Immune_AcidPoisonRadiation = true

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
ENT.SoundTbl_FootStepL = {
	"vj_fallout/mirelurk/foot/mirelurk_foot_l01.mp3",
	"vj_fallout/mirelurk/foot/mirelurk_foot_l02.mp3",
}
ENT.SoundTbl_FootStepR = {
	"vj_fallout/mirelurk/foot/mirelurk_foot_r01.mp3",
	"vj_fallout/mirelurk/foot/mirelurk_foot_r02.mp3",
}
ENT.SoundTbl_Idle = {
	"vj_fallout/mirelurk/mirelurk_idle01.mp3",
	"vj_fallout/mirelurk/mirelurk_idle02.mp3",
	"vj_fallout/mirelurk/mirelurk_idle03.mp3",
	"vj_fallout/mirelurk/mirelurk_idle04.mp3",
}
ENT.SoundTbl_Pain = {
	"vj_fallout/mirelurk/mirelurk_injured01.mp3",
	"vj_fallout/mirelurk/mirelurk_injured02.mp3",
}
ENT.SoundTbl_Death = {
	"vj_fallout/mirelurk/mirelurk_death01.mp3",
	"vj_fallout/mirelurk/mirelurk_death02.mp3",
}
ENT.BulletResistance = 0.4
ENT.Controller_UseFirstPerson = true
ENT.Controller_FirstPersonBone = "Bip01 Head"
ENT.Controller_FirstPersonOffset = Vector(4,0,0)
ENT.Controller_FirstPersonAngle = Angle(90,0,90)
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetupInventory(opWep)
	if self.CustomInventory then self:CustomInventory() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.tbl_Inventory = {}
	self:SetupInventory()
	self:SetCollisionBounds(Vector(26,26,80),Vector(-26,-26,0))
	local v1,v2 = self:GetCollisionBounds()
	self.Height = v2.z
	self.DefaultDistance = self.MeleeAttackDistance
	self.atkData = {
		["left"] = {dmg=18,dist=120},
		["right"] = {dmg=18,dist=120},
		["leftpower"] = {dmg=25,dist=120},
		["rightpower"] = {dmg=25,dist=120},
		["power"] = {dmg=34,dist=120},
		["forwardpower"] = {dmg=34,dist=140},
	}
	self.sndData = {
		["Melee"] = {
			tbl={
				"vj_fallout/mirelurk/mirelurk_attack01.mp3",
				"vj_fallout/mirelurk/mirelurk_attack02.mp3",
			},
			vol=75,
			pitch=100
		},
		["MeleePower"] = {
			tbl={
				"vj_fallout/mirelurk/mirelurk_attackpower01.mp3",
			},
			vol=75,
			pitch=100
		},
		["MeleePowerRun"] = {
			tbl={
				"vj_fallout/mirelurk/mirelurk_attackpowerforward01.mp3",
				"vj_fallout/mirelurk/mirelurk_attackpowerrun01.mp3"
			},
			vol=75,
			pitch=100
		},
		["IdleAngry"] = {
			tbl={
				"vj_fallout/mirelurk/mirelurk_warning.mp3",
			},
			vol=75,
			pitch=100
		}
	}
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert()
	if math.random(1,4) == 1 then
		self:VJ_ACT_PLAYACTIVITY(ACT_IDLE_ANGRY,true,false,true)
		if self.tbl_Flames then
			for i,data in pairs(self.tbl_Flames) do
				self:Particle(i,3)
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	-- print(key)
	if key == "event_emit FootLeft" then
		VJ_EmitSound(self,self.SoundTbl_FootStepL,self.FootStepSoundLevel,self.sndData["Melee"].pitch)
		if self.tbl_Flames then
			util.ScreenShake(self:GetPos(),13,100,1,1000)
		end
	elseif key == "event_emit FootRight" then
		VJ_EmitSound(self,self.SoundTbl_FootStepR,self.FootStepSoundLevel,self.sndData["Melee"].pitch)
		if self.tbl_Flames then
			util.ScreenShake(self:GetPos(),13,100,1,1000)
		end
	elseif string.find(key,"event_play") then
		local snd = string.Replace(key,"event_play ","")
		VJ_EmitSound(self,self.sndData[snd].tbl,self.sndData[snd].vol,self.sndData[snd].pitch)
	elseif string.find(key,"event_mattack") then
		local atk = string.Replace(key,"event_mattack ","")
		self.MeleeAttackDamage = self.atkData[atk].dmg
		self.MeleeAttackDamageDistance = self.atkData[atk].dist
		self:MeleeAttackCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	local time = self:GetPathTimeToGoal()
	if self.NearestPointToEnemyDistance > self.DefaultDistance && time > 0.5 && time < 1.5 && math.random(1,20) == 1 then
		self.MeleeAttackDistance = self.DefaultDistance *2
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK2}
		self.HasMeleeAttackKnockBack = true
		self.MeleeAttackKnockBack_Forward1 = 270
		self.MeleeAttackKnockBack_Forward2 = 290
		self.MeleeAttackKnockBack_Up1 = self.Height +(self.Height *0.8)
		self.MeleeAttackKnockBack_Up2 = self.Height +(self.Height *0.9)
	else
		self.MeleeAttackDistance = self.DefaultDistance
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}
		self.HasMeleeAttackKnockBack = false
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
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup)
	if dmginfo:IsBulletDamage() then
		if hitgroup == 101 then
			dmginfo:ScaleDamage(1.5)
		else
			dmginfo:ScaleDamage(self.BulletResistance)
		end
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