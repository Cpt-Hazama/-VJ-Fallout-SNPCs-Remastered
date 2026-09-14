if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel                         = "models/fallout/weapons/w_flamer.mdl"
SWEP.PrintName                          = "Flamer"
SWEP.ViewModelB                         = "models/fallout/weapons/c_flamer.mdl"
SWEP.AnimationType                      = "2hh"
SWEP.PHoldType                          = "crossbow"
SWEP.Slot                               = (SWEP.AnimationType == "1gt" && 4 or SWEP.AnimationType == "1hm" && 0 or SWEP.AnimationType == "2hm" && 0 or SWEP.AnimationType == "2ha" && 2 or SWEP.AnimationType == "2hh" && 3 or SWEP.AnimationType == "2hl" && 4 or SWEP.AnimationType == "2hr" && 2 or SWEP.AnimationType == "1hp" && 1 or SWEP.AnimationType == "1md" && 4) or 1
SWEP.Weights = {
    WalkSpeed = 0.75,
    RunSpeed = 0.75,
    CrouchSpeed = 0.75,
    ClimbSpeed = 0.75,
    JumpPower = 0.75,
}

SWEP.NPC_NextPrimaryFire                = 0.1
SWEP.NPC_TimeUntilFire                  = 0
SWEP.Primary.Damage                     = 6
SWEP.Primary.ClipSize                   = 60
SWEP.Primary.Delay                      = 0.1
SWEP.Primary.Automatic                  = true

SWEP.AnimTbl_Deploy                     = {ACT_VM_DEPLOY_4}
SWEP.AnimTbl_Idle                       = {ACT_VM_IDLE_5}
SWEP.AnimTbl_PrimaryFire                = {ACT_SLAM_DETONATOR_DRAW}
SWEP.AnimTbl_Reload                     = {"2hhreloadb"}

SWEP.NPC_EquipSound                     = "vj_fallout/weapons/minigun/minigun_equip.wav"
SWEP.NPC_UnequipSound                   = "vj_fallout/weapons/minigun/minigun_unequip.wav"
SWEP.NPC_ReloadSound                    = {"vj_fallout/weapons/flamer/flamer_reload.wav"}
SWEP.Primary.Sound                      = {}
SWEP.PrimaryEffects_MuzzleAttachment    = "muzzle"
SWEP.PrimaryEffects_MuzzleFlash         = false
SWEP.Primary.DisableBulletCode          = true
SWEP.NPC_FiringDistanceMax              = 375

SWEP.WorldModel_CustomPositionAngle     = Vector(80,5,270)
SWEP.WorldModel_CustomPositionOrigin    = Vector(-3.6,0,-1.2)
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base                               = "weapon_vj_f3r_base"
SWEP.Author                             = "Cpt. Hazama"
SWEP.Contact                            = "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose                            = "This weapon is made for Players and NPCs"
SWEP.Instructions                       = "Controls are like a regular weapon."
SWEP.Category                           = "VJ Base - Fallout: Remastered"
SWEP.Spawnable                          = true
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnReload()
    self:StopFireLoop()
    self:PlayWeaponSoundTimed(self.NPC_ReloadSound,0)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnInit()
    self.CurrentFireSound = CreateSound(self,"vj_fallout/weapons/flamer/flamer_fire_lp.wav")
    self.CurrentFireSound:SetSoundLevel(85)
    self.StopingSound = CreateSound(self,"vj_fallout/weapons/flamer/flamer_fire_end.wav")
    self.StopingSound:SetSoundLevel(80)
    self.FlamerIsFiring = false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:GetFlameOriginDirection(owner)
    if owner:IsPlayer() then
        return owner:GetShootPos(), owner:GetAimVector()
    end

    local attID = self:LookupAttachment("muzzle")
    local att = attID != 0 && self:GetAttachment(attID) or nil
    local pos = att && att.Pos or self:GetPos()
    local enemy = owner:GetEnemy()

    if IsValid(enemy) then
        return pos, (enemy:WorldSpaceCenter() -pos):GetNormalized()
    end

    return pos, self:GetForward()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnPrimaryAttack_BeforeShoot()
    if CLIENT then return end

    local owner = self:GetOwner()
    if !IsValid(owner) then return true end

    local pos, dir = self:GetFlameOriginDirection(owner)
    VJ.ApplyRadiusDamage(
        owner,
        self,
        pos,
        370,
        5,
        DMG_BURN,
        true,
        true,
        {
            UseConeDegree = 30,
            UseConeDirection = dir
        }
    )
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:StartWorldFlame()
    if CLIENT or IsValid(self.Flame) then return end

    local attID = self:LookupAttachment("muzzle")
    local att = attID != 0 && self:GetAttachment(attID) or nil
    if !att then return end

    local flame = ents.Create("info_particle_system")
    if !IsValid(flame) then return end

    flame:SetKeyValue("start_active","1")
    flame:SetKeyValue("effect_name","flamer")
    flame:SetPos(att.Pos)
    flame:SetAngles(att.Ang)
    flame:Spawn()
    flame:Activate()
    flame:SetParent(self)
    flame:Fire("SetParentAttachment","muzzle",0)
    self:DeleteOnRemove(flame)
    self.Flame = flame
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:StopWorldFlame()
    if CLIENT then return end
    SafeRemoveEntity(self.Flame)
    self.Flame = nil
end
---------------------------------------------------------------------------------------------------------------------------------------------
if CLIENT then
    function SWEP:StartViewFlame()
        if self.LocalFlame && self.LocalFlame.IsValid && self.LocalFlame:IsValid() then return end

        local owner = self:GetOwner()
        if !IsValid(owner) or !owner:IsPlayer() or owner != LocalPlayer() then return end

        local vm = IsValid(self.VJ_CModel) && self.VJ_CModel or owner:GetViewModel()
        if !IsValid(vm) then return end

        local attID = vm:LookupAttachment("muzzle")
        if !attID or attID <= 0 then return end

        local fx = CreateParticleSystem(vm,"flamer",PATTACH_POINT_FOLLOW,attID)
        if fx then
            self.LocalFlame = fx
            self:AddGarbage(fx)
        end
    end

    function SWEP:StopViewFlame()
        local fx = self.LocalFlame
        if fx && fx.IsValid && fx:IsValid() then
            fx:StopEmissionAndDestroyImmediately()
        end
        self.LocalFlame = nil
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:PlayFireLoop()
    if self.StopingSound && self.StopingSound:IsPlaying() then
        self.StopingSound:Stop()
    end

    if self.CurrentFireSound && !self.CurrentFireSound:IsPlaying() then
        self.CurrentFireSound:Play()
    end

    self.FlamerIsFiring = true

    if SERVER then
        self:StartWorldFlame()
    elseif CLIENT then
        self:StartViewFlame()
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:StopFireLoop(playEndSound)
    local wasFiring = self.FlamerIsFiring == true
    self.FlamerIsFiring = false

    if self.CurrentFireSound && self.CurrentFireSound:IsPlaying() then
        self.CurrentFireSound:Stop()
		self.CurrentFireSound = nil
		self.CurrentFireSound = CreateSound(self,"vj_fallout/weapons/flamer/flamer_fire_lp.wav")
		self.CurrentFireSound:SetSoundLevel(85)
    end

    if SERVER then
        self:StopWorldFlame()
    elseif CLIENT then
        self:StopViewFlame()
    end

    if SERVER && wasFiring && playEndSound != false && self.StopingSound then
        if self.StopingSound:IsPlaying() then self.StopingSound:Stop() end
        self.StopingSound:Play()
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:WeaponThink()
    local owner = self:GetOwner()
    if !IsValid(owner) then
        self:StopFireLoop(false)
        return
    end

    if CLIENT then
        if owner:IsPlayer() && owner == LocalPlayer() then
            local firing = owner:KeyDown(IN_ATTACK) && self:Clip1() > 0 && !self.Reloading
            if firing then
                self:StartViewFlame()
            else
                self:StopViewFlame()
            end
        end
        return
    end

    if owner:IsNPC() then
        self.NPC_NextPrimaryFire = 0.1
        local enemy = owner:GetEnemy()
        local firing = IsValid(enemy)
            && owner.WeaponAttackState
            && owner.WeaponAttackState >= 10
            && enemy:GetPos():Distance(owner:GetPos()) <= self.NPC_FiringDistanceMax

        if firing then
            self:PlayFireLoop()
        else
            self:StopFireLoop()
        end
        return
    end

    if owner:IsPlayer() then
        local firing = owner:KeyDown(IN_ATTACK) && self:Clip1() > 0 && !self.Reloading
        if firing then
            self:PlayFireLoop()
        else
            self:StopFireLoop()
        end
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:WeaponHolstered(newWep)
    self:StopFireLoop(false)
    if CLIENT then self:StopViewFlame() end
    return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnRemove()
    self:StopFireLoop(false)
    if self.StopingSound && self.StopingSound:IsPlaying() then self.StopingSound:Stop() end
    if CLIENT then self:StopViewFlame() end
end
