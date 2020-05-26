AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/deathclaw.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 500
ENT.HullType = HULL_LARGE
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_DEATHCLAW"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDistance = 80
ENT.MeleeAttackDamageDistance = 110
ENT.MeleeAttackDamage = 100
ENT.DisableFootStepSoundTimer = true

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
	"vj_fallout/deathclaw/foot/deathclaw_foot_run_l01.mp3",
	"vj_fallout/deathclaw/foot/deathclaw_foot_run_l02.mp3",
}
ENT.SoundTbl_FootStepR = {
	"vj_fallout/deathclaw/foot/deathclaw_foot_run_r01.mp3",
	"vj_fallout/deathclaw/foot/deathclaw_foot_run_r02.mp3",
}
ENT.SoundTbl_Idle = {
	"vj_fallout/deathclaw/deathclaw_idle01.mp3",
	"vj_fallout/deathclaw/deathclaw_idle02.mp3",
	"vj_fallout/deathclaw/deathclaw_idle03.mp3",
	"vj_fallout/deathclaw/deathclaw_idle04.mp3",
}
ENT.SoundTbl_Alert = {
	"vj_fallout/deathclaw/deathclaw_chase01.mp3",
	"vj_fallout/deathclaw/deathclaw_chase02.mp3",
	"vj_fallout/deathclaw/deathclaw_chase03.mp3",
}
ENT.SoundTbl_BeforeMeleeAttack = {
	"vj_fallout/deathclaw/deathclaw_attack01.mp3",
	"vj_fallout/deathclaw/deathclaw_attack02.mp3",
	"vj_fallout/deathclaw/deathclaw_attackpower01.mp3",
	"vj_fallout/deathclaw/deathclaw_attackpowerforward01.mp3",
	"vj_fallout/deathclaw/deathclaw_poweratk01.mp3",
	"vj_fallout/deathclaw/deathclaw_poweratk02.mp3",
	"vj_fallout/deathclaw/deathclaw_poweratk03.mp3",
}
ENT.SoundTbl_MeleeAttack = {
	"vj_fallout/deathclaw/deathclaw_claw_atk01.mp3",
	"vj_fallout/deathclaw/deathclaw_claw_atk02.mp3",
	"vj_fallout/deathclaw/deathclaw_claw_atk03.mp3",
	"vj_fallout/deathclaw/deathclaw_claw_atk04.mp3",
}
ENT.SoundTbl_Pain = {
	"vj_fallout/deathclaw/deathclaw_pain01.mp3",
	"vj_fallout/deathclaw/deathclaw_pain02.mp3",
}
ENT.SoundTbl_Death = {
	"vj_fallout/deathclaw/deathclaw_death01.mp3",
	"vj_fallout/deathclaw/deathclaw_death02.mp3",
}

ENT.FootStepSoundLevel = 85
ENT.HasWorldShakeOnMove = true -- Should the world shake when it's moving?
ENT.WorldShakeOnMoveAmplitude = 5 -- How much the screen will shake | From 1 to 16, 1 = really low 16 = really high
ENT.WorldShakeOnMoveRadius = 750 -- How far the screen shake goes, in world units
ENT.WorldShakeOnMoveDuration = 0.2 -- How long the screen shake will last, in seconds
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetupInventory(opWep)
	if self.CustomInventory then self:CustomInventory() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnFlinch_AfterFlinch(dmginfo,hitgroup)
	if self:GetBodygroup(1) == 1 && hitgroup == 101 then
		local ent = dmginfo:GetAttacker()
		for i = 1,3 do
			timer.Simple(0.15 *i,function()
				if IsValid(self) then
					local posA,ang = self:GetBonePosition(48)
					local posB,ang = self:GetBonePosition(50)

					VJ_EmitSound(self,"weapons/stunstick/spark" .. i .. ".wav",80)

					self.DamageSpark1 = ents.Create("env_spark")
					self.DamageSpark1:SetKeyValue("Magnitude","1")
					self.DamageSpark1:SetKeyValue("Spark Trail Length","1")
					self.DamageSpark1:SetPos(posA +Vector(0,0,3))
					self.DamageSpark1:SetAngles(self:GetAngles())
					self.DamageSpark1:SetParent(self)
					self.DamageSpark1:Spawn()
					self.DamageSpark1:Activate()
					self.DamageSpark1:Fire("StartSpark","",0)
					self.DamageSpark1:Fire("StopSpark","",0.001)
					self:DeleteOnRemove(self.DamageSpark1)

					self.DamageSpark1 = ents.Create("env_spark")
					self.DamageSpark1:SetKeyValue("Magnitude","1")
					self.DamageSpark1:SetKeyValue("Spark Trail Length","1")
					self.DamageSpark1:SetPos(posB +Vector(0,0,3))
					self.DamageSpark1:SetAngles(self:GetAngles())
					self.DamageSpark1:SetParent(self)
					self.DamageSpark1:Spawn()
					self.DamageSpark1:Activate()
					self.DamageSpark1:Fire("StartSpark","",0)
					self.DamageSpark1:Fire("StopSpark","",0.001)
					self:DeleteOnRemove(self.DamageSpark1)

					if i == 3 then
						local effectdata = EffectData()
						effectdata:SetOrigin(posA +Vector(0,0,1))
						util.Effect("HelicopterMegaBomb",effectdata)

						VJ_EmitSound(self,"weapons/grenade_launcher1.wav",80)

						self:SetBodygroup(1,0)
						self.VJ_NPC_Class = {"CLASS_DEATHCLAW"}
						self:ResetEnemy(true)

						if IsValid(ent) then
							table.insert(self.VJ_AddCertainEntityAsFriendly,ent)
							timer.Simple(30,function()
								if IsValid(self) && IsValid(ent) then
									table.Empty(self.VJ_AddCertainEntityAsFriendly)
									table.insert(self.VJ_AddCertainEntityAsEnemy,ent)
									self:AddEntityRelationship(ent,D_HT,100)
									self:VJ_DoSetEnemy(ent,true,true)
									self:SetEnemy(ent)
								end
							end)
						end
					end
				end
			end)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert()

end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.tbl_Inventory = {}
	self:SetupInventory()
	self:SetCollisionBounds(Vector(40,40,120),Vector(-40,-40,0))
	local v1,v2 = self:GetCollisionBounds()
	self.Height = v2.z
	self.DefaultDistance = self.MeleeAttackDistance
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "event_emit FootLeft" or key == "event_emit FootRunLeft" then
		VJ_EmitSound(self,self.SoundTbl_FootStepL,self.FootStepSoundLevel,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
		if self.HasWorldShakeOnMove then util.ScreenShake(self:GetPos(), self.WorldShakeOnMoveAmplitude, self.WorldShakeOnMoveFrequency, self.WorldShakeOnMoveDuration, self.WorldShakeOnMoveRadius) end
	elseif key == "event_emit FootRight" or key == "event_emit FootRunRight" then
		VJ_EmitSound(self,self.SoundTbl_FootStepR,self.FootStepSoundLevel,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
		if self.HasWorldShakeOnMove then util.ScreenShake(self:GetPos(), self.WorldShakeOnMoveAmplitude, self.WorldShakeOnMoveFrequency, self.WorldShakeOnMoveDuration, self.WorldShakeOnMoveRadius) end
	elseif string.find(key,"event_mattack") then
		local atk = string.Replace(key,"event_mattack ","")
		if atk == "power" || atk == "forwardpower" then
			self.MeleeAttackDamageType = bit.bor(DMG_SLASH,DMG_ALWAYSGIB)
		else
			self.MeleeAttackDamageType = DMG_SLASH
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
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,GetCorpse)
	GetCorpse.tbl_Inventory = self.tbl_Inventory
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()

end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/