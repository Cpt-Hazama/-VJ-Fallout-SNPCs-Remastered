AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/sporecarrier.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 75
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_VAULTSPORE"} -- NPCs with the same class with be allied to each other

ENT.BloodColor = "Green" -- The blood type, this will determine what it should use (decal, particle, etc.)

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDistance = 80
ENT.MeleeAttackDamageDistance = 110
ENT.MeleeAttackDamage = 25

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
ENT.SoundTbl_FootStep = {
	"vj_fallout/sporecarrier/foot/sporecarrier_foot_l01.mp3",
	"vj_fallout/sporecarrier/foot/sporecarrier_foot_l02.mp3",
	"vj_fallout/sporecarrier/foot/sporecarrier_foot_l03.mp3",
	"vj_fallout/sporecarrier/foot/sporecarrier_foot_r01.mp3",
	"vj_fallout/sporecarrier/foot/sporecarrier_foot_r02.mp3",
	"vj_fallout/sporecarrier/foot/sporecarrier_foot_r03.mp3",
}
ENT.SoundTbl_Idle = {
	"vj_fallout/sporecarrier/sporecarrier_aimvox01.mp3",
	"vj_fallout/sporecarrier/sporecarrier_aimvox02.mp3",
	"vj_fallout/sporecarrier/sporecarrier_aimvox03.mp3",
	"vj_fallout/sporecarrier/sporecarrier_aimvox04.mp3",
}
ENT.SoundTbl_Alert = {
	"vj_fallout/sporecarrier/sporecarrier_hissvox01.mp3",
	"vj_fallout/sporecarrier/sporecarrier_hissvox02.mp3",
	"vj_fallout/sporecarrier/sporecarrier_hissvox03.mp3",
	"vj_fallout/sporecarrier/sporecarrier_hissvox04.mp3",
	"vj_fallout/sporecarrier/sporecarrier_hissvox05.mp3",
}
ENT.SoundTbl_BeforeMeleeAttack = {
	"vj_fallout/sporecarrier/sporecarrier_atkvox01.mp3",
	"vj_fallout/sporecarrier/sporecarrier_atkvox02.mp3",
	"vj_fallout/sporecarrier/sporecarrier_atkvox03.mp3",
	"vj_fallout/sporecarrier/sporecarrier_atkvox04.mp3",
	"vj_fallout/sporecarrier/sporecarrier_atkvox05.mp3",
	"vj_fallout/sporecarrier/sporecarrier_atkvox06.mp3",
	"vj_fallout/sporecarrier/sporecarrier_atkvox07.mp3",
}
ENT.SoundTbl_MeleeAttack = {
	"vj_fallout/sporecarrier/sporecarrier_armswing01.mp3",
	"vj_fallout/sporecarrier/sporecarrier_armswing02.mp3",
	"vj_fallout/sporecarrier/sporecarrier_armswing03.mp3",
	"vj_fallout/sporecarrier/sporecarrier_armswing04.mp3",
}
ENT.SoundTbl_Pain = {
	"vj_fallout/sporecarrier/sporecarrier_risevox01.mp3",
	"vj_fallout/sporecarrier/sporecarrier_risevox02.mp3",
	"vj_fallout/sporecarrier/sporecarrier_risevox03.mp3",
}
ENT.SoundTbl_Death = {}

ENT.Glow = true
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetupInventory(opWep)
	if self.CustomInventory then self:CustomInventory() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.tbl_Inventory = {}
	self:SetupInventory()
	self:SetCollisionBounds(Vector(20,20,42),Vector(-20,-20,0))
	local v1,v2 = self:GetCollisionBounds()
	self.Height = v2.z
	self.DefaultDistance = self.MeleeAttackDistance

	if self.Glow then
		for _,att in ipairs({"LClavicle","RClavicle","LForearm","RForearm","LHand","RHand","LThigh","RThigh","LCalf","RCalf","LFoot","RFoot","Head"}) do
			ParticleEffectAttach("sporecarrier_glow",PATTACH_POINT_FOLLOW,self,self:LookupAttachment(att))
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if string.find(key,"Foot") then
		VJ_EmitSound(self,self.SoundTbl_FootStepL,self.FootStepSoundLevel,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
	elseif string.find(key,"event_mattack") then
		local atk = string.Replace(key,"event_mattack ","")
		if atk == "back" then
			VJ_EmitSound(self,"vj_fallout/ghoulferal/feralghoul_radiate.mp3",78,100)
			ParticleEffect("sporecarrier_radiation",self:GetPos() +self:OBBCenter(),self:GetAngles(),nil)

			for _,v in ipairs(ents.FindInSphere(self:GetPos(),500)) do
				if (v:IsNPC() && v != self) or (v:IsPlayer() && GetConVarNumber("ai_ignoreplayers") == 0) then
					if self:Disposition(v) != D_LI then
						local dmginfo = DamageInfo()
						dmginfo:SetDamage(100)
						dmginfo:SetAttacker(self)
						dmginfo:SetInflictor(self)
						dmginfo:SetDamageType(DMG_RADIATION)
						dmginfo:SetDamagePosition(v:GetPos() +v:OBBCenter())
						v:TakeDamageInfo(dmginfo)
					end
				end
			end

			local i = 0
			local bonepos,boneang = self:GetBonePosition(i)
			while bonepos do
				ParticleEffect("vj_impact1_green",bonepos,boneang,nil)
				i = i +1
				bonepos,boneang = self:GetBonePosition(i)
			end
			gamemode.Call("OnNPCKilled",self,self,self,DamageInfo())
			SafeRemoveEntity(self)
			return
		end
		self:MeleeAttackCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnThinkActive()
	if self.Glow && self:Health() <= self:GetMaxHealth() *0.2 && math.random(1,20) == 1 && self:GetActivity() != ACT_RANGE_ATTACK1_LOW then
		self:VJ_ACT_PLAYACTIVITY(ACT_RANGE_ATTACK1_LOW,true,false,false)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:TranslateActivity(act)
	if act == ACT_IDLE then
		return (self:Health() <= self:GetMaxHealth() *0.5) && ACT_IDLE or (self.Alerted && ACT_IDLE_STIMULATED or ACT_IDLE)
	elseif act == ACT_WALK then
		return (self:Health() <= self:GetMaxHealth() *0.5) && ACT_WALK_HURT or ACT_WALK
	elseif act == ACT_RUN then
		return (self:Health() <= self:GetMaxHealth() *0.5) && ACT_RUN_HURT or ACT_RUN
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
	if !(self:Health() <= self:GetMaxHealth() *0.5) && self.NearestPointToEnemyDistance > self.DefaultDistance && time > 0.5 && time < 1.5 then
		self.MeleeAttackDistance = self.DefaultDistance *2
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK2}
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