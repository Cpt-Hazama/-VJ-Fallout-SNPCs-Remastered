if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.WorldModel					= "models/fallout/weapons/w_teslacannonproto.mdl"
SWEP.PrintName					= "Tesla Cannon"
SWEP.AnimationType 						= "2hl"
SWEP.PHoldType 							= "rpg"
SWEP.Slot 								= (SWEP.AnimationType == "1gt" && 4 or SWEP.AnimationType == "1hm" && 0 or SWEP.AnimationType == "2hm" && 0 or SWEP.AnimationType == "2ha" && 2 or SWEP.AnimationType == "2hh" && 3 or SWEP.AnimationType == "2hl" && 4 or SWEP.AnimationType == "2hr" && 2 or SWEP.AnimationType == "1hp" && 1 or SWEP.AnimationType == "1md" && 4) or 1
SWEP.NPC_NextPrimaryFire 		= 3 -- Next time it can use primary fire
SWEP.NPC_CustomSpread	 		= 0
SWEP.NPC_TimeUntilFire	 		= 0 -- How much time until the bullet/projectile is fired?
SWEP.NPC_TimeUntilFireExtraTimers = {} -- Extra timers, which will make the gun fire again! | The seconds are counted after the self.NPC_TimeUntilFire!
SWEP.Primary.Damage				= 200 -- Damage
SWEP.Primary.ClipSize			= 1 -- Max amount of bullets per clip
SWEP.Primary.Delay						= 3
SWEP.Primary.Automatic					= false

SWEP.AnimTbl_Deploy 					= {"2hlequip"}
SWEP.AnimTbl_Idle 						= {"2hlaim"}
SWEP.AnimTbl_PrimaryFire 				= {"2hlattack3"}
SWEP.AnimTbl_Reload 					= {"2hlreloadb"}

SWEP.NPC_EquipSound 			= "vj_fallout/weapons/assaultrifle/rifleassault_equip.wav"
SWEP.NPC_UnequipSound 			= "vj_fallout/weapons/assaultrifle/rifleassault_unequip.wav"
SWEP.NPC_ReloadSound			= {"vj_fallout/weapons/teslacannon/teslacannon_jam.wav"}
SWEP.Primary.Sound				= {"vj_fallout/weapons/teslacannon/teslacannon_fire_2d01.wav","vj_fallout/weapons/teslacannon/teslacannon_fire_2d02.wav"}
SWEP.Primary.DistantSound		= {"vj_fallout/weapons/teslacannon/teslacannon_fire_3d01.wav","vj_fallout/weapons/teslacannon/teslacannon_fire_3d02.wav"}
SWEP.PrimaryEffects_MuzzleAttachment = "muzzle"
SWEP.Primary.TracerType			= "vj_fo3_tesla"
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.PrimaryEffects_MuzzleFlash 	= false

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
function SWEP:CustomBulletSpawnPosition()
	local owner = self:GetOwner()
	local att = self:LookupAttachment("muzzle")
	if att != 0 then
		local data = self:GetAttachment(att)
		if data then return data.Pos end
	end
	return owner:GetShootPos() +owner:GetAimVector() *20
end