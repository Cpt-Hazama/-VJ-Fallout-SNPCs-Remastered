AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/player/adpowerarmor.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 125

ENT.VJ_NPC_Class = {"CLASS_ENCLAVE"} -- NPCs with the same class with be allied to each other

ENT.FlinchChance = 12 -- Chance of it flinching from 1 to x | 1 will make it always flinch
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomInit()
	local hp = math.random(self.StartHealth -10,self.StartHealth +10)
	self:SetHealth(hp)
	self:SetMaxHealth(hp)
	
	self:SetBodygroup(3,2)
	self:SetBodygroup(4,3)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:AfterInit()
	self:SetVoice("male08")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup)
	VJ_EmitSound(self,"vj_impact_metal/bullet_metal/metalsolid"..math.random(1,10)..".wav",70)
	if (dmginfo:IsBulletDamage()) then
		dmginfo:ScaleDamage(0.65)
		-- local attacker = dmginfo:GetAttacker()
		-- if math.random(1,3) == 1 then
			-- self.DamageSpark1 = ents.Create("env_spark")
			-- self.DamageSpark1:SetKeyValue("Magnitude","1")
			-- self.DamageSpark1:SetKeyValue("Spark Trail Length","1")
			-- self.DamageSpark1:SetPos(dmginfo:GetDamagePosition())
			-- self.DamageSpark1:SetAngles(self:GetAngles())
			-- self.DamageSpark1:SetParent(self)
			-- self.DamageSpark1:Spawn()
			-- self.DamageSpark1:Activate()
			-- self.DamageSpark1:Fire("StartSpark","",0)
			-- self.DamageSpark1:Fire("StopSpark","",0.001)
			-- self:DeleteOnRemove(self.DamageSpark1)
		-- end
	elseif dmginfo:GetDamageType() != DMG_GENERIC then
		dmginfo:ScaleDamage(0.75)
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/