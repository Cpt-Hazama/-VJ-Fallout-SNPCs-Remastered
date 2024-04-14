AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/fallout/supermutant_overlord.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 1250

ENT.PoseParameterLooking_InvertPitch = true

ENT.GeneralSoundPitch1 = 90
ENT.GeneralSoundPitch2 = 90
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetAnimationTranslations(htype)
	local wep = self:GetActiveWeapon()
	if wep.AnimationType then
		htype = wep.AnimationType
	end
	self.AnimationTranslations[ACT_IDLE] 							= ACT_IDLE
	self.AnimationTranslations[ACT_WALK] 							= ACT_WALK
	self.AnimationTranslations[ACT_RUN] 							= ACT_RUN

	if htype == "2hh" then
		local aim = VJ_SequenceToActivity(self,"2hhaim")
		local walk = VJ_SequenceToActivity(self,"2hhaim_walk")
		local run = VJ_SequenceToActivity(self,"2hhaim_run")
		local fire = VJ_SequenceToActivity(self,"2hhattackloop")
		local reload = "2hhreloadc"

		self.AnimationTranslations[ACT_IDLE_ANGRY] 					= aim
		self.AnimationTranslations[ACT_WALK_AIM] 						= walk
		self.AnimationTranslations[ACT_RUN_AIM] 						= run
		self.AnimationTranslations[ACT_RANGE_ATTACK1] 					= aim
		self.AnimationTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= fire
		self.AnimationTranslations[ACT_RELOAD]							= "vjges_" .. reload
	elseif htype == "2hl" then
		local aim = VJ_SequenceToActivity(self,"2hlaim")
		local walk = VJ_SequenceToActivity(self,"2hlaim_walk")
		local run = VJ_SequenceToActivity(self,"2hlaim_run")
		local fire = VJ_SequenceToActivity(self,"2hlattackright")
		local reload = "2hlreloade"

		self.AnimationTranslations[ACT_IDLE_ANGRY] 					= aim
		self.AnimationTranslations[ACT_WALK_AIM] 						= walk
		self.AnimationTranslations[ACT_RUN_AIM] 						= run
		self.AnimationTranslations[ACT_RANGE_ATTACK1] 					= aim
		self.AnimationTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= fire
		self.AnimationTranslations[ACT_RELOAD]							= "vjges_" .. reload
	elseif htype == "2hr" or htype == "2hr_bolt" or htype == "ar2" or htype == "shotgun" then
		local aim = VJ_SequenceToActivity(self,"2hraim")
		local walk = VJ_SequenceToActivity(self,"2hraim_walk")
		local run = VJ_SequenceToActivity(self,"2hraim_run")
		local fire = VJ_SequenceToActivity(self,"2hrattackright")
		local reload = "2hrreloadb"

		self.AnimationTranslations[ACT_IDLE_ANGRY] 					= aim
		self.AnimationTranslations[ACT_WALK_AIM] 						= walk
		self.AnimationTranslations[ACT_RUN_AIM] 						= run
		self.AnimationTranslations[ACT_RANGE_ATTACK1] 					= aim
		self.AnimationTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= fire
		self.AnimationTranslations[ACT_RELOAD]							= "vjges_" .. reload
	elseif htype == "1hm" or htype == "2hm" then
		local aim = VJ_SequenceToActivity(self,"2hmaim")
		local walk = VJ_SequenceToActivity(self,"2hmaim_walk")
		local run = VJ_SequenceToActivity(self,"2hmaim_run")
		local fire = ACT_GESTURE_MELEE_ATTACK2
		local fire2 = ACT_MELEE_ATTACK2
		local reload = "2hrreloadb"

		self.AnimationTranslations[ACT_IDLE_ANGRY] 					= aim
		self.AnimationTranslations[ACT_WALK_AIM] 						= walk
		self.AnimationTranslations[ACT_RUN_AIM] 						= run
		self.AnimationTranslations[ACT_RANGE_ATTACK1] 					= aim
		self.AnimationTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= fire
		self.AnimationTranslations[ACT_RANGE_ATTACK2] 					= fire2
		self.AnimationTranslations[ACT_RELOAD]							= "vjges_" .. reload
	else
		local aim = VJ_SequenceToActivity(self,"2haaim")
		local walk = VJ_SequenceToActivity(self,"2haaim_walk")
		local run = VJ_SequenceToActivity(self,"2haaim_run")
		local fire = VJ_SequenceToActivity(self,"2haattackloop")
		local reload = "2hareloada"

		self.AnimationTranslations[ACT_IDLE_ANGRY] 					= aim
		self.AnimationTranslations[ACT_WALK_AIM] 						= walk
		self.AnimationTranslations[ACT_RUN_AIM] 						= run
		self.AnimationTranslations[ACT_RANGE_ATTACK1] 					= aim
		self.AnimationTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= fire
		self.AnimationTranslations[ACT_RELOAD]							= "vjges_" .. reload
	end

	if !self.CanHolsterWeapon then
		self.AnimationTranslations[ACT_IDLE] 							= self.AnimationTranslations[ACT_IDLE_ANGRY]
		self.AnimationTranslations[ACT_WALK] 							= self.AnimationTranslations[ACT_WALK_AIM]
		self.AnimationTranslations[ACT_RUN] 							= self.AnimationTranslations[ACT_RUN_AIM]
	end

	return true
end