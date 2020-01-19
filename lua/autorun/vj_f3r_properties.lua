/*--------------------------------------------------
	=============== Autorun File ===============
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
AddCSLuaFile()

local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")
if VJExists == true then

	properties.Add("Make Guard", {
		MenuLabel = "#Make Guard",
		Order = 999,
		MenuIcon = "icon16/shield_add.png",

		Filter = function(self,ent,ply)
			if !IsValid(ent) then return false end
			if !ent:IsNPC() then return false end
			if !ent.IsVJBaseSNPC then return false end
			if ent.Base == "npc_vj_f3r_human_base" then
				return true
			end
		end,
		Action = function(self,ent) -- CS
			self:MsgStart()
				net.WriteEntity(ent)
			self:MsgEnd()
		end,
		Receive = function(self,length,player) -- SV
			local ent = net.ReadEntity()
			if !self:Filter(ent,player) then return end
			ent.Human_GuardMode = true
			ent:OnGuardEnabled(true)
			player:ChatPrint("Guard Mode: Enabled")
		end
	})

	properties.Add("Remove Guard", {
		MenuLabel = "#Remove Guard",
		Order = 999,
		MenuIcon = "icon16/shield_delete.png",

		Filter = function(self,ent,ply)
			if !IsValid(ent) then return false end
			if !ent:IsNPC() then return false end
			if !ent.IsVJBaseSNPC then return false end
			if ent.Base == "npc_vj_f3r_human_base" then
				return true
			end
		end,
		Action = function(self,ent) -- CS
			self:MsgStart()
				net.WriteEntity(ent)
			self:MsgEnd()
		end,
		Receive = function(self,length,player) -- SV
			local ent = net.ReadEntity()
			if !self:Filter(ent,player) then return end
			ent.Human_GuardMode = false
			ent:OnGuardDisabled()
			player:ChatPrint("Guard Mode: Disabled")
		end
	})

	properties.Add("Set Guard Position", {
		MenuLabel = "#Set Guard Position",
		Order = 999,
		MenuIcon = "icon16/shield_go.png",

		Filter = function(self,ent,ply)
			if !IsValid(ent) then return false end
			if !ent:IsNPC() then return false end
			if !ent.IsVJBaseSNPC then return false end
			if ent.Base == "npc_vj_f3r_human_base" then
				return true
			end
		end,
		Action = function(self,ent) -- CS
			self:MsgStart()
				net.WriteEntity(ent)
			self:MsgEnd()
		end,
		Receive = function(self,length,player) -- SV
			local ent = net.ReadEntity()
			if !self:Filter(ent,player) then return end
			ent.Human_GuardPosition = ent:GetPos()
			player:ChatPrint("Guard Position Set")
		end
	})

end