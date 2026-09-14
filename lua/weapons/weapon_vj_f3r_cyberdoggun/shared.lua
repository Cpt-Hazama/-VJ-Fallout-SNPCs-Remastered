if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel					= "models/fallout/weapons/w_cyberdoggun.mdl"
SWEP.PrintName					= "Cyber-Dog Gun"
SWEP.ViewModelB							= "models/fallout/weapons/c_cyberdoggun.mdl"
SWEP.AnimationType 						= "2hh"
SWEP.PHoldType 							= "crossbow"
SWEP.Slot 								= (SWEP.AnimationType == "1gt" && 4 or SWEP.AnimationType == "1hm" && 0 or SWEP.AnimationType == "2hm" && 0 or SWEP.AnimationType == "2ha" && 2 or SWEP.AnimationType == "2hh" && 3 or SWEP.AnimationType == "2hl" && 4 or SWEP.AnimationType == "2hr" && 2 or SWEP.AnimationType == "1hp" && 1 or SWEP.AnimationType == "1md" && 4) or 1
SWEP.Weights = {
	WalkSpeed = 0.75,
	RunSpeed = 0.75,
	CrouchSpeed = 0.75,
	ClimbSpeed = 0.75,
	JumpPower = 0.75,
}

SWEP.NPC_NextPrimaryFire 		= false -- Next time it can use primary fire
SWEP.NPC_CustomSpread	 		= 0.5
SWEP.NPC_TimeUntilFire	 		= 0 -- How much time until the bullet/projectile is fired?
SWEP.NPC_TimeUntilFireExtraTimers = {0.08} -- Extra timers, which will make the gun fire again! | The seconds are counted after the self.NPC_TimeUntilFire!
SWEP.Primary.Damage				= 6 -- Damage
SWEP.Primary.ClipSize			= 50 -- Max amount of bullets per clip
SWEP.Primary.Delay						= 0.08
SWEP.Primary.Automatic					= true

SWEP.AnimTbl_Deploy 					= {ACT_VM_DEPLOY_4}
SWEP.AnimTbl_Idle 						= {ACT_VM_IDLE_5}
SWEP.AnimTbl_PrimaryFire 				= {ACT_SLAM_DETONATOR_DRAW}
SWEP.AnimTbl_Reload 					= {ACT_SLAM_DETONATOR_DETONATE}

SWEP.NPC_EquipSound 			= "vj_fallout/weapons/cyberdoggun/k9000equip01.mp3"
SWEP.NPC_UnequipSound 			= "vj_fallout/weapons/cyberdoggun/k9000unequip02.mp3"
SWEP.NPC_ReloadSound 			= {"vj_fallout/weapons/cyberdoggun/k9000combatstart03.mp3"}
SWEP.Primary.Sound				= {}
SWEP.PrimaryEffects_MuzzleAttachment = "muzzle"
SWEP.PrimaryEffects_MuzzleParticles = {"muzzleflash_5"}
---------------------------------------------------------------------------------------------------------------------------------------------

SWEP.WorldModel_CustomPositionAngle 	= Vector(80,5,270)
SWEP.WorldModel_CustomPositionOrigin 	= Vector(-3.6,0,-1.2)
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base 						= "weapon_vj_f3r_base"
SWEP.Author 					= "Cpt. Hazama"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players and NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "VJ Base - Fallout: Remastered"
SWEP.Spawnable 					= true
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnReload()
	self:PlayWeaponSoundTimed(self.NPC_ReloadSound,0)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnInit()
	self.CurrentFireSound = CreateSound(self,"vj_fallout/weapons/cyberdoggun/cyberdog_lp.wav")
	self.CurrentFireSound:SetSoundLevel(95)
	self.StartSound = CreateSound(self,"vj_fallout/weapons/minigun/wpn_minigun_spinup.wav")
	self.StartSound:SetSoundLevel(80)
	self.StopingSound = CreateSound(self,"vj_fallout/weapons/minigun/wpn_minigun_spindown.wav")
	self.StopingSound:SetSoundLevel(80)
	self.HasSpunUp = false
	self.ChangingSpin = false
	self.SpinToken = 0
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:SpinUp()
	if !self.ChangingSpin && !self.StopingSound:IsPlaying() then
		self.ChangingSpin = true
		self.SpinToken = (self.SpinToken or 0) +1
		local token = self.SpinToken
		self.StartSound:Play()
		timer.Simple(SoundDuration("vj_fallout/weapons/minigun/wpn_minigun_spinup.wav"),function()
			if IsValid(self) && self.SpinToken == token && self.ChangingSpin then
				self.HasSpunUp = true
				self.ChangingSpin = false
				self.StartSound:Stop()

			end
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnPrimaryAttack_BeforeShoot()
	if self:GetOwner():IsPlayer() && self.HasSpunUp == false then
		return true
	end

end
---------------------------------------------------------------------------------------------------------------------------------------------
if SERVER then
	function SWEP:WeaponThink()
		local owner = self:GetOwner()
		if owner:IsNPC() then
			self.NPC_NextPrimaryFire = self.HasSpunUp && 0.16 or false
			local enemy = owner:GetEnemy()
			if IsValid(enemy) then
				local canFire = owner.WeaponAttackState && owner.WeaponAttackState >= 10
				if canFire then
					if !self.HasSpunUp then self:SpinUp() return end
					self:PlayFireLoop()
				else
					self:StopFireLoop()
				end
			else
				self:StopFireLoop()
			end
			return
		end

		if owner:IsPlayer() && owner:KeyDown(IN_ATTACK) && self:Clip1() > 0 && !self.Reloading then
			if !self.HasSpunUp then self:SpinUp() return end
			self:PlayFireLoop()
		else
			self:StopFireLoop()
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:PlayFireLoop()
	if !self.CurrentFireSound:IsPlaying() then
		self.CurrentFireSound:Play()
		if self.StopingSound != nil && self.StopingSound:IsPlaying() then self.StopingSound:Stop() end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:StopFireLoop()
	if self.ChangingSpin then
		self.SpinToken = (self.SpinToken or 0) +1
		self.ChangingSpin = false
		self.HasSpunUp = false
		if self.StartSound then self.StartSound:Stop() end
	end
	if self.CurrentFireSound != nil && self.CurrentFireSound:IsPlaying() then
		self.CurrentFireSound:Stop()
		self.StopingSound:Play()
		self.HasSpunUp = false

		timer.Simple(SoundDuration("vj_fallout/weapons/minigun/wpn_minigun_spindown.wav"),function()
			if IsValid(self) then
				self.HasSpunUp = false
				self.ChangingSpin = false
				self.StopingSound:Stop()
			end
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:WeaponHolstered(newWep)
	self:StopFireLoop()
	if self.StartSound then self.StartSound:Stop() end
	self.HasSpunUp = false
	self.ChangingSpin = false
	self.SpinToken = (self.SpinToken or 0) +1

	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnRemove()
	self:StopFireLoop()
	if self.StartSound then self.StartSound:Stop() end

end
