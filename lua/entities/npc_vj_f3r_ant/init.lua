AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/giantant.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 150
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_GIANTANT"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)

ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDistance = 80
ENT.MeleeAttackDamageDistance = 110
ENT.MeleeAttackDamage = 24

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
		HitGroup = {104,106},
		Animation = {ACT_FLINCH_LEFTARM}
	},
	{
		HitGroup = {105,107},
		Animation = {ACT_FLINCH_RIGHTARM}
	},
}

	-- ====== File Path Variables ====== --
	-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStepL = {
	"vj_fallout/giantant/foot/ant_foot_l01.mp3",
	"vj_fallout/giantant/foot/ant_foot_l02.mp3",
}
ENT.SoundTbl_FootStepR = {
	"vj_fallout/giantant/foot/ant_foot_r01.mp3",
	"vj_fallout/giantant/foot/ant_foot_r02.mp3",
}
ENT.SoundTbl_Idle = {
	"vj_fallout/giantant/ant_idle01.mp3",
	"vj_fallout/giantant/ant_idle02.mp3",
	"vj_fallout/giantant/ant_idle03.mp3",
}
ENT.SoundTbl_BeforeMeleeAttack = {
	"vj_fallout/giantant/ant_attack01.mp3",
	"vj_fallout/giantant/ant_attack02.mp3",
	"vj_fallout/giantant/ant_attack03.mp3",
}
ENT.SoundTbl_Pain = {
	"vj_fallout/giantant/ant_injured01.mp3",
	"vj_fallout/giantant/ant_injured02.mp3",
	"vj_fallout/giantant/ant_injured03.mp3",
	"vj_fallout/giantant/ant_injured04.mp3",
}
ENT.SoundTbl_Death = {
	"vj_fallout/giantant/ant_death01.mp3",
	"vj_fallout/giantant/ant_death02.mp3",
}

ENT.HasFlameAttack = false
ENT.RangeDistance = 200

ENT.VJC_Data = {
    CameraMode = 1, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
    ThirdP_Offset = Vector(0,0,-20), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "Bip01 Head", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(8, 0, 4), -- The offset for the controller when the camera is in first person
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetupInventory(opWep)
	if self.CustomInventory then self:CustomInventory() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.tbl_Inventory = {}
	self:SetupInventory()
	self:SetCollisionBounds(Vector(28,28,40),Vector(-28,-28,0))
	local v1,v2 = self:GetCollisionBounds()
	self.Height = v2.z
	self.DefaultDistance = self.MeleeAttackDistance
	
	self.FlameLP = CreateSound(self,"vj_fallout/giantant/flamerant_fire_lp.wav")
	self.FlameLP:ChangeVolume(78)

	self.InAttack = false
	self.NextRangeAttackT = CurTime() +1
	self.LastFlameT = CurTime() +1
	
	if self.AntInit then self:AntInit() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "event_emit FootLeft" then
		VJ_EmitSound(self,self.SoundTbl_FootStepL,self.FootStepSoundLevel,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
	elseif key == "event_emit FootRight" then
		VJ_EmitSound(self,self.SoundTbl_FootStepR,self.FootStepSoundLevel,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
	elseif string.find(key,"event_mattack") then
		local atk = string.Replace(key,"event_mattack ","")
		self:MeleeAttackCode()
	elseif string.find(key,"event_rattack") then
		local atk = string.Replace(key,"event_rattack ","")
		if atk == "start" then // RANGE_ATTACK2
			self.FlameLP:Stop()
			self.FlameLP:Play()
			
			local att = self:GetAttachment(self:LookupAttachment("mouth"))
			local spawnparticle = ents.Create("info_particle_system")
			spawnparticle:SetKeyValue("start_active","1")
			spawnparticle:SetKeyValue("effect_name","flame_gargantua")
			spawnparticle:SetPos(att.Pos)
			spawnparticle:SetAngles(att.Ang)
			spawnparticle:Spawn()
			spawnparticle:Activate()
			spawnparticle:SetParent(self)
			spawnparticle:Fire("SetParentAttachment","mouth")
			self:DeleteOnRemove(spawnparticle)
			self.Flame = spawnparticle
		end
		if atk == "flame" then
			self:DoFlameDamage(225,5,self)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	if self:Health() <= self:GetMaxHealth() *0.35 then
		self.AnimTbl_Walk = {ACT_WALK_HURT}
		self.AnimTbl_Run = {ACT_RUN_HURT}
	end

	if (self:GetActivity() != ACT_RANGE_ATTACK1 && self:GetActivity() != ACT_ARM) && self.FlameLP:IsPlaying() && CurTime() > self.LastFlameT then
		SafeRemoveEntity(self.Flame)
		self.FlameLP:Stop()
	end
	
	local enemy = self:GetEnemy()
	if IsValid(enemy) then
		local dist = self.NearestPointToEnemyDistance
		local cont = self.VJ_IsBeingControlled
		if self.HasFlameAttack then
			if cont then
				if self.MeleeAttacking then return end
				if self.InAttack then
					if self.VJ_TheController:KeyDown(IN_ATTACK2) then
						self:VJ_ACT_PLAYACTIVITY(ACT_RANGE_ATTACK1,true,false,true)
						self.NextRangeAttackT = CurTime() +1
						self.LastFlameT = CurTime() +0.2
					else
						self:VJ_ACT_PLAYACTIVITY(ACT_DISARM,true,false,true)
						self.InAttack = false
						self.NextRangeAttackT = CurTime() +3
					end
				end
				if CurTime() > self.NextRangeAttackT && self.VJ_TheController:KeyDown(IN_ATTACK2) then
					self:VJ_ACT_PLAYACTIVITY(ACT_ARM,true,false,true)
					timer.Simple(VJ_GetSequenceDuration(self,ACT_ARM),function()
						if IsValid(self) then
							self.InAttack = true
						end
					end)
					self.NextRangeAttackT = CurTime() +3
					self.LastFlameT = CurTime() +0.5
				end
				return
			end
			if /*(cont && self.VJ_TheController:KeyDown(IN_ATTACK2)) or */(!cont && dist <= self.RangeDistance && self:Visible(enemy)) then
				if self.MeleeAttacking then return end
				if CurTime() < self.NextRangeAttackT then return end
				self:VJ_ACT_PLAYACTIVITY(ACT_ARM,true,false,true)
				timer.Simple(VJ_GetSequenceDuration(self,ACT_ARM),function()
					if IsValid(self) && self:GetActivity() == ACT_ARM then
						self:VJ_ACT_PLAYACTIVITY(ACT_RANGE_ATTACK1,true,false,true)
						timer.Simple(VJ_GetSequenceDuration(self,ACT_RANGE_ATTACK1),function()
							if IsValid(self) && self:GetActivity() == ACT_RANGE_ATTACK1 then
								self:VJ_ACT_PLAYACTIVITY(ACT_DISARM,true,false,true)
							end
						end)
					end
				end)
				self.NextRangeAttackT = CurTime() +(cont && 3 or math.Rand(8,16))
			end
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
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	self.FlameLP:Stop()
end
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/