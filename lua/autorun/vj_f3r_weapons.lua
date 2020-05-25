/*--------------------------------------------------
	=============== Autorun File ===============
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")
if VJExists == true then
	include('autorun/vj_controls.lua')
	
	VJ.AddNPCWeapon("VJ_F3R_AssaultRifle","weapon_vj_f3r_assaultrifle")
	VJ.AddNPCWeapon("VJ_F3R_CombatShotgun","weapon_vj_f3r_combatshotgun")
	VJ.AddNPCWeapon("VJ_F3R_GatlingLaser","weapon_vj_f3r_gatlinglaser")
	VJ.AddNPCWeapon("VJ_F3R_Fatman","weapon_vj_f3r_fatman")
	VJ.AddNPCWeapon("VJ_F3R_10mmPistol","weapon_vj_f3r_10mmpistol")
	VJ.AddNPCWeapon("VJ_F3R_HuntingRifle","weapon_vj_f3r_huntingrifle")
	VJ.AddNPCWeapon("VJ_F3R_PlasmaPistol","weapon_vj_f3r_plasmapistol")
	VJ.AddNPCWeapon("VJ_F3R_PlasmaRifle","weapon_vj_f3r_plasmarifle")
end