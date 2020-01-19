/*--------------------------------------------------
	=============== Autorun File ===============
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")
if VJExists == true then

	local ENT = FindMetaTable("Entity")
	local NPC = FindMetaTable("NPC")

	function NPC:Item_Stealthboy()
		self:SetMaterial("cpthazama/cloak")
		self.VJ_NoTarget = true
		self.DisableMakingSelfEnemyToNPCs = true
		self:DrawShadow(false)
		if IsValid(self:GetActiveWeapon()) then
			self:GetActiveWeapon():DrawShadow(false)
			self:GetActiveWeapon():SetMaterial("cpthazama/cloak")
		end
		for _, x in ipairs(ents.GetAll()) do
			if (x:GetClass() != self:GetClass() && x:GetClass() != "npc_grenade_frag") && x:IsNPC() && self:Visible(x) then
				x:AddEntityRelationship(self,D_NU,99)
				if x.IsVJBaseSNPC == true then
					x.MyEnemy = NULL
					x:SetEnemy(NULL)
					x:ClearEnemyMemory()
				end
				if VJ_HasValue(self.NPCTbl_Combine,x:GetClass()) or VJ_HasValue(self.NPCTbl_Resistance,x:GetClass()) then
					x:VJ_SetSchedule(SCHED_RUN_RANDOM)
					x:SetEnemy(NULL)
					x:ClearEnemyMemory()
				end
			end
		end
		timer.Simple(20,function()
			if IsValid(self) then
				self:SetMaterial(" ")
				self.VJ_NoTarget = false
				self:DrawShadow(true)
				self.DisableMakingSelfEnemyToNPCs = false
				if IsValid(self:GetActiveWeapon()) then
					self:GetActiveWeapon():DrawShadow(true)
					self:GetActiveWeapon():SetMaterial(" ")
				end
			end
		end)
	end

	function ENT:FindInventoryItem(itemID)
		local rTbl = {}
		for i = 1,#self.tbl_Inventory do
			if self.tbl_Inventory[i].id == itemID then
				rTbl.index = i
				rTbl.class = self.tbl_Inventory[i].class
				rTbl.count = self.tbl_Inventory[i].count
				return rTbl
			end
		end
	end

	function ENT:GetInventory()
		return self.tbl_Inventory
	end

	function ENT:RemoveFromInventory(itemID,removeCount)
		local index = self:FindInventoryItem(itemID).index
		local class = self:FindInventoryItem(itemID).class
		local count = self:FindInventoryItem(itemID).count
		if count -removeCount <= 0 then
			if self:GetInventory()[index] == nil || type(self:GetInventory()[index]) == "table" then
				self:GetInventory()[index] = nil
			else
				table.remove(self:GetInventory(),self:GetInventory()[index])
			end
			MsgN("Removed item " .. itemID .. " from " .. tostring(self))
		else
			self:GetInventory()[index].count = self:GetInventory()[index].count -removeCount
			MsgN("Removed " .. removeCount .. " " .. itemID .. " from " .. tostring(self))
		end
	end

	function ENT:AddToInventory(itemID,itemClass,itemCount)
		if self:GetInventory()[index] then
			local index = self:FindInventoryItem(itemID).index
			local class = self:FindInventoryItem(itemID).class
			local count = self:FindInventoryItem(itemID).count
			if self:GetInventory()[index].id == itemID then
				self:GetInventory()[index].count = self:GetInventory()[index].count +itemCount
			else
				local index = #self.tbl_Inventory
				self.tbl_Inventory[index +1] = {id=itemID,class=itemClass,count=itemCount}
			end
		else
			local index = #self.tbl_Inventory
			self.tbl_Inventory[index +1] = {id=itemID,class=itemClass,count=itemCount}
		end
		MsgN("Added " .. itemCount .. " " .. itemID .. " to " .. tostring(self))
	end
end