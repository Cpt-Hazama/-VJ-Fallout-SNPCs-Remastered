/*--------------------------------------------------
	=============== Autorun File ===============
	*** Copyright (c) 2012-2019 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
------------------ Addon Information ------------------
local PublicAddonName = "Fallout SNPCs Remastered"
local AddonName = "Fallout Remastered"
local AddonType = "SNPC"
local AutorunFile = "autorun/vj_f3r_autorun.lua"
-------------------------------------------------------

local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")
if VJExists == true then
	include('autorun/vj_controls.lua')

	if SERVER then
		resource.AddWorkshop("2600347219")
		resource.AddWorkshop("2600378863")
	end

	/*
		-- Human Voice Types --
		female01
		female03 -- NCR
		female06
		female07
		femaleraider
		femaledefault
		malefiend
		maleraider
		maleclone
		maledefault
		male01
		male02
		male04 -- Legion
		male05 -- NCR
		male03 -- This is technically the actual fiend voice lines, the other is a raider/fiend mix
		male08
	*/

	function devGetSounds(dir,keyword,incl)
		local tbl = {}
		local dir = dir or "vj_fallout/human/femaleadult01/"
		local keyword = keyword or "alertidle"
		if istable(keyword) then
			for _,file in pairs(file.Find("sound/" .. dir .. "*","GAME")) do
				for _,v in pairs(keyword) do
					if string.find(file,v) then
						if incl && !string.find(file,incl) then continue end
						if v == "death" && string.find(file,"deathresponse") then continue end
						table.insert(tbl,dir .. file)
					end
				end
			end
		else
			for _,file in pairs(file.Find("sound/" .. dir .. "*","GAME")) do
				if string.find(file,keyword) then
					if incl && !string.find(file,incl) then continue end
					if keyword == "death" && string.find(file,"deathresponse") then continue end
					table.insert(tbl,dir .. file)
				end
			end
		end
		-- for _,v in pairs(tbl) do
		-- 	print('"' .. v .. '",')
		-- end
		return tbl
	end

	function devMimicTables(dir,requested,incl,useENT)
		local sounds = devSetTables(dir,incl)
		if requested then
			for i,v in pairs(sounds[requested]) do
				print('"' .. v .. '",')
			end
		else
			print("[Writing Sound Tables]")
			for name,tbl in pairs(sounds) do
				if #tbl == 0 then
					print(useENT && 'ENT' or 'self' ..'.SoundTbl_' .. name .. ' = {}')
					continue
				end
				print(useENT && 'ENT' or 'self' ..'.SoundTbl_' .. name .. ' = {')
				for i,v in pairs(tbl) do
					print('	"' .. v .. '",')
				end
				print('}')
			end
			print("[Finished Writing Sound Tables]")
		end
	end

	function devSetTables(dir,incl)
		local foundData = {}
		local tbl = {
			["IdleDialogue"] = {},
			["IdleDialogueAnswer"] = {},
			["Idle"] = {},
			["FollowPlayer"] = {},
			["UnFollowPlayer"] = {},
			["Investigate"] = {},
			["OnPlayerSight"] = {},
			["Suppressing"] = {},
			["Alert"] = {},
			["OnGrenadeSight"] = {},
			["OnKilledEnemy"] = {},
			["Guard_Warn"] = {},
			["Guard_Angry"] = {},
			["Guard_Calmed"] = {},
			["AllyDeath"] = {},
			["OnClearedArea"] = {},
			["DamageByPlayer"] = {},
			["LostEnemy"] = {},
			["CombatIdle"] = {},
			["Pain"] = {},
			["Death"] = {},
			["Swing"] = {},
		}
		dir = dir or "vj_fallout/human/femaleadult01/"
		for name,stored in pairs(tbl) do
			local keyword = name
			if name == "IdleDialogue" then
				keyword = {"hello","greeting"}
			elseif name == "IdleDialogueAnswer" then
				keyword = {"hello","greeting","goodbye"}
			elseif name == "Idle" then
				keyworld = "wehavenoidlelol"
			elseif name == "FollowPlayer" then
				keyword = {"hello","greeting"}
			elseif name == "UnFollowPlayer" then
				keyword = "goodbye"
			elseif name == "Investigate" then
				keyword = "normaltoalert"
			elseif name == "OnPlayerSight" then
				keyword = "wehavenosightlol"
			elseif name == "Suppressing" then
				keyword = "_attack"
			elseif name == "CombatIdle" then
				keyword = "alertidle"
			elseif name == "Alert" then
				keyword = {"normaltocombat","alerttocombat"}
			elseif name == "OnGrenadeSight" then
				keyword = "avoidthreat"
			elseif name == "OnKilledEnemy" then
				keyword = "combattonormal"
			elseif name == "OnClearedArea" then
				keyword = "combattonormal"
			elseif name == "Guard_Warn" then
				keyword = "guardtrespass"
			elseif name == "Guard_Angry" then
				keyword = {"startcombatresp","normaltocombat"}
			elseif name == "Guard_Calmed" then
				keyword = {"alerttonormal","acceptyield"}
			elseif name == "AllyDeath" then
				keyword = "deathresponse"
			elseif name == "DamageByPlayer" then
				keyword = "assault"
			elseif name == "LostEnemy" then
				keyword = {"alerttonormal","combattolost"}
			elseif name == "Pain" then
				keyword = "hit"
			elseif name == "Death" then
				keyword = "death"
			elseif name == "Swing" then
				keyword = "powerattack"
			end
			local foundFiles = devGetSounds(dir,keyword,incl) or {}
			foundData[name] = foundFiles
		end
		return foundData
	end

	local wepCommon = {
		"weapon_vj_f3r_assaultrifle",
		"weapon_vj_f3r_assaultrifle",
		"weapon_vj_f3r_assaultrifle",
		"weapon_vj_f3r_10mmpistol",
		"weapon_vj_f3r_10mmpistol",
		"weapon_vj_f3r_10mmpistol",
		"weapon_vj_f3r_10mmpistol",
		"weapon_vj_f3r_10mmsmg",
		"weapon_vj_f3r_10mmsmg",
		"weapon_vj_f3r_10mmsmg",
		"weapon_vj_f3r_10mmsmg",
		"weapon_vj_f3r_10mmsmg",
		"weapon_vj_f3r_44magnum",
		"weapon_vj_f3r_44magnum",
		"weapon_vj_f3r_44magnum",
		"weapon_vj_f3r_combatshotgun",
		"weapon_vj_f3r_combatshotgun",
		"weapon_vj_f3r_combatshotgun",
		"weapon_vj_f3r_combatshotgun",
		"weapon_vj_f3r_missilelauncher",
		"weapon_vj_f3r_flamer",
		"weapon_vj_f3r_flamer",
		"weapon_vj_f3r_huntingrifle",
		"weapon_vj_f3r_huntingrifle",
		"weapon_vj_f3r_huntingrifle",
		"weapon_vj_f3r_huntingrifle",
		"weapon_vj_f3r_huntingrifle",
		"weapon_vj_f3r_huntingrifle",
		"weapon_vj_f3r_huntingrifle",
		"weapon_vj_f3r_laserpistol",
		"weapon_vj_f3r_laserpistol",
		"weapon_vj_f3r_sawedoffshotgun",
		"weapon_vj_f3r_sawedoffshotgun",
		"weapon_vj_f3r_sawedoffshotgun",
		"weapon_vj_f3r_sawedoffshotgun",
		"weapon_vj_f3r_sawedoffshotgun",
		"weapon_vj_f3r_sniperrifle",
		"weapon_vj_f3r_sniperrifle",
		"weapon_vj_f3r_sniperrifle",
		"weapon_vj_f3r_sniperrifle",
		"weapon_vj_f3r_combatknife",
		"weapon_vj_f3r_leadpipe",
		"weapon_vj_f3r_supersledge",
		"weapon_vj_f3r_g3assaultrifle",
		"weapon_vj_f3r_g3assaultrifle",
		"weapon_vj_f3r_g3assaultrifle",
		"weapon_vj_f3r_g3assaultrifle",
		"weapon_vj_f3r_g3assaultrifle",
		"weapon_vj_f3r_lincolnrifle",
		"weapon_vj_f3r_baseballbat",
		"weapon_vj_f3r_baseballbat",
		"weapon_vj_f3r_baseballbat",
		"weapon_vj_f3r_baseballbat",
		"weapon_vj_f3r_sledgehammer",
		"weapon_vj_f3r_sledgehammer",
		"weapon_vj_f3r_sledgehammer",
	}

	local wepAll = {
		"weapon_vj_f3r_laserkatana",
		"weapon_vj_f3r_combatknife",
		"weapon_vj_f3r_leadpipe",
		"weapon_vj_f3r_supersledge",
		"weapon_vj_f3r_shishkebab",
		"weapon_vj_f3r_assaultrifle",
		"weapon_vj_f3r_10mmpistol",
		"weapon_vj_f3r_10mmsmg",
		"weapon_vj_f3r_25mmlauncher",
		"weapon_vj_f3r_44magnum",
		"weapon_vj_f3r_alienblaster",
		"weapon_vj_f3r_combatshotgun",
		"weapon_vj_f3r_cyberdoggun",
		"weapon_vj_f3r_flamer",
		"weapon_vj_f3r_gatlinglaser",
		"weapon_vj_f3r_heavyincinerator",
		"weapon_vj_f3r_huntingrifle",
		"weapon_vj_f3r_laserrifle",
		"weapon_vj_f3r_laserpistol",
		"weapon_vj_f3r_laserscattergun",
		"weapon_vj_f3r_mauserpistol",
		"weapon_vj_f3r_missilelauncher",
		"weapon_vj_f3r_multiplasmarifle",
		"weapon_vj_f3r_plasmacaster",
		"weapon_vj_f3r_plasmapistol",
		"weapon_vj_f3r_plasmarifle",
		-- "weapon_vj_f3r_railwayrifle",
		"weapon_vj_f3r_rechargerpistol",
		"weapon_vj_f3r_rechargerrifle",
		"weapon_vj_f3r_sawedoffshotgun",
		"weapon_vj_f3r_scattergun",
		"weapon_vj_f3r_sniperrifle",
		"weapon_vj_f3r_teslacannon",
		"weapon_vj_f3r_minigun",

		"weapon_vj_f3r_g3assaultrifle",
		"weapon_vj_f3r_lincolnrifle",
		"weapon_vj_f3r_baseballbat",
		"weapon_vj_f3r_sledgehammer",
	}
	
	local vCre = "Fallout - Creatures"
	VJ.AddCategoryInfo(vCre, {Icon = "vj_icons/f3r_creatures16.png"})
	local vHum = "Fallout - Humans"
	VJ.AddCategoryInfo(vHum, {Icon = "vj_icons/f3r_humans16.png"})
	local vRob = "Fallout - Robots"
	VJ.AddCategoryInfo(vRob, {Icon = "vj_icons/f3r_robots16.png"})
	local vFEV = "Fallout - Super Mutants"
	VJ.AddCategoryInfo(vFEV, {Icon = "vj_icons/f3r_mutants16.png"})

		-- Creatures --
			-- Animals --
		VJ.AddNPC("Bighorner","npc_vj_f3r_bighorner",vCre)
		VJ.AddNPC("Brahmin","npc_vj_f3r_brahmin",vCre)
		VJ.AddNPC("Brahmin Pack","npc_vj_f3r_brahminpack",vCre)
		VJ.AddNPC("Brahmin Water","npc_vj_f3r_brahminwater",vCre)
		VJ.AddNPC("Coyote","npc_vj_f3r_coyote",vCre)
		VJ.AddNPC("Dogskin","npc_vj_f3r_dog",vCre)
		VJ.AddNPC("Vicious Dog","npc_vj_f3r_dog_vic",vCre)
		VJ.AddNPC("Yaoguai","npc_vj_f3r_yaoguai",vCre)
		VJ.AddNPC("Giant Rat","npc_vj_f3r_rat",vCre)
		VJ.AddNPC("Molerat","npc_vj_f3r_molerat",vCre)
		VJ.AddNPC("Mongrel","npc_vj_f3r_mongrel",vCre)
		VJ.AddNPC("Nightstalker","npc_vj_f3r_nightstalker",vCre)

			-- Bugs --
		VJ.AddNPC("Bloat Fly","npc_vj_f3r_bloatfly",vCre)
		VJ.AddNPC("Corpse Fly","npc_vj_f3r_corpsefly",vCre)
		VJ.AddNPC("Giant Ant","npc_vj_f3r_ant",vCre)
		VJ.AddNPC("Giant Fire Ant","npc_vj_f3r_antfire",vCre)
		VJ.AddNPC("Giant Ant Queen","npc_vj_f3r_antqueen",vCre)
		VJ.AddNPC("Giant Fire Ant Queen","npc_vj_f3r_antfirequeen",vCre)
		VJ.AddNPC("Mantis","npc_vj_f3r_mantis",vCre)
		VJ.AddNPC("Mantis Nymph","npc_vj_f3r_mantisnymph",vCre)
		VJ.AddNPC("Cazadore","npc_vj_f3r_cazadore",vCre)
		VJ.AddNPC("Radroach","npc_vj_f3r_radroach",vCre)
		VJ.AddNPC("Glowroach","npc_vj_f3r_radroachglow",vCre)
		VJ.AddNPC("Nukaroach","npc_vj_f3r_radroachnuka",vCre)

			-- Deathclaws --
		VJ.AddNPC("Deathclaw","npc_vj_f3r_deathclaw",vCre)
		VJ.AddNPC("Deathclaw (Enclave)","npc_vj_f3r_deathclaw_e",vCre)
		VJ.AddNPC("Deathclaw Alphamale","npc_vj_f3r_deathclawalpha",vCre)
		VJ.AddNPC("Deathclaw Alphamale (Enclave)","npc_vj_f3r_deathclawalpha_e",vCre)
		VJ.AddNPC("Deathclaw Baby","npc_vj_f3r_deathclawbaby",vCre)
		VJ.AddNPC("Deathclaw Baby (Enclave)","npc_vj_f3r_deathclawbaby_e",vCre)
		VJ.AddNPC("Deathclaw Mother","npc_vj_f3r_deathclawmom",vCre)
		VJ.AddNPC("Deathclaw Mother (Enclave)","npc_vj_f3r_deathclawmom_e",vCre)

			-- Feral Ghouls --
		VJ.AddNPC("Feral Ghoul (Armored)","npc_vj_f3r_ghoul_armor",vCre)
		VJ.AddNPC("Feral Ghoul (Swamp)","npc_vj_f3r_ghoul_swamp",vCre)
		VJ.AddNPC("Feral Ghoul","npc_vj_f3r_ghoul",vCre)
		VJ.AddNPC("Feral Ghoul (RobCo)","npc_vj_f3r_ghoul_vault",vCre)
		VJ.AddNPC("Feral Ghoul (Mutated)","npc_vj_f3r_ghoul_mutant",vCre)
		VJ.AddNPC("Feral Ghoul (Ravager)","npc_vj_f3r_ghoul_ravager",vCre)
		VJ.AddNPC("Feral Ghoul (NCR)","npc_vj_f3r_ghoul_ncr",vCre)
		VJ.AddNPC("Feral Ghoul (Vault Security)","npc_vj_f3r_ghoul_vaultsec",vCre)
		VJ.AddNPC("Feral Ghoul (Reaver)","npc_vj_f3r_ghoul_reaver",vCre)
		VJ.AddNPC("Glowing One","npc_vj_f3r_ghoul_glow",vCre)
		VJ.AddNPC("Glowing One (NCR)","npc_vj_f3r_ghoul_glowncr",vCre)
		VJ.AddNPC("Glowing One (Vault)","npc_vj_f3r_ghoul_glowvau",vCre)
		VJ.AddNPC("Glowing One (Vault Secuirty)","npc_vj_f3r_ghoul_glowsec",vCre)

			-- Geckos --
		VJ.AddNPC("Gecko","npc_vj_f3r_gecko",vCre)
		VJ.AddNPC("Gecko (Golden)","npc_vj_f3r_geckogold",vCre)
		VJ.AddNPC("Gecko (Fire)","npc_vj_f3r_geckofire",vCre)
		VJ.AddNPC("Gecko (Green)","npc_vj_f3r_geckogreen",vCre)
		VJ.AddNPC("Gojira","npc_vj_f3r_geckobig",vCre)

			-- Mirelurks --
		VJ.AddNPC("Magmalurk","npc_vj_f3r_magmalurk",vCre)
		VJ.AddNPC("Mirelurk","npc_vj_f3r_mirelurk",vCre)
		VJ.AddNPC("Mirelurk Hunter","npc_vj_f3r_mirelurkhunter",vCre)
		VJ.AddNPC("Nukalurk","npc_vj_f3r_mirelurknuka",vCre)
		VJ.AddNPC("Firelurk","npc_vj_f3r_mirelurkfire",vCre)
		VJ.AddNPC("Glowlurk","npc_vj_f3r_mirelurkglow",vCre)
		VJ.AddNPC("Swamplurk","npc_vj_f3r_mirelurkswamp",vCre)
		VJ.AddNPC("Swamplurk Hunter","npc_vj_f3r_swamplurkhunt",vCre)
		VJ.AddNPC("Mirelurk King","npc_vj_f3r_mirelurkking",vCre)
		VJ.AddNPC("Swampurk Queen","npc_vj_f3r_mirelurkswampque",vCre)
		VJ.AddNPC("Lakelurk","npc_vj_f3r_lakelurk",vCre)
		VJ.AddNPC("Lakelurk King","npc_vj_f3r_lakelurkking",vCre)
		VJ.AddNPC("Lakelurk Alpha Male","npc_vj_f3r_lakelurkalpha",vCre)

			-- Radscorpions --
		VJ.AddNPC("Albino Radscorpion","npc_vj_f3r_radscor_albino",vCre)
		VJ.AddNPC("Barkscorpion","npc_vj_f3r_radscor_bark",vCre)
		VJ.AddNPC("Giant Radscorpion","npc_vj_f3r_radscor",vCre)
		VJ.AddNPC("Giant Nukascorpion","npc_vj_f3r_radscor_nuka",vCre)
		VJ.AddNPC("Giant Glowscorpion","npc_vj_f3r_radscor_glow",vCre)
		VJ.AddNPC("Radscorpion","npc_vj_f3r_radscor_small",vCre)
	
			-- Misc. --
		VJ.AddNPC("Spore Carrier","npc_vj_f3r_sporecarrier",vCre)
		VJ.AddNPC("Spore Plant","npc_vj_f3r_sporeplant",vCre)
		VJ.AddNPC("Street Trog","npc_vj_f3r_trog",vCre)
		VJ.AddNPC("Tunneler","npc_vj_f3r_tunneler",vCre)
		VJ.AddNPC("Tunneler Queen","npc_vj_f3r_tunnelerqueen",vCre)

		-- Robots --
	VJ.AddNPC("Liberty Prime","npc_vj_f3r_libertyprime",vRob)
	VJ.AddNPC("Zeta Support Drone","npc_vj_f3r_drone",vRob)
	VJ.AddNPC("Eye Bot","npc_vj_f3r_eyebot",vRob)
	VJ.AddNPC("Ede","npc_vj_f3r_eyebot_ede",vRob)
	VJ.AddNPC("Protectron","npc_vj_f3r_protectron",vRob)
	VJ.AddNPC("Protectron (Army)","npc_vj_f3r_protectron_army",vRob)
	VJ.AddNPC("Protectron (Enclave)","npc_vj_f3r_protectron_enc",vRob)
	VJ.AddNPC("Protectron (Metro)","npc_vj_f3r_protectron_metro",vRob)
	VJ.AddNPC("Protectron (Outcast)","npc_vj_f3r_protectron_outc",vRob)
	VJ.AddNPC("Protectron (Factory)","npc_vj_f3r_protectron_fact",vRob)
	VJ.AddNPC("Army Gutsy","npc_vj_f3r_gutsyarmy",vRob)
	VJ.AddNPC("Brother Hood Gutsy","npc_vj_f3r_gutsybos",vRob)
	VJ.AddNPC("Brother Hood Gutsy (Winter)","npc_vj_f3r_gutsybosw",vRob)
	VJ.AddNPC("Enclave Gutsy","npc_vj_f3r_gutsyenclave",vRob)
	VJ.AddNPC("Outcast Gutsy","npc_vj_f3r_gutsyoutcast",vRob)
	VJ.AddNPC("Andy","npc_vj_f3r_handyandy",vRob)
	VJ.AddNPC("Mister Handy","npc_vj_f3r_handy",vRob)
	VJ.AddNPC("Nuka Handy","npc_vj_f3r_handynuka",vRob)
	VJ.AddNPC("Sentrybot (Army)","npc_vj_f3r_sentrybot_army",vRob)
	VJ.AddNPC("Sentrybot (Enclave)","npc_vj_f3r_sentrybot_enc",vRob)
	VJ.AddNPC("Sentrybot (Outcast)","npc_vj_f3r_sentrybot_out",vRob)
	VJ.AddNPC("Sentrybot (Brother Hood)","npc_vj_f3r_sentrybot",vRob)
	VJ.AddNPC("Sentrybot (Brother Hood Winter)","npc_vj_f3r_sentrybot_bosw",vRob)
	VJ.AddNPC("Sentry Turret (Brother Hood)","npc_vj_f3r_sentryturret",vRob)
	VJ.AddNPC("Sentry Turret (Raiders)","npc_vj_f3r_sentryturret_flame",vRob)
	VJ.AddNPC("Sentry Turret (Enclave)","npc_vj_f3r_sentryturret_plasma",vRob)
	VJ.AddNPC("Chinese Spider Mine","npc_vj_f3r_spidermine",vRob)

		-- FEV Mutants --
	VJ.AddNPC_HUMAN("Super Mutant","npc_vj_f3r_supermutant",{
		"weapon_vj_f3r_huntingrifle",
		"weapon_vj_f3r_10mmsmg",
		"weapon_vj_f3r_sledgehammer",
	},vFEV)
	VJ.AddNPC_HUMAN("Super Mutant (Light)","npc_vj_f3r_supermutant_lig",{
		"weapon_vj_f3r_g3assaultrifle",
		"weapon_vj_f3r_huntingrifle",
		"weapon_vj_f3r_combatshotgun",
		"weapon_vj_f3r_10mmsmg",
		"weapon_vj_f3r_sledgehammer",
	},vFEV)
	VJ.AddNPC_HUMAN("Super Mutant (Medium)","npc_vj_f3r_supermutant_med",{
		"weapon_vj_f3r_g3assaultrifle",
		"weapon_vj_f3r_huntingrifle",
		"weapon_vj_f3r_combatshotgun",
		"weapon_vj_f3r_10mmsmg",
		"weapon_vj_f3r_laserpistol",
		"weapon_vj_f3r_laserrifle",
		"weapon_vj_f3r_plasmarifle",
		"weapon_vj_f3r_sledgehammer","weapon_vj_f3r_minigun",
	},vFEV)
	VJ.AddNPC_HUMAN("Super Mutant (Heavy)","npc_vj_f3r_supermutant_hea",{
		"weapon_vj_f3r_heavyincinerator",
		"weapon_vj_f3r_gatlinglaser",
		"weapon_vj_f3r_fatman",
		"weapon_vj_f3r_plasmacaster",
		"weapon_vj_f3r_teslacannon",
		"weapon_vj_f3r_missilelauncher","weapon_vj_f3r_minigun",
	},vFEV)
	VJ.AddNPC_HUMAN("Super Mutant (Nightkin)","npc_vj_f3r_supermutant_nig",{
		"weapon_vj_f3r_g3assaultrifle",
		"weapon_vj_f3r_huntingrifle",
		"weapon_vj_f3r_combatshotgun",
		"weapon_vj_f3r_lincolnrifle",
		"weapon_vj_f3r_10mmsmg",
		"weapon_vj_f3r_laserpistol",
		"weapon_vj_f3r_laserrifle",
		"weapon_vj_f3r_plasmarifle",
		"weapon_vj_f3r_sledgehammer",
	},vFEV)
	VJ.AddNPC("Super Mutant Behemoth","npc_vj_f3r_behemoth",vFEV)
	VJ.AddNPC("Centaur","npc_vj_f3r_centaur",vFEV)
	VJ.AddNPC("Evolved Centaur","npc_vj_f3r_centaurbig",vFEV)
	VJ.AddNPC("The Thing","npc_vj_f3r_centaurthing",vFEV)
	VJ.AddNPC("FEV Subject","npc_vj_f3r_fev",vFEV)

	VJ.AddNPC_HUMAN("Super Mutant","npc_vj_f3r_supermutant_3",{
		"weapon_vj_f3r_huntingrifle",
		"weapon_vj_f3r_10mmsmg",
		"weapon_vj_f3r_sledgehammer",
	},vFEV)
	VJ.AddNPC_HUMAN("Super Mutant (Light)","npc_vj_f3r_supermutant_lig_3",{
		"weapon_vj_f3r_g3assaultrifle",
		"weapon_vj_f3r_huntingrifle",
		"weapon_vj_f3r_combatshotgun",
		"weapon_vj_f3r_10mmsmg",
		"weapon_vj_f3r_sledgehammer",
	},vFEV)
	VJ.AddNPC_HUMAN("Super Mutant (Medium)","npc_vj_f3r_supermutant_med_3",{
		"weapon_vj_f3r_g3assaultrifle",
		"weapon_vj_f3r_huntingrifle",
		"weapon_vj_f3r_combatshotgun",
		"weapon_vj_f3r_10mmsmg",
		"weapon_vj_f3r_laserpistol",
		"weapon_vj_f3r_laserrifle",
		"weapon_vj_f3r_plasmarifle",
		"weapon_vj_f3r_sledgehammer","weapon_vj_f3r_minigun",
	},vFEV)
	VJ.AddNPC_HUMAN("Super Mutant (Heavy)","npc_vj_f3r_supermutant_hea_3",{
		"weapon_vj_f3r_heavyincinerator",
		"weapon_vj_f3r_gatlinglaser",
		"weapon_vj_f3r_fatman",
		"weapon_vj_f3r_plasmacaster",
		"weapon_vj_f3r_teslacannon",
		"weapon_vj_f3r_missilelauncher","weapon_vj_f3r_minigun",
	},vFEV)
	VJ.AddNPC_HUMAN("Super Mutant Overlord","npc_vj_f3r_supermutant_elite_3",{
		"weapon_vj_f3r_heavyincinerator",
		"weapon_vj_f3r_gatlinglaser",
		"weapon_vj_f3r_missilelauncher",
		"weapon_vj_f3r_supersledge",
		"weapon_vj_f3r_laserscattergun","weapon_vj_f3r_minigun",
	},vFEV)
	VJ.AddNPC_HUMAN("Super Mutant (Captain)","npc_vj_f3r_supermutant_cap_3",{
		"weapon_vj_f3r_g3assaultrifle",
		"weapon_vj_f3r_heavyincinerator",
		"weapon_vj_f3r_gatlinglaser",
		"weapon_vj_f3r_missilelauncher",
		"weapon_vj_f3r_flamer",
		"weapon_vj_f3r_supersledge",
		"weapon_vj_f3r_laserrifle",
		"weapon_vj_f3r_plasmarifle","weapon_vj_f3r_minigun",
	},vFEV)
	VJ.AddNPC_HUMAN("Super Mutant (Nightkin)","npc_vj_f3r_supermutant_nig_3",{
		"weapon_vj_f3r_g3assaultrifle",
		"weapon_vj_f3r_huntingrifle",
		"weapon_vj_f3r_combatshotgun",
		"weapon_vj_f3r_lincolnrifle",
		"weapon_vj_f3r_10mmsmg",
		"weapon_vj_f3r_laserpistol",
		"weapon_vj_f3r_laserrifle",
		"weapon_vj_f3r_plasmarifle",
		"weapon_vj_f3r_sledgehammer",
	},vFEV)
	VJ.AddNPC_HUMAN("Fawkes","npc_vj_f3r_supermutant_vault_3",{
		"weapon_vj_f3r_g3assaultrifle",
		"weapon_vj_f3r_combatshotgun",
		"weapon_vj_f3r_gatlinglaser",
		"weapon_vj_f3r_supersledge",
	},vFEV)

		-- Humans --
	-- VJ.AddNPC_HUMAN("_Human Base","npc_vj_f3r_human_base",{
	-- 	"weapon_vj_f3r_g3assaultrifle",
	-- 	"weapon_vj_f3r_combatshotgun",
	-- 	"weapon_vj_f3r_10mmpistol",
	-- 	"weapon_vj_f3r_huntingrifle",
	-- },vHum)
	VJ.AddNPC_HUMAN("Enclave Soldier (NV)","npc_vj_f3r_enclave_nv",{"weapon_vj_f3r_plasmapistol","weapon_vj_f3r_plasmarifle"},vHum)
	VJ.AddNPC_HUMAN("Enclave Soldier","npc_vj_f3r_enclave",{"weapon_vj_f3r_plasmapistol","weapon_vj_f3r_plasmarifle"},vHum)
	VJ.AddNPC_HUMAN("Enclave Hellfire Soldier","npc_vj_f3r_enclave_hell",{"weapon_vj_f3r_heavyincinerator"},vHum)
	VJ.AddNPC_HUMAN("Enclave Tesla Soldier","npc_vj_f3r_enclave_tesla",{
		"weapon_vj_f3r_plasmarifle",
		"weapon_vj_f3r_plasmarifle",
		"weapon_vj_f3r_plasmarifle",
		"weapon_vj_f3r_plasmacaster",
		"weapon_vj_f3r_multiplasmarifle",
		"weapon_vj_f3r_multiplasmarifle",
	},vHum)
	VJ.AddNPC_HUMAN("Brother Hood Initiate","npc_vj_f3r_bos",{"weapon_vj_f3r_laserpistol","weapon_vj_f3r_10mmpistol"},vHum)
	VJ.AddNPC_HUMAN("Brother Hood T-45","npc_vj_f3r_bosarmor",{"weapon_vj_f3r_laserpistol","weapon_vj_f3r_minigun","weapon_vj_f3r_laserpistol","weapon_vj_f3r_laserpistol","weapon_vj_f3r_laserrifle","weapon_vj_f3r_laserrifle","weapon_vj_f3r_laserrifle","weapon_vj_f3r_laserrifle","weapon_vj_f3r_laserscattergun","weapon_vj_f3r_laserscattergun","weapon_vj_f3r_sniperrifle","weapon_vj_f3r_sniperrifle","weapon_vj_f3r_missilelauncher","weapon_vj_f3r_gatlinglaser","weapon_vj_f3r_gatlinglaser","weapon_vj_f3r_flamer","weapon_vj_f3r_assaultrifle","weapon_vj_f3r_assaultrifle","weapon_vj_f3r_assaultrifle"},vHum)
	VJ.AddNPC_HUMAN("Brother Hood Outcast","npc_vj_f3r_bosarmor_outcast",{"weapon_vj_f3r_laserpistol","weapon_vj_f3r_minigun","weapon_vj_f3r_laserpistol","weapon_vj_f3r_laserpistol","weapon_vj_f3r_laserrifle","weapon_vj_f3r_laserrifle","weapon_vj_f3r_laserrifle","weapon_vj_f3r_laserrifle","weapon_vj_f3r_laserscattergun","weapon_vj_f3r_laserscattergun","weapon_vj_f3r_sniperrifle","weapon_vj_f3r_sniperrifle","weapon_vj_f3r_missilelauncher","weapon_vj_f3r_gatlinglaser","weapon_vj_f3r_gatlinglaser","weapon_vj_f3r_flamer","weapon_vj_f3r_assaultrifle","weapon_vj_f3r_assaultrifle","weapon_vj_f3r_assaultrifle"},vHum)
	VJ.AddNPC_HUMAN("Child of Atom","npc_vj_f3r_coa",{"weapon_vj_f3r_10mmpistol"},vHum)
	VJ.AddNPC_HUMAN("Gary","npc_vj_f3r_garry",wepCommon,vHum)
	VJ.AddNPC_HUMAN("Talon Merc Company","npc_vj_f3r_talon",wepCommon,vHum)
	VJ.AddNPC_HUMAN("Raider (Metal Armor)","npc_vj_f3r_raider_met",wepCommon,vHum)
	VJ.AddNPC_HUMAN("Raider (Power Armor)","npc_vj_f3r_raider_pow",wepCommon,vHum)
	VJ.AddNPC_HUMAN("Raider","npc_vj_f3r_raider",wepCommon,vHum)
	VJ.AddNPC_HUMAN("Y-17 Trauma Override Harness","npc_vj_f3r_skeleton",wepAll,vHum)
	VJ.AddNPC_HUMAN("Chinese Stealth Suit MK.I","npc_vj_f3r_chinese1",{"weapon_vj_f3r_laserkatana","weapon_vj_f3r_assaultrifle","weapon_vj_f3r_sniperrifle"},vHum)
	VJ.AddNPC_HUMAN("Chinese Stealth Suit MK.II","npc_vj_f3r_chinese2",{"weapon_vj_f3r_laserkatana","weapon_vj_f3r_assaultrifle","weapon_vj_f3r_sniperrifle"},vHum)
	VJ.AddNPC_HUMAN("Vault Dweller","npc_vj_f3r_vault",wepCommon,vHum)
	VJ.AddNPC_HUMAN("Vault Security","npc_vj_f3r_vaultsec",{"weapon_vj_f3r_10mmpistol","weapon_vj_f3r_10mmsmg"},vHum)
	VJ.AddNPC_HUMAN("Wastelander","npc_vj_f3r_waste",wepCommon,vHum)
	VJ.AddNPC_HUMAN("NCR Ranger","npc_vj_f3r_ncr",wepCommon,vHum)
	VJ.AddNPC_HUMAN("Legion Soldier","npc_vj_f3r_legion",wepCommon,vHum)
	VJ.AddNPC_HUMAN("Legion Centurion","npc_vj_f3r_legion_centurion",wepCommon,vHum)
	-- VJ.AddNPC_HUMAN("Caesar","npc_vj_f3r_legion_caesar",wepCommon,vHum)

	VJ.AddParticle("particles/alienblaster.pcf",{
		"alienblaster_projectile",
	})
	VJ.AddParticle("particles/centaur_spit.pcf",{
		"centaur_spit",
	})
	VJ.AddParticle("particles/magmalurk_flame.pcf",{
		"magmalurk_flame",
	})
	VJ.AddParticle("particles/flamer.pcf",{
		"flamer",
	})
	VJ.AddParticle("particles/vj_f3r_laserkatana.pcf",{
		"vj_f3r_laserkatana_red",
		"vj_f3r_laserkatana_blue",
		"vj_f3r_laserkatana_green",
	})
	VJ.AddParticle("particles/glowingone.pcf",{})
	VJ.AddParticle("particles/flame_gargantua.pcf",{})
	VJ.AddParticle("particles/flame_gojira.pcf",{})
	VJ.AddParticle("particles/flamer.pcf",{})
	VJ.AddParticle("particles/incinerator.pcf",{})
	VJ.AddParticle("particles/mininuke.pcf",{
		"mininuke_explosion",
		"mininuke_explosion_generic_smokestreak_parent",
		"mininuke_explosion_child_firesmoke",
		"mininuke_explosion_child_flash",
		"mininuke_explosion_child_flash_mod",
		"mininuke_explosion_child_shrapnel",
		"mininuke_explosion_child_smoke",
		"mininuke_explosion_child_sparks",
		"mininuke_explosion_child_sparks2",
		"mininuke_explosion_shrapnel_fire_child",
		"mininuke_explosion_shrapnel_smoke_child",
	})
	VJ.AddParticle("particles/goregrenade.pcf",{})
	VJ.AddParticle("particles/radiation_shockwave.pcf",{})
	VJ.AddParticle("particles/sporecarrier_glow.pcf",{})
	VJ.AddParticle("particles/sporecarrier_radiation.pcf",{})
	VJ.AddParticle("particles/plasmapistol.pcf",{})
	VJ.AddParticle("particles/fo3_fx.pcf",{})
	VJ.AddParticle("particles/vman_explosion.pcf",{})
	VJ.AddParticle("particles/rpg_firetrail.pcf",{})
	VJ.AddParticle("particles/nuke_explosion.pcf",{})
	VJ.AddParticle("particles/muzzleflashes_test.pcf",{})
	VJ.AddParticle("particles/fo3_laser.pcf",{
		"vj_f3r_laser_red",
		"vj_f3r_laser_red_impact",
		"vj_f3r_laser_green",
		"vj_f3r_laser_green_impact",
		"vj_f3r_laser_blue",
		"vj_f3r_laser_blue_impact",
	})
	VJ.AddParticle("particles/fo3_libertyprime.pcf",{
		"fo4_mininuke_explosion",
		"vj_f3r_lp_impact",
		"vj_f3r_lp_laser"
	})

	VJ.AddConVar("vj_f3r_human_holster", 1, {FCVAR_ARCHIVE})
	VJ.AddConVar("vj_f3r_prime_nukes", 1, {FCVAR_ARCHIVE})

	if CLIENT then
		hook.Add("PopulateToolMenu", "VJ_ADDTOMENU_F3R", function()
			spawnmenu.AddToolMenuOption("DrVrej", "SNPC Configures", "Fallout Remastered", "Fallout Remastered", "", "", function(Panel)
				if !game.SinglePlayer() && !LocalPlayer():IsAdmin() then
					Panel:AddControl("Label", {Text = "#vjbase.menu.general.admin.not"})
					Panel:AddControl( "Label", {Text = "#vjbase.menu.general.admin.only"})
					return
				end
				Panel:AddControl( "Label", {Text = "#vjbase.menu.general.admin.only"})
				Panel:AddControl("Checkbox", {Label = "Allow Humanoids to unequip their weapon", Command = "vj_f3r_human_holster"})
				Panel:AddControl("Checkbox", {Label = "Allow Liberty Prime to use Mini-Nukes", Command = "vj_f3r_prime_nukes"})
			end)
		end)
	end
	
-- !!!!!! DON'T TOUCH ANYTHING BELOW THIS !!!!!! -------------------------------------------------------------------------------------------------------------------------
	AddCSLuaFile(AutorunFile)
	VJ.AddAddonProperty(AddonName,AddonType)
else
	if (CLIENT) then
		chat.AddText(Color(0,200,200),PublicAddonName,
		Color(0,255,0)," was unable to install, you are missing ",
		Color(255,100,0),"VJ Base!")
	end
	timer.Simple(1,function()
		if not VJF then
			if (CLIENT) then
				VJF = vgui.Create("DFrame")
				VJF:SetTitle("ERROR!")
				VJF:SetSize(790,560)
				VJF:SetPos((ScrW()-VJF:GetWide())/2,(ScrH()-VJF:GetTall())/2)
				VJF:MakePopup()
				VJF.Paint = function()
					draw.RoundedBox(8,0,0,VJF:GetWide(),VJF:GetTall(),Color(200,0,0,150))
				end

				local VJURL = vgui.Create("DHTML",VJF)
				VJURL:SetPos(VJF:GetWide()*0.005, VJF:GetTall()*0.03)
				VJURL:Dock(FILL)
				VJURL:SetAllowLua(true)
				VJURL:OpenURL("https://sites.google.com/site/vrejgaming/vjbasemissing")
			elseif (SERVER) then
				timer.Create("VJBASEMissing",5,0,function() print("VJ Base is Missing! Download it from the workshop!") end)
			end
		end
	end)
end
