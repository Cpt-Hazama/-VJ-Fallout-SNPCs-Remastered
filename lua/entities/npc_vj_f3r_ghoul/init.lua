AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/ghoulferal.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 50
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_GHOUL_FERAL"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDistance = 80
ENT.MeleeAttackDamageDistance = 110
ENT.MeleeAttackDamage = 10

ENT.HasRangeAttack = false -- Should the SNPC have a range attack?
ENT.RangeAttackEntityToSpawn = "obj_vj_f3r_goregrenade" -- The entity that is spawned when range attacking
ENT.AnimTbl_RangeAttack = {ACT_ARM} -- Range Attack Animations
ENT.RangeDistance = 1200 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 300 -- How close does it have to be until it uses melee?
ENT.TimeUntilRangeAttackProjectileRelease = 1 -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = math.random(5,8) -- How much time until it can use a range attack?
ENT.RangeUseAttachmentForPos = true -- Should the projectile spawn on a attachment?
ENT.RangeUseAttachmentForPosID = "grenade" -- The attachment used on the range attack if RangeUseAttachmentForPos is set to true

	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 15 -- Chance of it flinching from 1 to x | 1 will make it always flinch
ENT.NextMoveAfterFlinchTime = false -- How much time until it can move, attack, etc. | Use this for schedules or else the base will set the time 0.6 if it sees it's a schedule!
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
ENT.SoundTbl_FootStepL = {"vj_fallout/ghoulferal/foot/feralghoul_foot_l01.mp3","vj_fallout/ghoulferal/foot/feralghoul_foot_l02.mp3"}
ENT.SoundTbl_FootStepR = {"vj_fallout/ghoulferal/foot/feralghoul_foot_r01.mp3","vj_fallout/ghoulferal/foot/feralghoul_foot_r02.mp3"}
ENT.SoundTbl_FootStepL_Run = {"vj_fallout/ghoulferal/foot/feralghoul_foot_run_l01.mp3","vj_fallout/ghoulferal/foot/feralghoul_foot_run_l02.mp3"}
ENT.SoundTbl_FootStepR_Run = {"vj_fallout/ghoulferal/foot/feralghoul_foot_run_r01.mp3","vj_fallout/ghoulferal/foot/feralghoul_foot_run_r02.mp3"}
ENT.SoundTbl_Idle = {}
ENT.SoundTbl_Investigate = {
	"vj_fallout/ghoulferal/feralghoul_aware01.mp3",
	"vj_fallout/ghoulferal/feralghoul_aware02.mp3",
	"vj_fallout/ghoulferal/feralghoul_aware03.mp3",
	"vj_fallout/ghoulferal/feralghoul_aware04.mp3",
}
ENT.SoundTbl_Alert = {"vj_fallout/ghoulferal/feralghoul_alert01.mp3"}
ENT.SoundTbl_BeforeMeleeAttack = {
	"vj_fallout/ghoulferal/feralghoul_attack01.mp3",
	"vj_fallout/ghoulferal/feralghoul_attack02.mp3",
	"vj_fallout/ghoulferal/feralghoul_attack03.mp3",
	"vj_fallout/ghoulferal/feralghoul_attack04.mp3",
}
ENT.SoundTbl_Pain = {
	"vj_fallout/ghoulferal/feralghoul_injured01.mp3",
	"vj_fallout/ghoulferal/feralghoul_injured02.mp3",
	"vj_fallout/ghoulferal/feralghoul_injured03.mp3",
	"vj_fallout/ghoulferal/feralghoul_injured04.mp3",
}
ENT.SoundTbl_Death = {
	"vj_fallout/ghoulferal/feralghoul_death01.mp3",
	"vj_fallout/ghoulferal/feralghoul_death02.mp3",
	"vj_fallout/ghoulferal/feralghoul_death03.mp3",
	"vj_fallout/ghoulferal/feralghoul_death04.mp3",
}

ENT.Skin = {[1]=0,[2]=0}
ENT.CanUseRadAttack = false
ENT.RadiationAttackDistance = 200
ENT.RadStrength = 0.8
ENT.tbl_Caps = {
	"bodycap_head",
	"bodycap_leftleg",
	"bodycap_rightleg",
	"bodycap_leftarm",
	"bodycap_rightarm",
}
ENT.RadDamage = 10
ENT.NextRadAttackT = CurTime() +5
ENT.RadAttacking = false
ENT.HasGrenadeAttack = false
ENT.GrenadeAttackDistance = 1250
ENT.NextGrenadeAttackT = CurTime() +1
ENT.Controller_UseFirstPerson = true
ENT.Controller_FirstPersonBone = "Bip01 Head"
ENT.Controller_FirstPersonOffset = Vector(5,0,3)
ENT.Controller_FirstPersonAngle = Angle(90,0,90)
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetupInventory(opWep)
	if self.CustomInventory then self:CustomInventory() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackCode_GetShootPos(TheProjectile)
	return self:CalculateProjectile("Curve", self:GetPos(), self:GetEnemy():GetPos() + self:GetEnemy():OBBCenter(), 3500)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomInitialize()
	if self.CanUseRadAttack then
		for _,v in pairs(self.tbl_Caps) do
			if self:LookupAttachment(v) then ParticleEffectAttach("glowingone_testc",PATTACH_POINT_FOLLOW,self,self:LookupAttachment(v)) end
		end
		self.Glow = ents.Create("light_dynamic")
		self.Glow:SetKeyValue("brightness","1")
		self.Glow:SetKeyValue("distance","150")
		self.Glow:SetLocalPos(self:GetPos())
		self.Glow:SetLocalAngles(self:GetAngles())
		self.Glow:Fire("Color", "127 255 0")
		self.Glow:SetParent(self)
		self.Glow:Spawn()
		self.Glow:Activate()
		self.Glow:Fire("TurnOn","",0)
		self.Glow:FollowBone(self,self:LookupBone("Bip01 Spine"))
		self:DeleteOnRemove(self.Glow)
	end
	self:SetSkin(math.random(self.Skin[1],self.Skin[2]))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.tbl_Inventory = {}
	self:SetupInventory()
	self:SetCollisionBounds(Vector(16,16,80),Vector(-16,-16,0))
	local v1,v2 = self:GetCollisionBounds()
	self.Height = v2.z
	self.DefaultDistance = self.MeleeAttackDistance
	self.DefaultDamage = self.MeleeAttackDamage
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackCode_GetShootPos(TheProjectile)
	return (self:GetEnemy():GetPos() +self:GetEnemy():OBBCenter() -(self:GetAttachment(self:LookupAttachment(self.RangeUseAttachmentForPosID)).Pos)) *1.3 +self:GetUp() *220
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	-- print(key)
	if key == "event_emit FootLeft" then
		VJ_EmitSound(self,self.SoundTbl_FootStepL,self.FootStepSoundLevel,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
	elseif key == "event_emit FootRunLeft" then
		VJ_EmitSound(self,self.SoundTbl_FootStepL_Run,self.FootStepSoundLevel,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
	elseif key == "event_emit FootRight" then
		VJ_EmitSound(self,self.SoundTbl_FootStepR,self.FootStepSoundLevel,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
	elseif key == "event_emit FootRunRight" then
		VJ_EmitSound(self,self.SoundTbl_FootStepR_Run,self.FootStepSoundLevel,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
	elseif key == "event_play AttackThrow" then
		VJ_EmitSound(self,"vj_fallout/ghoulferal/ghoulreaver_throw0"..math.random(1,2)..".mp3",78,100)
	elseif key == "event_play Equip" then
		VJ_EmitSound(self,"vj_fallout/ghoulferal/ghoulreaver_equip0"..math.random(1,3)..".mp3",78,100)
	elseif key == "event_grabgrenade" then
		VJ_EmitSound(self,"physics/body/body_medium_break"..math.random(2,4)..".wav",78,100)
		ParticleEffect("blood_impact_red_01",self:GetPos() +self:OBBCenter(),Angle(0,0,0),nil)
		ParticleEffect("blood_impact_green_01",self:GetPos() +self:OBBCenter(),Angle(0,0,0),nil)
		ParticleEffect("blood_impact_green_01",self:GetPos() +self:OBBCenter(),Angle(0,0,0),nil)
		for i = 1,7 do
			timer.Simple(i *0.14,function() if IsValid(self) then ParticleEffect("blood_impact_green_01",self:GetAttachment(1).Pos,Angle(0,0,0),nil) end end)
		end
		self:TakeDamage(25,self,self)
	elseif key == "event_unequip" then
		VJ_EmitSound(self,"physics/body/body_medium_break4.wav",78,100)
		ParticleEffect("blood_impact_red_01",self:GetPos() +self:OBBCenter(),Angle(0,0,0),nil)
		ParticleEffect("blood_impact_green_01",self:GetPos() +self:OBBCenter(),Angle(0,0,0),nil)
		ParticleEffect("blood_impact_green_01",self:GetPos() +self:OBBCenter(),Angle(0,0,0),nil)
		self:SetHealth(self:Health() +25)
	elseif key == "event_equipped" then
		-- if self:GetActivity() == ACT_ARM then
			-- self.AnimTbl_RangeAttack = {ACT_RANGE_ATTACK2}
			-- self:VJ_ACT_PLAYACTIVITY(ACT_RANGE_ATTACK2,true,false,true)
		-- end
	elseif key == "event_play AttackRadiation" then
		VJ_EmitSound(self,"vj_fallout/ghoulferal/feralghoul_radiate.mp3",78,100)
		self.radlight = ents.Create("light_dynamic")
		self.radlight:SetKeyValue("_light","255 194 53 100")
		self.radlight:SetKeyValue("brightness","8")
		self.radlight:SetKeyValue("distance","160")
		self.radlight:SetKeyValue("_cone","0")
		self.radlight:SetPos(self:GetPos() +self:OBBCenter())
		self.radlight:SetParent(self)
		self.radlight:Spawn()
		self.radlight:Activate()
		self.radlight:Fire("TurnOn","",0)
		self:DeleteOnRemove(self.radlight)

		local shockwave = ents.Create("info_particle_system")
		shockwave:SetParent(self)
		shockwave:SetPos(self:GetPos() +self:OBBCenter())
		shockwave:SetKeyValue("effect_name","radiation_shockwave")
		shockwave:SetKeyValue("start_active","1")
		shockwave:Spawn()
		shockwave:Activate()
		self:DeleteOnRemove(shockwave)
		timer.Simple(3.5,function()
			if IsValid(self) then
				self:ResetParticles() -- Fail-safe
			end
		end)
	elseif key == "event_glowstart" then
		if !self.tbl_GlowLights then self.tbl_GlowLights = {} end
		table.Empty(self.tbl_GlowLights)
		for i = 1, self:GetBoneCount() -1 do
			local bonepos,boneang = self:GetBonePosition(i)
			local glow = ents.Create("info_particle_system")
			glow:SetParent(self)
			glow:SetPos(bonepos)
			glow:SetKeyValue("effect_name","glowingone_testA")
			glow:SetKeyValue("start_active","1")
			glow:Spawn()
			glow:Activate()
			self:DeleteOnRemove(glow)
			table.insert(self.tbl_GlowLights,glow)
		end
		timer.Simple(3.5,function()
			if IsValid(self) then
				self:ResetParticles() -- Fail-safe
			end
		end)
	elseif key == "event_rattack radiation" then
		for i = 1,7 do
			timer.Simple(i *0.4,function()
				if IsValid(self) then
					self.RadStrength = self.RadStrength -0.1
					-- Entity(1):ChatPrint(tostring(750 *self.RadStrength))
					for _,v in ipairs(ents.FindInSphere(self:GetPos(),750 *self.RadStrength)) do
						if (v:IsNPC() && v != self) or (v:IsPlayer() && GetConVarNumber("ai_ignoreplayers") == 0) then
							if self:Disposition(v) != D_LI && !v.VJ_F3R_Ghoul then
								local dmginfo = DamageInfo()
								dmginfo:SetDamage(self.RadDamage +(self.RadDamage *self.RadStrength))
								dmginfo:SetAttacker(self)
								dmginfo:SetInflictor(self)
								dmginfo:SetDamageType(DMG_RADIATION)
								dmginfo:SetDamagePosition(v:GetPos() +v:OBBCenter())
								v:TakeDamageInfo(dmginfo)
							elseif v.VJ_F3R_Ghoul then
								v:SetHealth(v:Health() +(self.RadDamage +(self.RadDamage *self.RadStrength)))
								if v:Health() > v:GetMaxHealth() then v:SetHealth(v:GetMaxHealth()) end
							end
						end
					end
					if i == 7 then
						self.RadStrength = 0.8
					end
				end
			end)
		end
	elseif key == "event_glowend" then
		self:ResetParticles()
	elseif key == "event_rattack throw" then
		self:GrenadeCode()
		-- timer.Simple(0.3,function()
			-- if IsValid(self) then
				-- self.AnimTbl_RangeAttack = {ACT_ARM}
			-- end
		-- end)
	elseif string.find(key,"event_mattack") then
		local atk = string.Replace(key,"event_mattack ","")
		if atk == "leftpower" || atk == "leftpower" || atk == "leftpower" then
			self.MeleeAttackDamage = self.DefaultDamage *2.75
		else
			self.MeleeAttackDamage = self.DefaultDamage
		end
		self:MeleeAttackCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:ResetParticles()
	for _,v in pairs(self.tbl_GlowLights) do
		if IsValid(v) then
			v:Remove()
		end
	end
	if IsValid(self.radlight) then self.radlight:Fire("TurnOff","",0) end
	self:StopParticles()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	local time = self:GetPathTimeToGoal()
	if self.NearestPointToEnemyDistance > self.DefaultDistance && time > 0.5 && time < 1.5 && math.random(1,3) == 1 then
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
	
	local cont = self.VJ_TheController
	if IsValid(self:GetEnemy()) then
		if self.CanUseRadAttack && ((IsValid(cont) && cont:KeyDown(IN_RELOAD)) or !IsValid(cont) && (type(self.NearestPointToEnemyDistance) == "number" && self.NearestPointToEnemyDistance <= self.RadiationAttackDistance) && (type(self.NearestPointToEnemyDistance) == "number" && self.NearestPointToEnemyDistance > self.MeleeAttackDistance) && math.random(1,20) == 1) then
			if CurTime() > self.NextRadAttackT && !self.RadAttacking && !self.MeleeAttacking && !self.RangeAttacking then
				self:VJ_ACT_PLAYACTIVITY(ACT_RANGE_ATTACK1,true,false,false)
				self.RadAttacking = true
				self.RangeAttacking = true
				timer.Simple(self:DecideAnimationLength(ACT_RANGE_ATTACK1,false),function()
					if IsValid(self) then
						self.RadAttacking = false
						self.RangeAttacking = false
					end
				end)
				self.NextRadAttackT = CurTime() +math.Rand(10,25)
			end
		end
		if self.HasGrenadeAttack && self:Health() > 50 && ((IsValid(cont) && cont:KeyDown(IN_ATTACK2)) or !IsValid(cont) && self:GetEnemy():Visible(self) && (type(self.NearestPointToEnemyDistance) == "number" && self.NearestPointToEnemyDistance <= self.GrenadeAttackDistance) && (type(self.NearestPointToEnemyDistance) == "number" && self.NearestPointToEnemyDistance > self.MeleeAttackDistance) && math.random(1,8) == 1) then
			if CurTime() > self.NextGrenadeAttackT && !self.RadAttacking && !self.MeleeAttacking && !self.RangeAttacking then
				self:VJ_ACT_PLAYACTIVITY(ACT_ARM,true,false,true)
				timer.Simple(self:DecideAnimationLength(ACT_ARM,false),function()
					if IsValid(self) then
						if self:Health() > 50 then
							if IsValid(self:GetEnemy()) then
								self:VJ_ACT_PLAYACTIVITY(ACT_RANGE_ATTACK2,true,0.8,true)
								timer.Simple(self:DecideAnimationLength(ACT_RANGE_ATTACK2,false,3),function()
									if IsValid(self) then
										self.RangeAttacking = false
									end
								end)
							else
								self:VJ_ACT_PLAYACTIVITY(ACT_DISARM,true,false,false)
								self.RangeAttacking = false
							end
						else
							self:VJ_ACT_PLAYACTIVITY(ACT_DISARM,true,false,false)
							self.RangeAttacking = false
						end
					end
				end)
				self.NextGrenadeAttackT = CurTime() +math.Rand(6,10)
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GrenadeCode()
	if !IsValid(self:GetEnemy()) then return end
	local rangeprojectile = ents.Create(self.RangeAttackEntityToSpawn)
	rangeprojectile:SetPos(self:GetAttachment(self:LookupAttachment(self.RangeUseAttachmentForPosID)).Pos)
	rangeprojectile:SetAngles((self:GetEnemy():GetPos()-rangeprojectile:GetPos()):Angle())
	rangeprojectile:Spawn()
	rangeprojectile:Activate()
	rangeprojectile:SetOwner(self)
	rangeprojectile:SetPhysicsAttacker(self)
	local phys = rangeprojectile:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:SetVelocity(self:RangeAttackCode_GetShootPos(rangeprojectile))
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