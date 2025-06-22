AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
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
	if !(self:Health() <= self:GetMaxHealth() *0.35) && self.EnemyData.DistanceNearest > self.DefaultDistance && time > 0.5 && time < 1.5 && math.random(1,20) == 1 then
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
function ENT:TranslateActivity(act)
	if act == ACT_IDLE then
		return (self:Health() <= self:GetMaxHealth() *0.35) && ACT_IDLE or (self.Alerted && ACT_IDLE_ANGRY or ACT_IDLE)
	elseif act == ACT_WALK then
		return (self:Health() <= self:GetMaxHealth() *0.35) && ACT_WALK_HURT or (self.Alerted && ACT_WALK_AIM or ACT_WALK)
	elseif act == ACT_RUN then
		return (self:Health() <= self:GetMaxHealth() *0.35) && ACT_RUN_HURT or ACT_RUN
	end

	local translation = self.AnimationTranslations[act]
	if translation then
		if istable(translation) then
			if act == ACT_IDLE then
				self:ResolveAnimation(translation)
			end
			return translation[math.random(1, #translation)] or act -- "or act" = To make sure it doesn't return nil when the table is empty!
		else
			return translation
		end
	end
	return act
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnThinkActive()
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
	self.FlyLoop:Stop()
end
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/