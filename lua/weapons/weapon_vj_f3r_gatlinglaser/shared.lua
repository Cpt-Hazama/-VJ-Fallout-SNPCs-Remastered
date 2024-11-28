if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.ViewModelB							= "models/fallout/weapons/c_gatlinglaser.mdl"
SWEP.WorldModel							= "models/fallout/weapons/w_gatlinglaser.mdl"
SWEP.PrintName							= "Gatling Laser"
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

SWEP.WorldModel_CustomPositionAngle 	= Vector(80,5,270)
SWEP.WorldModel_CustomPositionOrigin 	= Vector(-3.6,0,-1.2)

SWEP.NPC_NextPrimaryFire 				= false
SWEP.NPC_CustomSpread	 				= 0.5
SWEP.NPC_TimeUntilFire	 				= 0
SWEP.NPC_TimeUntilFireExtraTimers 		= {0.08}

SWEP.Primary.Damage						= 7
SWEP.Primary.ClipSize					= 240
SWEP.Primary.Delay						= 0.12
SWEP.Primary.Automatic = true

SWEP.AnimTbl_Deploy 					= {ACT_VM_DEPLOY_4}
SWEP.AnimTbl_Idle 						= {ACT_VM_IDLE_5}
SWEP.AnimTbl_PrimaryFire 				= {ACT_SLAM_DETONATOR_DRAW}
SWEP.AnimTbl_Reload 					= {ACT_SLAM_DETONATOR_DETONATE}

SWEP.NPC_EquipSound 			= "vj_fallout/weapons/minigun/minigun_equip.wav"
SWEP.NPC_UnequipSound 			= "vj_fallout/weapons/minigun/minigun_unequip.wav"
SWEP.NPC_ReloadSound			= {"vj_fallout/weapons/gatlinglaser/gatlinglaser_reload.wav"}

SWEP.Primary.TracerType 				= "vj_fo3_laser"
SWEP.PrimaryEffects_MuzzleParticles 	= nil
SWEP.PrimaryEffects_MuzzleFlash 	= false

SWEP.PrimaryEffects_MuzzleAttachment 	= "muzzle"
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
	self:PlayWeaponSoundTimed("vj_fallout/weapons/gatlinglaser/gatlinglaser_reload.wav",0)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnPrimaryAttack_BulletCallback(attacker,tr,dmginfo)
	local vjeffectmuz = EffectData()
	vjeffectmuz:SetOrigin(tr.HitPos)
	util.Effect("vj_fo3_laserhit",vjeffectmuz)
	dmginfo:SetDamageType(bit.bor(DMG_BULLET,DMG_BURN,DMG_DISSOLVE))
end
---------------------------------------------------------------------------------------------------------------------------------------------
-- if SERVER then
	function SWEP:OnInit()
		self.CurrentFireSound = CreateSound(self,"vj_fallout/weapons/gatlinglaser/gatlinglaser_fire_lp.wav")
		self.CurrentFireSound:SetSoundLevel(95)
		self.StartSound = CreateSound(self,"common/null")
		self.StartSound:SetSoundLevel(15)
		self.StopingSound = CreateSound(self,"vj_fallout/weapons/gatlinglaser/gatlinglaser_fire_end.wav")
		self.StopingSound:SetSoundLevel(80)
		self.HasSpunUp = false
		self.ChangingSpin = false
	end
-- end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:SpinUp()
	if !self.ChangingSpin && !self.StopingSound:IsPlaying() then
		self.ChangingSpin = true
		self.StartSound:Play()
		timer.Simple(SoundDuration("common/null.wav"),function()
			if IsValid(self) then
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
			if IsValid(self.Owner:GetEnemy()) then
				if self.Owner.DoingWeaponAttack then
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
			return
		end
		if owner:KeyDown(IN_ATTACK) && self:Clip1() > 0 && !self.Reloading then
			if !self.HasSpunUp then
				self:SpinUp()
				return
			end
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
		timer.Simple(SoundDuration("vj_fallout/weapons/gatlinglaser/gatlinglaser_fire_end.wav"),function()
			if IsValid(self) then
				self.HasSpunUp = false
				self.StopingSound:Stop()
			end
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnRemove()
	self:StopFireLoop()
	if self.StartSound then self.StartSound:Stop() end
end