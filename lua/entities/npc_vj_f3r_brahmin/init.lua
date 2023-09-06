AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/brahmin.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 40
ENT.HullType = HULL_HUMAN
ENT.Behavior = VJ_BEHAVIOR_PASSIVE
ENT.PlayerFriendly = true
ENT.FriendsWithAllPlayerAllies = true
ENT.Supplies = 0
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_BRAHMIN"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = false -- Should the SNPC have a melee attack?
ENT.DisableFootStepSoundTimer = true

	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 12 -- Chance of it flinching from 1 to x | 1 will make it always flinch
ENT.NextMoveAfterFlinchTime = false -- How much time until it can move, attack, etc. | Use this for schedules or else the base will set the time 0.6 if it sees it's a schedule!
ENT.HasHitGroupFlinching = true -- It will flinch when hit in certain hitgroups | It can also have certain animations to play in certain hitgroups
ENT.HitGroupFlinching_DefaultWhenNotHit = false -- If it uses hitgroup flinching, should it do the regular flinch if it doesn't hit any of the specified hitgroups?
ENT.HitGroupFlinching_Values = {
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
ENT.SoundTbl_FootStep = {
	"vj_fallout/brahmin/foot/brahmin_foot01.mp3",
	"vj_fallout/brahmin/foot/brahmin_foot02.mp3",
	"vj_fallout/brahmin/foot/brahmin_foot03.mp3",
	"vj_fallout/brahmin/foot/brahmin_foot04.mp3",
}
ENT.SoundTbl_Idle = {
	"vj_fallout/brahmin/brahmin_idle_breathing01.mp3",
	"vj_fallout/brahmin/brahmin_idle_breathing02.mp3",
	"vj_fallout/brahmin/brahmin_idle_breathing03.mp3",
	"vj_fallout/brahmin/brahmin_idle_breathing04.mp3",
	"vj_fallout/brahmin/brahmin_idle_breathing05.mp3",
	"vj_fallout/brahmin/brahmin_idle_breathing06.mp3",
	"vj_fallout/brahmin/brahmin_idle_breathing07.mp3",
}
ENT.SoundTbl_Moo = {
	"vj_fallout/brahmin/brahmin_idle_moo01.mp3",
	"vj_fallout/brahmin/brahmin_idle_moo02.mp3",
	"vj_fallout/brahmin/brahmin_idle_moo03.mp3",
}
ENT.SoundTbl_Pain = {"vj_fallout/brahmin/brahmin_injured01.mp3","vj_fallout/brahmin/brahmin_injured02.mp3","vj_fallout/brahmin/brahmin_injured03.mp3"}
ENT.SoundTbl_Death = {"vj_fallout/brahmin/brahmin_death01.mp3","vj_fallout/brahmin/brahmin_death02.mp3"}
ENT.SoundTbl_Breath = {"vj_fallout/brahmin/brahmin_conscious_lp.mp3"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetupInventory(opWep)
	if self.CustomInventory then self:CustomInventory() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTouch(ent)
	if ent:IsPlayer() then
		local sup = self.Supplies
		if sup == 0 then return end
		if ent.VJ_F3R_BrahminT == nil then
			ent.VJ_F3R_BrahminT = 0
		end
		if CurTime() > ent.VJ_F3R_BrahminT then
			ent.VJ_F3R_BrahminT = CurTime() +15
			if sup == 1 then
				ent:SetArmor(ent:Armor() +10)
				ent:ChatPrint("You grab some supplies for your armor (+10 armor)")
			else
				ent:SetHealth(ent:Health() +2)
				ent:ChatPrint("You make a cup of water and drink all of it. (+2 HP)")
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.tbl_Inventory = {}
	self:SetupInventory()
	self:SetCollisionBounds(Vector(30,30,70),Vector(-30,-30,0))
	-- self:ManipulateBoneJiggle(45,1)
	self:ManipulateBoneJiggle(46,1)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "event_emit Foot" then
		VJ_EmitSound(self,self:GetModel() == "models/fallout/brahmin.mdl" && self.SoundTbl_FootStep or "vj_fallout/brahmin/foot/brahmin_foot_pack0" .. math.random(1,2) .. ".mp3",self.FootStepSoundLevel,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
	end
	if key == "event_play IdleMoo" then
		VJ_EmitSound(self,self.SoundTbl_Moo,80)
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