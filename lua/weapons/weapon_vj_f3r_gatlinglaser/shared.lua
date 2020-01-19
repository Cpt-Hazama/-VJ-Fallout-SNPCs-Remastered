if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel					= "models/fallout/weapons/w_gatlinglaser.mdl"
SWEP.PrintName					= "Gatling Laser"
SWEP.ID 						= ITEM_VJ_GATLINGLASER
SWEP.AnimationType 				= "2hh"
SWEP.NPC_NextPrimaryFire 		= 0.16 -- Next time it can use primary fire
SWEP.NPC_CustomSpread	 		= 0.5
SWEP.NPC_TimeUntilFire	 		= 0 -- How much time until the bullet/projectile is fired?
SWEP.NPC_TimeUntilFireExtraTimers = {0.08} -- Extra timers, which will make the gun fire again! | The seconds are counted after the self.NPC_TimeUntilFire!
SWEP.Primary.Damage				= 7 -- Damage
SWEP.Primary.ClipSize			= 240 -- Max amount of bullets per clip
SWEP.NPC_EquipSound 			= "vj_fallout/weapons/assaultrifle/rifleassault_equip.wav"
SWEP.NPC_UnequipSound 			= "vj_fallout/weapons/assaultrifle/rifleassault_unequip.wav"
SWEP.NPC_ReloadSound 			= {"vj_fallout/weapons/gatlinglaser/gatlinglaser_reload.wav"}
SWEP.Primary.Sound				= {"vj_fallout/weapons/gatlinglaser/fire.wav"}
SWEP.PrimaryEffects_MuzzleAttachment = "muzzle"
SWEP.Primary.TracerType			= "vj_fo3_laser"
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base 						= "weapon_vj_base"
SWEP.Author 					= "Cpt. Hazama"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players and NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "VJ Base - Fallout: Remastered"
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.MadeForNPCsOnly 			= true -- Is tihs weapon meant to be for NPCs only?
	-- World Model ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel_UseCustomPosition = false -- Should the gun use custom position? This can be used to fix guns that are in the crotch
SWEP.WorldModel_CustomPositionAngle = Vector(-10,0,180)
SWEP.WorldModel_CustomPositionOrigin = Vector(-1,11.3,1)
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Force				= 1 -- Force applied on the object the bullet hits
SWEP.Primary.Ammo				= "Pistol" -- Ammo type
SWEP.PrimaryEffects_SpawnShells = false
SWEP.HoldType 					= "normal"
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnPrimaryAttack_BulletCallback(attacker,tr,dmginfo)
	local vjeffectmuz = EffectData()
	vjeffectmuz:SetOrigin(tr.HitPos)
	-- vjeffectmuz:SetPos(tr.HitPos)
	util.Effect("vj_fo3_laserhit",vjeffectmuz)
	dmginfo:SetDamageType(DMG_DISSOLVE)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:PrimaryAttack(ShootPos,ShootDir)
	//if self.Owner:KeyDown(IN_RELOAD) then return end
	//self.Owner:SetFOV(45, 0.3)
	//if !IsFirstTimePredicted() then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	if self.Reloading == true then return end
	if self.Owner:IsNPC() && self.Owner.VJ_IsBeingControlled == false && !IsValid(self.Owner:GetEnemy()) then return end
	if self.Owner:IsPlayer() && self.Primary.AllowFireInWater == false && self.Owner:WaterLevel() == 3 && self.Reloading == false then self.Owner:EmitSound(VJ_PICKRANDOMTABLE(self.DryFireSound),self.DryFireSoundLevel,math.random(self.DryFireSoundPitch1,self.DryFireSoundPitch2)) return end
	if self:Clip1() <= 0 && self.Reloading == false then self.Owner:EmitSound(VJ_PICKRANDOMTABLE(self.DryFireSound),self.DryFireSoundLevel,math.random(self.DryFireSoundPitch1,self.DryFireSoundPitch2)) return end
	if (!self:CanPrimaryAttack()) then return end
	self:CustomOnPrimaryAttack_BeforeShoot()
	if (SERVER) then
		if self.Owner:IsNPC() then
			timer.Simple(self.NPC_ExtraFireSoundTime,function()
				if IsValid(self) && IsValid(self.Owner) then
					VJ_EmitSound(self.Owner,self.NPC_ExtraFireSound,self.NPC_ExtraFireSoundLevel,math.Rand(self.NPC_ExtraFireSoundPitch1,self.NPC_ExtraFireSoundPitch2))
				end
			end)
		end
		local firesd = VJ_PICKRANDOMTABLE(self.Primary.Sound)
		if firesd != false then
			-- self:EmitSound(firesd, 80, math.random(90,100))
			sound.Play(firesd,self:GetPos(),90,math.random(90,100))
		end
		if self.Primary.HasDistantSound == true then
			local farsd = VJ_PICKRANDOMTABLE(self.Primary.DistantSound)
			if farsd != false then
				sound.Play(farsd,self:GetPos(),self.Primary.DistantSoundLevel,math.random(self.Primary.DistantSoundPitch1,self.Primary.DistantSoundPitch2),self.Primary.DistantSoundVolume)
			end
		end
	end
	//self:EmitSound(Sound(self.Primary.Sound),80,self.Primary.SoundPitch)
	if self.Primary.DisableBulletCode == false then
		local bullet = {}
			bullet.Num = self.Primary.NumberOfShots
			local spawnpos = self.Owner:GetShootPos()
			if self.Owner:IsNPC() then
				spawnpos = self:GetNWVector("VJ_CurBulletPos")
			end
			//print(spawnpos)
			//VJ_CreateTestObject(spawnpos,self:GetAngles(),Color(0,0,255))
			bullet.Src = spawnpos
			bullet.Dir = self.Owner:GetAimVector()
			bullet.Callback = function(attacker,tr,dmginfo)
				self:CustomOnPrimaryAttack_BulletCallback(attacker,tr,dmginfo)
			end
				/*bullet.Callback = function(attacker, tr, dmginfo)
				local laserhit = EffectData()
				laserhit:SetOrigin(tr.HitPos)
				laserhit:SetNormal(tr.HitNormal)
				laserhit:SetScale(80)
				util.Effect("VJ_Small_Explosion1", laserhit)

				bullet.Callback = function(attacker, tr, dmginfo)
				local laserhit = EffectData()
				laserhit:SetOrigin(tr.HitPos)
				laserhit:SetNormal(tr.HitNormal)
				laserhit:SetScale(25)
				util.Effect("AR2Impact", laserhit)
				end*/
				//tr.HitPos:Ignite(8,0)
				//return true end
			if self.Owner:IsPlayer() then
				bullet.Spread = Vector((self.Primary.Cone /60)/4,(self.Primary.Cone /60)/4,0)
			end
			bullet.Tracer = self.Primary.Tracer
			bullet.TracerName = self.Primary.TracerType
			bullet.Force = self.Primary.Force
			if self.Owner:IsPlayer() then
				if self.Primary.PlayerDamage == "Same" then
					bullet.Damage = self.Primary.Damage
				elseif self.Primary.PlayerDamage == "Double" then
					bullet.Damage = self.Primary.Damage *2
				elseif isnumber(self.Primary.PlayerDamage) then
					bullet.Damage = self.Primary.PlayerDamage
				end
			else
				if self.Owner.IsVJBaseSNPC == true then
					bullet.Damage = self.Owner:VJ_GetDifficultyValue(self.Primary.Damage)
				else
					bullet.Damage = self.Primary.Damage
				end
			end
			bullet.AmmoType = self.Primary.Ammo
			self.Owner:FireBullets(bullet)
	else
		if self.Owner:IsNPC() && self.Owner.IsVJBaseSNPC == true then
			self.Owner.Weapon_ShotsSinceLastReload = self.Owner.Weapon_ShotsSinceLastReload + 1
		end
	end
	if GetConVarNumber("vj_wep_nomuszzleflash") == 0 then self.Owner:MuzzleFlash() end
	self:PrimaryAttackEffects()
	if self.Owner:IsPlayer() then
	self:ShootEffects("ToolTracer")
	self:SendWeaponAnim(VJ_PICKRANDOMTABLE(self.AnimTbl_PrimaryFire))
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.Owner:ViewPunch(Angle(-self.Primary.Recoil,0,0)) end
	if !self.Owner:IsNPC() then
		self:TakePrimaryAmmo(self.Primary.TakeAmmo)
	end
	self:CustomOnPrimaryAttack_AfterShoot()
	//self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	timer.Simple(self.NextIdle_PrimaryAttack,function() if self:IsValid() then self:DoIdleAnimation() end end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:PrimaryAttackEffects()
	local customeffects = self:CustomOnPrimaryAttackEffects()
	if customeffects != true then return end

	if self.PrimaryEffects_MuzzleFlash == true && GetConVarNumber("vj_wep_nomuszzleflash") == 0 then
		local muzzleattach = self.PrimaryEffects_MuzzleAttachment
		if isnumber(muzzleattach) == false then muzzleattach = self:LookupAttachment(muzzleattach) end
		local vjeffectmuz = EffectData()
		vjeffectmuz:SetOrigin(self.Owner:GetShootPos())
		vjeffectmuz:SetEntity(self)
		vjeffectmuz:SetStart(self.Owner:GetShootPos())
		vjeffectmuz:SetNormal(self.Owner:GetAimVector())
		vjeffectmuz:SetAttachment(muzzleattach)
		util.Effect("vj_fo3_muzzle_gatlinglaser",vjeffectmuz)
	end

	if SERVER && self.PrimaryEffects_SpawnDynamicLight == true && GetConVarNumber("vj_wep_nomuszzleflash") == 0 && GetConVarNumber("vj_wep_nomuszzleflash_dynamiclight") == 0 then
		local FireLight1 = ents.Create("light_dynamic")
		FireLight1:SetKeyValue("brightness", self.PrimaryEffects_DynamicLightBrightness)
		FireLight1:SetKeyValue("distance", self.PrimaryEffects_DynamicLightDistance)
		if self.Owner:IsPlayer() then FireLight1:SetLocalPos(self.Owner:GetShootPos() +self:GetForward()*40 + self:GetUp()*-10) else FireLight1:SetLocalPos(self:GetAttachment(1).Pos) end
		FireLight1:SetLocalAngles(self:GetAngles())
		FireLight1:Fire("Color", self.PrimaryEffects_DynamicLightColor.r.." "..self.PrimaryEffects_DynamicLightColor.g.." "..self.PrimaryEffects_DynamicLightColor.b)
		FireLight1:SetParent(self)
		FireLight1:Spawn()
		FireLight1:Activate()
		FireLight1:Fire("TurnOn","",0)
		FireLight1:Fire("Kill","",0.07)
		self:DeleteOnRemove(FireLight1)
	end
end