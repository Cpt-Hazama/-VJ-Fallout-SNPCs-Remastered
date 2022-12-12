if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel							= "models/fallout/weapons/v_arms.mdl"
SWEP.PrintName							= "Weapon_Base"
SWEP.ID 								= ITEM_VJ_NO_ID
SWEP.AnimationType 						= "2ha"
SWEP.PHoldType 							= "ar2"

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
SWEP.PrimaryEffects_MuzzleParticles 	= {"muzzleflash_4"}

SWEP.PrimaryEffects_MuzzleAttachment 	= "muzzle"
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
SWEP.Primary.PlayerDamage 		= "Double"
SWEP.HoldType 					= SWEP.AnimationType
SWEP.ViewModel 					= "models/cpthazama/fallout/weapons/c_arms.mdl"
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
		if self:GetOwner():IsPlayer() then
			local ent = self:CreateCModel(self.WorldModel,RENDERGROUP_BOTH)
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

	if IsValid(self:GetOwner()) then
		self.WorldModel_UseCustomPosition = self:GetOwner():IsPlayer()
		self:SetHoldType(self:GetOwner():IsPlayer() && self.PHoldType or self.HoldType)
	else
		self.WorldModel_UseCustomPosition = false
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnEquip()
	if self.OnEquip then
		self:OnEquip()
	end
	if CLIENT then
		if self:GetOwner():IsPlayer() then
			local ent = self:CreateCModel(self.WorldModel,RENDERGROUP_BOTH)
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
	return self:CustomOnHolster(newWep)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnRemove()
	self:StopParticles()
	self:CustomOnRemove()
	for _,v in pairs(self.Garbage) do
		SafeRemoveEntity(v)
	end
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