AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/radscorpion.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 350
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_RADSCORPION"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDistance = 80
ENT.Immune_AcidPoisonRadiation = true

ENT.BulletResistance = 0.7

	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 12 -- Chance of it flinching from 1 to x | 1 will make it always flinch
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
	"vj_fallout/radscorpion/foot/radscorpion_foot_l01.mp3",
	"vj_fallout/radscorpion/foot/radscorpion_foot_l02.mp3",
}
ENT.SoundTbl_FootStepR = {
	"vj_fallout/radscorpion/foot/radscorpion_foot_r01.mp3",
	"vj_fallout/radscorpion/foot/radscorpion_foot_r02.mp3",
}
ENT.SoundTbl_Idle = {
	"vj_fallout/radscorpion/radscorpion_idle01.mp3",
	"vj_fallout/radscorpion/radscorpion_idle02.mp3",
}
ENT.SoundTbl_Alert = {
	"vj_fallout/radscorpion/radscorpion_chase01.mp3",
	"vj_fallout/radscorpion/radscorpion_chase02.mp3",
	"vj_fallout/radscorpion/radscorpion_chase03.mp3",
	"vj_fallout/radscorpion/radscorpion_chase04.mp3",
	"vj_fallout/radscorpion/radscorpion_chase05.mp3",
}
ENT.SoundTbl_Pain = {
	"vj_fallout/radscorpion/radscorpion_injured01.mp3",
	"vj_fallout/radscorpion/radscorpion_injured02.mp3",
}
ENT.SoundTbl_Death = {
	"vj_fallout/radscorpion/radscorpion_death01.mp3",
	"vj_fallout/radscorpion/radscorpion_death02.mp3",
}
ENT.BulletResistance = 0.85
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetupInventory(opWep)
	if self.CustomInventory then self:CustomInventory() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.tbl_Inventory = {}
	self:SetupInventory()
	self:SetCollisionBounds(Vector(50,50,60),Vector(-50,-50,0))
	local v1,v2 = self:GetCollisionBounds()
	self.Height = v2.z
	self.DefaultDistance = self.MeleeAttackDistance
	self.atkData = {
		["left"] = {dmg=28,dist=145},
		["right"] = {dmg=28,dist=145},
		["leftpower"] = {dmg=35,dist=145},
		["rightpower"] = {dmg=35,dist=145},
		["power"] = {dmg=45,dist=180},
		["forwardpower"] = {dmg=45,dist=180},
	}
	self.sndData = {
		["Melee"] = {
			tbl={
				"vj_fallout/radscorpion/radscorpion_attack01.mp3",
				"vj_fallout/radscorpion/radscorpion_attack02.mp3",
				"vj_fallout/radscorpion/radscorpion_attack03.mp3",
			},
			vol=75,
			pitch=100
		},
		["MeleePower"] = {
			tbl={
				"vj_fallout/radscorpion/radscorpion_attacktail01.mp3",
			},
			vol=75,
			pitch=100
		},
		["MeleePowerRun"] = {
			tbl={
				"vj_fallout/radscorpion/radscorpion_attacktail01.mp3"
			},
			vol=75,
			pitch=100
		},
		["AttackSting"] = {
			tbl={
				"vj_fallout/radscorpion/radscorpion_attackstingvox01.mp3",
				"vj_fallout/radscorpion/radscorpion_attackstingvox02.mp3",
				"vj_fallout/radscorpion/radscorpion_attackstingvox03.mp3",
				"vj_fallout/radscorpion/radscorpion_attackstingvox04.mp3",
			},
			vol=75,
			pitch=100
		},
		["Strike"] = {
			tbl={
				"vj_fallout/radscorpion/radscorpion_strikevox01.mp3",
				"vj_fallout/radscorpion/radscorpion_strikevox02.mp3",
				"vj_fallout/radscorpion/radscorpion_strikevox03.mp3",
				"vj_fallout/radscorpion/radscorpion_strikevox04.mp3",
			},
			vol=75,
			pitch=100
		},
		["IdleAngry"] = {
			tbl={
				"vj_fallout/radscorpion/radscorpion_aware.mp3",
			},
			vol=75,
			pitch=100
		}
	}
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert()
	if math.random(1,4) == 1 then
		self:VJ_ACT_PLAYACTIVITY(ACT_IDLE_AGITATED,true,false,true)
		VJ_EmitSound(self,self.sndData["IdleAngry"].tbl,self.sndData["IdleAngry"].vol,self.sndData["IdleAngry"].pitch)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
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
		if atk == "power" || atk == "forwardpower" then
			VJ_EmitSound(self,"vj_fallout/radscorpion/radscorpion_attacksting0" .. math.random(1,3) .. ".mp3",65,100)
			self.MeleeAttackDamageType = bit.bor(DMG_DIRECT,DMG_POISON)
		else
			VJ_EmitSound(self,"vj_fallout/radscorpion/radscorpion_clawatk0" .. math.random(1,3) .. ".mp3",65,100)
			self.MeleeAttackDamageType = DMG_SLASH
		end
		self:MeleeAttackCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	local time = self:GetPathTimeToGoal()
	if self.NearestPointToEnemyDistance > self.DefaultDistance && time > 0.5 && time < 1.5 && math.random(1,20) == 1 then
		self.MeleeAttackDistance = self.DefaultDistance *2
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK2}
		self.MeleeAttackDamageType = DMG_POISON
		self.HasMeleeAttackKnockBack = true
		self.MeleeAttackKnockBack_Forward1 = 270
		self.MeleeAttackKnockBack_Forward2 = 290
		self.MeleeAttackKnockBack_Up1 = self.Height +(self.Height *0.8)
		self.MeleeAttackKnockBack_Up2 = self.Height +(self.Height *0.9)
	else
		self.MeleeAttackDistance = self.DefaultDistance
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}
		self.MeleeAttackDamageType = DMG_SLASH
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