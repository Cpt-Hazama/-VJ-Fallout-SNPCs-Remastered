if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel							= "models/fallout/weapons/v_arms.mdl"
SWEP.PrintName							= "Weapon_Base"
SWEP.ID 								= ITEM_VJ_NO_ID
SWEP.AnimationType 						= "2ha"
SWEP.PHoldType 							= "ar2"
SWEP.Slot 								= (SWEP.AnimationType == "1gt" && 4 or SWEP.AnimationType == "1hm" && 0 or SWEP.AnimationType == "2hm" && 0 or SWEP.AnimationType == "2ha" && 2 or SWEP.AnimationType == "2hh" && 3 or SWEP.AnimationType == "2hl" && 4 or SWEP.AnimationType == "2hr" && 2 or SWEP.AnimationType == "1hp" && 1 or SWEP.AnimationType == "1md" && 4) or 1
SWEP.SlotPos 							= 4
SWEP.Weights = false

SWEP.WorldModel_CustomPositionAngle 	= Vector(80,5,270)
SWEP.WorldModel_CustomPositionOrigin 	= Vector(-3.6,0,-1.2)

SWEP.NPC_NextPrimaryFire 				= 0.1
SWEP.NPC_CustomSpread	 				= 0.8
SWEP.NPC_TimeUntilFire	 				= 0
SWEP.NPC_TimeUntilFireExtraTimers 		= {}

SWEP.Primary.Damage						= 1
SWEP.Primary.ClipSize					= 1
SWEP.Primary.Delay						= -1
SWEP.Primary.Cone						= -1

SWEP.AnimTbl_Deploy 					= {}
SWEP.AnimTbl_Idle 						= {}
SWEP.AnimTbl_PrimaryFire 				= {}
SWEP.AnimTbl_Reload 					= {}

SWEP.NPC_EquipSound 					= false
SWEP.NPC_UnequipSound 					= false
SWEP.NPC_ReloadSound					= {}
SWEP.Primary.Sound						= {}
SWEP.Primary.DistantSound				= {}

SWEP.Primary.TracerType 				= "vj_fo3_tracer"
SWEP.PrimaryEffects_MuzzleParticles 	= {}

SWEP.PrimaryEffects_MuzzleAttachment 	= "muzzle"

SWEP.AdjustViewModel = false
SWEP.ViewModelAdjust = {
	Pos = {Right = 0,Forward = 0,Up = 0},
	Ang = {Right = 0,Up = 0,Forward = 0}
}

SWEP.ZoomLevel = 40
SWEP.ViewModelZoomAdjust = {
	Pos = {Right = -0.25,Forward = 2,Up = 0},
	Ang = {Right = 0,Up = 0,Forward = 0}
}
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:WeaponEquip() end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:WeaponThink() end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base 						= "weapon_vj_base"
SWEP.Author 					= "Cpt. Hazama"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players and NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "VJ Base - Fallout: Remastered"
SWEP.Spawnable = false
SWEP.ViewModelFOV = 55
SWEP.BobScale = 0.25
SWEP.SwayScale = 0.5
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.MadeForNPCsOnly 			= false -- Is tihs weapon meant to be for NPCs only?
	-- World Model ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel_UseCustomPosition = false
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Force				= 1 -- Force applied on the object the bullet hits
SWEP.Primary.Ammo				= "Pistol" -- Ammo type
SWEP.PrimaryEffects_SpawnShells = false
SWEP.Reload_TimeUntilAmmoIsSet 	= false
SWEP.Primary.PlayerDamage 		= "Double"
SWEP.HoldType 					= SWEP.AnimationType
SWEP.ViewModel 					= "models/cpthazama/fallout/weapons/c_arms.mdl"
SWEP.ViewModelB 				= false
SWEP.UseHands 					= true

SWEP.Garbage = {}
--
local vj_wep_muzzleflash = GetConVar("vj_wep_muzzleflash")
local vj_wep_muzzleflash_light = GetConVar("vj_wep_muzzleflash_light")
local vj_wep_shells = GetConVar("vj_wep_shells")
local metaEntity = FindMetaTable("Entity")
local metaAngle = FindMetaTable("Angle")
local funcGetTable = metaEntity.GetTable
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnDoMeleeAttack(anim,time) end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:AddGarbage(ent)
	table.insert(self.Garbage,ent)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:SetupDataTables()
	self:NetworkVar("Bool", "Zoomed")
	self:NetworkVar("Bool", "DrawWorldModel")
	if SERVER then
		self:SetDrawWorldModel(true)
	end

	if self.Vars then
		for _,v in pairs(self.Vars) do
			self:NetworkVar(v.Type, v.Index, v.Name)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
if SERVER then
	util.AddNetworkString("VJ_F3R_InitCModel")
	util.AddNetworkString("VJ_F3R_ClearCModel")

	function SWEP:InitializeCModel()
		net.Start("VJ_F3R_InitCModel")
			net.WriteEntity(self)
			net.WriteEntity(self:GetOwner())
		net.Send(self:GetOwner())
	end

	function SWEP:ClearGarbage()
		net.Start("VJ_F3R_ClearCModel")
			net.WriteEntity(self)
			net.WriteEntity(self:GetOwner())
		net.Send(self:GetOwner())
	end
else
	function SWEP:InitializeCModel()
		self:CleanUpGarbage()
		SafeRemoveEntity(self.VJ_CModel)
		local ent = self:CreateCModel(self.ViewModelB or self.WorldModel,RENDERGROUP_BOTH)
		if ent:GetParent() != self:GetOwner():GetViewModel() then
			ent:SetNoDraw(true)
			ent:SetupBones()
			ent:SetParent(self:GetOwner():GetViewModel())
			ent:AddEffects(EF_BONEMERGE)
			ent:AddEffects(EF_BONEMERGE_FASTCULL)
		end
		self.VJ_CModel = ent

		if self.OnCModelInit then
			self:OnCModelInit(ent)
		end
	end
	
	net.Receive("VJ_F3R_InitCModel",function(len,ply)
		local wep = net.ReadEntity()
		local owner = net.ReadEntity()
		if IsValid(wep) && IsValid(owner) && wep.InitializeCModel then
			wep:InitializeCModel()
		end
	end)
	
	net.Receive("VJ_F3R_ClearCModel",function(len,ply)
		local wep = net.ReadEntity()
		local owner = net.ReadEntity()
		if IsValid(wep) && IsValid(owner) then
			wep:CleanUpGarbage()
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnHit(entTbl,hitType) end
---------------------------------------------------------------------------------------------------------------------------------------------
local string_StartWith = string.StartWith
--
if CLIENT then
	function SWEP:CreateCModel(...)
		local ent = ClientsideModel(...)
		self:AddGarbage(ent)
		return ent
	end

	function SWEP:CustomOnInitialize()
		if self.OnInit then
			self:OnInit()
		end
		if self:GetOwner():IsPlayer() then
			self:InitializeCModel()
		end
	end

	function SWEP:ViewModelDrawn()
		if self.VJ_CModel then
			self.VJ_CModel:DrawModel()
		end
	end
else
	function SWEP:CustomOnInitialize()
		if self.OnInit then
			self:OnInit()
		end

		if self.Primary.Delay == -1 then
			self.Primary.Delay = self.NPC_NextPrimaryFire or 0.1
		end
		if self.Primary.Cone == -1 then
			self.Primary.Cone = self.NPC_CustomSpread *10 or 7
		end

		self:SetZoomed(false)

		if self.IsMeleeWeapon then
			self.PrimaryEffects_MuzzleFlash = false
			self.PrimaryEffects_SpawnDynamicLight = false
			if self.MeleeInit then
				self:MeleeInit()
			end
		end

		local owner = self:GetOwner()
		self.WorldModel_UseCustomPosition = owner:IsPlayer() or (owner:IsNPC() && string_StartWith(owner:GetClass(), "npc_vj_f3r") == false)

		hook.Add("OnPlayerPhysicsDrop",self,function(self,ply,ent)
			if ply == self:GetOwner() && ply:GetActiveWeapon() == self then
				self:InitializeCModel()
			end
		end)

		timer.Simple(0,function()
			local owner = self.Owner
			local tbl = self.Weights
			if tbl && owner:IsPlayer() then
				self.Weight = tbl.Weight or 0
				self.WalkSpeed = tbl.WalkSpeed or 1
				self.RunSpeed = tbl.RunSpeed or 1
				self.CrouchSpeed = tbl.CrouchSpeed or 1
				self.ClimbSpeed = tbl.ClimbSpeed or 1
				self.JumpPower = tbl.JumpPower or 1

				self.Original_WalkSpeed = owner:GetWalkSpeed() or 200
				self.Original_RunSpeed = owner:GetRunSpeed() or 400
				self.Original_CrouchSpeed = owner:GetCrouchedWalkSpeed() or 0.3
				self.Original_ClimbSpeed = owner:GetLadderClimbSpeed() or 200
				self.Original_JumpPower = owner:GetJumpPower() or 200
			end

			self.Original_Cone = self.Primary.Cone
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:PlayWeaponSoundTimed(snd,time,vol)
	if !self:GetOwner():IsPlayer() then return end

	timer.Simple(time,function()
		if IsValid(self) && self.Reloading && IsValid(self:GetOwner()) then
			VJ_CreateSound(self:GetOwner(), snd, vol or 70)
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:GetDrawWorldModel() return end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:PrimaryAttackEffects(owner)
	local selfData = funcGetTable(self)
	if selfData.IsMeleeWeapon then return end
	owner = owner or metaEntity.GetOwner(self)
	if selfData.CustomOnPrimaryAttackEffects && selfData.CustomOnPrimaryAttackEffects(self, owner) == false then return end -- !!!!!!!!!!!!!! DO NOT USE !!!!!!!!!!!!!! [Backwards Compatibility!]
	
	if vj_wep_muzzleflash:GetInt() == 1 then
		owner:MuzzleFlash()
		
		-- MUZZLE FLASH
		if selfData.PrimaryEffects_MuzzleFlash then
			local muzzleAttach = selfData.PrimaryEffects_MuzzleAttachment
			if !isnumber(muzzleAttach) then muzzleAttach = self:LookupAttachment(muzzleAttach) end
			-- Players
			if owner:IsPlayer() && owner:GetViewModel() != nil then
				local muzzleFlashEffect = EffectData()
				local shootPos = owner:GetShootPos()
				muzzleFlashEffect:SetOrigin(shootPos)
				muzzleFlashEffect:SetEntity(self)
				muzzleFlashEffect:SetStart(shootPos)
				muzzleFlashEffect:SetNormal(owner:GetAimVector())
				muzzleFlashEffect:SetAttachment(muzzleAttach)
				util.Effect("VJ_Weapon_PlayerMuzzle_F3R", muzzleFlashEffect)
			-- NPCs
			else
				local particles = selfData.PrimaryEffects_MuzzleParticles
				if selfData.PrimaryEffects_MuzzleParticlesAsOne then -- Combine all of the particles in the table!
					for _, v in ipairs(particles) do
						ParticleEffectAttach(v, PATTACH_POINT_FOLLOW, self, muzzleAttach)
					end
				else
					particles = VJ.PICK(particles)
					if particles then
						ParticleEffectAttach(particles, PATTACH_POINT_FOLLOW, self, muzzleAttach)
					end
				end
			end
		end
		
		-- MUZZLE DYNAMIC LIGHT
		if SERVER && selfData.PrimaryEffects_SpawnDynamicLight && vj_wep_muzzleflash_light:GetInt() == 1 then
			local muzzleLight = ents.Create("light_dynamic")
			muzzleLight:SetKeyValue("brightness", selfData.PrimaryEffects_DynamicLightBrightness)
			muzzleLight:SetKeyValue("distance", selfData.PrimaryEffects_DynamicLightDistance)
			if owner:IsPlayer() then
				muzzleLight:SetLocalPos(owner:GetShootPos() + metaEntity.GetForward(self)*40 + metaEntity.GetUp(self)*-10)
			else
				muzzleLight:SetLocalPos(selfData.GetBulletPos(self))
			end
			muzzleLight:SetLocalAngles(metaEntity.GetAngles(self))
			muzzleLight:SetColor(selfData.PrimaryEffects_DynamicLightColor)
			//muzzleLight:SetParent(self)
			muzzleLight:Spawn()
			muzzleLight:Activate()
			muzzleLight:Fire("TurnOn", "", 0)
			muzzleLight:Fire("Kill", "", 0.07)
			self:DeleteOnRemove(muzzleLight)
		end
	end

	-- SHELL CASING
	if !owner:IsPlayer() && selfData.PrimaryEffects_SpawnShells && vj_wep_shells:GetInt() == 1 then
		local shellAttach = selfData.PrimaryEffects_ShellAttachment
		shellAttach = self:GetAttachment(isnumber(shellAttach) and shellAttach or self:LookupAttachment(shellAttach))
		if !shellAttach then -- No attachment found, so just use some default pos & ang
			shellAttach = {Pos = owner:GetShootPos(), Ang = metaEntity.GetAngles(self)}
		end
		local effectData = EffectData()
		effectData:SetEntity(self)
		effectData:SetOrigin(shellAttach.Pos)
		effectData:SetAngles(shellAttach.Ang)
		util.Effect(selfData.PrimaryEffects_ShellType, effectData, true, true)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnThink()
	local owner = self:GetOwner()
	if self.WeaponThink then
		self:WeaponThink(owner)
	end

	if self.IsMeleeWeapon then
		if self.MeleeThink then
			self:MeleeThink(owner)
		end
	end

	if IsValid(self:GetOwner()) then
		self.WorldModel_UseCustomPosition = owner:IsPlayer() or (owner:IsNPC() && string_StartWith(owner:GetClass(), "npc_vj_f3r") == false)
		self:SetHoldType(owner:IsPlayer() && (self.PHoldType or self.AnimationType) or self.HoldType)
	else
		self.WorldModel_UseCustomPosition = false
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnEquip(owner)
	if self.WeaponEquip then
		self:WeaponEquip()
	end
	if CLIENT then
		if owner:IsPlayer() then
			self:InitializeCModel()
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnDeploy()
	if self.WeaponDeploy then
		self:WeaponDeploy()
	end
	local owner = self:GetOwner()
	if owner:IsPlayer() then
		self:InitializeCModel()
		timer.Simple(0,function()
			if self.WalkSpeed then
				owner:SetWalkSpeed(owner:GetWalkSpeed() *self.WalkSpeed)
			end
			if self.RunSpeed then
				owner:SetRunSpeed(owner:GetRunSpeed() *self.RunSpeed)
			end
			if self.CrouchSpeed then
				owner:SetCrouchedWalkSpeed(owner:GetCrouchedWalkSpeed() *self.CrouchSpeed)
			end
			if self.ClimbSpeed then
				owner:SetLadderClimbSpeed(owner:GetLadderClimbSpeed() *self.ClimbSpeed)
			end
			if self.JumpPower then
				owner:SetJumpPower(owner:GetJumpPower() *self.JumpPower)
			end
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:WeaponHolstered(newWep) return true end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:Holster(newWep)
	if self == newWep or self.Reloading == true then return end
	self.HasIdleAnimation = false
	if self:GetOwner():IsPlayer() then
		if SERVER then
			self:ClearGarbage()
		else
			self:CleanUpGarbage()
		end
	end
	if SERVER && self:GetOwner():IsPlayer() then
		self:ResetPlayerSpeed(self:GetOwner())
	end
	return self:WeaponHolstered(newWep)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CleanUpGarbage()
	for _,v in pairs(self.Garbage) do
		if v.StopEmissionAndDestroyImmediately then
			v:StopEmissionAndDestroyImmediately()
		else
			SafeRemoveEntity(v)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnRemove()
	self:StopParticles()
	self:CustomOnRemove()
	self:CleanUpGarbage()
	if SERVER && self:GetOwner():IsPlayer() then
		self:ResetPlayerSpeed(self:GetOwner())
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:ResetPlayerSpeed(owner)
	owner:SetWalkSpeed(self.Original_WalkSpeed or 200)
	owner:SetRunSpeed(self.Original_RunSpeed or 400)
	owner:SetCrouchedWalkSpeed(self.Original_CrouchSpeed or 0.3)
	owner:SetLadderClimbSpeed(self.Original_ClimbSpeed or 200)
	owner:SetJumpPower(self.Original_JumpPower or 200)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:GetZoomViewModelPosition()
	return self:GetZoomed(), self.ViewModelZoomAdjust.Pos, self.ViewModelZoomAdjust.Ang
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:ShouldForceViewModelPosition()
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
local IRONSIGHT_TIME = 0.25
--
function SWEP:GetViewModelPosition(pos,ang)
	local shouldZoom, zoomPos, zoomAng = self:GetZoomViewModelPosition()
	local forceAdjust, forceAdjustPos, forceAdjustAng = self:ShouldForceViewModelPosition()

	if self.AdjustViewModel == true or forceAdjust then
		pos:Add(ang:Right() *(self.ViewModelAdjust.Pos.Right))
		pos:Add(ang:Forward() *(self.ViewModelAdjust.Pos.Forward))
		pos:Add(ang:Up() *(self.ViewModelAdjust.Pos.Up))
		ang:RotateAroundAxis(ang:Right(),self.ViewModelAdjust.Ang.Right)
		ang:RotateAroundAxis(ang:Up(),self.ViewModelAdjust.Ang.Up)
		ang:RotateAroundAxis(ang:Forward(),self.ViewModelAdjust.Ang.Forward)
	else
		pos:Add(ang:Right() *0)
		pos:Add(ang:Forward() *0)
		pos:Add(ang:Up() *0)
		ang:RotateAroundAxis(ang:Right(),0)
		ang:RotateAroundAxis(ang:Up(),0)
		ang:RotateAroundAxis(ang:Forward(),0)
	end

	if shouldZoom != self.ShouldZoom then
		self.ShouldZoom = shouldZoom
		self.ZoomT = CurTime()
	end
	
	local ZoomT = self.ZoomT or 0

	if !shouldZoom && ZoomT < CurTime() -IRONSIGHT_TIME then
		return pos, ang
	end

	local Mul = 1
	if ZoomT > CurTime() -IRONSIGHT_TIME then
		Mul = math.Clamp((CurTime() -ZoomT) /IRONSIGHT_TIME,0,1)
		if !shouldZoom then
			Mul = 1 -Mul
		end
	end

	-- if shouldZoom then
		pos:Add(ang:Right() *(zoomPos.Right *Mul))
		pos:Add(ang:Forward() *(zoomPos.Forward *Mul))
		pos:Add(ang:Up() *(zoomPos.Up *Mul))
		ang:RotateAroundAxis(ang:Right(),zoomAng.Right *Mul)
		ang:RotateAroundAxis(ang:Up(),zoomAng.Up *Mul)
		ang:RotateAroundAxis(ang:Forward(),zoomAng.Forward *Mul)
	-- end

	return pos,ang
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CalcViewModelView(vm, OldEyePos, OldEyeAng, EyePos, EyeAng) -- Credits to Rex for the sway code, he did a really good job on it. Used without permission but he loves Daddy so I'm sure he won't mind ;)
	local EyePos, EyeAng = self:GetViewModelPosition(OldEyePos, OldEyeAng)
	local ply = self:GetOwner()
	local EyePos = OldEyePos
	local EyeAng = OldEyeAng

	local realspeed = ply:GetVelocity():Length2D() /ply:GetRunSpeed()
	local speed = math.Clamp(ply:GetVelocity():Length2DSqr() /ply:GetRunSpeed(), 0.25, 1)

	local bob_x_val = CurTime()*8
	local bob_y_val = CurTime()*16
	
	local bob_x = math.sin(bob_x_val*0.1)*0.5
	local bob_y = math.sin(bob_y_val*0.15)*0.05
	EyePos = EyePos + EyeAng:Right()*bob_x
	EyePos = EyePos + EyeAng:Up()*bob_y
	EyeAng:RotateAroundAxis(EyeAng:Forward(), 5 *bob_x)
	
	local speed_mul = 2
	if self:GetOwner():IsOnGround() && realspeed > 0.1 then
		local bobspeed = math.Clamp(realspeed*1.1, 0, 1)
		local bob_x = math.sin(bob_x_val*1*speed) *0.1 *bobspeed
		local bob_y = math.cos(bob_y_val*1*speed) *0.125 *bobspeed
		EyePos = EyePos + EyeAng:Right()*bob_x*speed_mul *0.65
		EyePos = EyePos + EyeAng:Up() *bob_y *speed_mul *1.5
	end

	if FrameTime() < 0.04 then
		if !self.SwayPos then self.SwayPos = Vector() end
		local vel = ply:GetVelocity()
		vel.x = math.Clamp(vel.x/300, -0.5, 0.5)
		vel.y = math.Clamp(vel.y/300, -0.5, 0.5)
		vel.z = math.Clamp(vel.z/750, -1, 0.5)
		
		self.SwayPos = LerpVector(FrameTime()*25, self.SwayPos, -vel)
		EyePos = EyePos + self.SwayPos
	end

	local EyePos, EyeAng = self:GetViewModelPosition(EyePos, EyeAng)
	return EyePos, EyeAng
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:TranslateAnim(seq)
	local anim = seq
	local useSeq = false
	if type(anim) == "string" then
		anim = VJ_SequenceToActivity(self:GetOwner():GetViewModel(), anim)
		if anim == false then
			anim = seq
			useSeq = true
		end
	end
	return anim, useSeq
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:SendWeaponSeq(seq)
	local owner = self:GetOwner()
	local vm = owner:GetViewModel()
	vm:ResetSequenceInfo()
	vm:SendViewModelMatchingSequence(vm:LookupSequence(seq))
	vm:SetPlaybackRate(1)
	vm:SetCycle(0)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:PlayAnimation(anim)
	local owner = self:GetOwner()
	local anim, useSeq = self:TranslateAnim(istable(anim) && VJ.PICK(anim) or anim)
	local animTime = VJ_GetSequenceDuration(owner:GetViewModel(), anim)
	if useSeq then
		self:SendWeaponSeq(anim)
	else
		self:SendWeaponAnim(anim)
	end
	return animTime, anim
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:DoIdleAnimation()
	if !self.HasIdleAnimation or CurTime() < self.NextIdleT then return end
	local owner = self:GetOwner()
	if IsValid(owner) then
		if self.IsMeleeWeapon == true then
			self.SwingSide = 0
		end
		owner:SetAnimation(PLAYER_IDLE)
		local animTime = self:PlayAnimation(self.AnimTbl_Idle)
		self.NextIdleT = CurTime() + animTime
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:Deploy()
	if self.InitHasIdleAnimation == true then self.HasIdleAnimation = true end
	local owner = self:GetOwner()
	if owner:IsPlayer() then
		self:CustomOnDeploy()
		if self.HasDeploySound == true then self:EmitSound(VJ.PICK(self.DeploySound),50,math.random(90,100)) end
		
		local curTime = CurTime()
		local animTime = self:PlayAnimation(self.AnimTbl_Deploy)
		self:SetNextPrimaryFire(curTime + animTime)
		self:SetNextSecondaryFire(curTime + animTime)
		self.NextIdleT = curTime + animTime
		self.NextReloadT = curTime + animTime
	end
	return true -- Or else the player won't be able to get the weapon!
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:NPC_Reload()
	local owner = self:GetOwner()
	owner.NextThrowGrenadeT = owner.NextThrowGrenadeT + 2
	owner.NextChaseTime = 0
	self:CustomOnReload()
	if self.NPC_HasReloadSound == true then VJ.EmitSound(owner, self.NPC_ReloadSound, self.NPC_ReloadSoundLevel) end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnReload() end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:Reload()
	if !IsValid(self) then return end
	local owner = self:GetOwner()
	if !IsValid(owner) or !owner:IsPlayer() or !owner:Alive() or owner:GetAmmoCount(self.Primary.Ammo) == 0 or self.Reloading or CurTime() < self.NextReloadT then return end // or !owner:KeyDown(IN_RELOAD)
	if self:Clip1() < self.Primary.ClipSize then
		self.Reloading = true
		self:SetZoomed(false)
		self:OnReload("Start")
		self:CustomOnReload()
		if SERVER && self.HasReloadSound == true then
			local reloadSD = VJ.PICK(self.ReloadSound)
			if reloadSD then
				owner:EmitSound(reloadSD, 50, math.random(90, 100))
			end
		end
		local animTime = self:PlayAnimation(self.AnimTbl_Reload)
		self.NextIdleT = CurTime() + animTime
		-- Handle clip
		timer.Simple(self.Reload_TimeUntilAmmoIsSet or animTime, function()
			if IsValid(self) && self:OnReload("Finish") != true then
				local ammoUsed = math.Clamp(self.Primary.ClipSize - self:Clip1(), 0, owner:GetAmmoCount(self:GetPrimaryAmmoType())) -- Amount of ammo that it will use (Take from the reserve)
				owner:RemoveAmmo(ammoUsed, self.Primary.Ammo)
				self:SetClip1(self:Clip1() + ammoUsed)
			end
		end)
		-- Handle animation
		owner:SetAnimation(PLAYER_RELOAD)
		timer.Simple(animTime, function()
			if IsValid(self) then
				self.Reloading = false
			end
		end)
		return true
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:Zoom()
	if self.Reloading then return end
	local zoomed = self:GetZoomed()
	self:SetZoomed(!zoomed)
	self:GetOwner():SetFOV(self:GetZoomed() && (self.ZoomLevel or 40) or (GetConVar("fov_desired"):GetInt() or 90), 0.25)
	self.Primary.Cone = (self:GetZoomed() && self.Original_Cone *0.5) or self.Original_Cone
	self:EmitSound("physics/metal/weapon_footstep" .. (self:GetZoomed() && 2 or 1) .. ".wav", 65, 100)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnMeleeHit(entTbl,UseAlt)
	local owner = self:GetOwner()
	local hitType = 0
	if #entTbl <= 0 then
		local tr = util.TraceLine({
			start = owner:GetShootPos(),
			endpos = owner:GetShootPos() +owner:GetAimVector() *self.MeleeHitDistance,
			filter = {owner,self}
		})
		if tr.Hit then
			if self.SoundTbl_MeleeAttackHitWorld then
				sound.Play(VJ.PICK(self.SoundTbl_MeleeAttackHitWorld), tr.HitPos, 75)
			end
			hitType = 1
		else
			if self.SoundTbl_MeleeAttackMiss then
				sound.Play(VJ.PICK(self.SoundTbl_MeleeAttackMiss), owner:GetShootPos(), 70)
			end
			hitType = 2
		end
	else
		if self.SoundTbl_MeleeAttackHit then
			sound.Play(VJ.PICK(self.SoundTbl_MeleeAttackHit), owner:EyePos(), 75)
		end
		for _,v in pairs(entTbl) do
			local applyDmg = DamageInfo()
			applyDmg:SetDamage((UseAlt && self.Primary.HeavyDamage or self.Primary.Damage) *(owner:IsPlayer() && 2 or 1))
			applyDmg:SetDamageType(self.Primary.DamageType)
			applyDmg:SetDamagePosition(self:GetNearestPoint(v).MyPosition)
			applyDmg:SetDamageForce(self:GetForward() *((applyDmg:GetDamage() +100) *70))
			applyDmg:SetInflictor(self)
			applyDmg:SetAttacker(owner)
			v:TakeDamageInfo(applyDmg,owner)
		end
		hitType = 3
	end

	self:OnHit(entTbl,hitType)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnPrimaryAttack_BeforeShoot()
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnPrimaryAttack_AfterShoot() end
---------------------------------------------------------------------------------------------------------------------------------------------
local function IsValidEntity(v)
	if !IsValid(v) then return false end
	if v:IsNPC() or v:IsPlayer() or v:IsNextBot() or v:GetClass() == "prop_physics" or string_StartWith(v:GetClass(),"func") then
		return true
	end
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:PrimaryAttack(UseAlt)
	//if self:GetOwner():KeyDown(IN_RELOAD) then return end
	//self:GetOwner():SetFOV(45, 0.3)
	//if !IsFirstTimePredicted() then return end

	local selfData = funcGetTable(self)
	local owner = metaEntity.GetOwner(self)
	local ownerData = funcGetTable(owner)

	local curTime = CurTime()
	self:SetNextPrimaryFire(curTime + selfData.Primary.Delay)

	local isNPC = owner:IsNPC()
	local isPly = owner:IsPlayer()
	
	if selfData.Reloading or self:GetNextSecondaryFire() > curTime then return end
	if isNPC && !ownerData.VJ_IsBeingControlled && !IsValid(owner:GetEnemy()) then return end -- If the NPC owner isn't being controlled and doesn't have an enemy, then return end
	if !selfData.IsMeleeWeapon && ((isPly && !selfData.Primary.AllowInWater && owner:WaterLevel() == 3) or (self:Clip1() <= 0)) then
		if SERVER then
			owner:EmitSound(VJ.PICK(selfData.DryFireSound), selfData.DryFireSoundLevel, math.random(selfData.DryFireSoundPitch.a, selfData.DryFireSoundPitch.b))
		end
		return
	end
	if !selfData.CanPrimaryAttack(self) then return end
	if selfData.OnPrimaryAttack(self, "Init") == true then return end

	local ownersPos = metaEntity.GetPos(owner)
	
	if isNPC && ownerData.IsVJBaseSNPC then
		timer.Simple(selfData.NPC_ExtraFireSoundTime, function()
			if IsValid(self) && IsValid(owner) then
				VJ.EmitSound(owner, selfData.NPC_ExtraFireSound, selfData.NPC_ExtraFireSoundLevel, math.Rand(selfData.NPC_ExtraFireSoundPitch.a, selfData.NPC_ExtraFireSoundPitch.b))
			end
		end)
	end
	
	-- Firing Sounds
	if SERVER then
		local fireSd = VJ.PICK(selfData.Primary.Sound)
		if fireSd then
			self:EmitSound(fireSd, selfData.Primary.SoundLevel, math.random(selfData.Primary.SoundPitch.a, selfData.Primary.SoundPitch.b), selfData.Primary.SoundVolume, CHAN_WEAPON, 0, 0, VJ_RecipientFilter)
			//EmitSound(fireSd, ownersPos, owner:EntIndex(), CHAN_WEAPON, 1, 140, 0, 100, 0, filter)
			//sound.Play(fireSd, ownersPos, self.Primary.SoundLevel, math.random(self.Primary.SoundPitch.a, self.Primary.SoundPitch.b), self.Primary.SoundVolume)
		end
		if selfData.Primary.HasDistantSound then
			local fireFarSd = VJ.PICK(selfData.Primary.DistantSound)
			if fireFarSd then
				-- Use "CHAN_AUTO" instead of "CHAN_WEAPON" otherwise it will override primary firing sound because it's also "CHAN_WEAPON"
				self:EmitSound(fireFarSd, selfData.Primary.DistantSoundLevel, math.random(selfData.Primary.DistantSoundPitch.a, selfData.Primary.DistantSoundPitch.b), selfData.Primary.DistantSoundVolume, CHAN_AUTO, 0, 0, VJ_RecipientFilter)
			end
		end
	end
	
	-- Firing Gesture
	if ownerData.IsVJBaseSNPC_Human && ownerData.AnimTbl_WeaponAttackGesture then
		ownerData.PlayAnim(owner, ownerData.AnimTbl_WeaponAttackGesture, false, false, false, 0, {AlwaysUseGesture = true})
	end

	local animTime, anim
	if isPly then
		//self:ShootEffects("ToolTracer") -- Deprecated
		owner:ViewPunch(Angle(-self.Primary.Recoil, 0, 0))
		owner:SetAnimation(PLAYER_ATTACK1)
		if self.IsMeleeWeapon == true then
			if UseAlt then
				self.SwingSide = 0
				animTime, anim = self:PlayAnimation(owner:GetVelocity():Length() > 15 && self.AnimTbl_Melee_PowerForward or self.AnimTbl_Melee_Power)
				anim = !isstring(anim) && VJ_GetSequenceName(owner:GetViewModel(), anim) or anim
				self:SetNextSecondaryFire(CurTime() + animTime)
			else
				self.SwingSide = self.SwingSide == 1 && 0 or 1
				animTime, anim = self:PlayAnimation(self.SwingSide == 1 && self.AnimTbl_Melee_Right or self.AnimTbl_Melee_Left)
				anim = !isstring(anim) && VJ_GetSequenceName(owner:GetViewModel(), anim) or anim
			end
		else
			animTime, anim = self:PlayAnimation(self.AnimTbl_PrimaryFire)
		end
		self.NextIdleT = CurTime() + animTime
		self.NextReloadT = CurTime() + animTime
	end
	
	-- MELEE WEAPON
	if selfData.IsMeleeWeapon then
		if SERVER && owner:IsPlayer() then
			local time = (self.MeleeHitTimes && self.MeleeHitTimes[anim]) or self.MeleeHitTime or 0.5
			self:OnDoMeleeAttack(anim,time)
			timer.Simple(time,function()
				if IsValid(self) && IsValid(owner) && self:GetOwner() == owner && owner:GetActiveWeapon() == self then
					local tbl = {}
					for _,v in pairs(ents.FindInSphere(owner:GetShootPos(),self.MeleeHitDistance)) do
						if IsValidEntity(v) && v.Health && owner:Visible(v) && v != self && v != owner && (owner:GetAimVector():Angle():Forward():Dot(((v:GetPos() +v:OBBCenter()) - owner:GetShootPos()):GetNormalized()) > math.cos(math.rad(self.MeleeHitRadius or 50))) then
							table.insert(tbl,v)
						end
					end
					self:OnMeleeHit(tbl,UseAlt)
				end
			end)
		end
	else
		if !selfData.Primary.DisableBulletCode then
			local bullet = {}
				bullet.Num = selfData.Primary.NumberOfShots
				bullet.Tracer = selfData.Primary.Tracer
				bullet.TracerName = selfData.Primary.TracerType
				bullet.Force = selfData.Primary.Force
				bullet.AmmoType = selfData.Primary.Ammo

				-- Bullet spawn position & spread & damage
				if isPly then
					bullet.Spread = Vector((selfData.Primary.Cone / 60) / 4, (selfData.Primary.Cone / 60) / 4, 0)
					bullet.Src = owner:GetShootPos()
					bullet.Dir = owner:GetAimVector()
					local plyDmg = selfData.Primary.PlayerDamage
					if plyDmg == "Same" then
						bullet.Damage = selfData.Primary.Damage
					elseif plyDmg == "Double" then
						bullet.Damage = selfData.Primary.Damage * 2
					elseif isnumber(plyDmg) then
						bullet.Damage = plyDmg
					end
				elseif owner.IsVJBaseSNPC then
					local ene = owner:GetEnemy()
					local spawnPos = selfData.GetBulletPos(self)
					local aimPos = ownerData.GetAimPosition(owner, ene, spawnPos, 0)
					local spread = ownerData.GetAimSpread(owner, ene, aimPos, selfData.NPC_CustomSpread or 1) // owner:GetPos():Distance(owner.VJ_TheController:GetEyeTrace().HitPos) -- Was used when NPC was being controlled
					bullet.Spread = Vector(spread, spread, 0)
					bullet.Dir = (aimPos - spawnPos):GetNormal()
					bullet.Src = spawnPos
					bullet.Damage = ownerData.ScaleByDifficulty(owner, selfData.Primary.Damage)
				else
					local spawnPos = selfData.GetBulletPos(self)
					bullet.Spread = Vector(0.05, 0.05, 0)
					bullet.Dir = (owner:GetEnemy():BodyTarget(spawnPos) - spawnPos):GetNormal()
					bullet.Src = spawnPos
					bullet.Damage = selfData.Primary.Damage
				end
				
				-- Callback
				bullet.Callback = function(attacker, tr, dmginfo)
					dmginfo:SetWeapon(self)
					dmginfo:SetInflictor(self)
					return selfData.OnPrimaryAttack_BulletCallback(self, attacker, tr, dmginfo)
				end
			owner:FireBullets(bullet)
		end
	end
	
	if !selfData.IsMeleeWeapon then -- Melee weapons shouldn't consume ammo!
		if isPly then -- "TakePrimaryAmmo" calls "Ammo1" and "RemoveAmmo" which do NOT exist in NPCs!
			selfData.TakePrimaryAmmo(self, selfData.Primary.TakeAmmo)
		else
			self:SetClip1(self:Clip1() - selfData.Primary.TakeAmmo)
		end
	end
	
	selfData.PrimaryAttackEffects(self, owner)
	
	-- if isPly then
	-- 	//self:ShootEffects("ToolTracer") -- Deprecated
	-- 	owner:ViewPunch(Angle(-selfData.Primary.Recoil, 0, 0))
	-- 	owner:SetAnimation(PLAYER_ATTACK1)
	-- 	local anim = VJ.PICK(selfData.AnimTbl_PrimaryFire)
	-- 	local animTime = VJ.AnimDuration(owner:GetViewModel(), anim)
	-- 	self:SendWeaponAnim(anim)
	-- 	selfData.PLY_NextIdleAnimT = curTime + animTime
	-- 	selfData.PLY_NextReloadT = curTime + animTime
	-- end
	selfData.OnPrimaryAttack(self, "PostFire")
	//self:SetNextPrimaryFire(curTime + self.Primary.Delay)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CanSecondaryAttack()
	if !self.IsMeleeWeapon then
		return self:GetNextSecondaryFire() < CurTime()
	end
	return self:CanPrimaryAttack()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:SecondaryAttack()
	if !self.IsMeleeWeapon then
		self:Zoom()
		self:SetNextSecondaryFire(CurTime() + 0.2)
		return true
	end
	self:PrimaryAttack(true)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:GetNearestPoint(argent,SameZ)
	if !IsValid(argent) then return end
	SameZ = SameZ or false -- Should the Z of the pos be the same as the NPC's?
	local myNearestPoint = self:GetOwner():EyePos()
	local NearestPositions = {MyPosition=Vector(0,0,0), EnemyPosition=Vector(0,0,0)}
	local Pos_Enemy, Pos_Self = argent:NearestPoint(myNearestPoint + argent:OBBCenter()), self:NearestPoint(argent:GetPos() + self:OBBCenter())
	Pos_Enemy.z, Pos_Self.z = argent:GetPos().z, myNearestPoint.z
	if SameZ == true then
		Pos_Enemy = Vector(Pos_Enemy.x,Pos_Enemy.y,self:SetNearestPointToEntityPosition().z)
		Pos_Self = Vector(Pos_Self.x,Pos_Self.y,self:SetNearestPointToEntityPosition().z)
	end
	NearestPositions.MyPosition = Pos_Self
	NearestPositions.EnemyPosition = Pos_Enemy
	return NearestPositions
end