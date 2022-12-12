if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel							= "models/fallout/weapons/v_arms.mdl"
SWEP.PrintName							= "Weapon_Base"
SWEP.ID 								= ITEM_VJ_NO_ID
SWEP.AnimationType 						= "2ha"
SWEP.PHoldType 							= "ar2"
SWEP.Weights = false

SWEP.WorldModel_CustomPositionAngle 	= Vector(80,5,270)
SWEP.WorldModel_CustomPositionOrigin 	= Vector(-3.6,0,-1.2)

SWEP.NPC_NextPrimaryFire 				= 0.1
SWEP.NPC_CustomSpread	 				= 0.8
SWEP.NPC_TimeUntilFire	 				= 0
SWEP.NPC_TimeUntilFireExtraTimers 		= {}

SWEP.Primary.Damage						= 1
SWEP.Primary.ClipSize					= 1

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
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnEquip() end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnThink() end
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
---------------------------------------------------------------------------------------------------------------------------------------------
if CLIENT then
	function SWEP:CreateCModel(...)
		local ent = ClientsideModel(...)
		table.insert(self.Garbage,ent)
		return ent
	end

	function SWEP:CustomOnInitialize()
		if self.OnInit then
			self:OnInit()
		end
		if self:GetOwner():IsPlayer() then
			local ent = self:CreateCModel(self.ViewModelB or self.WorldModel,RENDERGROUP_BOTH)
			if ent:GetParent() != self:GetOwner():GetViewModel() then
				ent:SetNoDraw(true)
				ent:SetupBones()
				ent:SetParent(self:GetOwner():GetViewModel())
				ent:AddEffects(EF_BONEMERGE)
				ent:AddEffects(EF_BONEMERGE_FASTCULL)
			end
			self.VJ_CModel = ent
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

		if self.IsMeleeWeapon then
			if self.MeleeInit then
				self:MeleeInit()
			end
		end

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
function SWEP:PrimaryAttackEffects()
	if self:CustomOnPrimaryAttackEffects() != true or self.IsMeleeWeapon == true then return end
	local owner = self:GetOwner()
	
	/*local muzzleFlashEffect = EffectData()
	muzzleFlashEffect:SetOrigin(owner:GetShootPos())
	muzzleFlashEffect:SetEntity(self)
	muzzleFlashEffect:SetStart(owner:GetShootPos())
	muzzleFlashEffect:SetNormal(owner:GetAimVector())
	muzzleFlashEffect:SetAttachment(1)
	util.Effect("VJ_Weapon_RifleMuzzle1",muzzleFlashEffect)*/
	
	if GetConVar("vj_wep_nomuszzleflash"):GetInt() == 0 then
		-- MUZZLE FLASH
		if self.PrimaryEffects_MuzzleFlash == true then
			local muzzleAttach = self.PrimaryEffects_MuzzleAttachment
			if !isnumber(muzzleAttach) then muzzleAttach = self:LookupAttachment(muzzleAttach) end
			-- Players
			if owner:IsPlayer() && owner:GetViewModel() != nil then
				local muzzleFlashEffect = EffectData()
				muzzleFlashEffect:SetOrigin(owner:GetShootPos())
				muzzleFlashEffect:SetEntity(self)
				muzzleFlashEffect:SetStart(owner:GetShootPos())
				muzzleFlashEffect:SetNormal(owner:GetAimVector())
				muzzleFlashEffect:SetAttachment(muzzleAttach)
				util.Effect("VJ_Weapon_PlayerMuzzle_F3R", muzzleFlashEffect)
			else -- NPCs
				if self.PrimaryEffects_MuzzleParticlesAsOne == true then -- Combine all of the particles in the table!
					for _,v in pairs(self.PrimaryEffects_MuzzleParticles) do
						if !istable(v) then
							ParticleEffectAttach(v, PATTACH_POINT_FOLLOW, self, muzzleAttach)
						end
					end
				else
					ParticleEffectAttach(VJ_PICK(self.PrimaryEffects_MuzzleParticles), PATTACH_POINT_FOLLOW, self, muzzleAttach)
				end
			end
		end
		
		-- MUZZLE LIGHT
		if SERVER && self.PrimaryEffects_SpawnDynamicLight == true && GetConVar("vj_wep_nomuszzleflash_dynamiclight"):GetInt() == 0 then
			local muzzleLight = ents.Create("light_dynamic")
			muzzleLight:SetKeyValue("brightness", self.PrimaryEffects_DynamicLightBrightness)
			muzzleLight:SetKeyValue("distance", self.PrimaryEffects_DynamicLightDistance)
			if owner:IsPlayer() then muzzleLight:SetLocalPos(owner:GetShootPos() +self:GetForward()*40 + self:GetUp()*-10) else muzzleLight:SetLocalPos(self:GetNW2Vector("VJ_CurBulletPos")) end
			muzzleLight:SetLocalAngles(self:GetAngles())
			muzzleLight:Fire("Color", self.PrimaryEffects_DynamicLightColor.r.." "..self.PrimaryEffects_DynamicLightColor.g.." "..self.PrimaryEffects_DynamicLightColor.b)
			//muzzleLight:SetParent(self)
			muzzleLight:Spawn()
			muzzleLight:Activate()
			muzzleLight:Fire("TurnOn", "", 0)
			muzzleLight:Fire("Kill", "", 0.07)
			self:DeleteOnRemove(muzzleLight)
		end
	end

	-- SHELL CASING
	if !owner:IsPlayer() && self.PrimaryEffects_SpawnShells == true && GetConVar("vj_wep_nobulletshells"):GetInt() == 0 then
		local shellAttach = self.PrimaryEffects_ShellAttachment
		if !isnumber(shellAttach) then shellAttach = self:LookupAttachment(shellAttach) end
		local shellEffect = EffectData()
		shellEffect:SetEntity(self)
		shellEffect:SetOrigin(owner:GetShootPos())
		shellEffect:SetNormal(owner:GetAimVector())
		shellEffect:SetAttachment(shellAttach)
		util.Effect(self.PrimaryEffects_ShellType, shellEffect)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnThink()
	if self.OnThink then
		self:OnThink()
	end

	if self.IsMeleeWeapon then
		if self.MeleeThink then
			self:MeleeThink()
		end
	end

	if IsValid(self:GetOwner()) then
		self.WorldModel_UseCustomPosition = self:GetOwner():IsPlayer()
		self:SetHoldType(self:GetOwner():IsPlayer() && self.PHoldType or self.HoldType)
	else
		self.WorldModel_UseCustomPosition = false
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnEquip(owner)
	if self.OnEquip then
		self:OnEquip()
	end
	if CLIENT then
		if owner:IsPlayer() then
			local ent = self:CreateCModel(self.ViewModelB or self.WorldModel,RENDERGROUP_BOTH)
			if ent:GetParent() != owner:GetViewModel() then
				ent:SetNoDraw(true)
				ent:SetupBones()
				ent:SetParent(owner:GetViewModel())
				ent:AddEffects(EF_BONEMERGE)
				ent:AddEffects(EF_BONEMERGE_FASTCULL)
			end
			self.VJ_CModel = ent
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnDeploy()
	if self.OnDeploy then
		self:OnDeploy()
	end
	local owner = self:GetOwner()
	if owner:IsPlayer() then
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
function SWEP:Holster(newWep)
	if self == newWep or self.Reloading == true then return end
	self.HasIdleAnimation = false
	if self:GetOwner():IsPlayer() then
		for _,v in pairs(self.Garbage) do
			SafeRemoveEntity(v)
		end
	end
	if SERVER && self:GetOwner():IsPlayer() then
		self:ResetPlayerSpeed(self:GetOwner())
	end
	return self:CustomOnHolster(newWep)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnRemove()
	self:StopParticles()
	self:CustomOnRemove()
	for _,v in pairs(self.Garbage) do
		SafeRemoveEntity(v)
	end
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
function SWEP:ShouldForceViewModelPosition()
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:GetViewModelPosition(pos,ang)
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
	local anim, useSeq = self:TranslateAnim(istable(anim) && VJ_PICK(anim) or anim)
	local animTime = VJ_GetSequenceDuration(owner:GetViewModel(), anim)
	if useSeq then
		self:SendWeaponSeq(anim)
	else
		self:SendWeaponAnim(anim)
	end
	return animTime
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:DoIdleAnimation()
	if !self.HasIdleAnimation or CurTime() < self.NextIdleT then return end
	self:CustomOnIdle()
	local owner = self:GetOwner()
	if IsValid(owner) then
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
		if self.HasDeploySound == true then self:EmitSound(VJ_PICK(self.DeploySound),50,math.random(90,100)) end
		
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
function SWEP:Reload()
	if !IsValid(self) then return end
	local owner = self:GetOwner()
	if !IsValid(owner) or !owner:IsPlayer() or !owner:Alive() or owner:GetAmmoCount(self.Primary.Ammo) == 0 or self.Reloading or CurTime() < self.NextReloadT then return end // or !owner:KeyDown(IN_RELOAD)
	if self:Clip1() < self.Primary.ClipSize then
		self.Reloading = true
		self:CustomOnReload()
		if SERVER && self.HasReloadSound == true then owner:EmitSound(VJ_PICK(self.ReloadSound), 50, math.random(90, 100)) end
		-- Handle animation
		owner:SetAnimation(PLAYER_RELOAD)
		local animTime = self:PlayAnimation(self.AnimTbl_Reload)
		self.NextIdleT = CurTime() + animTime
		timer.Simple(animTime, function()
			if IsValid(self) then
				self.Reloading = false
			end
		end)
		-- Handle clip
		timer.Simple(self.Reload_TimeUntilAmmoIsSet or animTime, function()
			if IsValid(self) && self:CustomOnReload_Finish() != false then
				local ammoUsed = math.Clamp(self.Primary.ClipSize - self:Clip1(), 0, owner:GetAmmoCount(self:GetPrimaryAmmoType())) -- Amount of ammo that it will use (Take from the reserve)
				owner:RemoveAmmo(ammoUsed, self.Primary.Ammo)
				self:SetClip1(self:Clip1() + ammoUsed)
				self:CustomOnReload_Finish()
			end
		end)
		return true
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:PrimaryAttack(UseAlt)
	//if self:GetOwner():KeyDown(IN_RELOAD) then return end
	//self:GetOwner():SetFOV(45, 0.3)
	//if !IsFirstTimePredicted() then return end
	
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	local owner = self:GetOwner()
	local isNPC = owner:IsNPC()
	local isPly = owner:IsPlayer()
	
	if self.Reloading or self:GetNextSecondaryFire() > CurTime() then return end
	if isNPC && owner.VJ_IsBeingControlled == false && !IsValid(owner:GetEnemy()) then return end -- If the NPC owner isn't being controlled and doesn't have an enemy, then return end
	if SERVER && self.IsMeleeWeapon == false && ((isPly && self.Primary.AllowFireInWater == false && owner:WaterLevel() == 3) or (self:Clip1() <= 0)) then owner:EmitSound(VJ_PICK(self.DryFireSound),self.DryFireSoundLevel,math.random(self.DryFireSoundPitch.a, self.DryFireSoundPitch.b)) return end
	if (!self:CanPrimaryAttack()) then return end
	if self:CustomOnPrimaryAttack_BeforeShoot() == true then return end
	
	if isNPC && owner.IsVJBaseSNPC == true then
		timer.Simple(self.NPC_ExtraFireSoundTime, function()
			if IsValid(self) && IsValid(owner) then
				VJ_EmitSound(owner, self.NPC_ExtraFireSound, self.NPC_ExtraFireSoundLevel, math.Rand(self.NPC_ExtraFireSoundPitch.a, self.NPC_ExtraFireSoundPitch.b))
			end
		end)
	end
	
	-- Firing Sounds
	if SERVER then
		local fireSd = VJ_PICK(self.Primary.Sound)
		if fireSd != false then
			sound.Play(fireSd, owner:GetPos(), self.Primary.SoundLevel, math.random(self.Primary.SoundPitch.a, self.Primary.SoundPitch.b), self.Primary.SoundVolume)
			//self:EmitSound(fireSd, 80, math.random(90,100))
		end
		if self.Primary.HasDistantSound == true then
			local fireFarSd = VJ_PICK(self.Primary.DistantSound)
			if fireFarSd != false then
				sound.Play(fireFarSd, owner:GetPos(), self.Primary.DistantSoundLevel, math.random(self.Primary.DistantSoundPitch.a, self.Primary.DistantSoundPitch.b), self.Primary.DistantSoundVolume)
			end
		end
	end
	
	-- Firing Gesture
	if owner.IsVJBaseSNPC_Human == true && owner.DisableWeaponFiringGesture != true then
		owner:VJ_ACT_PLAYACTIVITY(owner:TranslateToWeaponAnim(VJ_PICK(owner.AnimTbl_WeaponAttackFiringGesture)), false, false, false, 0, {AlwaysUseGesture=true})
	end
	
	-- MELEE WEAPON
	if self.IsMeleeWeapon == true then

	-- REGULAR WEAPON (NON-MELEE)
	else
		if self.Primary.DisableBulletCode == false then
			local bullet = {}
				bullet.Num = self.Primary.NumberOfShots
				bullet.Tracer = self.Primary.Tracer
				bullet.TracerName = self.Primary.TracerType
				bullet.Force = self.Primary.Force
				bullet.Dir = owner:GetAimVector()
				bullet.AmmoType = self.Primary.Ammo
				bullet.Src = isNPC and self:GetNW2Vector("VJ_CurBulletPos") or owner:GetShootPos() -- Spawn Position
				
				-- Callback
				bullet.Callback = function(attacker, tr, dmginfo)
					self:CustomOnPrimaryAttack_BulletCallback(attacker, tr, dmginfo)
					/*local laserhit = EffectData()
					laserhit:SetOrigin(tr.HitPos)
					laserhit:SetNormal(tr.HitNormal)
					laserhit:SetScale(25)
					util.Effect("AR2Impact", laserhit)
					tr.HitPos:Ignite(8,0)*/
				end
				
				-- Damage
				if isPly then
					bullet.Spread = Vector((self.Primary.Cone / 60) / 4, (self.Primary.Cone / 60) / 4, 0)
					if self.Primary.PlayerDamage == "Same" then
						bullet.Damage = self.Primary.Damage
					elseif self.Primary.PlayerDamage == "Double" then
						bullet.Damage = self.Primary.Damage * 2
					elseif isnumber(self.Primary.PlayerDamage) then
						bullet.Damage = self.Primary.PlayerDamage
					end
				else
					if owner.IsVJBaseSNPC == true then
						bullet.Damage = owner:VJ_GetDifficultyValue(self.Primary.Damage)
					else
						bullet.Damage = self.Primary.Damage
					end
				end
			owner:FireBullets(bullet)
		elseif isNPC && owner.IsVJBaseSNPC == true then -- Make sure the VJ SNPC recognizes that it lost a ammunition, even though it was a custom bullet code
			self:SetClip1(self:Clip1() - 1)
		end
		if GetConVar("vj_wep_nomuszzleflash"):GetInt() == 0 then owner:MuzzleFlash() end
	end
	
	self:PrimaryAttackEffects()
	if isPly then
		//self:ShootEffects("ToolTracer") -- Deprecated
		owner:ViewPunch(Angle(-self.Primary.Recoil, 0, 0))
		self:TakePrimaryAmmo(self.Primary.TakeAmmo)
		owner:SetAnimation(PLAYER_ATTACK1)
		local animTime = self:PlayAnimation(self.AnimTbl_PrimaryFire)
		self.NextIdleT = CurTime() + animTime
		self.NextReloadT = CurTime() + animTime
	end
	self:CustomOnPrimaryAttack_AfterShoot()
	//self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
end