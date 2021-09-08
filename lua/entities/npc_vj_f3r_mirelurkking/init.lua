AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/mirelurkking.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 375
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_MIRELURK"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "White" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDistance = 80
ENT.Immune_AcidPoisonRadiation = true

ENT.BulletResistance = 0.75

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.RangeAttackEntityToSpawn = "obj_vj_f3r_sonic" -- The entity that is spawned when range attacking
ENT.AnimTbl_RangeAttack = {ACT_RANGE_ATTACK1} -- Range Attack Animations
ENT.RangeDistance = 1500 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 200 -- How close does it have to be until it uses melee?
ENT.TimeUntilRangeAttackProjectileRelease = false -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = 6 -- How much time until it can use a range attack?
ENT.RangeUseAttachmentForPos = true -- Should the projectile spawn on a attachment?
ENT.RangeUseAttachmentForPosID = "mouth"
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
	"vj_fallout/mirelurkking/foot/mirelurkking_foot_l01.mp3",
	"vj_fallout/mirelurkking/foot/mirelurkking_foot_l02.mp3",
}
ENT.SoundTbl_FootStepR = {
	"vj_fallout/mirelurkking/foot/mirelurkking_foot_r01.mp3",
	"vj_fallout/mirelurkking/foot/mirelurkking_foot_r02.mp3",
}
ENT.SoundTbl_Idle = {
	"vj_fallout/mirelurkking/mirelurkking_idle_feeding.mp3"
}
ENT.SoundTbl_Pain = {
	"vj_fallout/mirelurkking/mirelurkking_injured01.mp3",
	"vj_fallout/mirelurkking/mirelurkking_injured02.mp3",
}
ENT.SoundTbl_Death = {
	"vj_fallout/mirelurkking/mirelurkking_death01.mp3",
	"vj_fallout/mirelurkking/mirelurkking_death02.mp3",
}
ENT.BulletResistance = 1
ENT.Controller_FirstPersonBone = "Bip01 Head"
ENT.Controller_FirstPersonOffset = Vector(4,0,5)
ENT.Controller_FirstPersonAngle = Angle(90,0,90)

ENT.IsKing = true
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetupInventory(opWep)
	if self.CustomInventory then self:CustomInventory() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackCode_GetShootPos(TheProjectile)
	return self:CalculateProjectile("Curve",self:GetAttachment(self:LookupAttachment(self.RangeUseAttachmentForPosID)).Pos,self:GetEnemy():GetPos() +self:GetEnemy():OBBCenter() +self:GetEnemy():GetUp() *30,1500)
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
		["leftjab"] = {dmg=35,dist=120},
		["rightjab"] = {dmg=35,dist=120},
		["leftslice"] = {dmg=35,dist=120},
		["rightslice"] = {dmg=35,dist=120},
		["backhand"] = {dmg=45,dist=120},
		["forward"] = {dmg=45,dist=140},
	}
	self.sndData = {
		["Attack"] = {
			tbl={
				"vj_fallout/mirelurkking/mirelurkking_attack01.mp3",
				"vj_fallout/mirelurkking/mirelurkking_attack02.mp3",
				"vj_fallout/mirelurkking/mirelurkking_attack03.mp3",
			},
			vol=75,
			pitch=100
		},
		["MeleePower"] = {
			tbl={
				"vj_fallout/mirelurkking/mirelurkking_attack03.mp3",
			},
			vol=75,
			pitch=100
		},
		["MeleePowerRun"] = {
			tbl={
				"vj_fallout/mirelurkking/mirelurkking_attack03.mp3"
			},
			vol=75,
			pitch=100
		},
		["IdleAngry"] = {
			tbl={
				"vj_fallout/mirelurkking/mirelurkking_equip.mp3",
			},
			vol=82,
			pitch=100
		}
	}
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert()
	if math.random(1,4) == 1 then
		self:VJ_ACT_PLAYACTIVITY("vjseq_specialidle_alert",true,false,true)
		VJ_EmitSound(self,self.sndData["IdleAngry"].tbl,self.sndData["IdleAngry"].vol,self.sndData["IdleAngry"].pitch)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRangeAttack_AfterStartTimer()
	if self.IsKing then
		timer.Simple(0.2,function()
			if IsValid(self) && self.RangeAttacking then
				ParticleEffectAttach("fo3_mirelurk_pulse",PATTACH_POINT_FOLLOW,self,1)
			end
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	-- print(key)
	if key == "event_emit FootLeft" then
		VJ_EmitSound(self,self.SoundTbl_FootStepL,self.FootStepSoundLevel,self.sndData["Attack"].pitch)
	elseif key == "event_emit FootRight" then
		VJ_EmitSound(self,self.SoundTbl_FootStepR,self.FootStepSoundLevel,self.sndData["Attack"].pitch)
	elseif string.find(key,"event_play") then
		local snd = string.Replace(key,"event_play ","")
		VJ_EmitSound(self,self.sndData[snd].tbl,self.sndData[snd].vol,self.sndData[snd].pitch)
	elseif string.find(key,"event_mattack") then
		local atk = string.Replace(key,"event_mattack ","")
		self.MeleeAttackDamage = self.atkData[atk].dmg
		self.MeleeAttackDamageDistance = self.atkData[atk].dist
		self:MeleeAttackCode()
	elseif string.find(key,"event_rattack") then
		local atk = string.Replace(key,"event_rattack ","")
		VJ_EmitSound(self,"vj_fallout/mirelurkking/mirelurkking_attack_sonic.mp3",80,100)
		self:StopParticles()
		self:RangeAttackCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	local time = self:GetPathTimeToGoal()
	if self.NearestPointToEnemyDistance > self.DefaultDistance && time > 0.2 && time < 1.5 && math.random(1,20) == 1 then
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
			dmginfo:ScaleDamage(self.BulletResistance or 1)
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