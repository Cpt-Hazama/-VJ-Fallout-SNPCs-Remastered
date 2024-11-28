AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/player/centurion.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 1

ENT.PlayerFriendly = false
ENT.VJ_NPC_Class = {"CLASS_LEGION"} -- NPCs with the same class with be allied to each other

ENT.SpawnWithApparelChance = 1
ENT.SpawnWithHairChance = 1
ENT.SpawnWithBeardChance = 0

ENT.tbl_ApparelModels = {"models/fallout/apparel/centurionhelmet_go.mdl"}

ENT.tbl_HairModels = {
	"models/fallout/player/hair/haircombover.mdl",
	"models/fallout/player/hair/haircurly.mdl",
	"models/fallout/player/hair/hairmessy01.mdl",
	"models/fallout/player/hair/hairmessy02.mdl",
	"models/fallout/player/hair/hairmessy03.mdl",
	"models/fallout/player/hair/hairspikey.mdl",
	"models/fallout/player/hair/hairwavy.mdl"
}

ENT.Data = {
	["m"] = {
		{mdl="models/fallout/player/centurion.mdl",
			hp=150,
			b_scale=0.7,
			o_scale=0.75,
			hair=true,
			hairchance=false,
			beards=true,
			beardchance=false,
			apparel=defApparel_Male,
			apparelchance=false
		}
	}
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomInit()
	self.Gender = 1
	self.SpawnData = self.Gender == 1 && VJ.PICK(self.Data["m"]) or VJ.PICK(self.Data["f"])

	local hp = math.random(self.SpawnData.hp -10,self.SpawnData.hp +10)
	self:SetHealth(hp)
	self:SetMaxHealth(hp)

	self:SetModel(VJ.PICK(self.SpawnData.mdl))
	self:SetCollisionBounds(Vector(18,18,82),Vector(-18,-18,0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:AfterInit()
	self:SetVoice("male04")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup)
	if (dmginfo:IsBulletDamage()) then
		local bScale = self.SpawnData.b_scale
		dmginfo:ScaleDamage(bScale)
		if bScale <= 0.8 then VJ_EmitSound(self,"vj_impact_metal/bullet_metal/metalsolid"..math.random(1,10)..".wav",70) end
	elseif dmginfo:GetDamageType() != DMG_GENERIC then
		local oScale = self.SpawnData.o_scale
		dmginfo:ScaleDamage(oScale)
		if oScale <= 0.8 then VJ_EmitSound(self,"vj_impact_metal/bullet_metal/metalsolid"..math.random(1,10)..".wav",70) end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:AddApparel(ent,mdl,ishair,color)
	local attach = ent:GetAttachment(ent:LookupAttachment("headgear"))
	apparel = ents.Create("prop_dynamic")
	apparel:SetModel(mdl)
	apparel:SetPos(attach.Pos)
	apparel:SetAngles(attach.Ang)
	apparel:SetOwner(ent)
	apparel:SetParent(ent)
	apparel:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
	-- if !ishair then apparel:AddEffects(EF_BONEMERGE) end
	apparel:Fire("SetParentAttachment","headgear",0)
	apparel:Spawn()
	apparel:Activate()
	-- apparel:SetRenderMode(RENDERMODE_TRANSALPHA)
	ent:DeleteOnRemove(apparel)
	if color then
		apparel:SetColor(color)
	end
	apparel:SetSolid(SOLID_NONE)
	if ent == self then
		if !ishair then
			table.insert(self.tbl_CurrentApparel,apparel)
			table.insert(self.tbl_Apparel,apparel:GetModel())
		else
			table.insert(self.tbl_CurrentHair,apparel)
			table.insert(self.tbl_Hair,apparel:GetModel())
		end
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/