AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/fallout/supermutant_nightkin.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.VJ_NPC_Class = {"CLASS_FEV_MUTANT_EAST_FRIENDLY"} -- NPCs with the same class with be allied to each other
ENT.StartHealth = 250

ENT.PlayerFriendly = true
ENT.HasOnPlayerSight = true
ENT.FriendsWithAllPlayerAllies = true
ENT.PlayerFriendly = true
ENT.FollowPlayer = true
ENT.BecomeEnemyToPlayer = true
ENT.BecomeEnemyToPlayerLevel = 5
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomInventory()
	self:AddToInventory(ITEM_VJ_STIMPACK,nil,math.random(3,6))
end