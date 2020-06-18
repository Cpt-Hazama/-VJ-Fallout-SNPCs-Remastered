AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.VJ_NPC_Class = {"CLASS_RAIDER"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomRangeAttackCode()
	local start = self:GetAttachment(1).Pos
	local bullet = {}
	bullet.Num = 1
	bullet.Src = start
	bullet.Dir = (self:GetEnemy():GetPos() +self:GetEnemy():OBBCenter()) -start +VectorRand() *20
	bullet.Spread = 4
	bullet.Tracer = 1
	bullet.TracerName = "vj_fo3_laser"
	bullet.Force = 7
	bullet.Damage = self.LaserDamage
	bullet.AmmoType = "SMG1"
	bullet.Callback = function(attacker,tr,dmginfo)
		local vjeffectmuz = EffectData()
		vjeffectmuz:SetOrigin(tr.HitPos)
		util.Effect("vj_fo3_laserhit",vjeffectmuz)
		dmginfo:SetDamageType(bit.bor(DMG_BULLET,DMG_BURN,DMG_DISSOLVE))
	end
	self:FireBullets(bullet)
	
	local vjeffectmuz = EffectData()
	vjeffectmuz:SetOrigin(start)
	vjeffectmuz:SetEntity(self)
	vjeffectmuz:SetStart(start)
	vjeffectmuz:SetNormal(bullet.Dir)
	vjeffectmuz:SetAttachment(1)
	util.Effect("vj_fo3_muzzle_gatlinglaser",vjeffectmuz)
	
	local FireLight1 = ents.Create("light_dynamic")
	FireLight1:SetKeyValue("brightness", "4")
	FireLight1:SetKeyValue("distance", "120")
	FireLight1:SetPos(start)
	FireLight1:SetLocalAngles(self:GetAngles())
	FireLight1:Fire("Color", "255 0 0")
	FireLight1:SetParent(self)
	FireLight1:Spawn()
	FireLight1:Activate()
	FireLight1:Fire("TurnOn","",0)
	FireLight1:Fire("Kill","",0.07)
	self:DeleteOnRemove(FireLight1)
	
	VJ_EmitSound(self,"vj_fallout/weapons/laserpistol/pistollaser_fire_2d.wav",85)
	VJ_EmitSound(self,"vj_fallout/weapons/laserpistol/pistollaser_fire_3d.wav",110)
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/