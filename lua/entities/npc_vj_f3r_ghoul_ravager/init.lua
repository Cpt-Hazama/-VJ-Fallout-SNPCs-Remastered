AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/fallout/ghoulferal_ravager.mdl"}
ENT.StartHealth = 950

ENT.HasGrenadeAttack = true
ENT.CanUseRadAttack = true
ENT.RadiationAttackDistance = 200
ENT.RadStrength = 0.8
ENT.RadDamage = 18
ENT.NextRadAttackT = CurTime() +5
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/