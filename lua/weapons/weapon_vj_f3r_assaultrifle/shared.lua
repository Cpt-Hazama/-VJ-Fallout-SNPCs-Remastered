if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel					= "models/fallout/weapons/w_assaultrifle.mdl"
SWEP.PrintName					= "Assault Rifle"
SWEP.ID 						= ITEM_VJ_ASSAULTRIFLE
SWEP.AnimationType 				= "2ha"
SWEP.NPC_NextPrimaryFire 		= 0.1 -- Next time it can use primary fire
SWEP.NPC_CustomSpread	 		= 0.8
SWEP.NPC_TimeUntilFire	 		= 0 -- How much time until the bullet/projectile is fired?
SWEP.NPC_TimeUntilFireExtraTimers = {} -- Extra timers, which will make the gun fire again! | The seconds are counted after the self.NPC_TimeUntilFire!
SWEP.Primary.Damage				= 4 -- Damage
SWEP.Primary.ClipSize			= 28 -- Max amount of bullets per clip
SWEP.NPC_EquipSound 			= "vj_fallout/weapons/assaultrifle/rifleassault_equip.wav"
SWEP.NPC_UnequipSound 			= "vj_fallout/weapons/assaultrifle/rifleassault_unequip.wav"
SWEP.NPC_ReloadSound			= {"vj_fallout/weapons/assaultrifle/rifleassaultg3_reload_out.wav"}
SWEP.Primary.Sound				= {"vj_fallout/weapons/assaultrifle/rifleassaultg3_fire_2d.wav"}
SWEP.Primary.DistantSound		= {"vj_fallout/weapons/assaultrifle/rifleassaultg3_fire_3d.wav"}
SWEP.PrimaryEffects_MuzzleAttachment = "muzzle"
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
SWEP.MadeForNPCsOnly 			= true -- Is tihs weapon meant to be for NPCs only?
	-- World Model ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel_UseCustomPosition = false -- Should the gun use custom position? This can be used to fix guns that are in the crotch
SWEP.WorldModel_CustomPositionAngle = Vector(80,5,270)
SWEP.WorldModel_CustomPositionOrigin = Vector(-3.6,0,-0.2)
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Force				= 1 -- Force applied on the object the bullet hits
SWEP.Primary.Ammo				= "Pistol" -- Ammo type
SWEP.PrimaryEffects_SpawnShells = false
SWEP.HoldType 					= "2ha"
SWEP.PHoldType 					= "ar2"
SWEP.ViewModel 					= "models/fallout/weapons/v_arms.mdl"
SWEP.CMuzzle = "muzzle"

SWEP.AnimTbl_Deploy = {ACT_GESTURE_RANGE_ATTACK_HMG1}
SWEP.AnimTbl_Idle = {ACT_GESTURE_RANGE_ATTACK_AR2_GRENADE}
SWEP.AnimTbl_PrimaryFire = {ACT_GESTURE_RANGE_ATTACK_AR1}
SWEP.AnimTbl_Reload = {ACT_GESTURE_BARNACLE_STRANGLE}

SWEP.Garbage = {}
---------------------------------------------------------------------------------------------------------------------------------------------
-- function SWEP:SetupDataTables()
-- 	self:NetworkVar("Entity",0,"CModel")
-- 	self:NetworkVar("Vector",0,"CMuzzle")
-- end
---------------------------------------------------------------------------------------------------------------------------------------------
if CLIENT then
	-- function SWEP:CreateCModel(...)
	-- 	local ent = ClientsideModel(...)
	-- 	table.insert(self.Garbage,ent)
	-- 	return ent
	-- end

	-- function SWEP:CustomOnInitialize()
	-- 	if self:GetOwner():IsPlayer() then
	-- 		self.VJ_CModel = self:CreateCModel(self.WorldModel,RENDERGROUP_BOTH)
	-- 		if self.VJ_CModel:GetParent() != self:GetOwner():GetViewModel() then
	-- 			self.VJ_CModel:SetNoDraw(true)
	-- 			self.VJ_CModel:SetupBones()
	-- 			self.VJ_CModel:SetParent(self:GetOwner():GetViewModel())
	-- 			self.VJ_CModel:AddEffects(EF_BONEMERGE)
	-- 			self.VJ_CModel:AddEffects(EF_BONEMERGE_FASTCULL)
	-- 		end
	-- 	end
	-- end

	-- function SWEP:ViewModelDrawn()
	-- 	if self.VJ_CModel then
	-- 		self.VJ_CModel:DrawModel()
	-- 		self:SetCMuzzle(self.VJ_CModel:GetAttachment(1).Pos)
	-- 	end
	-- end
end
---------------------------------------------------------------------------------------------------------------------------------------------
-- function SWEP:PrimaryAttackEffects()
-- 	if self:CustomOnPrimaryAttackEffects() != true then return end
-- 	local owner = self:GetOwner()

-- 	if GetConVarNumber("vj_wep_nomuszzleflash") == 0 then
-- 		if self.PrimaryEffects_MuzzleFlash == true then
-- 			local muzzleattach = self.PrimaryEffects_MuzzleAttachment
-- 			if isnumber(muzzleattach) == false && IsValid(self.VJ_CModel) then muzzleattach = self.VJ_CModel:LookupAttachment(muzzleattach) end
-- 			if owner:IsPlayer() && owner:GetViewModel() != nil && IsValid(self.VJ_CModel) then
-- 				local vjeffectmuz = EffectData()
-- 				vjeffectmuz:SetOrigin(owner:GetShootPos())
-- 				vjeffectmuz:SetEntity(self.VJ_CModel)
-- 				vjeffectmuz:SetStart(owner:GetShootPos())
-- 				vjeffectmuz:SetNormal(owner:GetAimVector())
-- 				vjeffectmuz:SetAttachment(muzzleattach)
-- 				util.Effect("VJ_Weapon_RifleMuzzle1",vjeffectmuz)
-- 			end
-- 		end
-- 	end
-- end
---------------------------------------------------------------------------------------------------------------------------------------------
/*function SWEP:PrimaryAttack(UseAlt)
	//if self:GetOwner():KeyDown(IN_RELOAD) then return end
	//self:GetOwner():SetFOV(45, 0.3)
	//if !IsFirstTimePredicted() then return end
	
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	local owner = self:GetOwner()
	local isnpc = owner:IsNPC()
	local isply = owner:IsPlayer()
	
	if self.Reloading == true then return end
	if isnpc && owner.VJ_IsBeingControlled == false && !IsValid(owner:GetEnemy()) then return end -- If the NPC owner isn't being controlled and doesn't have an enemy, then return end
	if (isply && self.Primary.AllowFireInWater == false && owner:WaterLevel() == 3) or (self:Clip1() <= 0) then owner:EmitSound(VJ_PICK(self.DryFireSound),self.DryFireSoundLevel,math.random(self.DryFireSoundPitch1,self.DryFireSoundPitch2)) return end
	if (!self:CanPrimaryAttack()) then return end
	self:CustomOnPrimaryAttack_BeforeShoot()
	
	if isnpc && owner.IsVJBaseSNPC == true then
		timer.Simple(self.NPC_ExtraFireSoundTime, function()
			if IsValid(self) && IsValid(owner) then
				VJ_EmitSound(owner,self.NPC_ExtraFireSound,self.NPC_ExtraFireSoundLevel,math.Rand(self.NPC_ExtraFireSoundPitch.a, self.NPC_ExtraFireSoundPitch.b))
			end
		end)
	end
	local firesd = VJ_PICK(self.Primary.Sound)
	if firesd != false then
		self:EmitSound(firesd, 80, math.random(90,100))
		//sound.Play(firesd,self:GetPos(),80,math.random(90,100))
	end
	if self.Primary.HasDistantSound == true then
		local farsd = VJ_PICK(self.Primary.DistantSound)
		if farsd != false then
			sound.Play(farsd,self:GetPos(),self.Primary.DistantSoundLevel,math.random(self.Primary.DistantSoundPitch1,self.Primary.DistantSoundPitch2),self.Primary.DistantSoundVolume)
		end
	end
	
	if owner.IsVJBaseSNPC_Human == true && owner.DisableWeaponFiringGesture != true then
		local anim = owner:TranslateToWeaponAnim(VJ_PICK(owner.AnimTbl_WeaponAttackFiringGesture))
		owner:VJ_ACT_PLAYACTIVITY(anim, false, false, false, 0, {AlwaysUseGesture=true})
	end
	
	if self.Primary.DisableBulletCode == false then
		local bullet = {}
			bullet.Num = self.Primary.NumberOfShots
			bullet.Tracer = self.Primary.Tracer
			bullet.TracerName = self.Primary.TracerType
			bullet.Force = self.Primary.Force
			bullet.Dir = owner:GetAimVector()
			bullet.AmmoType = self.Primary.Ammo
			
			-- Spawn Position
			local spawnpos = self:LocalToWorld(self:GetCMuzzle())
			if isnpc then
				spawnpos = self:GetNWVector("VJ_CurBulletPos")
			end
			//print(spawnpos)
			//VJ_CreateTestObject(spawnpos,self:GetAngles(),Color(0,0,255))
			bullet.Src = spawnpos
			
			-- Damage
			if isply then
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
	else
		if isnpc && owner.IsVJBaseSNPC == true then -- Make sure the VJ SNPC recognizes that it lost a ammunition, even though it was a custom bullet code
			owner.Weapon_ShotsSinceLastReload = owner.Weapon_ShotsSinceLastReload + 1
		end
	end
	
	if GetConVarNumber("vj_wep_nomuszzleflash") == 0 then owner:MuzzleFlash() end
	self:PrimaryAttackEffects()
	if isply then
		//self:ShootEffects("ToolTracer") -- Deprecated
		self:SendWeaponAnim(VJ_PICK(self.AnimTbl_PrimaryFire))
		owner:SetAnimation(PLAYER_ATTACK1)
		owner:ViewPunch(Angle(-self.Primary.Recoil, 0, 0))
		self:TakePrimaryAmmo(self.Primary.TakeAmmo)
	end
	self:CustomOnPrimaryAttack_AfterShoot()
	//self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	timer.Simple(self.NextIdle_PrimaryAttack, function() if IsValid(self) then self:DoIdleAnimation() end end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnThink()
	if IsValid(self:GetOwner()) then
		self.WorldModel_UseCustomPosition = self:GetOwner():IsPlayer()
		self:SetHoldType(self:GetOwner():IsPlayer() && self.PHoldType or self.HoldType)
	else
		self.WorldModel_UseCustomPosition = false
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnEquip()
	-- if CLIENT then
		-- if self:GetOwner():IsPlayer() && !IsValid(self.VJ_CModel) then
			-- self.VJ_CModel = self:CreateCModel(self.WorldModel,RENDERGROUP_BOTH)
			-- if self.VJ_CModel:GetParent() != self:GetOwner():GetViewModel() then
				-- self.VJ_CModel:SetNoDraw(true)
				-- self.VJ_CModel:SetupBones()
				-- self.VJ_CModel:SetParent(self:GetOwner():GetViewModel())
				-- self.VJ_CModel:AddEffects(EF_BONEMERGE)
				-- self.VJ_CModel:AddEffects(EF_BONEMERGE_FASTCULL)
			-- end
		-- end
	-- end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:Holster()
	if self:GetOwner():IsPlayer() then
		for _,v in pairs(self.Garbage) do
			SafeRemoveEntity(v)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnRemove()
	if self:GetOwner():IsPlayer() then
		for _,v in pairs(self.Garbage) do
			SafeRemoveEntity(v)
		end
	end
end*/