AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/ghoulferal_vaultarmor.mdl"}
ENT.StartHealth = 175

ENT.Skin = {[1]=2,[2]=2}
ENT.CanUseRadAttack = true
ENT.RadiationAttackDistance = 200
ENT.RadStrength = 0.8
ENT.RadDamage = 10
ENT.NextRadAttackT = CurTime() +5
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/