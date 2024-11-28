AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/player/ncrtrooper.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 1

ENT.PlayerFriendly = true
ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY","CLASS_NCR"} -- NPCs with the same class with be allied to each other

ENT.SpawnWithApparelChance = 0
ENT.SpawnWithHairChance = 0
ENT.SpawnWithBeardChance = 0

local defHair_Male = {
	"models/fallout/player/hair/hairbuzzcut.mdl",
	"models/fallout/player/hair/haircombover.mdl",
	"models/fallout/player/hair/haircurly.mdl",
	"models/fallout/player/hair/hairda.mdl",
	"models/fallout/player/hair/hairmessy01.mdl",
	"models/fallout/player/hair/hairmessy02.mdl",
	"models/fallout/player/hair/hairmessy03.mdl",
	"models/fallout/player/hair/hairbalding.mdl",
	"models/fallout/player/hair/hairspikey.mdl",
	"models/fallout/player/hair/hairwastelandm.mdl",
	"models/fallout/player/hair/hairwavy.mdl"
}

local defHair_Female = {
	"models/fallout/player/hair/hairbun.mdl",
	"models/fallout/player/hair/haircurly.mdl",
	"models/fallout/player/hair/hairf01.mdl",
	"models/fallout/player/hair/hairf01b.mdl",
	"models/fallout/player/hair/hairf01c.mdl",
	"models/fallout/player/hair/hairf02.mdl",
	"models/fallout/player/hair/slippedtail01.mdl",
	"models/fallout/player/hair/slippedtail02.mdl",
	"models/fallout/player/hair/waves.mdl",
	"models/fallout/player/hair/coolhair/cool42.mdl",
	"models/fallout/player/hair/coolhair/cool45.mdl",
	"models/fallout/player/hair/coolhair/cool51.mdl",
	"models/fallout/player/hair/coolhair/cool56.mdl",
	"models/fallout/player/hair/coolhair/cool60.mdl",
	"models/fallout/player/hair/coolhair/cool65.mdl",
	"models/fallout/player/hair/coolhair/cool73.mdl",
	"models/fallout/player/hair/coolhair/cool77.mdl",
	"models/fallout/player/hair/coolhair/cool82.mdl",
	"models/fallout/player/hair/coolhair/cool84.mdl",
	"models/fallout/player/hair/coolhair/cool85.mdl",
	"models/fallout/player/hair/coolhair/cool93.mdl"
}

local defApparel_Male = {
	"models/fallout/headgear/bandana.mdl",
	"models/fallout/glasses/glassesreading.mdl",
	"models/fallout/headgear/cowboyhat.mdl",
	"models/fallout/headgear/cowboyhat2.mdl",
	"models/fallout/headgear/cowboyhat3.mdl",
	"models/fallout/headgear/cowboyhat4.mdl",
	"models/fallout/headgear/cowboyhat5.mdl",
}

local defApparel_Female = {
	"models/fallout/headgear/bandana.mdl",
	"models/fallout/glasses/glassesreading.mdl",
}

ENT.HairColors = {
	["m"] = {
		Color(196,197,135),
		Color(61,30,0),
		Color(0,0,0),
		Color(48,47,47),
		Color(143,143,143),
	},
	["f"] = {
		Color(196,197,135),
		Color(61,30,0),
		Color(0,0,0),
		Color(48,47,47),
		Color(143,143,143),
		Color(83,0,0),
		Color(17,12,41),
	},
}

ENT.Data = {
	["m"] = {
		{mdl="models/fallout/player/ncrtrooper.mdl",
			hp=60,
			b_scale=0.9,
			o_scale=0.92,
			hair=true,
			hairchance=false,
			beards=true,
			beardchance=false,
			apparel=defApparel_Male,
			apparelchance=false
		},
		{mdl="models/fallout/player/patrolranger.mdl",
			hp=65,
			b_scale=0.8,
			o_scale=0.835,
			hair=true,
			hairchance=false,
			beards=true,
			beardchance=false,
			apparel=defApparel_Male,
			apparelchance=false
		},
		{mdl="models/fallout/player/combatranger.mdl",
			hp=60,
			b_scale=0.825,
			o_scale=0.9,
			NoHair=true,
			hair=true,
			hairchance=false,
			beards=true,
			beardchance=false,
			apparel={"models/fallout/apparel/combatrangerhelmet.mdl"},
			apparelchance=2
		}
	},
	["f"] = {
		{mdl="models/fallout/player/female/ncrtrooper.mdl",
			hp=60,
			b_scale=0.9,
			o_scale=0.92,
			hair=true,
			hairchance=false,
			apparel=defApparel_Female,
			apparelchance=false
		},
		{mdl="models/fallout/player/female/patrolranger.mdl",
			hp=65,
			b_scale=0.8,
			o_scale=0.835,
			hair=true,
			hairchance=false,
			apparel={"models/fallout/headgear/bandana.mdl","models/fallout/headgear/combatarmorhelmet.mdl"},
			apparelchance=2
		},
		{mdl="models/fallout/player/female/combatranger.mdl",
			hp=60,
			b_scale=0.825,
			o_scale=0.9,
			NoHair=true,
			hair=true,
			hairchance=false,
			apparel={"models/fallout/apparel/combatrangerhelmet.mdl"},
			apparelchance=2
		},
	}
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:BeforeApparelSpawned()
	self.HairColor = self.Gender == 1 && VJ.PICK(self.HairColors["m"]) or VJ.PICK(self.HairColors["f"])
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomInit()
	self.Gender = math.random(1,2)
	self.SpawnData = self.Gender == 1 && VJ.PICK(self.Data["m"]) or VJ.PICK(self.Data["f"])

	local hp = math.random(self.SpawnData.hp -10,self.SpawnData.hp +10)
	self:SetHealth(hp)
	self:SetMaxHealth(hp)

	self:SetModel(VJ.PICK(self.SpawnData.mdl))
	self:SetCollisionBounds(Vector(18,18,82),Vector(-18,-18,0))

	if self.SpawnData.apparel then
		self.SpawnWithApparelChance = self.SpawnData.apparelchance or 8
		if self.SpawnData.apparel == true then
			self.tbl_ApparelModels = {
				"models/fallout/headgear/bandana.mdl",
				"models/fallout/glasses/glassesreading.mdl",
				"models/fallout/headgear/cowboyhat.mdl",
				"models/fallout/headgear/cowboyhat2.mdl",
				"models/fallout/headgear/cowboyhat3.mdl",
				"models/fallout/headgear/cowboyhat4.mdl",
				"models/fallout/headgear/cowboyhat5.mdl",
			}
		else
			self.tbl_ApparelModels = self.SpawnData.apparel
			if self.SpawnData.NoHair then
				self.CantHaveHairWithApparel = true
			end
		end
	end
	if self.SpawnData.hair then
		self.SpawnWithHairChance = self.SpawnData.hairchance or 1
		if self.SpawnData.hair == true then
			self.tbl_HairModels = self.Gender == 1 && defHair_Male or defHair_Female
		else
			self.tbl_HairModels = self.SpawnData.hair
		end
	end
	if self.SpawnData.beards then
		self.SpawnWithBeardChance = self.SpawnData.beardchance or (self.Gender == 2 && 0 or 5)
		if self.SpawnData.beards == true then
			self.tbl_BeardModels = {
				"models/fallout/player/beards/beardchincurtain.mdl",
				"models/fallout/player/beards/beardchinwide.mdl",
				"models/fallout/player/beards/beardcircle.mdl",
				"models/fallout/player/beards/beardmustache.mdl",
				"models/fallout/player/beards/beardside.mdl",
				"models/fallout/player/beards/beardthin.mdl",
			}
		else
			self.tbl_BeardModels = self.SpawnData.beards
		end
	end

	if self:GetModel() == "models/fallout/player/wastelandclothing.mdl" then
		self:SetBodygroup(0,math.random(0,5))
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:AfterInit()
	self:SetVoice(self.Gender == 1 && "male05" or "female03")
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