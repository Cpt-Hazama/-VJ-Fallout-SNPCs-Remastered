/*--------------------------------------------------
	=============== Autorun File ===============
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")
if VJExists == true then

	if CLIENT then return end

	local matStepSounds = {
		[MAT_ANTLION] = {
			"physics/flesh/flesh_impact_hard1.wav",
			"physics/flesh/flesh_impact_hard2.wav",
			"physics/flesh/flesh_impact_hard3.wav",
			"physics/flesh/flesh_impact_hard4.wav",
			"physics/flesh/flesh_impact_hard5.wav",
			"physics/flesh/flesh_impact_hard6.wav",
		},
		[MAT_BLOODYFLESH] = {
			"physics/flesh/flesh_impact_hard1.wav",
			"physics/flesh/flesh_impact_hard2.wav",
			"physics/flesh/flesh_impact_hard3.wav",
			"physics/flesh/flesh_impact_hard4.wav",
			"physics/flesh/flesh_impact_hard5.wav",
			"physics/flesh/flesh_impact_hard6.wav",
		},
		[MAT_CONCRETE] = {
			"player/footsteps/concrete1.wav",
			"player/footsteps/concrete2.wav",
			"player/footsteps/concrete3.wav",
			"player/footsteps/concrete4.wav",
		},
		[MAT_DIRT] = {
			"player/footsteps/dirt1.wav",
			"player/footsteps/dirt2.wav",
			"player/footsteps/dirt3.wav",
			"player/footsteps/dirt4.wav",
		},
		[MAT_FLESH] = {
			"physics/flesh/flesh_impact_hard1.wav",
			"physics/flesh/flesh_impact_hard2.wav",
			"physics/flesh/flesh_impact_hard3.wav",
			"physics/flesh/flesh_impact_hard4.wav",
			"physics/flesh/flesh_impact_hard5.wav",
			"physics/flesh/flesh_impact_hard6.wav",
		},
		[MAT_GRATE] = {
			"player/footsteps/metalgrate1.wav",
			"player/footsteps/metalgrate2.wav",
			"player/footsteps/metalgrate3.wav",
			"player/footsteps/metalgrate4.wav",
		},
		[MAT_ALIENFLESH] = {
			"physics/flesh/flesh_impact_hard1.wav",
			"physics/flesh/flesh_impact_hard2.wav",
			"physics/flesh/flesh_impact_hard3.wav",
			"physics/flesh/flesh_impact_hard4.wav",
			"physics/flesh/flesh_impact_hard5.wav",
			"physics/flesh/flesh_impact_hard6.wav",
		},
		[74] = { -- Snow
			"player/footsteps/sand1.wav",
			"player/footsteps/sand2.wav",
			"player/footsteps/sand3.wav",
			"player/footsteps/sand4.wav",
		},
		[MAT_PLASTIC] = {
			"physics/plaster/drywall_footstep1.wav",
			"physics/plaster/drywall_footstep2.wav",
			"physics/plaster/drywall_footstep3.wav",
			"physics/plaster/drywall_footstep4.wav",
		},
		[MAT_METAL] = {
			"player/footsteps/metal1.wav",
			"player/footsteps/metal2.wav",
			"player/footsteps/metal3.wav",
			"player/footsteps/metal4.wav",
		},
		[MAT_SAND] = {
			"player/footsteps/sand1.wav",
			"player/footsteps/sand2.wav",
			"player/footsteps/sand3.wav",
			"player/footsteps/sand4.wav",
		},
		[MAT_FOLIAGE] = {
			"player/footsteps/grass1.wav",
			"player/footsteps/grass2.wav",
			"player/footsteps/grass3.wav",
			"player/footsteps/grass4.wav",
		},
		[MAT_COMPUTER] = {
			"physics/plaster/drywall_footstep1.wav",
			"physics/plaster/drywall_footstep2.wav",
			"physics/plaster/drywall_footstep3.wav",
			"physics/plaster/drywall_footstep4.wav",
		},
		[MAT_SLOSH] = {
			"player/footsteps/slosh1.wav",
			"player/footsteps/slosh2.wav",
			"player/footsteps/slosh3.wav",
			"player/footsteps/slosh4.wav",
		},
		[MAT_TILE] = {
			"player/footsteps/tile1.wav",
			"player/footsteps/tile2.wav",
			"player/footsteps/tile3.wav",
			"player/footsteps/tile4.wav",
		},
		[85] = { -- Grass
			"player/footsteps/grass1.wav",
			"player/footsteps/grass2.wav",
			"player/footsteps/grass3.wav",
			"player/footsteps/grass4.wav",
		},
		[MAT_VENT] = {
			"player/footsteps/duct1.wav",
			"player/footsteps/duct2.wav",
			"player/footsteps/duct3.wav",
			"player/footsteps/duct4.wav",
		},
		[MAT_WOOD] = {
			"player/footsteps/wood1.wav",
			"player/footsteps/wood2.wav",
			"player/footsteps/wood3.wav",
			"player/footsteps/wood4.wav",
			"player/footsteps/woodpanel1.wav",
			"player/footsteps/woodpanel2.wav",
			"player/footsteps/woodpanel3.wav",
			"player/footsteps/woodpanel4.wav",
		},
		[MAT_GLASS] = {
			"physics/glass/glass_sheet_step1.wav",
			"physics/glass/glass_sheet_step2.wav",
			"physics/glass/glass_sheet_step3.wav",
			"physics/glass/glass_sheet_step4.wav",
		}
	}

	function VJ_GetVarInt(var)
		local var = GetConVar(var)
		return (var && var:GetInt()) or -1
	end

	function VJ_PlaySound(sndType,ent,snd,vol,pit,delay)
		delay = delay or 0
		vol = vol or 75
		timer.Simple(delay,function()
			pit = (pit or 100) *VJ_GetVarInt("host_timescale")
			if sndType == 1 && IsValid(ent) then
				VJ_CreateSound(ent,snd,vol,pit)
			elseif sndType == 2 && IsValid(ent) then
				VJ_EmitSound(ent,snd,vol,pit)
			elseif sndType == 3 then
				sound.Play(VJ_PICK(snd),type(ent) == "Vector" && ent or (IsValid(ent) && ent:GetPos()) or VJ_Vec0,vol,pit,1)
			end
		end)
	end

	function VJ_CreateStepSound(ent,stepHeight,overrideSound,overrideSoundOverlap)
		if !ent:IsOnGround() then return end
		stepHeight = stepHeight or 32
		local tr = util.TraceLine({
			start = ent:GetPos(),
			endpos = ent:GetPos() +Vector(0,0,-stepHeight),
			filter = {ent}
		})
		local matTable = (overrideSoundOverlap != true && overrideSound) or matStepSounds[tr.MatType]
		local waterLVL = ent:WaterLevel()
		local vol = ent.FootStepSoundLevel or 70
		local pit = ent:VJ_DecideSoundPitch(ent.FootStepPitch1 or 95,ent.FootStepPitch2 or 105) or 100
		if tr.Hit && matTable then
			VJ_PlaySound(2,ent,matTable,vol,pit)
			if overrideSoundOverlap then
				VJ_PlaySound(2,ent,overrideSound,vol,pit)
			end
		end
		if waterLVL > 0 && waterLVL < 3 then
			VJ_PlaySound(2,ent,"player/footsteps/wade" .. math.random(1,8) .. ".wav",vol,pit)
		end
	end

	local ENT = FindMetaTable("Entity")
	local NPC = FindMetaTable("NPC")

	function NPC:CustomPoseParameter(ent,ResetPoses)
		ResetPoses = ResetPoses or false
		local p_enemy = 0 -- Pitch
		local y_enemy = 0 -- Yaw
		local r_enemy = 0 -- Roll
		if IsValid(ent) && ResetPoses == false then
			local enemy_pos = ent:GetPos() +ent:OBBCenter()
			local self_ang = self:GetAngles()
			local enemy_ang = (enemy_pos - (self:GetPos() + self:OBBCenter())):Angle()
			p_enemy = math.AngleDifference(enemy_ang.p, self_ang.p)
			y_enemy = math.AngleDifference(enemy_ang.y, self_ang.y)
			r_enemy = math.AngleDifference(enemy_ang.z, self_ang.z)
		end
		
		local ang_app = math.ApproachAngle
		self:SetPoseParameter("aim_pitch", ang_app(self:GetPoseParameter("aim_pitch"), p_enemy, self.PoseParameterLooking_TurningSpeed))
		self:SetPoseParameter("aim_yaw", ang_app(self:GetPoseParameter("aim_yaw"), y_enemy, self.PoseParameterLooking_TurningSpeed))
	end

	function NPC:OnGuardEnabled(pos)
		self.PlayerFriendly = true
		self.BecomeEnemyToPlayerLevel = 1
		self.OnPlayerSightDistance = self.VJ_F3R_GuardWarnDistance
		self.OnPlayerSightNextTime1 = 10
		self.OnPlayerSightNextTime2 = 12
		if pos then self.VJ_F3R_GuardPosition = self:GetPos() end
	end
	
	function NPC:OnGuardDisabled()
		self.PlayerFriendly = self.OriginalFriendly
		self.BecomeEnemyToPlayerLevel = OriginalBecomeEnemyToPlayerLevel
		self.OnPlayerSightDistance = self.OriginalPlayerSightDistance
		self.OnPlayerSightNextTime1 = self.OriginalPlayerSightTime1
		self.OnPlayerSightNextTime2 = self.OriginalPlayerSightTime2
	end
	
	function NPC:GuardInit()
		self.OriginalClass = self.VJ_NPC_Class
		self.OriginalFriendly = self.PlayerFriendly
		self.OriginalBecomeEnemyToPlayerLevel = self.BecomeEnemyToPlayerLevel
		self.OriginalPlayerSightDistance = self.OnPlayerSightDistance
		self.OriginalPlayerSightTime1 = self.OnPlayerSightNextTime1
		self.OriginalPlayerSightTime2 = self.OnPlayerSightNextTime2
		if self.VJ_F3R_InGuardMode then
			self:OnGuardEnabled(true)
		end
	end
	
	function NPC:GuardAI()
		if self.VJ_F3R_InGuardMode then
			if !self.VJ_F3R_RanGuardStatusChange then
				self:OnGuardEnabled(false)
				self.VJ_F3R_RanGuardStatusChange = true
			end
			if !IsValid(self:GetEnemy()) && self:GetPos():Distance(self.VJ_F3R_GuardPosition) >= self.VJ_F3R_MaxGuardDistance then
				self:SetLastPosition(self.VJ_F3R_GuardPosition +Vector(math.Rand(-100,100),math.Rand(-100,100),0))
				self:VJ_TASK_GOTO_LASTPOS("TASK_WALK_PATH")
			end
		else
			if self.VJ_F3R_RanGuardStatusChange then
				self:OnGuardDisabled()
				self.VJ_F3R_RanGuardStatusChange = false
			end
		end
	end

	function NPC:Item_Stealthboy()
		self:SetMaterial("cpthazama/cloak")
		self:AddFlags(FL_NOTARGET)
		self.DisableMakingSelfEnemyToNPCs = true
		self:DrawShadow(false)
		if IsValid(self:GetActiveWeapon()) then
			self:GetActiveWeapon():DrawShadow(false)
			self:GetActiveWeapon():SetMaterial("cpthazama/cloak")
		end
		if self.tbl_CurrentApparel then
			for _,v in ipairs(self.tbl_CurrentApparel) do
				if IsValid(v) then
					-- print(self,v)
					v:SetMaterial("cpthazama/cloak")
					v:DrawShadow(false)
				end
			end
		end
		if self.tbl_CurrentHair then
			for k,v in ipairs(self.tbl_CurrentHair) do
				if IsValid(v) then
					v:SetMaterial("cpthazama/cloak")
					v:DrawShadow(false)
				end
			end
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
				self:RemoveFlags(FL_NOTARGET)
				self:DrawShadow(true)
				self.DisableMakingSelfEnemyToNPCs = false
				if IsValid(self:GetActiveWeapon()) then
					self:GetActiveWeapon():DrawShadow(true)
					self:GetActiveWeapon():SetMaterial(" ")
				end
				if self.tbl_CurrentApparel then
					for _,v in ipairs(self.tbl_CurrentApparel) do
						if IsValid(v) then
							v:SetMaterial(" ")
							v:DrawShadow(true)
						end
					end
				end
				if self.tbl_CurrentHair then
					for _,v in ipairs(self.tbl_CurrentHair) do
						if IsValid(v) then
							v:SetMaterial(" ")
							v:DrawShadow(true)
						end
					end
				end
			end
		end)
	end
	
	function ENT:InFront(ene,rad)
		return (self:GetForward():Dot((ene:GetPos() -self:GetPos()):GetNormalized()) > math.cos(math.rad(rad)))
	end

	function ENT:DoFlameDamage(dist,dmg,attacker,rad,ign,pos,dir)
		util.VJ_SphereDamage(self,self,pos or (self:GetPos() +(self:GetForward() *self:OBBMaxs().y)),dist,dmg,DMG_BURN,true,true,{UseCone=true,UseConeDegree=rad,UseConeDirection=dir or false}, function(ent) if !ent:IsOnFire() && (ent:IsPlayer() or ent:IsNPC()) && ign then ent:Ignite(ign) end end)
		-- local dispCheck = self:IsNPC() && true or false
		-- for _,ent in pairs(ents.FindInSphere(self:GetPos() +(self:GetForward() *self:OBBMaxs().y),dist)) do
		-- 	if (ent != self && ent != attacker && self:Visible(ent)) && ent != self.VJ_TheControllerBullseye then
		-- 		if self:IsNPC() && self:Disposition(ent) != D_HT then return end
		-- 		if self:InFront(ent,rad or 45) then
		-- 			if ent:IsNPC() or ent:IsPlayer() then
		-- 				ent:Ignite(ign or 4)
		-- 			end
		-- 			local dmginfo = DamageInfo()
		-- 			dmginfo:SetDamageType(DMG_BURN)
		-- 			dmginfo:SetDamage(dmg)
		-- 			dmginfo:SetAttacker(attacker || self)
		-- 			dmginfo:SetInflictor(self)
		-- 			ent:TakeDamageInfo(dmginfo)
		-- 		end
		-- 	end
		-- end
	end

	-- function ENT:DoFlameDamage(dist,dmg,attacker,ign)
		-- for _,ent in pairs(ents.FindInSphere(self:GetPos() +(self:GetForward() *self:OBBMaxs().y),dist)) do
			-- if ((self:Disposition(ent) == D_HT) && self:Visible(ent)) && ent != self.VJ_TheControllerBullseye then
				-- if self:InFront(ent,45) then
					-- ent:Ignite(ign or 4,0)
					-- local dmginfo = DamageInfo()
					-- dmginfo:SetDamageType(DMG_BURN)
					-- dmginfo:SetDamage(dmg)
					-- dmginfo:SetAttacker(attacker || self)
					-- dmginfo:SetInflictor(self)
					-- ent:TakeDamageInfo(dmginfo)
				-- end
			-- end
		-- end
	-- end

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
		if itemID == nil then return end
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