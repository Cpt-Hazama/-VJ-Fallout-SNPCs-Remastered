if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel					= "models/fallout/weapons/w_flamer.mdl"
SWEP.PrintName					= "Flamer"
-- SWEP.ID 						= ITEM_VJ_GATLINGLASER
SWEP.AnimationType 				= "2hh"
SWEP.NPC_NextPrimaryFire 		= false -- Next time it can use primary fire
SWEP.NPC_TimeUntilFire	 		= 0 -- How much time until the bullet/projectile is fired?
SWEP.Primary.Damage				= 6 -- Damage
SWEP.Primary.ClipSize			= 60 -- Max amount of bullets per clip
SWEP.NPC_EquipSound 			= "vj_fallout/weapons/minigun/minigun_equip.wav"
SWEP.NPC_UnequipSound 			= "vj_fallout/weapons/minigun/minigun_unequip.wav"
SWEP.NPC_ReloadSound 			= {"vj_fallout/weapons/flamer/flamer_reload.wav"}
SWEP.Primary.Sound				= {}
SWEP.PrimaryEffects_MuzzleAttachment = "muzzle"
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base 						= "weapon_vj_f3r_base"
SWEP.Author 					= "Cpt. Hazama"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players and NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "VJ Base - Fallout: Remastered"
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.MadeForNPCsOnly 			= true -- Is tihs weapon meant to be for NPCs only?
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Force				= 1 -- Force applied on the object the bullet hits
SWEP.Primary.Ammo				= "Pistol" -- Ammo type
SWEP.PrimaryEffects_MuzzleFlash = false
SWEP.PrimaryEffects_SpawnShells = false
SWEP.HoldType 					= "2hh"
SWEP.Primary.DisableBulletCode	= true
SWEP.NPC_FiringDistanceMax = 375
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnPrimaryAttack_BeforeShoot()
	if (CLIENT) then return end
	self:DoFlameDamage(370,5,self:GetOwner(),30)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnInitialize()
	self.CurrentFireSound = CreateSound(self,"vj_fallout/weapons/flamer/flamer_fire_lp.wav")
	self.CurrentFireSound:SetSoundLevel(85)
	self.StartSound = CreateSound(self,"vj_fallout/weapons/flamer/flamer_idle_end.wav")
	self.StartSound:SetSoundLevel(80)
	self.StopingSound = CreateSound(self,"vj_fallout/weapons/flamer/flamer_fire_end.wav")
	self.StopingSound:SetSoundLevel(80)
	self.HasSpunUp = false
	self.ChangingSpin = false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:SpinUp()
	if !self.ChangingSpin && !self.StopingSound:IsPlaying() then
		self.ChangingSpin = true
		self.StartSound:Play()
		timer.Simple(SoundDuration("vj_fallout/weapons/flamer/flamer_idle_end.wav"),function()
			if IsValid(self) then
				self.HasSpunUp = true
				self.ChangingSpin = false
				self.StartSound:Stop()

				local att = self:GetAttachment(self:LookupAttachment("muzzle"))
				local spawnparticle = ents.Create("info_particle_system")
				spawnparticle:SetKeyValue("start_active","1")
				spawnparticle:SetKeyValue("effect_name","flamer")
				spawnparticle:SetPos(att.Pos)
				spawnparticle:SetAngles(att.Ang)
				spawnparticle:Spawn()
				spawnparticle:Activate()
				spawnparticle:SetParent(self)
				spawnparticle:Fire("SetParentAttachment","muzzle")
				self:DeleteOnRemove(spawnparticle)
				self.Flame = spawnparticle
			end
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:WeapWeaponThink()
	self.NPC_NextPrimaryFire = self.HasSpunUp && 0.1 or false
	if IsValid(self.Owner:GetEnemy()) then
		if self.Owner.WeaponAttackState && self.Owner.WeaponAttackState >= 10 && self.Owner:GetEnemy():GetPos():Distance(self.Owner:GetPos()) <= self.NPC_FiringDistanceMax then
			if !self.HasSpunUp then
				self:SpinUp()
				return
			end
			self:PlayFireLoop()
		else
			self:StopFireLoop()
		end
	else
		self:StopFireLoop()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:PlayFireLoop()
	if !self.CurrentFireSound:IsPlaying() then
		self.CurrentFireSound:Play()
		if self.StopingSound != nil && self.StopingSound:IsPlaying() then
			self.StopingSound:Stop()
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:StopFireLoop()
	if self.CurrentFireSound != nil && self.CurrentFireSound:IsPlaying() then
		self.CurrentFireSound:Stop()
		self.StopingSound:Play()
		self.HasSpunUp = false
		SafeRemoveEntity(self.Flame)
		timer.Simple(SoundDuration("vj_fallout/weapons/flamer/flamer_fire_end.wav"),function()
			if IsValid(self) then
				self.HasSpunUp = false
				self.StopingSound:Stop()
			end
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnRemove()
	self:StopParticles()
	self.Deleted = true
	self:StopFireLoop()
	if self.StartSound then self.StartSound:Stop() end
end