AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/fallout/supermutant_marcus.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.VJ_NPC_Class = {"CLASS_FEV_MUTANT_FRIENDLY"}
ENT.StartHealth = 650

ENT.HasHealthRegeneration = true
ENT.HealthRegenerationAmount = 1
ENT.HealthRegenerationDelay = VJ_Set(0.35,0.35)

ENT.PlayerFriendly = true
ENT.HasOnPlayerSight = true
ENT.FriendsWithAllPlayerAllies = true
ENT.PlayerFriendly = true
ENT.FollowPlayer = true
ENT.BecomeEnemyToPlayer = true
ENT.BecomeEnemyToPlayerLevel = 5