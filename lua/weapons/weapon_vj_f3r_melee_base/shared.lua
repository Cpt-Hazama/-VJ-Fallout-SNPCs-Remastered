if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.PrintName = "None"

SWEP.WorldModel 				= "models/error.mdl"
SWEP.ID 						= 00000000
SWEP.AnimationType 				= "1hm"

SWEP.NPC_NextPrimaryFire 		= 1
SWEP.NPC_BeforeFireSound 		= {}

SWEP.Primary.Damage = 1
SWEP.Primary.HeavyDamage = 2
SWEP.Primary.Sound = {}
SWEP.HeavyAttackChance = 4
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Author = "Cpt. Hazama"
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.Instructions = ""
SWEP.Base = "weapon_vj_base"
SWEP.HoldType = SWEP.AnimationType
SWEP.MadeForNPCsOnly = true
SWEP.NPC_TimeUntilFire = 0
SWEP.IsMeleeWeapon = true
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnInitialize()
	if CLIENT then return end
	self.HasEffects = false

	if self.OnOnit then self:OnOnit() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnThink()
	if CLIENT then return end
	local noDraw = self:GetNoDraw()
	if noDraw then
		if self.HasEffects then
			self:StopParticles()
			self.HasEffects = false
		end
	else
		if !self.HasEffects then
			if self.StartParticles then self:StartParticles() end
			self.HasEffects = true
		end
	end

	if self.OnThink then self:OnThink(noDraw) end
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
	
	if self.Reloading == true then return end
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
			sound.Play(fireSd, owner:GetPos(), 80, math.random(90, 100), 1)
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
		if math.random(1,self.HeavyAttackChance) == 1 then
			local anim = owner:TranslateToWeaponAnim(ACT_RANGE_ATTACK2)
			owner:VJ_ACT_PLAYACTIVITY(anim, true, false, true)
		else
			local anim = owner:TranslateToWeaponAnim(VJ_PICK(owner.AnimTbl_WeaponAttackFiringGesture))
			owner:VJ_ACT_PLAYACTIVITY(anim, true, false, false, 0, {AlwaysUseGesture=true})
		end
	end
	
	-- MELEE WEAPON
	if self.IsMeleeWeapon == true then
		-- local meleeHitEnt = false
		-- for _,v in pairs(ents.FindInSphere(owner:GetPos(), self.MeleeWeaponDistance)) do
		-- 	if (owner.VJ_IsBeingControlled == true && owner.VJ_TheControllerBullseye == v) or (v:IsPlayer() && v.IsControlingNPC == true) then continue end
		-- 	if (isPly && v:EntIndex() != owner:EntIndex()) or (isNPC && (v:IsNPC() or (v:IsPlayer() && v:Alive() && GetConVar("ai_ignoreplayers"):GetInt() == 0)) && (owner:Disposition(v) != D_LI) && (v != owner) && (v:GetClass() != owner:GetClass()) or (v:GetClass() == "prop_physics") or v:GetClass() == "func_breakable_surf" or v:GetClass() == "func_breakable" && (owner:GetForward():Dot((v:GetPos() -owner:GetPos()):GetNormalized()) > math.cos(math.rad(owner.MeleeAttackDamageAngleRadius)))) then
		-- 		local dmginfo = DamageInfo()
		-- 		dmginfo:SetDamage(isNPC and owner:VJ_GetDifficultyValue(self.Primary.Damage) or self.Primary.Damage)
		-- 		if v:IsNPC() or v:IsPlayer() then dmginfo:SetDamageForce(owner:GetForward() * ((dmginfo:GetDamage() + 100) * 70)) end
		-- 		dmginfo:SetInflictor(owner)
		-- 		dmginfo:SetAttacker(owner)
		-- 		dmginfo:SetDamageType(DMG_CLUB)
		-- 		v:TakeDamageInfo(dmginfo, owner)
		-- 		if v:IsPlayer() then
		-- 			v:ViewPunch(Angle(math.random(-1, 1)*10, math.random(-1, 1)*10, math.random(-1, 1)*10))
		-- 		end
		-- 		VJ_DestroyCombineTurret(owner, v)
		-- 		self:CustomOnPrimaryAttack_MeleeHit(v)
		-- 		meleeHitEnt = true
		-- 	end
		-- end
		-- if meleeHitEnt == true then
		-- 	local meleeSd = VJ_PICK(self.MeleeWeaponSound_Hit)
		-- 	if meleeSd != false then
		-- 		self:EmitSound(meleeSd, 70, math.random(90, 100))
		-- 	end
		-- else
		-- 	if owner.IsVJBaseSNPC == true then owner:CustomOnMeleeAttack_Miss() end
		-- 	local meleeSd = VJ_PICK(self.MeleeWeaponSound_Miss)
		-- 	if meleeSd != false then
		-- 		self:EmitSound(meleeSd, 70, math.random(90, 100))
		-- 	end
		-- end
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
		self:SendWeaponAnim(VJ_PICK(self.AnimTbl_PrimaryFire))
		owner:SetAnimation(PLAYER_ATTACK1)
		owner:ViewPunch(Angle(-self.Primary.Recoil, 0, 0))
		self:TakePrimaryAmmo(self.Primary.TakeAmmo)
	end
	self:CustomOnPrimaryAttack_AfterShoot()
	//self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	timer.Simple(self.NextIdle_PrimaryAttack, function() if IsValid(self) then self:DoIdleAnimation() end end)
end