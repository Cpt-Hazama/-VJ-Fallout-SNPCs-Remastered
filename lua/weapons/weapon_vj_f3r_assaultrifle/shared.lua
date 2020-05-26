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
SWEP.Spawnable = true
SWEP.ViewModelFOV = 55
SWEP.BobScale = 0.25
SWEP.SwayScale = 0.5
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.MadeForNPCsOnly 			= false -- Is tihs weapon meant to be for NPCs only?
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
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:SetupDataTables()
	self:NetworkVar("Entity",0,"CModel")
	self:NetworkVar("Vector",0,"CMuzzle")
end
---------------------------------------------------------------------------------------------------------------------------------------------
if CLIENT then
	function SWEP:ViewModelDrawn()
		local setvalid = IsValid(self._CModel)
		if !setvalid then
			local vm = self.Owner:GetViewModel()
			if IsValid(vm) then
				self._CModel = ClientsideModel(self.WorldModel)
				self._CModel:SetPos(vm:GetPos())
				self._CModel:SetAngles(vm:GetAngles())
				self._CModel:AddEffects(EF_BONEMERGE)
				self._CModel:SetNoDraw(true)
				self._CModel:SetParent(vm)
				setvalid = true
				self:SetCModel(self._CModel)
			end
		end
		if setvalid then
			self._CModel:DrawModel()
			self:SetCMuzzle(self._CModel:GetAttachment(self._CModel:LookupAttachment(self.CMuzzle)).Pos)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:PrimaryAttackEffects()
	if self:CustomOnPrimaryAttackEffects() != true then return end
	local owner = self:GetOwner()
	
	/*local vjeffectmuz = EffectData()
	vjeffectmuz:SetOrigin(self:LocalToWorld(self:GetCMuzzle()))
	vjeffectmuz:SetEntity(self)
	vjeffectmuz:SetStart(self:LocalToWorld(self:GetCMuzzle()))
	vjeffectmuz:SetNormal(owner:GetAimVector())
	vjeffectmuz:SetAttachment(1)
	util.Effect("VJ_Weapon_RifleMuzzle1",vjeffectmuz)*/

	if GetConVarNumber("vj_wep_nomuszzleflash") == 0 then
		if self.PrimaryEffects_MuzzleFlash == true then
			local muzzleattach = self.PrimaryEffects_MuzzleAttachment
			if isnumber(muzzleattach) == false then muzzleattach = self:LookupAttachment(muzzleattach) end
			if owner:IsPlayer() && owner:GetViewModel() != nil then
				local vjeffectmuz = EffectData()
				vjeffectmuz:SetOrigin(self:LocalToWorld(self:GetCMuzzle()))
				vjeffectmuz:SetEntity(self)
				vjeffectmuz:SetStart(self:LocalToWorld(self:GetCMuzzle()))
				vjeffectmuz:SetNormal(owner:GetAimVector())
				vjeffectmuz:SetAttachment(muzzleattach)
				util.Effect("VJ_Weapon_RifleMuzzle1",vjeffectmuz)
			else
				if self.PrimaryEffects_MuzzleParticlesAsOne == true then
					for _,v in pairs(self.PrimaryEffects_MuzzleParticles) do
						if !istable(v) then
							ParticleEffectAttach(v,PATTACH_POINT_FOLLOW,self,muzzleattach)
						end
					end
				else
					ParticleEffectAttach(VJ_PICK(self.PrimaryEffects_MuzzleParticles),PATTACH_POINT_FOLLOW,self,muzzleattach)
				end
			end
		end
		
		if SERVER && self.PrimaryEffects_SpawnDynamicLight == true && GetConVarNumber("vj_wep_nomuszzleflash_dynamiclight") == 0 then
			local FireLight1 = ents.Create("light_dynamic")
			FireLight1:SetKeyValue("brightness", self.PrimaryEffects_DynamicLightBrightness)
			FireLight1:SetKeyValue("distance", self.PrimaryEffects_DynamicLightDistance)
			if owner:IsPlayer() then FireLight1:SetLocalPos(self:LocalToWorld(self:GetCMuzzle()) +self:GetForward()*40 + self:GetUp()*-10) else FireLight1:SetLocalPos(self:GetNWVector("VJ_CurBulletPos")) end
			FireLight1:SetLocalAngles(self:GetAngles())
			FireLight1:Fire("Color", self.PrimaryEffects_DynamicLightColor.r.." "..self.PrimaryEffects_DynamicLightColor.g.." "..self.PrimaryEffects_DynamicLightColor.b)
			//FireLight1:SetParent(self)
			FireLight1:Spawn()
			FireLight1:Activate()
			FireLight1:Fire("TurnOn","",0)
			FireLight1:Fire("Kill","",0.07)
			self:DeleteOnRemove(FireLight1)
		end
	end

	if self.PrimaryEffects_SpawnShells == true && !owner:IsPlayer() && GetConVarNumber("vj_wep_nobulletshells") == 0 then
		local shellattach = self.PrimaryEffects_ShellAttachment
		if isnumber(shellattach) == false then shellattach = self:LookupAttachment(shellattach) end
		local vjeffect = EffectData()
		vjeffect:SetEntity(self)
		vjeffect:SetOrigin(self:LocalToWorld(self:GetCMuzzle()))
		vjeffect:SetNormal(owner:GetAimVector())
		vjeffect:SetAttachment(shellattach)
		util.Effect(self.PrimaryEffects_ShellType,vjeffect)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:PrimaryAttack(UseAlt)
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
			
			-- Callback
			bullet.Callback = function(attacker, tr, dmginfo)
				self:CustomOnPrimaryAttack_BulletCallback(attacker,tr,dmginfo)
				/*local laserhit = EffectData()
				laserhit:SetOrigin(tr.HitPos)
				laserhit:SetNormal(tr.HitNormal)
				laserhit:SetScale(25)
				util.Effect("AR2Impact", laserhit)
				tr.HitPos:Ignite(8,0)*/
			end
			
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
function SWEP:CustomOnRemove()
	if self:GetOwner():IsPlayer() then
		SafeRemoveEntity(self:GetCModel())
	end
end