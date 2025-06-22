AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/dogskin.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 200

ENT.HasHealthRegeneration = false
ENT.HealthRegenerationAmount = 1
ENT.HealthRegenerationDelay = VJ.SET(1, 1)
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_DOG"} -- NPCs with the same class with be allied to each other
ENT.PlayerFriendly = true
ENT.FriendsWithAllPlayerAllies = true

ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDistance = 80
ENT.MeleeAttackDamageDistance = 110
ENT.MeleeAttackDamage = 12

	-- ====== File Path Variables ====== --
	-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {
	"vj_fallout/dog/foot/dog_foot01.mp3",
	"vj_fallout/dog/foot/dog_foot02.mp3",
	"vj_fallout/dog/foot/dog_foot03.mp3",
	"vj_fallout/dog/foot/dog_foot04.mp3",
	"vj_fallout/dog/foot/dog_foot05.mp3",
	"vj_fallout/dog/foot/dog_foot06.mp3",
}
ENT.SoundTbl_Idle = {
	"vj_fallout/dog/dog_idle_pant01.mp3",
	"vj_fallout/dog/dog_idle_pant02.mp3",
	"vj_fallout/dog/dog_idle_pant03.mp3",
	"vj_fallout/dog/dog_idle_pant04.mp3",
	"vj_fallout/dog/dog_idle_pant05.mp3",
	"vj_fallout/dog/dog_idle_pant06.mp3",
	"vj_fallout/dog/dog_sniff01.mp3",
	"vj_fallout/dog/dog_sniff02.mp3",
	"vj_fallout/dog/dog_sniff03.mp3",
	"vj_fallout/dog/dog_sniff04.mp3",
	"vj_fallout/dog/dog_sniff05.mp3",
	"vj_fallout/dog/dog_sniff06.mp3",
}
ENT.SoundTbl_Alert = {
	"vj_fallout/dog/dog_growl01.mp3",
	"vj_fallout/dog/dog_growl02.mp3",
	"vj_fallout/dog/dog_growl03.mp3",
	"vj_fallout/dog/dog_growl04.mp3",
	"vj_fallout/dog/dog_growl05.mp3",
	"vj_fallout/dog/dog_growl06.mp3",
	"vj_fallout/dog/dog_growl07.mp3",
}
ENT.SoundTbl_BeforeMeleeAttack = {
	"vj_fallout/dog/dog_attackmid01.mp3",
	"vj_fallout/dog/dog_attackmid02.mp3",
	"vj_fallout/dog/dog_attackforward01.mp3",
	"vj_fallout/dog/dog_attackforward02.mp3",
	"vj_fallout/dog/dog_attackforward03.mp3",
	"vj_fallout/dog/dog_attackforward04.mp3",
	"vj_fallout/dog/dog_attackforward05.mp3",
	"vj_fallout/dog/dog_attackforward06.mp3",
}
ENT.SoundTbl_IdleDialogue = {
	"vj_fallout/dog/dog_bark01.mp3",
	"vj_fallout/dog/dog_bark02.mp3",
	"vj_fallout/dog/dog_bark03.mp3",
	"vj_fallout/dog/dog_bark04.mp3",
	"vj_fallout/dog/dog_bark05.mp3",
	"vj_fallout/dog/dog_bark06.mp3",
	"vj_fallout/dog/dog_bark07.mp3",
	"vj_fallout/dog/dog_bark08.mp3",
	"vj_fallout/dog/dog_bark09.mp3",
	"vj_fallout/dog/dog_bark10.mp3",
	"vj_fallout/dog/dog_whimper01.mp3",
	"vj_fallout/dog/dog_whimper02.mp3",
	"vj_fallout/dog/dog_whimper03.mp3",
}
ENT.SoundTbl_IdleDialogueAnswer = {
	"vj_fallout/dog/dog_bark01.mp3",
	"vj_fallout/dog/dog_bark02.mp3",
	"vj_fallout/dog/dog_bark03.mp3",
	"vj_fallout/dog/dog_bark04.mp3",
	"vj_fallout/dog/dog_bark05.mp3",
	"vj_fallout/dog/dog_bark06.mp3",
	"vj_fallout/dog/dog_bark07.mp3",
	"vj_fallout/dog/dog_bark08.mp3",
	"vj_fallout/dog/dog_bark09.mp3",
	"vj_fallout/dog/dog_bark10.mp3",
	"vj_fallout/dog/dog_whimper01.mp3",
	"vj_fallout/dog/dog_whimper02.mp3",
	"vj_fallout/dog/dog_whimper03.mp3",
}
ENT.SoundTbl_Pain = {
	"vj_fallout/dog/dog_injured01.mp3",
	"vj_fallout/dog/dog_injured02.mp3",
	"vj_fallout/dog/dog_injured03.mp3",
	"vj_fallout/dog/dog_injured04.mp3",
	"vj_fallout/dog/dog_injured05.mp3",
	"vj_fallout/dog/dog_injured06.mp3",
}
ENT.SoundTbl_Death = {
	"vj_fallout/dog/dog_death01.mp3",
	"vj_fallout/dog/dog_death02.mp3",
	"vj_fallout/dog/dog_death03.mp3",
	"vj_fallout/dog/dog_death04.mp3",
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetupInventory(opWep)
	if self.CustomInventory then self:CustomInventory() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DogInit()
	self:SetSkin(math.random(0,math.random(0,1)))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInvestigate(argent)
	self.NextBarkT = self.NextBarkT or CurTime() -1
	if CurTime() > self.NextBarkT then
		self:VJ_ACT_PLAYACTIVITY("vjseq_specialidle_barksingle",true,false,true)
		timer.Simple(0.5,function() if IsValid(self) then VJ_EmitSound(self,"vj_fallout/dog/dog_bark0" .. math.random(1,9) .. ".mp3",80) end end)
		self.NextBarkT = CurTime() +math.Rand(4,6)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert(argent)
	self.NextBarkT = self.NextBarkT or CurTime() -1
	if self.FollowingPlayer && CurTime() > self.NextBarkT then
		self:VJ_ACT_PLAYACTIVITY("vjseq_specialidle_barksingle",true,false,true)
		timer.Simple(0.5,function() if IsValid(self) then VJ_EmitSound(self,"vj_fallout/dog/dog_bark0" .. math.random(1,9) .. ".mp3",80) end end)
		self.NextBarkT = CurTime() +math.Rand(3,6)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.tbl_Inventory = {}
	self:SetupInventory()
	self:SetCollisionBounds(Vector(20,20,45),Vector(-20,-20,0))
	local v1,v2 = self:GetCollisionBounds()
	self.Height = v2.z
	self.DefaultDistance = self.MeleeAttackDistance
	
	if self.PlayerFriendly then
		self.HasHealthRegeneration = true
		table.insert(self.VJ_NPC_Class,"CLASS_PLAYER_ALLY")
		self.SoundTbl_OnPlayerSight = {
			"vj_fallout/dog/dog_bark01.mp3",
			"vj_fallout/dog/dog_bark02.mp3",
			"vj_fallout/dog/dog_bark03.mp3",
			"vj_fallout/dog/dog_bark04.mp3",
			"vj_fallout/dog/dog_bark05.mp3",
			"vj_fallout/dog/dog_bark06.mp3",
			"vj_fallout/dog/dog_bark07.mp3",
			"vj_fallout/dog/dog_bark08.mp3",
			"vj_fallout/dog/dog_bark09.mp3",
			"vj_fallout/dog/dog_bark10.mp3",
		}
	end
	
	if self.DogInit then self:DogInit() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "event_emit Foot" then
		VJ_EmitSound(self,self.SoundTbl_FootStep,self.FootStepSoundLevel,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
	elseif string.find(key,"event_mattack") then
		local atk = string.Replace(key,"event_mattack ","")
		self:MeleeAttackCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:TranslateActivity(act)
	if act == ACT_IDLE then
		return (self:Health() <= self:GetMaxHealth() *0.5) && ACT_IDLE or (self.Alerted && ACT_IDLE_ANGRY or ACT_IDLE)
	elseif act == ACT_WALK then
		return (self:Health() <= self:GetMaxHealth() *0.5) && ACT_WALK_HURT or (self.Alerted && ACT_WALK_AGITATED or ACT_WALK)
	elseif act == ACT_RUN then
		return (self:Health() <= self:GetMaxHealth() *0.5) && ACT_RUN_HURT or (self.Alerted && ACT_RUN_AGITATED or ACT_RUN)
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
function ENT:MultipleMeleeAttacks()
	local time = self:GetPathTimeToGoal()
	if !(self:Health() <= self:GetMaxHealth() *0.5) && self.EnemyData.DistanceNearest > self.DefaultDistance && time > 0.5 && time < 1.5 then
		self.MeleeAttackDistance = self.DefaultDistance *2
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK2,ACT_RANGE_ATTACK1_LOW}
	else
		self.MeleeAttackDistance = self.DefaultDistance
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}
		self.HasMeleeAttackKnockBack = false
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