AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/dogskin.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 30
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
function ENT:CustomOnInitialize()
	self.tbl_Inventory = {}
	self:SetupInventory()
	self:SetCollisionBounds(Vector(20,20,45),Vector(-20,-20,0))
	local v1,v2 = self:GetCollisionBounds()
	self.Height = v2.z
	self.DefaultDistance = self.MeleeAttackDistance
	
	if self.PlayerFriendly then
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
function ENT:CustomOnThink()
	local idle = self.Alerted && ACT_IDLE_ANGRY or ACT_IDLE
	local walk = self.Alerted && ACT_WALK_AGITATED or ACT_WALK
	local run = self.Alerted && ACT_RUN_AGITATED or ACT_RUN
	if (self:Health() <= self:GetMaxHealth() *0.5) then idle = ACT_IDLE; walk = ACT_WALK_HURT; run = ACT_RUN_HURT end
	self.AnimTbl_IdleStand = {idle}
	self.AnimTbl_Walk = {walk}
	self.AnimTbl_Run = {run}
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	local time = self:GetPathTimeToGoal()
	if !(self:Health() <= self:GetMaxHealth() *0.5) && self.NearestPointToEnemyDistance > self.DefaultDistance && time > 0.5 && time < 1.5 then
		self.MeleeAttackDistance = self.DefaultDistance *2
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK2,ACT_RANGE_ATTACK1_LOW}
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